<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'invoice.label', default: 'Invoice')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
    <div class="col-12 col-md-8 col-lg-6 pb-5">
    <!--Form with header-->
        <g:form resource="${this.detail}" method="POST">
            <div class="card border-primary rounded-0">
                <div class="card-header p-0">
                    <div class="bg-info text-white text-center py-2">
                        <h3><i class="fa fa-shopping-cart"></i> Crear Detalle</h3>
                    </div>
                </div>
                <div class="card-body p-3">
                    <!--Body-->
                    <div class="form-group">
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text"><i class="fa fa-drumstick-bite text-info"></i></div>
                            </div>
                            <select id="product" name="product" class="form-control selectpicker" title="Seleccione un Producto" data-live-search="true" style="background-color: #ccc;overflow-x: hidden; overflow-y: scroll;" required>
                                <g:each in="${easy.admin.expense.Product.list()}">
                                    <option value="${it?.id}">${it?.name}</option>
                                </g:each>
                            </select>
                        </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text"><i class="fa fa-calculator text-info"></i></div>
                            </div>
                            <input type="number" id="cant" name="cant" />
                        </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text"><i class="fa fa-money-bill-alt text-info"></i></div>
                            </div>
                            <input type="number" id="amount" name="amount" />
                        </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text"><i class="fa fa-users text-info"></i></div>
                            </div>
                            <g:if test="${invoice?.id}">
                                <input type="text" readonly value="${invoice.client.firstName +' '+invoice.client.surname}"/>
                            </g:if>
                            <g:else>
                                <select id="invoice-select" name="invoice-select" class="form-control selectpicker" title="Seleccione una Factura" data-live-search="true" style="background-color: #ccc;overflow-x: hidden; overflow-y: scroll;" required>
                                    <g:each in="${easy.admin.expense.Invoice.list()}">
                                        <option value="${it?.id}">${it?.client.firstName+" "+it.client.surname+" - "+it.creationDate}</option>
                                    </g:each>
                                </select>
                            </g:else>
                            <input type="hidden" id="invoice" name="invoice" value="${invoice?.id}"/>
                        </div>

                    </div>
                </div>
                <div class="text-center">
                    <input type="submit" value="Crear siguiente Detalle" class="btn btn-info btn-block rounded-0 py-2">
                </div>
                <br>
                <div class="text-center">
                    <input type="submit" value="Finalizar Factura" class="btn btn-info btn-block rounded-0 py-2">
                </div>
            </div>

            </div>
        </g:form>
    <!--Form with header-->
    </div>
</div>
</div>
<script>
    $( document ).ready(function() {
        var invoiceIdValue = $("#invoice").val();
        if(invoiceIdValue) {
            $("#invoice").val(invoiceIdValue);
        } else {
            $("#invoice-select").change(function () {
                $("#invoice").val($("#invoice-select").val());
            });
        }
    });
</script>
</body>
</html>
