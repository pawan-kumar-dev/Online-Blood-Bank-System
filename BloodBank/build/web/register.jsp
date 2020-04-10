<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DONAR REGISTER</title>
    </head>
    <body>
         <%
            try{
        String name,dob,bgroup,password,email,gender,gen;
        name=request.getParameter("uname");
        dob=request.getParameter("applydate");
        bgroup=request.getParameter("bgroup");
        password=request.getParameter("pass");
        email=request.getParameter("mail");
        gender=request.getParameter("sex");
         if(name.isEmpty()||password.isEmpty()||email.isEmpty()||dob.isEmpty()||bgroup.isEmpty()){
        response.sendRedirect("index.html");}
         else{
         Random r1=new Random(System.currentTimeMillis());
        String uid="";
        for(int i=0;i<=5;i++){
           uid+=String.valueOf(r1.nextInt(8));}
         Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root");
        Statement chkuser=conn.createStatement();
        ResultSet chkuser1=chkuser.executeQuery("select * from donar where email='"+email+"';");
        if(chkuser1.next()){
            %><script>
                alert("Donar Already Registered....\n\
            Please Login To Continue....");
                window.location="loginform.html";
                </script><%
        }else{
        PreparedStatement pst=conn.prepareStatement("insert into donar(donarid,name,email,dob,bgroup,gender,pass) values(?,?,?,?,?,?,?);");
        pst.setString(1,uid);
        pst.setString(2,name);
        pst.setString(3,email);
        pst.setString(4, dob);
        pst.setString(5,bgroup);
        pst.setString(6,gender);
        pst.setString(7,password);
        int insertdata=pst.executeUpdate();
if(insertdata!=0){
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
             String to=email;
             Session session1 = Session.getDefaultInstance(props, null);
             MimeMessage message = new MimeMessage(session1);
             message.setFrom(new InternetAddress(from));
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
             message.setSubject("Welcome to BLOODR");
             message.setText("Hello Donar your Registration  ID is "+uid);
             Transport.send(message, from, pass);
%><script>
                alert("Donar Successfully Registered....Login to continue");
                window.location="loginform.html";
                </script><%
}
}
        }
}catch(Exception e){
            out.println(e.getMessage());
        }
        %>
    </body>
</html>
