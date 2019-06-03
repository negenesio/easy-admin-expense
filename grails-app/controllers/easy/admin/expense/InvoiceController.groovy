package easy.admin.expense

import easy.admin.expense.enums.InvoiceStatus
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class InvoiceController {

    InvoiceService invoiceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def finish() {
        println "INVOICE: [finish: params:["+params.toString()+"]]"
        Invoice invoice = Invoice.findById(params.'invoice-select-finished');
        invoice.status = InvoiceStatus.FINISHED
        invoice.save(flush:true, failOnError:true)
        if(invoice.hasErrors()){
            invoice.errors.allErrors.each {
                LOG.error("[FAIL-ERROR] [UPDATE INVOCE] - [MESSAGE: ${it}]")
            }
        }
        redirect(action: "administrator", controller: "invoice")
    }

    def getDetaiLByInvoce() {
        println "INVOICE: [getDetaiLByInvoce: params:["+params.toString()+"]]"
        String invoiceIdResult = params.invoiceId
        Invoice invoice = Invoice.findById(invoiceIdResult)

        if(invoice == null) {
            return null
        }

        List<Detail> details = Detail.findAllByInvoice(invoice)

        if(details.isEmpty()) {
            return null
        }

        BigDecimal total = 0;
        details.each { detail ->
            total += detail.amount * detail.cant
        }

        render(view: "/templates/_detailList", model:[detailList:details, invoice: invoice, total:total])
    }

    def administrator() {
        println "INVOICE: [administrator: params:["+params.toString()+"]]"
        List<Invoice> invoiceList = Invoice.findAll()
        return [invoices:invoiceList]
    }

    def index(Integer max) {
        println "INVOICE: [index: params:["+params.toString()+"]]"
        params.max = Math.min(max ?: 10, 100)
        respond invoiceService.list(params), model:[invoiceCount: invoiceService.count()]
    }

    def show(Long id) {
        respond invoiceService.get(id)
    }

    def create() {
        println "INVOICE: [create: params:["+params.toString()+"]]"
        respond new Invoice(params)
        return [clientId:params.clientId]
    }

    def save(Invoice invoice) {
        invoice.creationDate = new Date()
        invoice.status = InvoiceStatus.PENDING
        invoice.save(flush:true, failOnError:true)

        redirect (action: 'create', controller: 'detail', params:[invoiceIdResult:invoice.id])
    }

    def edit(Long id) {
        respond invoiceService.get(id)
    }

    def update(Invoice invoice) {
        if (invoice == null) {
            notFound()
            return
        }

        try {
            invoiceService.save(invoice)
        } catch (ValidationException e) {
            respond invoice.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'invoice.label', default: 'Invoice'), invoice.id])
                redirect invoice
            }
            '*'{ respond invoice, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        invoiceService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'invoice.label', default: 'Invoice'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoice.label', default: 'Invoice'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
