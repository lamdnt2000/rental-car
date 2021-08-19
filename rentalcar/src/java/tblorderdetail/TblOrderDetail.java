/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tblorderdetail;

/**
 *
 * @author sasuk
 */
public class TblOrderDetail {
    private int orderId;
    private String productId;
    private int amount;
    private float price;
    private int id;

    public TblOrderDetail(int orderId, String productId, int amount, float price, int id) {
        this.orderId = orderId;
        this.productId = productId;
        this.amount = amount;
        this.price = price;
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
}
