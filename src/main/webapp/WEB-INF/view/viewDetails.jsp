<html>
<head>
    <title>Product Details</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container py-5">

    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
        <div class="card-header bg-dark text-white">
            <h3 class="mb-0">Product Details</h3>
        </div>

        <div class="card-body">

            <p><strong>ID:</strong> ${product.id}</p>
            <p><strong>Name:</strong> ${product.name}</p>
            <p><strong>Price:</strong> ${product.productDetails.price} $</p>
            <p><strong>Manufacturer:</strong> ${product.productDetails.manufacturer}</p>
            <p><strong>Expiration Date:</strong> ${product.productDetails.expiration_date}</p>

            <p>
                <strong>Available:</strong>
                <span class="badge ${product.productDetails.available == 1 ? 'bg-success' : 'bg-danger'}">
                    ${product.productDetails.available == 1 ? "Available" : "Not Available"}
                </span>
            </p>

        </div>

        <div class="card-footer text-end">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                Back to Products
            </a>
        </div>
    </div>

</div>

</body>
</html>
