<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DONAR LOGGING</title>
    </head>
    <body>
         <% try{
            String mail=request.getParameter("mail");
        String password=request.getParameter("pass");
        if(mail.isEmpty()||password.isEmpty()||password.length()<8){
             response.sendRedirect("loginform.html");
        }else{
            Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root");
        Statement beforelogin=conn.createStatement();
        ResultSet chkbeforelogin=beforelogin.executeQuery("select * from donar where email='"+mail+"' and pass='"+password+"';");
        if(chkbeforelogin.next()){
            PreparedStatement pst=conn.prepareStatement("update donar set lastactivedate=? where email=?;");
            pst.setString(1,java.time.LocalDate.now().toString());
            pst.setString(2,mail);
            pst.executeUpdate();
            HttpSession userid=request.getSession();
            userid.setAttribute("dmail",mail);
             %><script>
                alert("Login Successful....");
                window.location="welcome.jsp";
                </script><%
        }else{
%><script>
                alert("Invalid Login....");
                window.location="loginform.html";
                </script><%
        }}}catch(Exception e){
out.println(e.getMessage());}
    %>
    </body>
</html>