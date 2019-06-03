<%@ page import="easy.admin.expense.enums.InvoiceStatus" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />

    <style>
    .input-group-text-v2 {
        width: 40px;
        height: 34px;
    }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center" style="padding-top: 20px">
    <div class="col-12 col-md-8 col-lg-6 pb-5">
    <!--Form with header-->
        <g:form resource="${this.detail}" method="POST" id="save">
            <div class="card rounded-0">
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
                                <div class="input-group-text input-group-text-v2"><i class="fa fa-drumstick-bite text-info"></i></div>
                            </div>
                            <select id="product" name="product" class="form-control selectpicker selectpicker-product" title="Seleccione un Producto" data-live-search="true" style="background-color: #ccc;overflow-x: hidden; overflow-y: scroll;" required>
                                <option selected value> -- Seleccione un Producto -- </option>
                                <g:each in="${easy.admin.expense.Product.list()}">
                                    <option value="${it?.id}">${it?.name}</option>
                                </g:each>
                            </select>
                        </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text input-group-text-v2"><i class="fa fa-calculator text-info"></i></div>
                            </div>
                            <input type="number" id="cant" name="cant" value="0" min="1" onkeyup="validateDetailSave()"/>
                        </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text input-group-text-v2"><i class="fa fa-money-bill-alt text-info"></i></div>
                            </div>
                            <input type="number" id="amount" name="amount" value="0" min="1" onkeyup="validateDetailSave()"/>
                        </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text input-group-text-v2"><i class="fa fa-users text-info"></i></div>
                            </div>
                            <select id="invoice-select" name="invoice-select" class="form-control selectpicker" title="Seleccione una Factura" data-live-search="true" style="background-color: #ccc;overflow-x: hidden; overflow-y: scroll;" required>
                                <g:if test="${invoiceSelect}">
                                    <option value> -- Seleccione una Factura -- </option>
                                </g:if>
                                <g:else>
                                    <option selected value> -- Seleccione una Factura -- </option>
                                </g:else>
                                <g:each in="${easy.admin.expense.Invoice.findAllByStatus(easy.admin.expense.enums.InvoiceStatus.PENDING)}">
                                    <g:if test="${invoiceSelect?.id == "${it.id}"}">
                                        <option selected value="${it?.id}">${it?.client.firstName+" "+it.client.surname+" - "+it.creationDate}</option>
                                    </g:if>
                                    <g:else>
                                        <option value="${it?.id}">${it?.client.firstName+" "+it.client.surname+" - "+it.creationDate}</option>
                                    </g:else>
                                </g:each>
                            </select>
                            <input type="hidden" id="invoice" name="invoice" value="${invoiceSelect?.id}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <input type="button" id="save-detail" value="Crear siguiente Detalle" class="btn btn-info btn-block rounded-0 py-2" disabled>
                <input type="hidden" name="invoice-select-save" id="invoice-select-saved"/>
            </div>
            <br>
            </g:form>
            <div class="text-center" id="div-list-detail" hidden="true" style="border-style: solid; border-color:#dfdfdf">
                %{--tabla lista detalle--}%
                <h5 id="titleDetailList"></h5>
                <div id="listDetailDiv"></div>
            </div>
            <div class="text-center">
                <g:form action="finish" controller="invoice">
                    <input type="submit" id="finishInvoice" value="Finalizar Factura" class="btn btn-info btn-block rounded-0 py-2" hidden="true">
                    <input type="hidden" name="invoice-select-finished" id="invoice-select-finished"/>
                </g:form>
            </div>
    </div>

        <!--Form with header-->
    </div>
</div>

<script>
    $( document ).ready(function() {
        $("#save-detail").click(function () {
            jQuery.ajax({
                type:'POST',
                data: {cant:$('#cant').val(), productId:$('#product').val(), amount: $("#amount").val(), invoiceIdResult:$("#invoice-select").val()},
                url:"${createLink(controller:'detail',action:'save')}",
                success:function(data,textStatus) {
                    updateDetailListSection();
                    clearDetail();
                    $("html, body").animate({ scrollTop: $(document).height() }, 1000);

                }
            });
        })

        $('#invoice-select').change(function () {
            updateDetailListSection();
            $("#invoice-select-finished").val($('#invoice-select').val());
            validateDetailSave();
        })

        $('#product').change(function () {
            validateDetailSave();
        });
        setValueDetailInvoiceSelect("${params.invoiceIdResult}")
    });

    function updateDetailListSection() {
        if($('#invoice-select').val() != "") {
            jQuery.ajax({
                type: 'POST',
                data: 'invoiceId=' + $('#invoice-select').val(),
                url: "${createLink(controller:'invoice',action:'getDetaiLByInvoce')}",
                success: function (data, textStatus) {
                    if (data != null) {
                        jQuery('#listDetailDiv').html(data);
                        showOrHideSection();
                    }
                }
            });
        }
    }

    function setValueDetailInvoiceSelect(value) {
        $('#invoice-select').val(value);
        $('#invoice-select').selectpicker('refresh');
        $('#invoice-select').change();
    }

    function showOrHideSection() {
        if($("#invoice-select").val() == "") {
            validateDetailSave();
            $("#finishInvoice").attr("hidden", true);
            $("#div-list-detail").attr("hidden", true);
        } else {
            validateDetailSave();
            $("#finishInvoice").attr("hidden", false);
            $("#div-list-detail").attr("hidden", false);
        }
    }

    function clearDetail() {
        $("#cant").val("0");
        $("#amount").val("0");
        $("#product").val("0");
        $("#product").val(null);
        $("#product").selectpicker('refresh');
        showOrHideSection();
    }

    function validateDetailSave() {
        if(invoiceValidator() && cantValidator() && productValidator() && amountValidator()) {
            if($("#invoice-select").val() == "") {
                $("#save-detail").attr("disabled", true);
            } else {
                $("#save-detail").attr("disabled", false);
            }
        } else {
            $("#save-detail").attr("disabled", true);
        }
    }

    function invoiceValidator() {
        if($("#invoice-select").val() != "") {
            return true;
        }
        return false;
    }

    function cantValidator() {
        if($("#cant").val() != "0" && $("#cant").val() != "") {
            return true;
        }
        return false;
    }

    function productValidator() {
        if($("#product").val() != "") {
            return true;
        }
        return false;
    }

    function amountValidator() {
        if($("#amount").val() != "0" && $("#amount").val() != "") {
            return true;
        }
        return false;
    }
</script>
</body>
</html>
