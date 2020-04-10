<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <link rel="stylesheet" type="text/css" href="css/style.css" />
        <title>WELCOME DONAR</title>
    </head>
    <body>
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
        }else{%><script>
            alert("SESSION HAS BEEN EXPIRED");
            window.location.href="loginform.html"; </script>
<%
    }
}catch(Exception e){
out.println(e.getMessage());
}%>
        <style>
            #details{
                display: inline-block;
                position: absolute;
            }
            #sch{
                outline:solid;
            }
        </style>
        <div id="header">
      <div id="logo">
        <div id="logo_text" style="display: inline;">
          <h1><a href="index.html">BLOODR</a></h1><H2>Blood Bank Management</H2>
          <h2>Donate blood...<br>save life...</h2>
        </div>
      </div>
      <div id="menubar">
        <ul id="menu">
            <li class="selected"><a href="welcome.jsp">Dashboard</a></li>
          <li><a href="details.jsp">View My Details</a></li>
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
       <details id="sch">
           <summary>Schedule An Appointment</summary>
           <br><br>
           <form name="sch" action="schedule.jsp" method="post">
           Date*:<br>
           <input type="date" name="appdate" min="2020-02-13" max="2022-12-31" required>
                  <br>Time* (Between 10:00 AM to 08:00 PM):
                  <br><input type="time" name="apptime" min="10:00" max="20:00">
                  <input type="submit" value="SCHEDULE AN APPOINTMENT" style="width: 210px;">
       </form>
       </details>
      </div>
    </body>
</html>
