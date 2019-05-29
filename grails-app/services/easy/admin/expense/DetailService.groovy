package easy.admin.expense

import grails.gorm.services.Service

@Service(Detail)
interface DetailService {

    Detail get(Serializable id)

    List<Detail> list(Map args)

    Long count()

    void delete(Serializable id)

    Detail save(Detail detail)

}