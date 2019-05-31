<%@ page import="easy.admin.expense.Client;" contentType="text/html;charset=UTF-8" %>
<div class="modal-header">
    <h5 class="modal-title">Factura Nº: ${invoice.id}</h5>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body center-right" style="padding-top: 0px;">
    <table class="table border-0">
        <tbody>
            <tr>
                <td style="border-top: 0px;padding-bottom: 0px;padding-top: 0px;"> <label style="font-size: 14px; font-weight: bold;">Cliente:</label> ${invoice.client.firstName +" "+invoice.client.surname}</td>
            </tr>
            <g:if test="${invoice.client.email != null}">
                <tr>
                    <td style="border-top: 0px;padding-bottom: 0px;padding-top: 0px;"> <label style="font-size: 14px; font-weight: bold;">Email:</label> ${invoice.client.email}</td>
                </tr>
            </g:if>
            <g:if test="${invoice.client.phone != null}">
                <tr>
                    <td style="border-top: 0px;padding-bottom: 0px;padding-top: 0px;"> <label style="font-size: 14px; font-weight: bold;">Telefono:</label> ${invoice.client.phone}</td>
                </tr>
            </g:if>
            <tr>
                <td style="border-top: 0px;padding-bottom: 0px;padding-top: 0px;"> <label style="font-size: 14px; font-weight: bold;">Fecha Creacion:</label> <g:formatDate format="dd/MM/yyyy" date="${invoice.creationDate}"/></td>
            </tr>
        </tbody>
    </table>
    %{--tabla detail list--}%
    <table class="table table-bordered table-hover center-table">

        <caption style="text-align: right;padding-right: 5px;"><label style="font-size: 14px; font-weight: bold;">Total:</label> ${detailList.amount.sum()}</caption>
       <thead>
       <th scope="col">#</th>
       <th scope="col">Producto</th>
       <th scope="col">Precio</th>
       <th scope="col">Cantidad</th>
       <th scope="col">Total</th>
       </thead>
       <tbody>
        <g:each in="${detailList}" var="detail" status="counter">
            <tr>
                <th scope="row">${counter+1}</th>
                <td> ${detail.product.name}</td>
                <td>$${detail.amount}</td>
                <td> ${detail.cant}</td>
                <td> ${detail.amount * detail.cant}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

