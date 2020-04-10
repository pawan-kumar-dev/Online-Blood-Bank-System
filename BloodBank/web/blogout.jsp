<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BLOOD BANK LOGOUT</title>
    </head>
    <body>
        <%
            HttpSession bankid=request.getSession();
            bankid.invalidate();
            %>
<script>alert("SUCCESSFULLY LOGOUT");</script><%
response.sendRedirect("loginform.html");
            %>
            
    </body>
</html>
