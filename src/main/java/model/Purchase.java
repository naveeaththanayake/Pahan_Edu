package model;

public class Purchase {
    private int cashierId;
<<<<<<< HEAD
    private String customerPhone; // Changed from int customerId
    private String itemId;
    private int quantity;

    public Purchase(int cashierId, String customerPhone, String itemId, int quantity) { // Changed constructor
=======
    private String customerPhone;
    private String itemId;
    private int quantity;

    public Purchase(int cashierId, String customerPhone, String itemId, int quantity) {
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
        this.cashierId = cashierId;
        this.customerPhone = customerPhone;
        this.itemId = itemId;
        this.quantity = quantity;
    }

    public int getCashierId() { return cashierId; }
    public void setCashierId(int cashierId) { this.cashierId = cashierId; }
    public String getCustomerPhone() { return customerPhone; } // Changed from getCustomerId
<<<<<<< HEAD
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; } // Changed from setCustomerId
=======
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
    public String getItemId() { return itemId; }
    public void setItemId(String itemId) { this.itemId = itemId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}