package model;

public class Customer {
    private String accountNumber;
    private String name;
    private String address;
    private String phone;

    // ✅ Default no-arg constructor (needed for JSP/Servlet frameworks)
    public Customer() {
    }

    // ✅ Constructor with all fields (used in CustomerServlet)
    public Customer(String accountNumber, String name, String address, String phone) {
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.phone = phone;
    }

    // ✅ Getters & Setters
    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
