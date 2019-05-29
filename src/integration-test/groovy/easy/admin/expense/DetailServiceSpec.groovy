package easy.admin.expense

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DetailServiceSpec extends Specification {

    DetailService detailService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Detail(...).save(flush: true, failOnError: true)
        //new Detail(...).save(flush: true, failOnError: true)
        //Detail detail = new Detail(...).save(flush: true, failOnError: true)
        //new Detail(...).save(flush: true, failOnError: true)
        //new Detail(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //detail.id
    }

    void "test get"() {
        setupData()

        expect:
        detailService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Detail> detailList = detailService.list(max: 2, offset: 2)

        then:
        detailList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        detailService.count() == 5
    }

    void "test delete"() {
        Long detailId = setupData()

        expect:
        detailService.count() == 5

        when:
        detailService.delete(detailId)
        sessionFactory.currentSession.flush()

        then:
        detailService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Detail detail = new Detail()
        detailService.save(detail)

        then:
        detail.id != null
    }
}
