<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountantHome.aspx.cs" Inherits="TradeApp.AccountantHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home: Accountant</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark">
                <a class="navbar-brand" href="#">Accountant Portal</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav d-flex flex-row justify-content-between">
                        <asp:Button class="btn btn-outline-success px-5 mx-3" type="button" runat="server" ID="aHomePage" Text="Home" OnClick="GoToHome"></asp:Button>
                        <%--                        <button class="btn btn-outline-success px-5 mx-3" type="button">Main button</button>--%>
                        <asp:Button class="btn btn-outline-secondary px-5 mx-3" type="button" runat="server" ID="gtCustomerPage" Text="Go to Customers page" OnClick="GoToCustomerPage"></asp:Button>
                        <asp:Button class="btn btn-outline-secondary px-5 mx-3 mr-5" type="button" runat="server" ID="gtProductPage" Text="Go to Products page" OnClick="GoToProductsPage"></asp:Button>
                        <asp:Button class="btn btn-outline-secondary px-5 ml-5 align-self-end" type="button" Text="Logout" runat="server" OnClick="Logout" ID="lgtBtn"></asp:Button>

                    </div>
                </div>
            </nav>
            <h1 runat="server" id="greeting"></h1>

            <%--            <asp:Button runat="server" ID="lgtBtn" Text="Logout" OnClick="Logout" />--%>
        </div>
    </form>
</body>
</html>
