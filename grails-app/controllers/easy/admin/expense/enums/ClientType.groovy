package easy.admin.expense.enums

enum ClientType {

    WORK("trabajo"),
    OTHER("otros"),
    FRIEND("amigo"),
    FAMILY("familia")

    private final String value

    ClientType(String value){
        this.value = value
    }

    private String value() { return value }

    public static ClientType getStatus(String value) {
        try {
            return ClientType.valueOf(value.toUpperCase());
        } catch (NullPointerException | IllegalArgumentException ignored) {
            return null;
        }
    }

    String toString() { value }
    String getKey() { name() }

}