<%@ page import="java.util.List" %>
<%@ page import="com.adminPanel.app.model.Product" %>

<html>
<head>
    <title>All Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .table-striped > tbody > tr:nth-of-type(odd) > * {
            background-color: #f3f4f6;
        }

        .table-dark {
            background-color: #343a40 !important;
            color: white;
            border-bottom: 2px solid #007bff;
        }

        table th, table td {
            padding: 0.75rem 1rem;
            vertical-align: middle;
            font-size: 0.95rem;
        }

        .badge {
            font-size: 0.8rem;
            min-width: 50px;
            text-align: center;
            padding: 0.4em 0.8em;
            font-weight: 600;
        }

        .product-name {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 250px;
        }

        .action-btns .btn {
            font-size: 0.85rem;
            padding: 0.4rem 0.7rem;
            transition: all 0.2s;
        }

        .action-btns .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .action-btns .btn-info {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
    </style>
</head>

<body class="bg-light">

<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-5 border-bottom pb-3">
        <h2 class="fw-bold text-dark mb-0">📦 All Products</h2>
        <a href="${pageContext.request.contextPath}/products/add" class="btn btn-primary shadow-sm">
            <i class="fas fa-plus me-1"></i> Add New Product
        </a>
    </div>

    <div class="card shadow-lg border-0 rounded-4">
        <div class="card-body p-0">

            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0 align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th style="width: 80px;">#ID</th>
                        <th>Product Name</th>
                        <th style="width: 120px;" class="text-center">Available</th>
                        <th class="text-center" style="width: 250px;">Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        List<Product> products = (List<Product>) request.getAttribute("AllProducts");

                        if (products != null && !products.isEmpty()) {
                            for (Product product : products) {
                                com.adminPanel.app.model.ProductDetails details = product.getProductDetails();
                                boolean isAvailable = (details != null && details.getAvailable() == 1);
                    %>
                    <tr>
                        <td class="text-muted"><%= product.getId() %></td>
                        <td class="fw-semibold product-name" title="<%= (details != null && details.getName() != null) ? details.getName() : "-" %>">
                            <%= (details != null && details.getName() != null) ? details.getName() : "-" %>
                        </td>

                        <td class="text-center">
                            <span class="badge <%= isAvailable ? "bg-success" : "bg-danger" %>">
                                <%= isAvailable ? "YES" : "NO" %>
                            </span>
                        </td>

                        <td class="text-center">
                            <div class="d-flex justify-content-center gap-2 action-btns">
                                <a href="<%=request.getContextPath()%>/products/view/<%= product.getId() %>"
                                   class="btn btn-info btn-sm text-white shadow-sm">
                                    <i class="fas fa-eye me-1"></i> View
                                </a>

                                <a href="<%=request.getContextPath()%>/products/update/<%= product.getId() %>"
                                   class="btn btn-warning btn-sm text-dark shadow-sm">
                                    <i class="fas fa-edit me-1"></i> Update
                                </a>

                                <a href="<%=request.getContextPath()%>/products/delete/<%= product.getId() %>"
                                   class="btn btn-danger btn-sm shadow-sm"
                                   onclick="return confirm('Are you sure you want to delete this product: <%= (details != null && details.getName() != null) ? details.getName() : product.getId() %>?');">
                                    <i class="fas fa-trash-alt me-1"></i> Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center text-muted py-4">
                            <i class="fas fa-box-open me-2"></i> No products available. Please add a new product.
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>

                </table>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
