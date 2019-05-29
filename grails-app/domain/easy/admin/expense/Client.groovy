package easy.admin.expense

import easy.admin.expense.enums.ClientType

class Client {

    String firstName
    String surname
    Date brithDate
    Date creationDate
    String email
    String phone
    ClientType type

    static constraints = {
    }
}
