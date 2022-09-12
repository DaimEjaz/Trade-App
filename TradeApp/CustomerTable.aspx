<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerTable.aspx.cs" Inherits="TradeApp.CustomerTable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Customer List</title>

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

            <div class="d-flex justify-content-between my-3 mx-2">
                <asp:Label runat="server" ID="lblId" Text="ID"></asp:Label>
                <asp:TextBox runat="server" ID="id" Text="optional..."></asp:TextBox>
                <asp:Label runat="server" ID="lblName" Text="Name"></asp:Label>
                <asp:TextBox runat="server" ID="name"></asp:TextBox>
                <asp:Label runat="server" ID="lblCost" Text="Address"></asp:Label>
                <asp:TextBox runat="server" ID="address"></asp:TextBox>


                <asp:Button runat="server" CssClass="btn btn-outline-success px-5 py-2" ID="addBtn" Text="Add" OnClientClick="javascript: return Add()" />
<%--                <asp:Button runat="server" CssClass="btn btn-outline-success px-5 py-2" ID="editBtn" Text="Edit" OnClientClick="javascript: return editCustomer()" />--%>
                <asp:Button runat="server" CssClass="btn btn-outline-success px-5 py-2" ID="Button2" Text="Generate Bill" OnClientClick="javascript: return generateBill()" />


            </div>


            <table id="customerTable" class="display">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
            </table>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {

            $.ajax({
                url: 'CustomerTable.aspx/GetCustomerList',
                method: 'post',
                dataType: 'json',
                contentType: 'application/json',
                async: false,
                success: function (data) {
                    console.log(data);
                    $('#customerTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                "targets": 0, "data": "Id", "searchable": true
                            },
                            {
                                "targets": 1, "data": "Name", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 2, "data": "Address", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 3,
                                "data": "Id",
                                "render": function (data, type, row, meta) {
                                    var editButton = '<button type="button" class="btn btn-primary" id="edit" onclick="editCustomer(' + data + ')">Edit</button>';
                                    var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteCustomer(' + data + ')">Delete</button>';
                                    return editButton + " | " + deleteButton;
                                },
                                "sortable": false,
                                "searchable": false,
                                "visible": true
                            }
                        ]
                    })
                }
            });
        })

        //Add new item
        function Add() {
            var name = document.getElementById("name").value;
            var address = document.getElementById("address").value;
            //var salePrice = document.getElementById("salePrice").value;
            try {
                if (!name || !address) {
                    throw "Please enter complete info";
                    return false;
                }
                $.ajax({
                    url: 'CustomerTable.aspx/AddCustomer',
                    type: 'post',
                    data: JSON.stringify({ "name": name, "address": address }),
                    contentType: 'application/json',
                    async: false,
                    success: function (data) {
                        var newTable = $('#customerTable').DataTable();

                        newTable.destroy();

                        document.getElementById("name").value = "";
                        document.getElementById("address").value = "";

                        $('#customerTable').dataTable({
                            data: JSON.parse(data.d),
                            columns: [
                                {
                                    "targets": 0, "data": "Id", "searchable": true
                                },
                                {
                                    "targets": 1, "data": "Name", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 2, "data": "Address", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 3,
                                    "data": "Id",
                                    "render": function (data, type, row, meta) {
                                        var editButton = '<button type="button" class="btn btn-primary" id="edit" onclick="editCustomer(' + data + ')">Edit</button>';
                                        var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteCustomer(' + data + ')">Delete</button>';
                                        return editButton + " | " + deleteButton;
                                    },
                                    "sortable": false,
                                    "searchable": false,
                                    "visible": true
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


        function deleteCustomer(data) {

            let target = data;
            $.ajax({
                url: 'CustomerTable.aspx/DeleteCustomer',
                type: 'post',
                data: JSON.stringify({ "index": target }),
                contentType: 'application/json',
                async: false,
                success: function (data) {
                    var newTable = $('#customerTable').DataTable();

                    newTable.destroy();


                    $('#customerTable').dataTable({
                        data: JSON.parse(data.d),
                        columns: [
                            {
                                "targets": 0, "data": "Id", "searchable": true
                            },
                            {
                                "targets": 1, "data": "Name", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 2, "data": "Address", "sortable": true, "searchable": true
                            },
                            {
                                "targets": 3,
                                "data": "Id",
                                "render": function (data, type, row, meta) {
                                    var editButton = '<button type="button" class="btn btn-primary" id="edit" onclick="editCustomer(' + data + ')">Edit</button>';
                                    var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteCustomer(' + data + ')">Delete</button>';
                                    return editButton + " | " + deleteButton;
                                },
                                "sortable": false,
                                "searchable": false,
                                "visible": true
                            }
                        ]
                    })
                }
            })

        }


        function editCustomer() {
            var name = document.getElementById("name").value;
            var address = document.getElementById("address").value;
            var id = document.getElementById("id").value;
            try {
                if (!name || !address || isNaN(id)) {
                    throw "Please enter complete info";
                    return false;
                }
                $.ajax({
                    url: 'CustomerTable.aspx/EditCustomer',
                    type: 'post',
                    data: JSON.stringify({ "id": id, "name": name, "address": address }),
                    contentType: 'application/json',
                    async: false,
                    success: function (data) {
                        var newTable = $('#customerTable').DataTable();

                        newTable.destroy();

                        document.getElementById("name").value = "";
                        document.getElementById("address").value = "";

                        $('#customerTable').dataTable({
                            data: JSON.parse(data.d),
                            columns: [
                                {
                                    "targets": 0, "data": "Id", "searchable": true
                                },
                                {
                                    "targets": 1, "data": "Name", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 2, "data": "Address", "sortable": true, "searchable": true
                                },
                                {
                                    "targets": 3,
                                    "data": "Id",
                                    "render": function (data, type, row, meta) {
                                        var editButton = '<button type="button" class="btn btn-primary" id="edit" onclick="editCustomer(' + data + ')">Edit</button>';
                                        var deleteButton = '<button type="button" class="btn btn-danger" id="delete1" onclick="deleteCustomer(' + data + ')">Delete</button>';
                                        return editButton + " | " + deleteButton;
                                    },
                                    "sortable": false,
                                    "searchable": false,
                                    "visible": true
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

        function generateBill() {
            var name = document.getElementById("name").value;
            var address = document.getElementById("address").value;
            var id = document.getElementById("id").value;
            try {
                if (name || address || isNaN(id)) {
                    throw "Please enter current info";
                    return false;
                }
                $.ajax({
                    url: 'CustomerTable.aspx/GenerateBill',
                    type: 'post',
                    data: JSON.stringify({ "id": id }),
                    contentType: 'application/json',
                    async: false,
                    success: function (data) {
                        alert(`The bill for this customer is: ${data.d}`);
                    }
                })

                return true;
            }
            catch (err) {
                alert(err);
            }
        }

    </script>

</body>
</html>
