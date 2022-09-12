<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductTable.aspx.cs" Inherits="TradeApp.ProductTable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Product List</title>


    <%--<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />

    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>--%>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>

    <%-- For data tables --%>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.css" />

    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap4.min.js"></script>
    <style>
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
        }

        body {
            width: 90%;
            margin: auto;
            background-color: honeydew;
            font-family: Cambria, Cochin, Georgia, Times, Times New Roman, serif;
            padding: 5px;
        }

        #productTable {
            width: 100% !important;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark">
                <a class="navbar-brand" href="#">Portal</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav d-flex flex-row justify-content-between">
                        <asp:Button class="btn btn-outline-success px-5 mx-3" type="button" runat="server" ID="HomePage" Text="Home" OnClick="GoToAdminPage"></asp:Button>
                        <%--                        <button class="btn btn-outline-success px-5 mx-3" type="button">Main button</button>--%>
                        <asp:Button class="btn btn-outline-secondary px-5 mx-3" type="button" runat="server" ID="gtCustomerPage" Text="Go to Customers page" OnClick="GoToCustomerPage"></asp:Button>
                        <asp:Button class="btn btn-outline-secondary px-5 mx-3 mr-5" type="button" runat="server" ID="gtProductPage" Text="Go to Products page" OnClick="GoToProductsPage"></asp:Button>
                        <asp:Button class="btn btn-outline-secondary px-5 ml-5 align-self-end" type="button" Text="Logout" runat="server" OnClick="Logout" ID="lgtBtn"></asp:Button>

                    </div>
                </div>
            </nav>


            <%--Modal Add button--%>
            <button type="button" class="btn btn-primary my-5" id="newProduct" data-toggle="modal" data-target="#productModal">
                <i class="mr-1 fa fa-plus"></i>Add New
            </button>
            <!--Add Product Modal -->
            <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="productModalLabel">Add Product</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="alert alert-danger d-none text-center w-75 m-auto" role="alert" id="customerError">
                                Please Enter Valid customer Data
                            </div>
                            <div class="alert alert-success d-none text-center w-75 m-auto" role="alert" id="customerSuccess">
                                Customer has been added successfully
                            </div>


                            <div class="form-group ">
                                <label for="productName">Product Name</label>
                                <input type="text" name="productName" id="productName" class="form-control" />
                            </div>
                            <div class="form-group ">
                                <label for="productCost">Cost</label>
                                <input type="text" name="productCost" id="productCost" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="productSalePrice">Sale Price</label>
                                <input type="text" name="productSalePrice" id="productSalePrice" class="form-control" />
                            </div>


                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <%--<button type="button" class="btn btn-primary" id="addProduct">Add Product</button>--%>
                            <asp:Button Text="Add Product" runat="server" ID="addProductBtn" CssClass="btn btn-primary" OnClientClick="return Add()" />
                        </div>
                    </div>
                </div>
            </div>


            <%--Modal Add button--%>
            <%--<button type="button" class="btn btn-primary my-5" id="updateProduct"  data-toggle="modal" data-target="#productUpdateModal">
                <i class="mr-1 fa fa-plus"></i>Add New
            </button>--%>
            <!--Update Product Modal -->
            <div class="modal fade" id="productUpdateModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="productUpdateModalLabel">Update Product</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="alert alert-danger d-none text-center w-75 m-auto" role="alert" id="customerUpdateError">
                                Please Enter Valid customer Data
                            </div>
                            <div class="alert alert-success d-none text-center w-75 m-auto" role="alert" id="customerUpdateSuccess">
                                Customer has been added successfully
                            </div>


                            <div class="form-group ">
                                <label for="productUpdateName">Product Name</label>
                                <input type="text" name="productUpdateName" id="productUpdateName" class="form-control" />
                            </div>
                            <div class="form-group ">
                                <label for="productUpdateCost">Cost</label>
                                <input type="text" name="productUpdateCost" id="productUpdateCost" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="productUpdateSalePrice">Sale Price</label>
                                <input type="text" name="productUpdateSalePrice" id="productUpdateSalePrice" class="form-control" />
                            </div>


                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <%--<button type="button" class="btn btn-primary" id="addProduct">Add Product</button>--%>
                            <asp:Button Text="Update Product" runat="server" ID="updateBtn" CssClass="btn btn-primary" OnClientClick="return updateProduct()" />
                        </div>
                    </div>
                </div>
            </div>

            <%--            //OLD--%>
            <%--<div class="d-flex justify-content-between my-3 mx-2">
                <asp:Label runat="server" ID="lblId" Text="ID"></asp:Label>
                <asp:TextBox runat="server" ID="id" Text="optional..... "></asp:TextBox>
                <asp:Label runat="server" ID="lblName" Text="Name"></asp:Label>
                <asp:TextBox runat="server" ID="name"></asp:TextBox>
                <asp:Label runat="server" ID="lblCost" Text="Cost"></asp:Label>
                <asp:TextBox runat="server" ID="cost"></asp:TextBox>
                <asp:Label runat="server" ID="lblSalePrice" Text="Sale Price"></asp:Label>
                <asp:TextBox runat="server" ID="salePrice"></asp:TextBox>

                <asp:Button runat="server" CssClass="btn btn-outline-success px-5 py-2" ID="addBtn" Text="Add" OnClientClick="javascript: return Add()" />
                <asp:Button runat="server" CssClass="btn btn-outline-success px-5 py-2" ID="editBtn" Text="Edit" OnClientClick="javascript: return editProduct()" />

            </div>--%>

            <table id="productTable" class="display">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Cost</th>
                        <th>Sale Price ($)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
            </table>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'ProductTable.aspx/GetProductList',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                responsive: true,
                async: false,
                success: function (data) {
                    $('#productTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                "targets": 0, "data": "ProductId", "searchable": true
                            },
                            {
                                "targets": 1, "data": "ProductName", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 2, "data": "ProductCost", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 3, "data": "ProductSalePrice", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 4,
                                "data": "ProductId",
                                "render": function (data, type, row, meta) {
                                    //'<button type="button" class="btn btn-primary" id="edit" onclick="editProduct(' + data + ')">Edit</button>'

                                    var editButton = '<button type="button" class="btn btn-primary updateProduct" data-toggle="modal"  data-target="#productUpdateModal" onclick="editProduct(' + data + ')"><i class="mr-1 fa fa-plus"></i>Update</button>';
                                    var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteProduct(' + data + ')">Delete</button>';
                                    return editButton + " | " + deleteButton;
                                },
                                "sortable": false,
                                "searchable": false,
                                "visible": true,
                            }
                        ]
                    })
                }
            });

            //Delete rows


            //$('#productTable').on('click', '.remove', function () {
            //    var table = $('#productTable').DataTable();
            //    var row = $(this).parents('tr');

            //    $('#productTable tbody').on('click', 'tr', function () {
            //        console.log(table.row(this).data().ProductId);
            //    });

            //    if ($(row).hasClass('child')) {
            //        table.row($(row).prev('tr')).remove().draw();
            //        console.log(table.row(this).data().ProductId);


            //    } else {
            //        table
            //            .row($(this).parents('tr'))
            //            .remove()
            //            .draw();
            //    }

            //});
        })
        //Add new item
        function Add() {
            var name = document.getElementById("productName").value;
            var cost = document.getElementById("productCost").value;
            var salePrice = document.getElementById("productSalePrice").value;
            try {
                //if (!name || !cost || !salePrice) {
                //    throw "Please enter complete info";
                //    return false;
                //}
                $.ajax({
                    url: 'ProductTable.aspx/AddProduct',
                    type: 'post',
                    data: JSON.stringify({ "name": name, "cost": cost, "salePrice": salePrice }),
                    contentType: 'application/json',
                    async: false,

                    success: function (data) {
                        var newTable = $('#productTable').DataTable();

                        newTable.destroy();

                        document.getElementById("productName").value = "";
                        document.getElementById("productCost").value = "";
                        document.getElementById("productCost").value = "";

                        $('#productTable').dataTable({
                            data: JSON.parse(data.d),

                            columns: [
                                {
                                    "targets": 0, "data": "ProductId", "searchable": true
                                },
                                {
                                    "targets": 1, "data": "ProductName", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 2, "data": "ProductCost", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 3, "data": "ProductSalePrice", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 4,
                                    "data": "ProductId",
                                    "render": function (data, type, row, meta) {
                                        var editButton = '<button type="button" class="btn btn-primary updateProduct" data-toggle="modal"  data-target="#productUpdateModal" onclick="editProduct(' + data + ')"><i class="mr-1 fa fa-plus"></i>Update</button>';
                                        var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteProduct(' + data + ')">Delete</button>';
                                        return editButton + " | " + deleteButton;
                                    },
                                    "sortable": false,
                                    "searchable": false,
                                    "visible": true,
                                }
                            ]
                        })
                    }
                })

                return true;
            }
            catch (err) {
                alert(err);
            }
        }


        function deleteProduct(data) {

            let target = data;
            $.ajax({
                url: 'ProductTable.aspx/DeleteProduct',
                type: 'post',
                data: JSON.stringify({ "index": target }),
                contentType: 'application/json',
                async: false,
                success: function (data) {
                    var newTable = $('#productTable').DataTable();

                    newTable.destroy();


                    $('#productTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                "targets": 0, "data": "ProductId", "searchable": true
                            },
                            {
                                "targets": 1, "data": "ProductName", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 2, "data": "ProductCost", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 3, "data": "ProductSalePrice", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 4,
                                "data": "ProductId",
                                "render": function (data, type, row, meta) {
                                    var editButton = '<button type="button" class="btn btn-primary updateProduct" data-toggle="modal"  data-target="#productUpdateModal" onclick="editProduct(' + data + ')"><i class="mr-1 fa fa-plus"></i>Update</button>';
                                    var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteProduct(' + data + ')">Delete</button>';
                                    return editButton + " | " + deleteButton;
                                },
                                "sortable": false,
                                "searchable": false,
                                "visible": true,
                            }
                        ]
                    })
                }
            })

        }

        function editProduct(data) {
            $('#updateBtn').attr('onclick', 'return updateProduct(' + data + ')');
        }
        function updateProduct(data) {
            let target = data;

            var name = document.getElementById("productUpdateName").value;
            var cost = document.getElementById("productUpdateCost").value;
            var salePrice = document.getElementById("productUpdateSalePrice").value;
            //var id = document.getElementById("id").value;

            try {
                //if (!name || !cost || !salePrice) {
                //    throw "Please enter complete info";
                //    return false;
                //}
                $.ajax({
                    url: 'ProductTable.aspx/EditProduct',
                    type: 'post',
                    data: JSON.stringify({ "id": target, "name": name, "cost": cost, "salePrice": salePrice }),
                    contentType: 'application/json',
                    async: false,
                    success: function (data) {
                        var newTable = $('#productTable').DataTable();

                        newTable.destroy();

                        document.getElementById("name").value = "";
                        document.getElementById("cost").value = "";
                        document.getElementById("salePrice").value = "";

                        $('#productTable').dataTable({
                            data: JSON.parse(data.d),
                            columns: [
                                {
                                    "targets": 0, "data": "ProductId", "searchable": true
                                },
                                {
                                    "targets": 1, "data": "ProductName", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 2, "data": "ProductCost", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 3, "data": "ProductSalePrice", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 4,
                                    "data": "ProductId",
                                    "render": function (data, type, row, meta) {
                                        var editButton = '<button type="button" class="btn btn-primary updateProduct" data-toggle="modal"  data-target="#productUpdateModal" onclick="editProduct(' + data + ')"><i class="mr-1 fa fa-plus"></i>Update</button>';
                                        var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteProduct(' + data + ')">Delete</button>';
                                        return editButton + " | " + deleteButton;
                                    },
                                    "sortable": false,
                                    "searchable": false,
                                    "visible": true,
                                }
                            ]
                        })
                    }
                })


            }
            catch (err) {
                alert(err);
            }

            return true;
        }
    </script>
</body>
</html>
