<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>


        <style>
            .center-table {
                  text-align: center;
              }

            .row-border-0 {
                border-top-width: 0px;
                border-top: 0px;
            }
    </style>
    </head>
    <body>

    %{--tabla facturas--}%
    <div class="container" style="width: 40%">
        <table class="table table-bordered table-hover center-table">
            <caption><strong></bold><i class="fas fa-file-invoice-dollar fa-2x"></i> Lista de facturaciones.</strong></caption>
            <thead>
                <th scope="col">#</th>
                <th scope="col">Nombre</th>
                <th scope="col">Fecha Creacion</th>
                <th scope="col">Acciones</th>
            </thead>
            <tbody>
            <g:each in="${invoices}" var="invoice">
                <tr>
                    <th scope="row">${invoice.id}</th>
                    <td> ${invoice.client.firstName+" "+invoice.client.surname} </td>
                    <td> <g:formatDate format="dd/MM/yyyy" date="${invoice.creationDate}"/> </td>
                    <td onclick="modalClick(this);" data-toggle="modal" id="button-detail-modal" data-id="${invoice.id}" data-target=".detailModal"><i style="font-size: 20px" class="fas fa-search-dollar"></i></td>
                </tr>
            </g:each>
            </tbody>

        </table>
    </div>

    %{--modal factura detalles--}%
    <div class="modal fade detailModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div id="detailModalDiv"></div>
            </div>
        </div>
    </div>


    <script>
        function modalClick(modal) {
           var invoiceId = $(modal).attr("data-id");

            jQuery.ajax(
                {
                    type:'POST',
                    data: 'invoiceId=' + invoiceId,
                    url:'/invoice/detailModal',
                    success:function(data,textStatus) {
                        jQuery('#detailModalDiv').html(data);
                    }
                });
        }

        // $('#button-detail-modal').on('shown.bs.modal', function () {
        //alert("hola");

        //var test =
        //alert(test);
        /*  $.ajax({
              url:URL,
              data: {id:'1'},
              success: function(resp){
                  console.log(resp);
                  $("#author").val(resp.author);
                  $("#book").val(resp.bookName);
              }
          });*/
        // });
        //});


    </script>
    </body>
</html>
