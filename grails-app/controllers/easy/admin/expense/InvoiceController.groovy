package easy.admin.expense

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class InvoiceController {

    InvoiceService invoiceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond invoiceService.list(params), model:[invoiceCount: invoiceService.count()]
    }

    def show(Long id) {
        respond invoiceService.get(id)
    }

    def create() {
        respond new Invoice(params)
    }

    def save(Invoice invoice) {
        if (invoice == null) {
            notFound()
            return
        }

        try {
            invoiceService.save(invoice)
        } catch (ValidationException e) {
            respond invoice.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'invoice.label', default: 'Invoice'), invoice.id])
                redirect invoice
            }
            '*' { respond invoice, [status: CREATED] }
        }
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
