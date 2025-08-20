package model;

public class Purchase {
    private int cashierId;
    private String customerPhone;
    private String itemId;
    private int quantity;

    public Purchase(int cashierId, String customerPhone, String itemId, int quantity) {
        this.cashierId = cashierId;
        this.customerPhone = customerPhone;
        this.itemId = itemId;
        this.quantity = quantity;
    }

    public int getCashierId() { return cashierId; }
    public void setCashierId(int cashierId) { this.cashierId = cashierId; }
    public String getCustomerPhone() { return customerPhone; } // Changed from getCustomerId
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    public String getItemId() { return itemId; }
    public void setItemId(String itemId) { this.itemId = itemId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}