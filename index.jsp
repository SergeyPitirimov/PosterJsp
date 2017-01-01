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
    <title>Poster - you may say whatever you want!</title>
  </head>
  <body>
    <div>
      <h1>You may say whatever you want!</h1>
      <form method="get" action="editor.jsp" >
        Name <input type="text" name = "name" value="" autofocus>
        Password <input type="password" name = "password" value="">
        <input type="submit" value="Enter">
      </form>
      <%
        Storage storage = new Storage();

        /* Add the new post and update already saved posts */
        if (request.getParameter("username") != null)
        {
          for(String element: storage.getPosts(storage.getUserId(request.getParameter("username"))))
          {
            /* Update or delete the post if it is necessary */
            if (!((request.getParameter(Integer.toString(storage.getPostId(element)))).equals(element)))
            {
              if (!((request.getParameter(Integer.toString(storage.getPostId(element)))).equals("")))
              {
                /* Update the post */
                storage.updatePost(storage.getPostId(element), request.getParameter(Integer.toString(storage.getPostId(element))));
              }
              else
              {
                /* Delete the post because it is empty */
                storage.deletePost(storage.getPostId(element));
              }
            }
          }

          /* Add the new post */
          if (!request.getParameter("newpost").equals(""))
          {
            storage.addPost(storage.getUserId(request.getParameter("username")), request.getParameter("newpost"));
          }
        }

        /* Print all posts for all users */
        for(String element: storage.getPosts(-1))
        {
      %>
          <p><%=element%></p>
      <%
        }
      %>
    </div>
  </body>
</html>