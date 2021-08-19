/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblorderdetail;

import java.io.Serializable;

/**
 *
 * @author sasuk
 */
public class TblOrderDetailDTO implements Serializable {

    private String productId;
    private int amount;
    private float price;
    private int orderId;
    private float discount;
    public TblOrderDetailDTO() {
    }

    public TblOrderDetailDTO(String productId, int amount, float price, int orderId, float discount) {
        this.productId = productId;
        this.amount = amount;
        this.price = price;
        this.orderId = orderId;
        this.discount = discount;
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

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }
    

}
