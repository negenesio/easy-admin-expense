package easy.admin.expense

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class DetailController {

    DetailService detailService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond detailService.list(params), model:[detailCount: detailService.count()]
    }

    def show(Long id) {
        respond detailService.get(id)
    }

    def create() {
        respond new Detail(params)
        Invoice invoice = Invoice.findById(params.invoiceId)
        return render(view: 'create', model:[invoice:invoice])
    }

    def save(Detail detail) {
        if (detail == null) {
            notFound()
            return
        }

        try {
            detailService.save(detail)
        } catch (ValidationException e) {
            respond detail.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'detail.label', default: 'Detail'), detail.id])
                redirect detail
            }
            '*' { respond detail, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond detailService.get(id)
    }

    def update(Detail detail) {
        if (detail == null) {
            notFound()
            return
        }

        try {
            detailService.save(detail)
        } catch (ValidationException e) {
            respond detail.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'detail.label', default: 'Detail'), detail.id])
                redirect detail
            }
            '*'{ respond detail, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        detailService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'detail.label', default: 'Detail'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'detail.label', default: 'Detail'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
