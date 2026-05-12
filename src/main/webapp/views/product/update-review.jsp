<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ecommerce.model.Review" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Edit Review — Cartella</title>

    <style>

        @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600&family=Poppins:wght@300;400;500;600&display=swap');

        *,
        *::before,
        *::after{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:'Poppins',sans-serif;
            background:#0f1110;
            color:white;
        }

        /* NAVBAR */

        .navbar{
            height:75px;
            padding:0 45px;

            display:flex;
            align-items:center;
            justify-content:space-between;

            background:rgba(13,23,18,.92);
            backdrop-filter:blur(10px);

            border-bottom:1px solid rgba(255,255,255,.06);
        }

        .navbar-brand{
            text-decoration:none;
            color:#fff;

            font-family:'Cormorant Garamond',serif;
            font-size:40px;
        }

        .navbar-brand span{
            color:#d0b178;
        }

        .nav-link{
            color:#d4d4d4;
            text-decoration:none;
            margin-left:28px;
            font-size:15px;
            transition:.3s;
        }

        .nav-link:hover{
            color:#d0b178;
        }

        /* CONTAINER */

        .container{
            max-width:650px;
            margin:50px auto;
            padding:0 25px;
        }

        .back-link{
            display:inline-block;
            margin-bottom:25px;

            text-decoration:none;
            color:#d0b178;
            font-size:15px;
        }

        .back-link:hover{
            opacity:.85;
        }

        /* CARD */

        .card{
            background:#171b19;
            border:1px solid rgba(255,255,255,.05);

            border-radius:28px;
            padding:40px;

            box-shadow:0 10px 30px rgba(0,0,0,.35);
        }

        .card-title{
            font-family:'Cormorant Garamond',serif;
            font-size:42px;
            margin-bottom:30px;
        }

        /* FORM */

        .form-group{
            margin-bottom:22px;
        }

        label{
            display:block;
            margin-bottom:10px;
            color:#d8d8d8;
            font-size:14px;
        }

        select,
        textarea{
            width:100%;

            background:#0f1110;

            border:1px solid rgba(255,255,255,.08);
            border-radius:10px;

            padding:14px 16px;

            color:white;
            font-size:15px;
            font-family:'Poppins',sans-serif;

            outline:none;
        }

        select:focus,
        textarea:focus{
            border-color:#d0b178;
        }

        textarea{
            min-height:140px;
            resize:vertical;
        }

        .btn-submit{
            width:100%;
            height:58px;

            border:none;
            border-radius:10px;

            background:linear-gradient(90deg,#0d3f2b,#1a5a3e,#0d3f2b);

            color:white;
            font-size:16px;
            font-weight:500;

            cursor:pointer;
            transition:.3s;
        }

        .btn-submit:hover{
            opacity:.9;
        }

        /* RESPONSIVE */

        @media(max-width:768px){

            .navbar{
                padding:0 20px;
            }

            .navbar-brand{
                font-size:32px;
            }

            .card{
                padding:28px;
            }

            .card-title{
                font-size:34px;
            }
        }

    </style>
</head>

<body>

<%
    Review review = (Review) request.getAttribute("review");
    String productId = (String) request.getAttribute("productId");
%>

<nav class="navbar">

    <a class="navbar-brand"
       href="${pageContext.request.contextPath}/home">

        Cartella<span>.</span>

    </a>

    <div>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/home">

            Home

        </a>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/logout">

            Sign out

        </a>

    </div>

</nav>

<div class="container">

    <a class="back-link"
       href="${pageContext.request.contextPath}/product?id=<%= productId %>">

        Back to Product

    </a>

    <div class="card">

        <div class="card-title">
            Edit Your Review
        </div>

        <form action="${pageContext.request.contextPath}/update-review"
              method="post">

            <input type="hidden"
                   name="reviewId"
                   value="<%= review.getId() %>">

            <input type="hidden"
                   name="productId"
                   value="<%= productId %>">

            <div class="form-group">

                <label for="rating">
                    Rating
                </label>

                <select name="rating"
                        id="rating"
                        required>

                    <option value="5"
                            <%= review.getRating() == 5 ? "selected" : "" %>>
                        ★★★★★ — Excellent
                    </option>

                    <option value="4"
                            <%= review.getRating() == 4 ? "selected" : "" %>>
                        ★★★★☆ — Good
                    </option>

                    <option value="3"
                            <%= review.getRating() == 3 ? "selected" : "" %>>
                        ★★★☆☆ — Average
                    </option>

                    <option value="2"
                            <%= review.getRating() == 2 ? "selected" : "" %>>
                        ★★☆☆☆ — Poor
                    </option>

                    <option value="1"
                            <%= review.getRating() == 1 ? "selected" : "" %>>
                        ★☆☆☆☆ — Terrible
                    </option>

                </select>

            </div>

            <div class="form-group">

                <label for="comment">
                    Your Review
                </label>

                <textarea name="comment"
                          id="comment"><%= review.getComment() != null ? review.getComment() : "" %></textarea>

            </div>

            <button type="submit"
                    class="btn-submit">

                Update Review

            </button>

        </form>

    </div>

</div>

</body>
</html>