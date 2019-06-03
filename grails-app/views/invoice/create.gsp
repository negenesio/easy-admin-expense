<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
    </head>
    <body>
    <div class="container">
        <div class="row justify-content-center" style="padding-top: 20px;">
            <div class="col-12 col-md-8 col-lg-6 pb-5">
                <!--Form with header-->
                <g:form resource="${this.invoice}" method="POST">
                    <div class="card rounded-0">
                        <div class="card-header p-0">
                            <div class="bg-info text-white text-center py-2">
                                <h3><i class="fa fa-file-invoice-dollar"></i> Crear Facturacion</h3>
                            </div>
                        </div>
                        <div class="card-body p-3">
                            <!--Body-->
                            <div class="form-group">
                                <div class="input-group mb-2">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text"><i class="fa fa-users text-info"></i></div>
                                    </div>
                                    <select id="client" name="client" class="form-control selectpicker" title="Seleccione un Cliente" data-live-search="true" style="background-color: #ccc;overflow-x: hidden; overflow-y: scroll;" required>
                                        <g:each in="${easy.admin.expense.Client.list()}">
                                            <g:if test="${params.clientId == it.id.toString()}">
                                                <option selected value="${it?.id}">${it?.firstName+" "+it.surname}</option>
                                            </g:if>
                                            <g:else>
                                                <option value="${it?.id}">${it?.firstName+" "+it.surname}</option>
                                            </g:else>
                                        </g:each>
                                    </select>
                                </div>
                            </div>
                        </div>
                            <div class="text-center">
                                <input type="submit" value="Crear Factura" class="btn btn-info btn-block rounded-0 py-2">
                            </div>
                        </div>

                    </div>
                </g:form>
                <!--Form with header-->
            </div>
        </div>
    </div>
   %{-- <input id="dateCreation" width="270" class="form-control" name="dateCreation" required/>


    %{--<script>
        $('#dateCreation').datepicker({
            uiLibrary: 'bootstrap4'
        });
    </script>--}%

    </body>
</html>
