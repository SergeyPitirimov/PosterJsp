<%-- 
    This is the poster of user's messages.
    Contact: Sergey Pitirimov, sergey.pitirimov@innopolis.ru
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="poster.Storage"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your posts, <%=request.getParameter("name")%></title>
  </head>
  <body>
    <h1><%=request.getParameter("name")%>, you may create or edit your posts here!</h1>
    <form method="get" action="index.jsp">
      New post: <input type="text" name = "newpost" value="" size="80" autofocus>
      <input type="submit" value="Publish">
    <%
      Storage editStorage = new Storage();
      int userId = -1;
      
      /* Add user if it is necessary */
      while ((userId = editStorage.getUserId(request.getParameter("name"))) < 0)
      {
        /* Create new user */
        if (!((request.getParameter("name")).equals("")))
        {
          editStorage.addUser(request.getParameter("name"), request.getParameter("password"));
        }
      }
      
      /* Print all posts of user, who has logged in */
      for(String post: editStorage.getPosts(userId))
      {
    %>
      <br>Edit post: <input type="text" name="<%=editStorage.getPostId(post)%>" value="<%=post%>" size="80">
    <%
      }
    %>
      <br><input type="hidden" name = "username" value="<%=request.getParameter("name")%>">
    </form>
  </body>
</html>
