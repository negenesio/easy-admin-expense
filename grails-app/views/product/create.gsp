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
    <g:form id="formSaveProduct" controller="product" action="save" method="POST">
        <div class="row justify-content-center" style="padding-top: 20px">
            <div class="col-12 col-md-8 col-lg-6 pb-5">
                <div class="card rounded-0">
                    <div class="card-header p-0">
                        <div class="bg-info text-white text-center py-2">
                            <h3><i class="fa fa-box-open"></i> Crear Producto</h3>
                        </div>
                    </div>
                    <div class="card-body p-3">
                        <!--Body-->
                        <div class="form-group">
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-drumstick-bite text-info"></i></div>
                                </div>
                                <input type="text" id="name" name="name" placeholder="Nombre del producto." onkeyup="validationProductSave()"/>
                            </div>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-dollar-sign text-info"></i></div>
                                </div>
                                <input type="number" id="amount" name="amount" value="0" min="1" onkeyup="validationProductSave()"/>
                            </div>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-calculator text-info"></i></div>
                                </div>
                                <input type="number" min="1" name="stock" id="stock" value="0" width="250px" onkeyup="validationProductSave()"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <input type="submit" id="save-product" value="Crear Producto" class="btn btn-info btn-block rounded-0 py-2" disabled>
                </div>
            </div>
        </div>
    </g:form>
</div>
<script>
    $(document).ready(function () {
        $('#formSaveClient').validate({
            bubblePosition: "bottom",
            bubbleGapTop: 10,
            bubbleGapLeft: -5,
            rules: {
                amount: {
                    required: true
                },
                stock: {
                    required: true
                },
                name: {
                    required: true,
                    email: true
                },
            },
            highlight: function (element) {
                $(element).closest('.control-group').removeClass('success').addClass('error');
            },
            success: function (element) {
                element.text('').addClass('valid')
                    .closest('.control-group').removeClass('error').addClass('success');
            }
        });
    });

    function validationProductSave() {
        if(validateAmount() && validateName() && validateStock()) {
            $("#save-product").attr("disabled", false);
        } else {
            $("#save-product").attr("disabled", true);
        }
    }

    function validateName() {
        if($("#name").val() != ""){
            return true;
        }
        return false;
    }

    function validateStock() {
        if($("#stock").val() != "0" && $("#stock").val() != "") {
            return true;
        }
        return false;
    }

    function validateAmount() {
        if($("#amount").val() != "0" && $("#amount").val() != "") {
            return true;
        }
        return false;
    }

</script>
</body>
</html>
