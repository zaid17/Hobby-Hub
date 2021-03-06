<%@ page import="com.hobbyHub.user.User" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <link rel="stylesheet" type="text/css" href="/assets/css/user-profile.css" />
  <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
  <!-- FontAwesome JS-->
  <script defer src="https://use.fontawesome.com/releases/v5.7.1/js/all.js"
    integrity="sha384-eVEQC9zshBn0rFj4+TU78eNA19HMNigMviK/PU/FFjLXqa/GKPgX58rvt5Z8PLs7"
    crossorigin="anonymous"></script>
  <!-- Theme CSS -->
  <link id="theme-style" rel="stylesheet" href="/assets/css/theme-1.css" />
  <title>HobbyHub</title>
  <!-- Google Fonts -->
  <!-- Vendor CSS Files -->
  <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
  <link href="/assets/vendor/icofont/icofont.min.css" rel="stylesheet" />
  <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
  <link href="/assets/vendor/venobox/venobox.css" rel="stylesheet" />
  <link href="/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet" />
  <link href="/assets/vendor/aos/aos.css" rel="stylesheet" />
  <!-- My Main CSS File -->
  <link href="/assets/css/style.css" rel="stylesheet" />
  <style>
    .card {
      margin-top: 2rem;
      margin-bottom: 4rem;
      width: 60%;
      height: 100%;
      margin-left: 10rem;
      text-align: center;
    }

    .card img {
      margin-top: 1rem;
      margin-bottom: 0;
      width: 60%;
      height: 20%;
      align-self: center;
    }

    .card-title {
      margin-top: 0;
    }

    .inline {
      display: inline-block;
    }
  </style>
</head>

<body>
  <%@include  file="sidenav.jsp" %>
  <div id="main">
    <div class="container">
      <section class="section about-section gray-bg" id="about">
        <div class="container">
          <div class="row align-items-center flex-row-reverse">
            <div class="col-lg-6"></div>
            <div class="col-lg-6">
              <div class="about-avatar">

                <img class="profile-image mb-3 rounded-circle mx-auto" src="${current_profile_name.imageUrl}"  alt="profile img" />
              </div>
            </div>
          </div>
          <div class="counter">
            <div class="row">
              <div class="col-6 col-lg-3">
                <div class="count-data text-center">
                  <h6 class="count h2" data-to="500" data-speed="500">${fn:length(current_profile_name.publishedBlogs)}</h6>
                  <p class="m-0px font-w-600">Posts</p>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="count-data text-center">
                  <h6 class="count h2" data-to="150" data-speed="150">${fn:length(current_profile_name.followers)}</h6>
                  <p class="m-0px font-w-600">Followers</p>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="count-data text-center">
                  <h6 class="count h2" data-to="850" data-speed="850">${fn:length(current_profile_name.followings)}</h6>
                  <p class="m-0px font-w-600">Following</p>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="count-data text-center">
                  <input name="${current_profile_name}" type="button"
                    onclick="window.location.assign(${current_profile_name} + /follow)" value="Follow"
                    class="btn btn-primary input" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <div class="container-fluid">
             <section class="blog-list px-3 py-5 p-md-5">
                  <div class="container">
                     <c:forEach items="${current_profile_name.publishedBlogs}" var="blog">
          <div class="item mb-5">
                      <div class="media">
                        <img
                          class="mr-3 img-fluid post-thumb d-none d-md-flex"
                          src="${blog.imageUrl}"
                          alt="blog-image"
                        />

                        <div class="media-body">
                          <h3 class="title mb-1">
                            <a href="${pageContext.request.contextPath}/${blog.id}">${blog.title}</a>
                          </h3>
                          <div class="meta mb-1">
                            <span class="date">${blog.dateCreated}</span>
                            <span class="comment">href="#"> ${fn:length(blog.commentsStatus.comments)}</span>
                          </div>
                          <div class="intro">
                                ${blog.description}
                          </div>

                        </div>
                        <!--//media-body-->
                      </div>
                      <!--//media-->
                    </div>

                    </c:forEach>

                  </div>
                </section>
      </div>
    </div>
  </div>
  <%!
         String getFollowingsUsers(User user){
         String  []items=new String[user.getFollowings().size()];
         for(int i=0;i<user.getFollowings().size();i++)
         {
         System.out.println(user.getFollowings().get(i).getUsername());
         items[i]=user.getFollowings().get(i).getUsername();
         }

           String result = "[";
           for(int i = 0; i < items.length; i++) {
             result += "\"" + items[i] + "\"";
             if(i < items.length - 1) {
               result += ", ";
             }
           }
           result += "]";
           return result;
         }
         %>
  <%! String followingArray = "[]"; %>
  <script>
    var elem = document.getElementsByClassName("input");
    for (var i = 0; i < elem.length; i++) {
      elem[i].value = "Follow";
    }
         <%
            if (request.getSession().getAttribute("user_object") != null) {
      followingArray = getFollowingsUsers((User)request.getSession().getAttribute("user_object"));

    }
    else {
      System.out.println("NULL SESSION " + (request.getSession() == null));
    }
            %>


         var followingArray = <%=followingArray%>

         for (var i = 0; i < elem.length; i++) {
      if (followingArray.includes(elem[i].name)) {
        elem[i].classList.remove('btn-primary');
        elem[i].classList.add('btn-secondary');
        elem[i].value = "Unfollow";
      }
    }
         <% followingArray = "[]";%>
      followingArray =[];
    <script src="/assets/vendor/jquery/jquery.min.js">
  </script>
  <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="/assets/vendor/php-email-form/validate.js"></script>
  <script src="/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
  <script src="/assets/vendor/counterup/counterup.min.js"></script>
  <script src="/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/assets/vendor/venobox/venobox.min.js"></script>
  <script src="/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
  <script src="/assets/vendor/typed.js/typed.min.js"></script>
  <script src="/assets/vendor/aos/aos.js"></script>
  <!-- My Main JS File -->
  <script src="/assets/js/main.js"></script>
</body>
<!-- Vendor JS Files -->

</html>