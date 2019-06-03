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
    <div class="container">
        <div class="row justify-content-center" style="padding-top: 20px">
            <div class="col-12 col-md-8 col-lg-6 pb-5">
                <div class="card-header p-0">
                    <div class="bg-info text-white text-center py-2">
                        <h3><i class="fa fa-clipboard-list"></i> Administrar Facturas</h3>
                    </div>
                </div>
                <table class="table table-bordered table-hover center-table">
                    <caption><strong></bold><i class="fas fa-file-invoice-dollar fa-2x"></i> Lista de facturaciones.</strong></caption>
                    <thead>
                    <th scope="col">#</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Fecha Creacion</th>
                    <th scope="col">Estado</th>
                    <th scope="col">Acciones</th>
                    </thead>
                    <tbody>
                    <g:each in="${invoices}" var="invoice">
                        <tr>
                            <th scope="row">${invoice.id}</th>
                            <td> ${invoice.client.firstName+" "+invoice.client.surname} </td>
                            <td> <g:formatDate format="dd/MM/yyyy" date="${invoice.creationDate}"/> </td>
                            <td> ${invoice.status} </td>
                            <td onclick="modalClick(this);" data-toggle="modal" id="button-detail-modal" data-id="${invoice.id}" data-target=".detailModal"><i style="font-size: 20px" class="fas fa-search-dollar"></i></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <!--Form with header-->
        </div>
    </div>

    %{--modal factura detalles--}%
    <div class="modal fade detailModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="card-header p-0">
                    <div class="bg-info text-white text-center py-2">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true" style="margin-right: 20px;font-size: 30px;"><i class="fa fa-times"></i></span>
                        </button>
                        <h3><i class="fa fa-list"></i> Detalle de Factura</h3>
                    </div>
                </div>
                <div class="modal-header">
                    <h5 class="modal-title" id="titleDetailList">Factura Nº: ${invoice?.id}</h5>
                </div>
                <div class="modal-body center-right" style="padding-top: 0px;">
                    <div id="detailModalDiv"></div>
                </div>
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
                    url:"${createLink(controller:'invoice',action:'getDetaiLByInvoce')}",
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
