/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tbldiscount;

import dntlam.utiles.DBHelper;
import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import javax.naming.NamingException;

/**
 *
 * @author sasuk
 */
public class TblDiscountDAO implements Serializable{
    public TblDiscountDTO checkValidCode(String code) throws SQLException, NamingException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblDiscountDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT id, sale, title,expiryDate "
                        + "FROM Discount "
                        + "WHERE id=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, code);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String title = rs.getString("title");
                    float price = rs.getFloat("sale");
                    Timestamp expiryDate = rs.getTimestamp("expiryDate");
                    dto = new TblDiscountDTO(code, title, price, null, expiryDate);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }
    
    
}
