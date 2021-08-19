/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblproduct;

import java.io.Serializable;

/**
 *
 * @author sasuk
 */
public class Parameter implements Serializable{
    private String name;
    private int status;
    private int catId;
    private int page;

    public Parameter() {
    }

    public Parameter(String name, int status, int catId) {
        this.name = name;
        this.status = status;
        this.catId = catId;
    }
    
    
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }


    
    
}
