<html>
<head>
    <title>Add Product</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container py-5">

    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">Add New Product</h3>
        </div>

        <div class="card-body">

            <form action="${pageContext.request.contextPath}/products/add" method="post">

                <div class="mb-3">
                    <label class="form-label">Product Name</label>
                    <input type="text"
                           name="name"
                           class="form-control"
                           placeholder="Enter main product name"
                           required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Details Name</label>
                    <input type="text"
                           name="productDetails.name"
                           class="form-control"
                           placeholder="Enter detailed product name"
                           required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="number"
                           step="0.01"
                           name="productDetails.price"
                           class="form-control"
                           placeholder="Enter price in USD"
                           required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Manufacturer</label>
                    <input type="text"
                           name="productDetails.manufacturer"
                           class="form-control"
                           placeholder="Enter manufacturer name" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Expiration Date</label>
                    <input type="date"
                           name="productDetails.expiration_date"
                           class="form-control"
                           placeholder="Select expiry date" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Available (0 = No, 1 = Yes)</label>
                    <input type="number"
                           name="productDetails.available"
                           class="form-control"
                           min="0" max="1"
                           placeholder="Enter 0 (No) or 1 (Yes)" />
                </div>

                <button type="submit" class="btn btn-primary w-100">
                    Add Product
                </button>

            </form>

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
