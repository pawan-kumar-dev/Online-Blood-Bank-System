<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/table.css" />
        <title>BLOOD BANK</title>
    </head>
    <body>
        <%
            try{
            HttpSession bankid=request.getSession();
            String id="";
            if(bankid!=null){
            id=(String)bankid.getAttribute("bank");}    
        %>
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
            <li><a href="orgcamp.html">Organize a Camp</a></li>
            <li><a href="blogout.jsp">Logout</a></li>
            
            
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
          <h1>Welcome to BLOODR Blood Bank Management System</h1>
       <p>Helping you to help others</p>
       <br><br>
       <h2>Manage your Donar</h2>
       <br><br>
       <details id="sch">
           <summary>Search for Blood</summary>
           <br><br>
           <form name="search" action="searched.jsp" method="post">
          Need Blood Groups*:<br>
						<select name="bgroup" required>
						<option value="blood">Blood Groups</option>
						<option value="A+">A+</option>
						<option value="B+">B+</option>
						<option value="O+">O+</option>
						<option value="A-">A-</option>
						<option value="B-">B-</option>
						<option value="O-">O-</option>
						<option value="AB+">AB+</option>
						<option value="AB-">AB-</option>
						</select>
          <input type="submit" value="SEARCH" style="width: 100px;" onclick="test()">
       </form>
           <script>
                 function test(){ 
                if(document.forms["search"]["bgroup"].selectedIndex < 1){
               alert("Please select the Blood Group..");
               window.location="bankpage.jsp";
                return false;}}
               </script>
       </details><br><br>
       <details><summary>View Donar Details</summary>
           <%
                Class.forName("com.mysql.jdbc.Driver");
        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/blood","root","root");
        Statement dst=conn.createStatement();
        ResultSet drs=dst.executeQuery("select * from donar;");
        if(drs.next()){
        %><table style="width:600px;"><tr>
                  <td style="width:10px;">DONAR ID</td>
                  <td style="width:10px;">DONAR NAME</td>
                  <td style="width:10px;">EMAIL</td>
                  <td style="width:10px;">DATE OF BIRTH</td>
                  <td style="width:10px;">BLOOD GROUP</td>
                  <td style="width:10px;">GENDER</td>
                  <td style="width:10px;">LAST ACTIVE ON</td>
                  <td style="width:10px;">OPERATION</td>
              </tr><%
                  ResultSet drs1=dst.executeQuery("select * from donar;");
                  while(drs1.next()){
              %><tr>
                       <td style="width:10px;"><%=drs1.getString(1)%></td>
                       <td style="width:10px;"><%=drs1.getString(2)%></td>
                       <td style="width:10px;"><%=drs1.getString(3)%></td>
                       <td style="width:10px;"><%=drs1.getString(4)%></td>
                       <td style="width:10px;"><%=drs1.getString(5)%></td>
                       <td style="width:10px;"><%=drs1.getString(6)%></td>
                       <td style="width:10px;"><%=drs1.getString(8)%></td>
                       <td style="width:10px;"><a href="delete.jsp?id=<%=drs1.getString(1)%>">DELETE DONAR</a></td></tr>
                       
     <%   }
%></table>
       </details>
       <br><br>
       <details><summary>View CAMP details</summary>
       <%
                Statement campst=conn.createStatement();
                ResultSet camprs=campst.executeQuery("select * from camp;");
                if(camprs.next()){
       %><table style="width:600px;">
               <tr>
                   <td>CAMP ID </td>
                   <td>Start Date</td>
                   <td>End Date</td>
                   <td>Venue</td>
               </tr>
               <%
                   ResultSet camprs1=campst.executeQuery("select * from camp;");
                   while(camprs1.next()){
                        %>
                        <tr> <td><%=camprs1.getString(1)%></td>
                  <td><%=camprs1.getString(2)%></td>
                  <td><%=camprs1.getString(3)%></td>
                  <td><%=camprs1.getString(4)%></td>
                        </tr>
                  <%  } 
                   }
                  else{
%><h2>NO CAMP AVAILABLE</h2><%
}%>
</table>
            <%
                }
                %>
       </details>
      </div>
      
          <%  }
catch(Exception e){
out.println(e.getMessage());
}
            %>
    </body>
</html>
