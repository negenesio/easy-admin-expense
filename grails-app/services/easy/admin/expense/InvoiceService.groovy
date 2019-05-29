package easy.admin.expense

import grails.gorm.services.Service

@Service(Invoice)
interface InvoiceService {

    Invoice get(Serializable id)

    List<Invoice> list(Map args)

    Long count()

    void delete(Serializable id)

    Invoice save(Invoice invoice)

}