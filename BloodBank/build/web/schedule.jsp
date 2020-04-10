<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.*"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/table.css" />
        
        <title>SCHEDULE APPOINTMENT</title>
    </head>
    <body>
        <style>
            .sch{
                width: 20px;
            }
        </style>
        <%
            HttpSession mailid=request.getSession();
            String donarname="",mail="";
            if(mailid!=null){
            mail=(String)mailid.getAttribute("dmail");}
            try{
              String date,time;
              date=request.getParameter("appdate");
              time=request.getParameter("apptime");
              if(date.isEmpty()||time.isEmpty()){
                  response.sendRedirect("welcome.jsp");
              }else{
               Random r1=new Random(System.currentTimeMillis());
        String schid="";
        for(int i=0;i<=5;i++){
           schid+=String.valueOf(r1.nextInt(8));}
         Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root");
        Statement chkuser=conn.createStatement();
        ResultSet chkuser1=chkuser.executeQuery("select * from donar where email='"+mail+"';");
        if(chkuser1.next()){
            donarname=chkuser1.getString(2);
            PreparedStatement pst=conn.prepareStatement("insert into schedule(scheduleid,donarid,time,date,address) values(?,?,?,?,?);");
            pst.setString(1,schid);
            pst.setString(2,chkuser1.getString(1));
            pst.setString(3,time);
            pst.setString(4,date);
            pst.setString(5,"VASAI-VIRAR CITY MUNICIPAL CORPORATION HOSPITAL");
             int insertdata=pst.executeUpdate();
if(insertdata!=0){
    StringBuilder txt=new StringBuilder();
    txt.append("Hello "+donarname.toUpperCase()+" your Appointment is scheduled with ID "+schid+"").append(System.lineSeparator()).append(System.lineSeparator());
    txt.append("on date "+date+" and time "+time+"").append(System.lineSeparator());
    txt.append("at VASAI-VIRAR MUNICIPAL CORPORATION HOSPITAL").append(System.lineSeparator());
    txt.append("Check on google map https://goo.gl/maps/S14ZE1grzRAiodBP8");
String host ="smtp.gmail.com";
             String from ="bloodr.org@gmail.com";  //Your mail id
             String pass ="pritee1999";   // Your Password
             Properties props = System.getProperties();
             props.put("mail.smtp.starttls.enable", "true"); // added this line
             props.put("mail.smtp.host", host);
             props.put("mail.smtp.user", from);
             props.put("mail.smtp.password", pass);
             props.put("mail.smtp.port", "25");
             props.put("mail.smtp.auth", "true");
             String to=mail;
             Session session1 = Session.getDefaultInstance(props, null);
             MimeMessage message = new MimeMessage(session1);
             message.setContent(message,"text/html");
             message.setFrom(new InternetAddress(from));
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
             message.setSubject("BLOODR Appointment Booked Notification");
             message.setText(txt.toString());
             Transport.send(message, from, pass);
    %><div id="header">
      <div id="logo">
        <div id="logo_text" style="display: inline;">
          <h1><a href="index.html">BLOODR</a></h1><H2>Blood Bank Management</H2>
          <h2>Donate blood...<br>save life...</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
            <li><a href="welcome.jsp">Dashboard</a></li>
          <li><a href="details.jsp">View My Details</a></li>
          <li><a href="camp.jsp">View Camp Details</a></li>
        </ul>
      </div>
    </div>
       <div id="sidebar_container">
           <img src="img1.jpg" style="width: 200px; height: 200px;">
           <img src="img2.png" style="width: 200px;">
           <img src="img3.jpg" style="width: 200px; height: 200px;">
           <img src="img4.jpg" style="width: 200px; height: 200px;">
      </div>
      <div id="content">
          <h1>Welcome <b><%=donarname.toUpperCase()%></b> to BLOODR Blood Bank Management System</h1>
       <p>Helping you to help others</p>
       <br><br><br><br>
       YOUR APPOINTMENT FOR DONATING IS SCHEDULED WITH ID :<%=schid%><br>
       on Date <%=date%> and Time <%=time%><br>
       at VASAI-VIRAR MUNICIPAL CORPORATION HOSPITAL<br>
       CHECK ON THE GOOGLE MAP
       <br><br><br>
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d60221.947124067075!2d72.80332093814847!3d19.374707472426007!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7af35391a26bf%3A0x6af096c368510e34!2sVasai%20Virar%20City%20Municipal%20Corporation%20Hospital!5e0!3m2!1sen!2sin!4v1580551992203!5m2!1sen!2sin" frameborder="1" style="border:1;" allowfullscreen="true"></iframe>
        <br><br>
        <details><summary>View Previous Appointments</summary>
            <%
                Statement st1=conn.createStatement();
                ResultSet schd=st1.executeQuery("select * from schedule where donarid='"+chkuser1.getString(1)+"';");
                if(schd.next()){
                %>
             <table style="width:600px;">
                <tr>
                    <th style="width:10px;">SCHEDULEID</th>
                    <th style="width:10px;">DATE</th>
                    <th style="width:10px;">TIME</th>
                    <th style="width:10px;">VENUE</th>
                </tr>
                <%
                    ResultSet schd1=st1.executeQuery("select * from schedule where donarid='"+chkuser1.getString(1)+"';");
                    while(schd1.next()){
                        %>
                        <tr>
                            <td style="width:10px;"><%=schd1.getString(1)%></td>
                            <td style="width:10px;"><%=schd1.getString(4)%></td>
                            <td style="width:10px;"><%=schd1.getString(3)%></td>
                            <td style="width:10px;"><%=schd1.getString(5)%></td>
                            
                        </tr>
                <%
                    }
                    %>
            </table>
            <%
                }
                %>
        </details>
      </div>
        <%
        }
              }
        else{
        %>
        <script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script>
<%
        }}
            }catch(Exception e){
            out.println(e.getMessage());
            }
%></body>
</html>
