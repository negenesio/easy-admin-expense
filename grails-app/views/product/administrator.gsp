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
            <div class="col-12 col-md-8 col-lg-6 pb-5">
                <div class="card-header p-0">
                    <div class="bg-info text-white text-center py-2">
                        <h3><i class="fa fa-box-open"></i> Administrar Productos</h3>
                    </div>
                </div>
                <table class="table table-bordered table-hover center-table">
                    <caption><strong></bold><i class="fas fa-box-open fa-2x"></i> Lista de Productos.</strong></caption>
                    <thead>
                    <th scope="col">#</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Stock</th>
                    <th scope="col">Fecha Creacion</th>
                    </thead>
                    <tbody>
                    <g:each in="${productList}" var="product">
                        <tr>
                            <th scope="row">${product.id}</th>
                            <td> ${product.name} </td>
                            <td> ${product.amount} </td>
                            <td> ${product.stock} </td>
                            <td> <g:formatDate format="dd/MM/yyyy" date="${product.creationDate}"/> </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </body>
</html>
