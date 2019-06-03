<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
    <style>
        .center-table {
          text-align: center;
        }
    </style>
    </head>
    <body>
    %{--tabla productos--}%
    <div class="container">
        <div class="row justify-content-center" style="padding-top: 20px">
            <div class="col-18 col-md-14 col-lg-10 pb-10">
                <div class="card-header p-0">
                    <div class="bg-info text-white text-center py-2">
                        <h3><i class="fa fa-shopping-cart"></i> Administrar Detalles</h3>
                    </div>
                </div>
                <table class="table table-bordered table-hover center-table">
                    <caption><strong></bold><i class="fas fa-box-open fa-2x"></i> Lista de Detalles.</strong></caption>
                    <thead>
                    <th scope="col">#</th>
                    <th scope="col">Producto</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Numero Factura</th>
                    <th scope="col">Cliente</th>
                    <th scope="col">Fecha Creacion</th>
                    </thead>
                    <tbody>
                    <g:each in="${detailList}" var="detail">
                        <tr>
                            <th scope="row">${detail.id}</th>
                            <td> ${detail.product.name} </td>
                            <td> ${detail.cant} </td>
                            <td> ${detail.amount} </td>
                            <td> ${detail.invoice.id} </td>
                            <td> ${detail.invoice.client.firstName +" "+detail.invoice.client.firstName} </td>
                            <td> <g:formatDate format="dd/MM/yyyy" date="${detail.creationDate}"/> </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </body>
</html>
