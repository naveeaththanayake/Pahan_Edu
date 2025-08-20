package model;

public class Cashier {
    private int cashierId;
    private String username;
    private String password;

    public Cashier(int cashierId, String username, String password) {
        this.cashierId = cashierId;
        this.username = username;
        this.password = password;
    }

    public int getCashierId() {
        return cashierId;
    }

    public void setCashierId(int cashierId) {
        this.cashierId = cashierId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}