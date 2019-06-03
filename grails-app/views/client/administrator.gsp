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
                        <h3><i class="fa fa-users"></i> Administrar Clientes</h3>
                    </div>
                </div>
                <table class="table table-bordered table-hover center-table">
                    <caption><strong></bold><i class="fas fa-box-open fa-2x"></i> Lista de Clientes.</strong></caption>
                    <thead>
                    <th scope="col">#</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Email</th>
                    <th scope="col">Telefono</th>
                    <th scope="col">Tipo</th>
                    <th scope="col">Fecha de Cumpleaños</th>
                    <th scope="col">Fecha Creacion</th>
                    </thead>
                    <tbody>
                    <g:each in="${clientList}" var="client">
                        <tr>
                            <th scope="row">${client.id}</th>
                            <td> ${client.firstName+" "+client.surname}</td>
                            <td> ${client.email} </td>
                            <td> ${client.phone} </td>
                            <td> ${client.type.value()} </td>
                            <td> <g:formatDate format="dd/MM/yyyy" date="${client.brithDate}"/> </td>
                            <td> <g:formatDate format="dd/MM/yyyy" date="${client.creationDate}"/> </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </body>
</html>
