package model;

import java.sql.Timestamp;

public class Bill {
    private int billId;
    private String accountNumber;
    private String details;
    private double totalAmount;
    private Timestamp date;

    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public Timestamp getDate() { return date; }
    public void setDate(Timestamp date) { this.date = date; }
}
