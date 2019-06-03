package easy.admin.expense

import easy.admin.expense.enums.InvoiceStatus

class Invoice {

    Date creationDate
    Client client
    InvoiceStatus status

    static constraints = {
    }
}
