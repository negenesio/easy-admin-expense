package easy.admin.expense

import easy.admin.expense.enums.ClientType

class BootStrap {

    def init = { servletContext ->
        Client nico = new Client(firstName: "Nicolas", surname: "Genesio", email: "nicolas.genesio@gmail.com", phone: "03512418483", type: ClientType.OTHER, creationDate: new Date(), brithDate: new Date()).save(failOnError:true)
        Client santi = new Client(firstName: "Santiago", surname: "Socin", email: "santiago.socin@gmail.com", phone: "03512112233", type: ClientType.WORK, creationDate: new Date(), brithDate: new Date()).save(failOnError:true)

        Product cheddar = new Product(name: "Cheddar 2.25kg", amount: 500, stock: 100, creationDate: new Date()).save(failOnError:true)
        Product patitas = new Product(name: "Patitas Pollo 45u", amount: 200, stock: 50, creationDate: new Date()).save(failOnError:true)
        Product papas = new Product(name: "Papas 2.25kg", amount: 300, stock: 25, creationDate: new Date()).save(failOnError:true)

        Invoice invoiceNico = new Invoice(creationDate: new Date(), client: nico).save(failOnError:true)
        Invoice invoiceSanti = new Invoice(creationDate: new Date(), client: santi).save(failOnError:true)

        Detail detailCheddarNico = new Detail(creationDate: new Date(), cant: 1, product: cheddar, amount: 500, invoice: invoiceNico).save(failOnError:true)
        Detail detailCheddarSanti = new Detail(creationDate: new Date(), cant: 1, product: cheddar, amount: 500, invoice: invoiceSanti).save(failOnError:true)
        Detail detailPapasSanti = new Detail(creationDate: new Date(), cant: 1, product: papas, amount: 500, invoice: invoiceSanti).save(failOnError:true)

        println "Cantidad de clientes: "+Client.findAll().size()
        println "Cantidad de detalles: "+Detail.findAll().size()
        println "Cantidad de productos: "+Product.findAll().size()
        println "Cantidad de facturas: "+Invoice.findAll().size()

    }
    def destroy = {
    }
}
