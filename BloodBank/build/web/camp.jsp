<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/table.css" />
        <title>VIEW CAMPS</title>
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
         Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root");
        Statement chkuser=conn.createStatement();
        ResultSet chkuser1=chkuser.executeQuery("select * from donar where email='"+mail+"';");
        if(chkuser1.next()){
             donarname=chkuser1.getString(2);
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
          <li class="selected"><a href="camp.jsp">View Camp Details</a></li>
           <li><a href="dlogout.jsp">Logout</a></li>
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
       <p>Helping you to help others</p><br><br>
       <%
            Statement camp=conn.createStatement();
            ResultSet campexist=camp.executeQuery("select * from camp");
            if(campexist.next()){
                %><details><summary>View Camp Details</summary><%
                    ResultSet campexist1=camp.executeQuery("select * from camp");
                while(campexist1.next()){
                    %><div>
                    <b>CAMP ID : <%=campexist1.getString(1)%></b><br>
                    <b>Start Date : <%=campexist1.getString(2)%></b><br>
                    <b>End Date : <%=campexist1.getString(3)%></b><br>
                    <b>Venue : <%=campexist1.getString(4)%></b><br>
                    <b>Checkout the Google map below </b><br><br>
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15053.796526036067!2d72.82558097353983!3d19.392991030848865!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7a9900c8c61e9%3A0x33688d68f298533a!2sHoly%20Family%20convent%20School%20and%20junior%20college!5e0!3m2!1sen!2sin!4v1580733413959!5m2!1sen!2sin" frameborder="0" style="border:0;" allowfullscreen=""></iframe> 
<br><form method="post">
    <input type="submit" formaction="campregis.jsp?campid=<%=campexist1.getString(1)%>" value="Register for Camp" style="width:150px;">
</form><hr></div>
                
<%           }%></details><% }else{
%><h2>NO CAMP AVALIABLE</h2><%
}
}else{
        %>
        <script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script>
<%
        }
              }catch(Exception e){
            out.println(e.getMessage());
            }
%>  
      </div>
    </body>
</html>
