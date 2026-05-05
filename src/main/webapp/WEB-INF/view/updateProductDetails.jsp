<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Update Product</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .small-card {
            max-width: 420px;
            margin: 40px auto;
            border-radius: 12px;
        }
    </style>
</head>

<body class="bg-light">

<div class="container">

    <div class="card shadow-sm small-card">
        <div class="card-header text-center">
            <h4 class="mt-2 mb-2">Update Product</h4>
        </div>

        <div class="card-body">

            <form action="${pageContext.request.contextPath}/products/update" method="post">

                <input type="hidden" name="id" value="${product.id}">
                <input type="hidden" name="productDetails.id" value="${product.productDetails.id}">

                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" name="productDetails.name"
                           value="${product.productDetails.name}"
                           class="form-control form-control-sm" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="number" step="0.01" name="productDetails.price"
                           value="${product.productDetails.price}"
                           class="form-control form-control-sm" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Manufacturer</label>
                    <input type="text" name="productDetails.manufacturer"
                           value="${product.productDetails.manufacturer}"
                           class="form-control form-control-sm">
                </div>

                <div class="mb-3">
                    <label class="form-label">Expiration Date</label>
                    <input type="date" name="productDetails.expiration_date"
                           value="${product.productDetails.expiration_date}"
                           class="form-control form-control-sm">
                </div>

                <div class="form-check mb-3">
                    <input type="checkbox" name="productDetails.available" value="1"
                           class="form-check-input"
                           <c:if test="${product.productDetails.available == 1}">checked</c:if>>
                    <label class="form-check-label">Available</label>
                </div>

                <button type="submit" class="btn btn-primary w-100 btn-sm">Update</button>

            </form>

        </div>

        <div class="card-footer text-center">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary w-100 btn-sm">Back</a>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
