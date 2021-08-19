/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tblorderdetail;

import dntlam.tblproduct.TblProductDTO;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author sasuk
 */
public class CartObj implements Serializable {

    private Map<TblProductDTO, Integer> items;

    public Map<TblProductDTO, Integer> getItems() {
        return items;
    }

    public void addItemToCart(TblProductDTO product, int quantity) {
        if (this.items == null) {
            items = new HashMap<>();
        }
        int amount = 0;
        if (this.items.containsKey(product)) {
            amount = this.items.get(product);
        }
        this.items.put(product, amount + quantity);
    }

    public void removeItemFromCart(String productId) {
        if (this.items == null) {
            return;
        }
        TblProductDTO product = new TblProductDTO();
        product.setId(productId);
        if (this.items.containsKey(product)) {
            this.items.remove(product);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }

    }

    public TblProductDTO getProductFromId(String productId) {
        if (this.items == null || this.items.isEmpty()) {
            return null;
        }
        for (TblProductDTO dto : this.items.keySet()) {
            if (dto.getId().equals(productId)) {
                return dto;
            }
        }
        return null;
    }

    public boolean updateQuantity(String productId, int quantity) {
        TblProductDTO product = getProductFromId(productId);
        if (product == null) {
            return false;
        }
        this.items.put(product, quantity);
        return true;
    }

    public float getTotalPrice() {
        if (this.items == null || this.items.isEmpty()) {
            return 0;
        }
        float total = 0;
        for (TblProductDTO dto : this.items.keySet()) {
            total += dto.getPrice() * items.get(dto)*dto.getSale();
        }
        return total;
    }

    public List<String> getAllListProduct() {
        if (this.items == null || this.items.isEmpty()) {
            return null;
        }
        List<String> listProductId = new ArrayList<>();
        for (TblProductDTO product : items.keySet()) {
            listProductId.add(product.getId());
        }
        return listProductId;
    }


    public void removeSale() {
        if (this.items == null || this.items.isEmpty()) {
            return;
        }
        for (TblProductDTO productDTO : items.keySet()) {
            if (productDTO.getSale() != 1) {
                productDTO.setSale(0);
                productDTO.setSaleId("");
            }
        }
    }
}
