/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tbldiscount;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author sasuk
 */
public class TblDiscountDTO implements Serializable{
    private String id;
    private String title;
    private float sale;
    private Timestamp createDate;
    private Timestamp expiryDate;

    public TblDiscountDTO(String id, String title, float sale, Timestamp createDate, Timestamp expiryDate) {
        this.id = id;
        this.title = title;
        this.sale = sale;
        this.createDate = createDate;
        this.expiryDate = expiryDate;
    }

    public TblDiscountDTO() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public float getSale() {
        return sale;
    }

    public void setSale(float sale) {
        this.sale = sale;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Timestamp getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Timestamp expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    
    
}
