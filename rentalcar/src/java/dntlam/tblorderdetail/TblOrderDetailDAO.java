/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblorderdetail;

import dntlam.utiles.DBHelper;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author sasuk
 */
public class TblOrderDetailDAO {

    public boolean addProductToCart(TblOrderDetailDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO OrderDetail (orderId,productId,amount,price,discount) "
                        + "SELECT ?,?,?,?,? "
                        + "WHERE (SELECT quantity FROM Product WHERE id=?) >=?";
                stm = con.prepareStatement(sql);
                int count = 0;
                stm.setInt(++count, dto.getOrderId());
                stm.setString(++count, dto.getProductId());
                stm.setInt(++count, dto.getAmount());
                stm.setFloat(++count, dto.getPrice());
                stm.setDouble(++count, (double)Math.round(dto.getDiscount() * 100) / 100);
                stm.setString(++count, dto.getProductId());
                stm.setInt(++count, dto.getAmount());
                int row = stm.executeUpdate();
                if (row > 0) {
                    result = true;
                }
            }
        } finally {

            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }
}
