<%-- 
    Document   : hosplogin
    Created on : Feb 4, 2020, 5:10:29 AM
    Author     : PAVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BANK LOGIN</title>
    </head>
    <body>
 <%
            try{
            String id,pass;
            id=request.getParameter("id");
            pass=request.getParameter("pass");
            if(id.equals("9689765707") && pass.equals("pritee1999")){
             HttpSession bankid=request.getSession();
            bankid.setAttribute("bank",id);
            response.sendRedirect("bankpage.jsp");
            }else{
        %>
        <script>
            alert("INVALID LOGIN");
            window.location.href="bank.html"; </script>
<%

}
            }
 catch(Exception e){
         out.println(e.getMessage());
        }%>
    </body>
</html>
