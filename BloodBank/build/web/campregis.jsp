<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Transport"%>
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
        <title>REGISTER FOR CAMP</title>
    </head>
    <body>
        <%
            HttpSession mailid=request.getSession();
            String donarname="",mail="";
            if(mailid!=null){
            mail=(String)mailid.getAttribute("dmail");}
            String campid=request.getParameter("campid");
             try{
         Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root");
        Statement chkuser=conn.createStatement();
        ResultSet chkuser1=chkuser.executeQuery("select * from donar where email='"+mail+"';");
        if(chkuser1.next()){
        donarname=chkuser1.getString(2);
        Statement campst=conn.createStatement();
        ResultSet camprs=campst.executeQuery("select * from camp where campid='"+campid+"';");
        if(camprs.next()){
            PreparedStatement pst=conn.prepareStatement("update donar set campid=? where donarid=?;");
            pst.setString(1,campid);
            pst.setString(2,chkuser1.getString(1));
         int insertdata=pst.executeUpdate();
        if(insertdata!=0){
        StringBuilder txt=new StringBuilder();
    txt.append("Hello "+donarname.toUpperCase()+" your Registration for camp is done with Camp ID "+campid+"").append(System.lineSeparator()).append(System.lineSeparator());
    txt.append("on date "+camprs.getString(2)+" and ending on "+camprs.getString(3)).append(System.lineSeparator());
    txt.append("at HOLY FAMILY SCHOOL VASAI WEST").append(System.lineSeparator());
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
             String to=mail;
             Session session1 = Session.getDefaultInstance(props, null);
             MimeMessage message = new MimeMessage(session1);
             message.setContent(message,"text/html");
             message.setFrom(new InternetAddress(from));
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
             message.setSubject("BLOODR CAMP REGISTRATION");
             message.setText(txt.toString());
             Transport.send(message, from, pass);
             %>
   <script>
            alert("Registration Done Successfully");
            window.location.href="welcome.jsp"; </script>      
        <%
        }}
        }
else{
        %>
        <script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script>
<%

}}
             catch(Exception e){
                 
             }
            %>
    </body>
</html>
