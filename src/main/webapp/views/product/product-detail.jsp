<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.model.Review" %>
<%@ page import="com.ecommerce.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <%
        Product product       = (Product) request.getAttribute("product");
        List<Review> reviews  = (List<Review>) request.getAttribute("reviews");
        User loggedInUser     = (User) session.getAttribute("loggedInUser");
    %>

    <title><%= product.getName() %> — Cartella</title>

    <style>

        @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600&family=Poppins:wght@300;400;500;600&display=swap');

        *,
        *::before,
        *::after{
            box-sizing:border-box;
            margin:0;
            padding:0;
        }

        body{
            font-family:'Poppins',sans-serif;
            background:#0f1110;
            color:#f5f5f5;
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
            position:sticky;
            top:0;
            z-index:100;
        }

        .navbar-brand{
            text-decoration:none;
            color:#fff;
            font-family:'Cormorant Garamond',serif;
            font-size:40px;
            letter-spacing:1px;
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
            max-width:1200px;
            margin:auto;
            padding:40px 25px 60px;
        }

        /* BREADCRUMB */

        .breadcrumb{
            margin-bottom:30px;
            color:#9ca3af;
            font-size:14px;
        }

        .breadcrumb a{
            color:#d0b178;
            text-decoration:none;
        }

        /* PRODUCT CARD */

        .product-card{
            background:#161a18;
            border:1px solid rgba(255,255,255,.05);

            border-radius:28px;
            overflow:hidden;

            display:flex;
            gap:0;

            margin-bottom:50px;

            box-shadow:0 10px 35px rgba(0,0,0,.35);
        }

        .product-img,
        .product-img-placeholder{
            width:450px;
            height:520px;
            object-fit:cover;
            flex-shrink:0;
        }

        .product-img-placeholder{
            display:flex;
            align-items:center;
            justify-content:center;

            background:linear-gradient(135deg,#15251d,#20362b);
            color:#d0b178;
            font-size:50px;
        }

        .product-info{
            flex:1;
            padding:45px;
        }

        .product-name{
            font-family:'Cormorant Garamond',serif;
            font-size:52px;
            margin-bottom:15px;
            color:white;
        }

        .product-price{
            font-size:38px;
            font-weight:600;
            color:#d0b178;
            margin-bottom:25px;
        }

        .product-desc{
            font-size:16px;
            line-height:1.9;
            color:#cfcfcf;
            margin-bottom:30px;
        }

        .product-meta{
            color:#8d9490;
            font-size:14px;
        }

        /* BUTTONS */

        .admin-actions{
            display:flex;
            gap:14px;
            margin-top:35px;
        }

        .btn{
            padding:13px 24px;
            border:none;
            border-radius:10px;

            font-size:14px;
            font-weight:500;
            text-decoration:none;
            cursor:pointer;

            transition:.3s;
        }

        .btn:hover{
            transform:translateY(-2px);
        }

        .btn-edit{
            background:#d0b178;
            color:#111;
        }

        .btn-delete-admin{
            background:#2b1a1a;
            color:#ffb4b4;
            border:1px solid rgba(255,120,120,.2);
        }

        /* SECTION TITLE */

        .section-title{
            display:flex;
            align-items:center;
            gap:12px;

            margin-bottom:25px;

            font-size:28px;
            font-family:'Cormorant Garamond',serif;
        }

        .count-badge{
            background:#d0b178;
            color:#111;

            padding:4px 12px;
            border-radius:50px;

            font-size:13px;
            font-weight:600;
        }

        /* REVIEWS */

        .review-card{
            background:#171b19;
            border:1px solid rgba(255,255,255,.05);

            border-radius:18px;
            padding:24px;
            margin-bottom:18px;
        }

        .review-header{
            display:flex;
            justify-content:space-between;
            margin-bottom:10px;
        }

        .reviewer-name{
            font-weight:600;
            color:#fff;
            font-size:15px;
        }

        .review-date{
            color:#8b8b8b;
            font-size:13px;
        }

        .stars{
            color:#d0b178;
            font-size:18px;
            letter-spacing:3px;
            margin-bottom:12px;
        }

        .review-comment{
            color:#d5d5d5;
            line-height:1.8;
            font-size:15px;
        }

        .review-actions{
            display:flex;
            gap:10px;
            margin-top:18px;
        }

        .btn-sm{
            padding:8px 16px;
            border-radius:8px;
            border:none;
            font-size:13px;
            cursor:pointer;
            text-decoration:none;
        }

        .btn-sm-edit{
            background:#d0b178;
            color:#111;
        }

        .btn-sm-delete{
            background:#2b1a1a;
            color:#ffb4b4;
        }

        /* NO REVIEWS */

        .no-reviews{
            text-align:center;
            padding:40px;
            background:#171b19;
            border-radius:18px;
            color:#9ca3af;
        }

        /* WRITE REVIEW */

        .write-review{
            margin-top:35px;

            background:#171b19;
            border:1px solid rgba(255,255,255,.05);

            border-radius:24px;
            padding:35px;
        }

        .write-review h3{
            font-family:'Cormorant Garamond',serif;
            font-size:34px;
            margin-bottom:25px;
            color:white;
        }

        .form-group{
            margin-bottom:22px;
        }

        label{
            display:block;
            margin-bottom:10px;
            color:#d9d9d9;
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
            min-height:130px;
            resize:vertical;
        }

        .btn-submit{
            background:linear-gradient(90deg,#0d3f2b,#1a5a3e,#0d3f2b);
            color:white;

            border:none;
            border-radius:10px;

            padding:14px 28px;

            font-size:15px;
            cursor:pointer;
            transition:.3s;
        }

        .btn-submit:hover{
            opacity:.9;
        }

        /* MOBILE */

        @media(max-width:900px){

            .product-card{
                flex-direction:column;
            }

            .product-img,
            .product-img-placeholder{
                width:100%;
                height:350px;
            }

            .product-info{
                padding:30px;
            }

            .product-name{
                font-size:42px;
            }

            .navbar{
                padding:0 20px;
            }
        }

    </style>
</head>

<body>

<nav class="navbar">

    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
        Cartella<span>.</span>
    </a>

    <div>
        <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Sign out</a>
    </div>

</nav>

<div class="container">

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        &rsaquo;
        <%= product.getName() %>
    </div>

    <div class="product-card">

        <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>

        <img class="product-img"
             src="<%= product.getImageUrl() %>"
             alt="<%= product.getName() %>"
             onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">

        <div class="product-img-placeholder" style="display:none;">
            Product
        </div>

        <% } else { %>

        <div class="product-img-placeholder">
            Product
        </div>

        <% } %>

        <div class="product-info">

            <h1 class="product-name"><%= product.getName() %></h1>

            <div class="product-price">
                $<%= product.getPrice() %>
            </div>

            <p class="product-desc">
                <%= product.getDescription() != null && !product.getDescription().isEmpty()
                        ? product.getDescription()
                        : "No description provided." %>
            </p>

            <div class="product-meta">
                Added:
                <%= product.getCreatedAt() != null
                        ? product.getCreatedAt().toString().substring(0,10)
                        : "N/A" %>
            </div>

            <% if (loggedInUser.isAdmin()) { %>

            <div class="admin-actions">

                <a class="btn btn-edit"
                   href="${pageContext.request.contextPath}/update-product?id=<%= product.getId() %>">
                    Edit Product
                </a>

                <form action="${pageContext.request.contextPath}/delete-product"
                      method="post"
                      style="display:inline"
                      onsubmit="return confirm('Delete this product?')">

                    <input type="hidden"
                           name="id"
                           value="<%= product.getId() %>">

                    <button type="submit" class="btn btn-delete-admin">
                        Delete
                    </button>

                </form>

            </div>

            <% } %>

        </div>

    </div>

    <div class="section-title">

        Reviews

        <span class="count-badge">
            <%= reviews != null ? reviews.size() : 0 %>
        </span>

    </div>

    <% if (reviews == null || reviews.isEmpty()) { %>

    <div class="no-reviews">
        No reviews yet. Be the first to share your thoughts!
    </div>

    <% } else { %>

    <% for (Review r : reviews) { %>

    <div class="review-card">

        <div class="review-header">

                    <span class="reviewer-name">
                        <%= r.getUsername() %>
                    </span>

            <span class="review-date">
                        <%= r.getCreatedAt() != null
                                ? r.getCreatedAt().toString().substring(0,10)
                                : "" %>
                    </span>

        </div>

        <div class="stars">

            <% for (int i = 1; i <= 5; i++) { %>

            <%= i <= r.getRating() ? "★" : "☆" %>

            <% } %>

        </div>

        <div class="review-comment">
            <%= r.getComment() != null ? r.getComment() : "" %>
        </div>

        <% if (loggedInUser != null &&
                (r.getUserId().equals(loggedInUser.getId())
                        || loggedInUser.isAdmin())) { %>

        <div class="review-actions">

            <% if (r.getUserId().equals(loggedInUser.getId())) { %>

            <a class="btn-sm btn-sm-edit"
               href="${pageContext.request.contextPath}/update-review?id=<%= r.getId() %>">
                Edit
            </a>

            <% } %>

            <form action="${pageContext.request.contextPath}/delete-review"
                  method="post"
                  style="display:inline"
                  onsubmit="return confirm('Delete this review?')">

                <input type="hidden"
                       name="id"
                       value="<%= r.getId() %>">

                <button type="submit" class="btn-sm btn-sm-delete">
                    Delete
                </button>

            </form>

        </div>

        <% } %>

    </div>

    <% } %>

    <% } %>

    <div class="write-review">

        <h3>Write a Review</h3>

        <form action="${pageContext.request.contextPath}/add-review" method="post">

            <input type="hidden"
                   name="productId"
                   value="<%= product.getId() %>">

            <div class="form-group">

                <label for="rating">Your Rating</label>

                <select name="rating" id="rating" required>

                    <option value="5">★★★★★ — Excellent</option>
                    <option value="4">★★★★☆ — Good</option>
                    <option value="3">★★★☆☆ — Average</option>
                    <option value="2">★★☆☆☆ — Poor</option>
                    <option value="1">★☆☆☆☆ — Terrible</option>

                </select>

            </div>

            <div class="form-group">

                <label for="comment">Your Review</label>

                <textarea name="comment"
                          id="comment"
                          placeholder="Share your experience with this product..."></textarea>

            </div>

            <button type="submit" class="btn-submit">
                Submit Review
            </button>

        </form>

    </div>

</div>

</body>
</html>