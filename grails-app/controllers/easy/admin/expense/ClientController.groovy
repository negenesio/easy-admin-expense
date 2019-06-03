package easy.admin.expense

import easy.admin.expense.enums.ClientType
import grails.validation.ValidationException

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*

class ClientController {

    ClientService clientService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def administrator() {
        List<Client> clientList = Client.findAll()
        return [clientList:clientList]
    }
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond clientService.list(params), model:[clientCount: clientService.count()]
    }

    def show(Long id) {
        respond clientService.get(id)
    }

    def create() {
        respond new Client(params)
    }

    def save() {
        println "CLIENT: [save: params:["+params.toString()+"]]"
        Client client = new Client();
        client.creationDate = new Date();
        client.type = ClientType.getStatus(params."client-type")
        client.firstName = params."first-name"
        client.surname = params.surname
        client.brithDate = new SimpleDateFormat("dd/mm/yyyy").parse(params."birthday-date")
        client.email = params.email
        client.phone = params.phone
        client.save(flush:true, failOnError:true)
        redirect(action: "create", controller: "invoice", params: [clientId:client.id])
    }

    def edit(Long id) {
        respond clientService.get(id)
    }

    def update(Client client) {
        if (client == null) {
            notFound()
            return
        }

        try {
            clientService.save(client)
        } catch (ValidationException e) {
            respond client.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'client.label', default: 'Client'), client.id])
                redirect client
            }
            '*'{ respond client, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        clientService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'client.label', default: 'Client'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'client.label', default: 'Client'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
