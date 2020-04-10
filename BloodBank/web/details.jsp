<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/table.css" />
        <title>VIEW DETAILS</title>
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
          <li class="selected"><a href="details.jsp">View My Details</a></li>
          <li><a href="camp.jsp">View Camp Details</a></li>
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
       <p>Helping you to help others</p>
       <br><br><br><br>
       YOUR DETAILS ARE AS FOLLOWS :<br>
       <b>DONAR ID : <%=chkuser1.getString(1)%></b><br>
       <b>NAME : <%=chkuser1.getString(2).toUpperCase()%></b><br>
       <b>EMAIL : <%=chkuser1.getString(3)%></b><br>
       <b>DATE OF BIRTH : <%=chkuser1.getString(4)%></b><br>
       <b>BLOOD GROUP : <%=chkuser1.getString(5)%></b><br>
       <b>GENDER : <%=chkuser1.getString(6).toUpperCase()%></b><br>
       <br><br>
        <br><br>
        <details><summary>View Appointments Details</summary>
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
                }else{
%><h2>NO APPOINTMENT BOOKED</h2><%
}
                %>
        </details><br><br>
        <details><summary>View Camp Registration details</summary>
          <%
                Statement campst=conn.createStatement();
                ResultSet camprs=campst.executeQuery("select * from donar where donarid='"+chkuser1.getString(1)+"' and campid is not null;");
                if(camprs.next()){
                  %>
             <table style="width:600px;">
                <tr>
                    <th style="width:10px;">CAMP ID</th>
                    <th style="width:10px;">VENUE</th>
                </tr>
                <%
                     ResultSet camprs2=campst.executeQuery("select * from donar where donarid='"+chkuser1.getString(1)+"';");
                     if(camprs2.next()){
                     ResultSet campdata=campst.executeQuery("select * from camp where campid='"+camprs2.getString(9)+"';");
                    while(campdata.next()){
                        %>
                        <tr>
                            <td style="width:10px;"><%=campdata.getString(1)%></td>
                            <td style="width:10px;"><%=campdata.getString(4)%></td>
                        </tr>
                <%
                    }}
                    %>
            </table>
            <%
                }else{
%>NO CAMP REGISTRATION<%
}
                %>
        </details>
      </div>
        <%
        }else{
        %>
        <script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script>
<%}
            }catch(Exception e){
            out.println(e.getMessage());
            }
%>
    </body>
</html>
