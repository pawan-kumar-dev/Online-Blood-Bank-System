<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DELETE THE DONAR</title>
    </head>
    <body>
        <%
            String id=request.getParameter("id");
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root"); 
Statement st=conn.createStatement();
ResultSet rs=st.executeQuery("select * from donar where donarid='"+id+"';");
if(rs.next()){
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
             message.setFrom(new InternetAddress(from));
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
             message.setSubject("DONAR IS DELETED");
             message.setText("Hello Donar as you are inactive so you are deleted");
             Transport.send(message, from, pass);
             PreparedStatement pst=conn.prepareStatement("delete from donar where donarid='"+id+"';");
             int del=pst.executeUpdate();
             if(del!=0){
              %>
        <script>
            alert("Donar Successfully Deleted....");
            window.location.href="bankpage.jsp"; </script>
<%
             }
}
            %>
        
    </body>
</html>
