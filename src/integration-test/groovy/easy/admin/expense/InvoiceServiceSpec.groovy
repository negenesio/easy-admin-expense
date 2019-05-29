package easy.admin.expense

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class InvoiceServiceSpec extends Specification {

    InvoiceService invoiceService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Invoice(...).save(flush: true, failOnError: true)
        //new Invoice(...).save(flush: true, failOnError: true)
        //Invoice invoice = new Invoice(...).save(flush: true, failOnError: true)
        //new Invoice(...).save(flush: true, failOnError: true)
        //new Invoice(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //invoice.id
    }

    void "test get"() {
        setupData()

        expect:
        invoiceService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Invoice> invoiceList = invoiceService.list(max: 2, offset: 2)

        then:
        invoiceList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        invoiceService.count() == 5
    }

    void "test delete"() {
        Long invoiceId = setupData()

        expect:
        invoiceService.count() == 5

        when:
        invoiceService.delete(invoiceId)
        sessionFactory.currentSession.flush()

        then:
        invoiceService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Invoice invoice = new Invoice()
        invoiceService.save(invoice)

        then:
        invoice.id != null
    }
}
