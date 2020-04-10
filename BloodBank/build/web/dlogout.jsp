<%-- 
    Document   : dlogout
    Created on : Feb 4, 2020, 11:47:21 AM
    Author     : PAVAN
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DONAR LOGOUT</title>
    </head>
    <body>
        <%
HttpSession mailid=request.getSession();
mailid.invalidate();
%>
<script>alert("SUCCESSFULLY LOGOUT");</script><%
response.sendRedirect("loginform.html");
            %>
    </body>
</html>
