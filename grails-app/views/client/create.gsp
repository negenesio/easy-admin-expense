<%@ page import="easy.admin.expense.enums.ClientType" %>
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
        <g:form id="formSaveClient" controller="client" action="save" method="POST">
            <div class="row justify-content-center" style="padding-top: 20px">
            <div class="col-12 col-md-8 col-lg-6 pb-5">
                <div class="card rounded-0">
                    <div class="card-header p-0">
                        <div class="bg-info text-white text-center py-2">
                            <h3><i class="fa fa-user"></i> Crear Cliente</h3>
                        </div>
                    </div>
                    <div class="card-body p-3">
                        <!--Body-->
                        <div class="form-group">
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-address-card text-info"></i></div>
                                </div>
                                <input type="text" id="first-name" name="first-name" placeholder="ingrese su nombre" onkeyup="validationClientSave()"/>
                            </div>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-address-card text-info"></i></div>
                                </div>
                                <input type="text" id="surname" name="surname" placeholder="ingrese su apellido" onkeyup="validationClientSave()"/>

                            </div>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-birthday-cake text-info"></i></div>
                                </div>
                                <input name="birthday-date" id="birthday-date" width="250px" onkeyup="validationClientSave()"/>
                            </div>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-at text-info"></i></div>
                                </div>
                                <input type="email" id="email" name="email" placeholder="ingrese su email" style="width: 250px;" onkeyup="validationClientSave()"/>
                            </div>
                        <div class="input-group mb-2">
                            <div class="input-group-prepend">
                                <div class="input-group-text input-group-text-v2"><i class="fa fa-phone text-info"></i></div>
                            </div>
                            <input name="phone" id="phone" type="text" onkeyup="validationClientSave();"/>
                        </div>

                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text input-group-text-v2"><i class="fa fa-user-cog text-info"></i></div>
                                </div>
                                <g:select id="client-type" name="client-type" noSelection="['':'Seleccione un Tipo']" optionValue="value"  optionKey="key" from="${easy.admin.expense.enums.ClientType}" class="form-control selectpicker selectpicker-client-type" data-live-search="true" style="background-color: #ccc;overflow-x: hidden; overflow-y: scroll;" required="">
                                </g:select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <input type="submit" id="save-client" value="Crear Cliente" class="btn btn-info btn-block rounded-0 py-2" disabled>
                </div>
            </div>
        </div>
    </g:form>
    </div>
    <script>
        $(document).ready(function () {
            $("#save-client").click(function () {
                if(validatePhone()) {
                    $('#phone').rules('add', {
                        required: false   // overwrite an existing rule
                    });
                }
            });

                $('#formSaveClient').validate({
                    bubblePosition: "bottom",
                    bubbleGapTop: 10,
                    bubbleGapLeft: -5,
                    rules: {
                        'first-name': {
                            required: true
                        },
                        surname: {
                            required: true
                        },
                        email: {
                            required: true,
                            email: true
                        },
                        phone: {
                            required: {
                                depends: function(element) {
                                    return ($("#phone").val() == "" || $("#phone").inputmask("isComplete"));
                                }
                            }
                        },
                        'client-type': {
                            required: true
                        },
                        'birthday-date': {
                            required: true
                        }
                    },
                    messages: {
                        phone: {
                            required: "",
                        }
                    },
                    highlight: function (element) {
                        $(element).closest('.control-group').removeClass('success').addClass('error');
                    },
                    success: function (element) {
                        element.text('').addClass('valid')
                            .closest('.control-group').removeClass('error').addClass('success');
                    }
                });

            $('#birthday-date').datepicker({
                uiLibrary: 'bootstrap4',
                locale: 'es-es',
            });

            $("#client-type").change(function () {
                validationClientSave();
            });

            $("#phone").inputmask("(999) 999-9999");
        });

        function validationClientSave() {
            if(validateFirstName() && validateSurname() && validateEmail() && validatePhone() && validateBirthdayDate()) {
                if($("#client-type").val() == ""){
                    $("#save-client").attr("disabled", true);
                } else {
                    $("#save-client").attr("disabled", false);
                }
            } else {
                $("#save-client").attr("disabled", true);
            }
        }

        function validatePhone() {
            return ($("#phone").val() == "" || $("#phone").inputmask("isComplete"));
        }

        function validateBirthdayDate() {
            if($("#birthday-date").val() != ""){
                return true;
            }
            return false;
        }

        function validateFirstName() {
            if($("#first-name").val() != ""){
                return true;
            }
            return false;
        }

        function validateSurname() {
            if($("#surname").val() != ""){
                return true;
            }
            return false;
        }

        function validateEmail() {
            if($("#email").val() != ""){
                return true;
            }
            return false;
        }

    </script>
    </body>
</html>
