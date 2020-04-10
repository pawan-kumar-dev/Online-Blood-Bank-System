<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Organizing a camp</title>
    </head>
    <body>
        <%
            try{
                String id1,sdate,edate;
                HttpSession bankid=request.getSession();
            String id="";
            if(bankid!=null){
            id=(String)bankid.getAttribute("bank");}
            id1=request.getParameter("campid");
            sdate=request.getParameter("sdate");
            edate=request.getParameter("edate");
            if(id1.isEmpty()||sdate.isEmpty()||edate.isEmpty()){
            response.sendRedirect("orgcamp.html");
            }else{
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root"); 
        PreparedStatement pst=conn.prepareStatement("insert into camp(campid,startdate,enddate,venue) values(?,?,?,?);");
            pst.setString(1,id1);
            pst.setString(2,sdate);
            pst.setString(3,edate);
            pst.setString(4,"HOLY FAMILY SCHOOL VASAI WEST");
            int inserted=pst.executeUpdate();
            if(inserted!=0){
                Statement st=conn.createStatement();
                ResultSet rs=st.executeQuery("select * from donar");
                while(rs.next()){
                    StringBuilder txt=new StringBuilder();
    txt.append("Hello "+rs.getString(2).toUpperCase()+" We are organizing a camp").append(System.lineSeparator());
     txt.append("on date "+sdate+" and ending on "+edate).append(System.lineSeparator());
    txt.append("at HOLY FAMILY SCHOOL VASAI WEST, you are heartly invited ").append(System.lineSeparator());
    txt.append("kindly signin to your account to register and to view more details").append(System.lineSeparator());
    txt.append("Check on google map https://goo.gl/maps/48w4RQJTrGFeY7an6");
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
             String to=rs.getString(3);
             Session session1 = Session.getDefaultInstance(props, null);
             MimeMessage message = new MimeMessage(session1);
             message.setContent(message,"text/html");
             message.setFrom(new InternetAddress(from));
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
             message.setSubject("BLOODR ORGANIZING BLOOD DONATION CAMP");
             message.setText(txt.toString());
             Transport.send(message, from, pass);
                }
                 %><script>
                alert("CAMP registered Successful....");
                window.location="bankpage.jsp";
                </script><%
            }
            }
            }catch(Exception e){
            out.println(e.getMessage());
            }
            %>
    </body>
</html>
