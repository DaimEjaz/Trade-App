<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="TradeApp.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous"/>
    <style>
        body{
            display: flex;
            justify-content:center;
            align-items: center;
            height: 100vh;
            background-color:cadetblue;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="container">
            <h1 id="heading">Login into Portal</h1>
            <p runat="server" id="message"></p>
            <br />

            <asp:Label runat="server" ID="userNameLabel" Text="Enter your username: "></asp:Label>
            <asp:TextBox runat="server" ID="username"></asp:TextBox>
            <br />

            <asp:Label runat="server" ID="passwordLabel" Text="Enter your password:"></asp:Label>
            <asp:TextBox runat="server" ID="password"></asp:TextBox>
            <br />

            <asp:DropDownList runat="server" ID="dropdown">
                <asp:ListItem Value="Admin">Admin</asp:ListItem>
                <asp:ListItem Value="Accountant">Accountant</asp:ListItem>
            </asp:DropDownList>

            <asp:Button CssClass="btn btn-success" runat="server" ID="loginBtn" Text="Login" OnClick="Login" />
        </div>
    </form>
</body>
</html>