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
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        List<Product> products = (List<Product>) request.getAttribute("products");
        List<Review> latestReviews = (List<Review>) request.getAttribute("latestReviews");
        String error = (String) request.getAttribute("error");
    %>

    <title>Cartella | Home</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI',sans-serif;
        }

        body{
            background:#0f172a;
            color:white;
            min-height:100vh;
        }

        /* NAVBAR */

        .navbar{
            width:100%;
            height:75px;
            padding:0 60px;
            display:flex;
            align-items:center;
            justify-content:space-between;
            background:rgba(15,23,42,.95);
            border-bottom:1px solid rgba(255,255,255,.06);
            position:sticky;
            top:0;
            z-index:100;
            backdrop-filter:blur(10px);
        }

        .logo{
            text-decoration:none;
            color:white;
            font-size:28px;
            font-weight:700;
        }

        .logo span{
            color: #185138;
        }

        .nav-right{
            display:flex;
            align-items:center;
            gap:18px;
        }

        .user-box{
            padding:10px 18px;
            border-radius:30px;
            background:#1e293b;
            font-size:14px;
            color:#cbd5e1;
        }

        .admin-badge{
            background: #3d751d;
            color:white;
            padding:4px 10px;
            border-radius:20px;
            margin-left:8px;
            font-size:11px;
            font-weight:600;
        }

        .nav-link{
            text-decoration:none;
            color:#cbd5e1;
            transition:.3s;
            font-size:14px;
        }

        .nav-link:hover{
            color:white;
        }

        /* HERO */

        .hero{
            padding:70px 40px 40px;
            text-align:center;
        }

        .hero h1{
            font-size:52px;
            margin-bottom:15px;
            font-weight:700;
        }

        .hero p{
            color:#94a3b8;
            font-size:17px;
        }

        .hero span{
            color: #297c26;
        }

        /* CONTAINER */

        .container{
            width:92%;
            max-width:1400px;
            margin:auto;
        }

        /* SECTION */

        .section-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin:40px 0 25px;
        }

        .section-title{
            font-size:28px;
            font-weight:700;
        }

        .count{
            color: #c3a457;
        }

        .btn-add{
            text-decoration:none;
            background:linear-gradient(135deg,#8b5cf6,#6366f1);
            color:white;
            padding:13px 22px;
            border-radius:12px;
            font-weight:600;
            transition:.3s;
        }

        .btn-add:hover{
            transform:translateY(-2px);
            opacity:.9;
        }

        /* GRID */

        .grid{
            display:grid;
            grid-template-columns:repeat(auto-fill,minmax(300px,1fr));
            gap:28px;
        }

        /* CARD */

        .card{
            background:#1e293b;
            border-radius:24px;
            overflow:hidden;
            transition:.35s;
            border:1px solid rgba(255,255,255,.05);
        }

        .card:hover{
            transform:translateY(-8px);
            box-shadow:0 20px 40px rgba(0,0,0,.35);
        }

        .card-image{
            width:100%;
            height:240px;
            overflow:hidden;
            background:#111827;
        }

        .card-image img{
            width:100%;
            height:100%;
            object-fit:cover;
        }

        .placeholder{
            width:100%;
            height:100%;
            display:flex;
            justify-content:center;
            align-items:center;
            color:#64748b;
            font-size:20px;
        }

        .card-body{
            padding:24px;
        }

        .product-name{
            font-size:22px;
            font-weight:700;
            margin-bottom:10px;
        }

        .product-desc{
            color:#94a3b8;
            line-height:1.6;
            font-size:14px;
            margin-bottom:18px;
            min-height:45px;
        }

        .product-price{
            color:#10b981;
            font-size:28px;
            font-weight:700;
            margin-bottom:22px;
        }

        /* BUTTONS */

        .actions{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
        }

        .btn{
            flex:1;
            border:none;
            padding:12px;
            border-radius:12px;
            cursor:pointer;
            font-weight:600;
            text-decoration:none;
            text-align:center;
            transition:.3s;
        }

        .btn-view{
            background:#334155;
            color:white;
        }

        .btn-view:hover{
            background:#475569;
        }

        .btn-edit{
            background:#312e81;
            color:white;
        }

        .btn-edit:hover{
            background:#4338ca;
        }

        .btn-delete{
            background:#7f1d1d;
            color:white;
        }

        .btn-delete:hover{
            background:#991b1b;
        }

        /* REVIEWS */

        .review-section{
            margin-top:70px;
        }

        .review-title{
            font-size:28px;
            margin-bottom:25px;
            font-weight:700;
        }

        .review-grid{
            display:grid;
            grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
            gap:22px;
        }

        .review-card{
            background:#1e293b;
            border-radius:20px;
            padding:24px;
            border:1px solid rgba(255,255,255,.05);
        }

        .review-top{
            display:flex;
            justify-content:space-between;
            margin-bottom:15px;
        }

        .review-user{
            font-weight:600;
        }

        .stars{
            color:#fbbf24;
        }

        .review-comment{
            color:#cbd5e1;
            line-height:1.7;
            font-size:14px;
        }

        /* EMPTY */

        .empty{
            width:100%;
            padding:80px 20px;
            text-align:center;
            background:#1e293b;
            border-radius:20px;
            color:#94a3b8;
        }

        /* DANGER */

        .danger{
            margin:70px 0;
            background:#1e1b2e;
            border:1px solid rgba(239,68,68,.3);
            border-radius:24px;
            padding:35px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            flex-wrap:wrap;
            gap:20px;
        }

        .danger h3{
            color:#ef4444;
            margin-bottom:10px;
            font-size:24px;
        }

        .danger p{
            color:#94a3b8;
        }

        .delete-account{
            background:#dc2626;
            color:white;
            border:none;
            padding:14px 28px;
            border-radius:14px;
            cursor:pointer;
            font-size:15px;
            font-weight:600;
            transition:.3s;
        }

        .delete-account:hover{
            background:#b91c1c;
        }

        /* FOOTER */

        footer{
            text-align:center;
            padding:30px;
            color:#64748b;
            border-top:1px solid rgba(255,255,255,.06);
            margin-top:40px;
        }

        /* MOBILE */

        @media(max-width:768px){

            .navbar{
                padding:0 20px;
            }

            .hero h1{
                font-size:36px;
            }

            .section-header{
                flex-direction:column;
                gap:20px;
                align-items:flex-start;
            }

            .danger{
                flex-direction:column;
                align-items:flex-start;
            }

        }

    </style>
</head>

<body>

<!-- NAVBAR -->

<nav class="navbar">

    <a href="${pageContext.request.contextPath}/home" class="logo">
        Carte<span>lla</span>
    </a>

    <div class="nav-right">

        <div class="user-box">
            <%= loggedInUser.getUsername() %>

            <% if(loggedInUser.isAdmin()){ %>
            <span class="admin-badge">ADMIN</span>
            <% } %>
        </div>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</nav>

<!-- HERO -->

<div class="hero">

    <h1>
        Welcome Back,
        <span><%= loggedInUser.getUsername() %></span>
    </h1>

    <p>
        Explore premium products with a modern shopping experience
    </p>

</div>

<div class="container">

    <% if(error != null && !error.isEmpty()){ %>

    <div style="
            background:#7f1d1d;
            padding:15px;
            border-radius:12px;
            margin-bottom:20px;
            color:white;">
        <%= error %>
    </div>

    <% } %>

    <!-- PRODUCTS -->

    <div class="section-header">

        <div class="section-title">
            Products
            <span class="count">
                (<%= products != null ? products.size() : 0 %>)
            </span>
        </div>

        <% if(loggedInUser.isAdmin()){ %>

        <a class="btn-add"
           href="${pageContext.request.contextPath}/add-product">

            Add Product

        </a>

        <% } %>

    </div>

    <div class="grid">

        <% if(products == null || products.isEmpty()){ %>

        <div class="empty">
            No products available right now.
        </div>

        <% } else { %>

        <% for(Product p : products){ %>

        <div class="card">

            <div class="card-image">

                <% if(p.getImageUrl() != null && !p.getImageUrl().isEmpty()){ %>

                <img src="<%= p.getImageUrl() %>"
                     alt="<%= p.getName() %>">

                <% } else { %>

                <div class="placeholder">
                    No Image
                </div>

                <% } %>

            </div>

            <div class="card-body">

                <div class="product-name">
                    <%= p.getName() %>
                </div>

                <div class="product-desc">

                    <%= p.getDescription() != null
                            ? p.getDescription()
                            : "No description available." %>

                </div>

                <div class="product-price">
                    $<%= p.getPrice() %>
                </div>

                <div class="actions">

                    <a class="btn btn-view"
                       href="${pageContext.request.contextPath}/product?id=<%= p.getId() %>">

                        View

                    </a>

                    <% if(loggedInUser.isAdmin()){ %>

                    <a class="btn btn-edit"
                       href="${pageContext.request.contextPath}/update-product?id=<%= p.getId() %>">

                        Edit

                    </a>

                    <form action="${pageContext.request.contextPath}/delete-product"
                          method="post"
                          style="display:inline; flex:1;"
                          onsubmit="return confirm('Delete this product?')">

                        <input type="hidden"
                               name="id"
                               value="<%= p.getId() %>">

                        <button type="submit"
                                class="btn btn-delete"
                                style="width:100%;">

                            Delete

                        </button>

                    </form>

                    <% } %>

                </div>

            </div>

        </div>

        <% } %>

        <% } %>

    </div>

    <!-- REVIEWS -->

    <div class="review-section">

        <div class="review-title">
            Latest Reviews
        </div>

        <% if(latestReviews == null || latestReviews.isEmpty()){ %>

        <div class="empty">
            No reviews yet.
        </div>

        <% } else { %>

        <div class="review-grid">

            <% for(Review r : latestReviews){ %>

            <div class="review-card">

                <div class="review-top">

                    <div class="review-user">
                        <%= r.getUsername() %>
                    </div>

                    <div class="stars">

                        <%
                            for(int i=1;i<=5;i++){
                                if(i <= r.getRating()){
                                    out.print("★");
                                }else{
                                    out.print("☆");
                                }
                            }
                        %>

                    </div>

                </div>

                <div class="review-comment">

                    <%= r.getComment() != null
                            ? r.getComment()
                            : "No comment." %>

                </div>

            </div>

            <% } %>

        </div>

        <% } %>

    </div>

    <!-- DANGER -->

    <div class="danger">

        <div>

            <h3>Delete Account</h3>

            <p>
                Permanently remove your account and data.
            </p>

        </div>

        <form action="${pageContext.request.contextPath}/delete-account"
              method="post"
              onsubmit="return confirm('Delete account permanently?')">

            <button type="submit" class="delete-account">
                Delete My Account
            </button>

        </form>

    </div>

</div>

<footer>
    Cartella © 2025
</footer>

</body>
</html>