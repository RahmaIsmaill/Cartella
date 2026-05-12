<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Cartella Login</title>

    <style>

        @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600&family=Poppins:wght@300;400;500;600&display=swap');

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            height:100vh;
            overflow:hidden;
            font-family:'Poppins',sans-serif;
            background:#101010;
            display:flex;
        }

        /* LEFT SIDE */

        .left{
            width:42%;
            position:relative;
            padding:60px;
            color:white;
            display:flex;
            flex-direction:column;
            justify-content:space-between;

            background:
                    linear-gradient(rgba(5,15,10,.72), rgba(5,15,10,.82)),
                    url('https://images.unsplash.com/photo-1494526585095-c41746248156?q=80&w=1400&auto=format&fit=crop');

            background-size:cover;
            background-position:center;
        }

        .left::after{
            content:"";
            position:absolute;
            inset:0;
            background:rgba(0,0,0,.2);
        }

        .left-content,
        .left-footer{
            position:relative;
            z-index:2;
        }

        .logo{
            font-family:'Cormorant Garamond',serif;
            font-size:74px;
            font-weight:500;
            margin-bottom:12px;
        }

        .line{
            width:80px;
            height:3px;
            background:#d1b375;
            margin-bottom:50px;
        }

        .hero-title{
            font-family:'Cormorant Garamond',serif;
            font-size:60px;
            line-height:1.05;
            max-width:300px;
            margin-bottom:25px;
        }

        .hero-text{
            font-size:18px;
            line-height:1.8;
            color:rgba(255,255,255,.78);
            max-width:360px;
        }

        .dots{
            display:flex;
            gap:14px;
            margin-top:40px;
        }

        .dot{
            width:14px;
            height:14px;
            border-radius:50%;
            border:2px solid rgba(255,255,255,.6);
        }

        .dot.active{
            background:#d1b375;
            border:none;
        }

        .footer-logo{
            font-size:20px;
            letter-spacing:8px;
            margin-bottom:8px;
        }

        .footer-text{
            font-size:15px;
            color:rgba(255,255,255,.7);
        }

        /* RIGHT SIDE */

        .right{
            width:58%;
            background:#f7f7f7;
            border-top-left-radius:65px;
            border-bottom-left-radius:65px;
            display:flex;
            justify-content:center;
            align-items:center;
            position:relative;
            padding:30px;
        }

        .lang{
            position:absolute;
            top:35px;
            right:50px;
            color:#444;
            font-size:15px;
        }

        .form-container{
            width:100%;
            max-width:500px;
        }

        .form-title{
            font-family:'Cormorant Garamond',serif;
            font-size:72px;
            text-align:center;
            color:#111;
            margin-bottom:10px;
        }

        .subtitle{
            text-align:center;
            color:#777;
            font-size:20px;
        }

        .small-line{
            width:70px;
            height:3px;
            background:#d1b375;
            margin:22px auto 45px;
        }

        label{
            display:block;
            margin-bottom:10px;
            font-size:17px;
            color:#222;
            font-weight:500;
        }

        .input-box{
            width:100%;
            height:65px;
            border:1px solid #e2e2e2;
            border-radius:8px;
            padding:0 20px;
            font-size:17px;
            outline:none;
            margin-bottom:25px;
            background:white;
        }

        .input-box:focus{
            border-color:#1f4e38;
        }

        .password-box{
            position:relative;
        }

        .forgot{
            position:absolute;
            right:18px;
            top:20px;
            color:#264d39;
            text-decoration:none;
            font-size:15px;
        }

        .btn{
            width:100%;
            height:68px;
            border:none;
            border-radius:8px;
            background:linear-gradient(90deg,#0d3f2b,#16563b,#0d3f2b);
            color:white;
            font-size:22px;
            font-weight:500;
            cursor:pointer;
            margin-top:10px;
        }

        .btn:hover{
            opacity:.95;
        }

        .or{
            display:flex;
            align-items:center;
            gap:18px;
            margin:35px 0;
            color:#777;
        }

        .or::before,
        .or::after{
            content:"";
            flex:1;
            height:1px;
            background:#d8d8d8;
        }

        .bottom{
            text-align:center;
            color:#555;
            font-size:17px;
        }

        .bottom a{
            color:#1f4e38;
            text-decoration:none;
            font-weight:500;
        }

        /* ALERT */

        .alert{
            background:#ffe4e4;
            color:#d52b2b;
            padding:14px;
            border-radius:10px;
            margin-bottom:18px;
            font-size:14px;
        }

        /* RESPONSIVE */

        @media(max-width:1100px){

            .left{
                display:none;
            }

            .right{
                width:100%;
                border-radius:0;
            }

            .form-title{
                font-size:55px;
            }
        }

    </style>
</head>

<body>

<div class="left">

    <div class="left-content">

        <div>
            <div class="logo">Cartella</div>
            <div class="line"></div>
        </div>

        <div>

            <div class="hero-title">
                Welcome back again
            </div>

            <div class="hero-text">
                Sign in and continue your elegant shopping experience
                with Cartella.
            </div>

            <div class="dots">
                <div class="dot active"></div>
                <div class="dot"></div>
                <div class="dot"></div>
            </div>

        </div>

    </div>

    <div class="left-footer">
        <div class="footer-logo">CARTELLA</div>
        <div class="footer-text">© 2024 All rights reserved.</div>
    </div>

</div>

<div class="right">

    <div class="lang">EN ▼</div>

    <div class="form-container">

        <div class="form-title">Welcome back</div>

        <div class="subtitle">
            Sign in to your Cartella account
        </div>

        <div class="small-line"></div>

        <%
            List<String> errors = (List<String>) request.getAttribute("errors");
            String singleError = (String) request.getAttribute("error");
        %>

        <% if(errors != null && !errors.isEmpty()) { %>
        <div class="alert">
            <% for(String e: errors){ %>
            <div><%= e %></div>
            <% } %>
        </div>
        <% } %>

        <% if(singleError != null){ %>
        <div class="alert"><%= singleError %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <label>Email address</label>

            <input class="input-box"
                   type="email"
                   name="email"
                   placeholder="you@example.com"
                   required>

            <label>Password</label>

            <div class="password-box">

                <input class="input-box"
                       type="password"
                       name="password"
                       placeholder="Enter your password"
                       required>

                <a href="#" class="forgot">Forgot?</a>

            </div>

            <button class="btn" type="submit">
                Sign In
            </button>

        </form>

        <div class="or">or</div>

        <div class="bottom">
            Don’t have an account?
            <a href="${pageContext.request.contextPath}/register">
                Create one
            </a>
        </div>

    </div>

</div>

</body>
</html>