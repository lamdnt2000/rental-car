/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblorder;

import dntlam.tblproduct.TblProductDTO;
import dntlam.utiles.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.naming.NamingException;

/**
 *
 * @author sasuk
 */
public class TblOrderDAO implements Serializable {

    private List<TblOrderDTO> listHistory;
    private List<TblProductDTO> listProduct;

    public TblOrderDTO createOrder(String member, Date rentalDate, Date returnDate) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        TblOrderDTO result = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                int status = 0;
                String query = "INSERT INTO Orders (member,status,rentalDate,returnDate,createDate) "
                        + "VALUES (?,?,?,?,?)";
                stm = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
                stm.setString(1, member);
                stm.setInt(2, status);
                stm.setTimestamp(3, new Timestamp(rentalDate.getTime()));
                stm.setTimestamp(4, new Timestamp(returnDate.getTime()));
                Timestamp createDate = new Timestamp(new Date().getTime());
                stm.setTimestamp(5, createDate);
                int row = stm.executeUpdate();
                if (row > 0) {
                    rs = stm.getGeneratedKeys();
                    if (rs.next()) {
                        int orderId = rs.getInt(1);
                        result = new TblOrderDTO(orderId, null, null, createDate, member, 0, status);
                    }

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
        return result;
    }

    public boolean updateOrder(TblOrderDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE Orders SET status = ?, total = ? "
                        + "WHERE id=?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, dto.getStatus());
                stm.setFloat(2, dto.getTotal());
                stm.setInt(3, dto.getId());
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
            return result;
        }
    }

    public void searchHistory(String name, Date rentalDateSearch, String member) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String queryName = (!"".equals(name)) ? "AND P.name LIKE ? " : "";
                String queryRentalDate = (rentalDateSearch!=null) ? "AND O.rentalDate = ? ":"";
                String sql = "SELECT DISTINCT O.id,O.total,O.createDate,O.rentalDate,O.returnDate,O.status "
                        + "FROM Orders O, OrderDetail I, Product P "
                        + "WHERE member = ? "
                        + "AND O.status>=0 "
                        + "AND O.id = I.orderId "
                        + "AND I.productId = P.id "
                        + queryName
                        + queryRentalDate
                        + "ORDER BY O.createDate DESC";
                int count = 0;
                stm = con.prepareStatement(sql);
                stm.setString(++count, member);
                if (!"".equals(queryName)) {
                    stm.setString(++count, "%" + name + "%");
                }
                if (!"".equals(queryRentalDate)) {
                    stm.setTimestamp(++count, new Timestamp(rentalDateSearch.getTime()));
                }

                rs = stm.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    float total = rs.getFloat("total");
                    Timestamp createDate = rs.getTimestamp("createDate");
                    Timestamp rentalDate = rs.getTimestamp("rentalDate");
                    Timestamp returnDate = rs.getTimestamp("returnDate");
                    int status = rs.getInt("status");
                    TblOrderDTO dto = new TblOrderDTO(id, rentalDate, returnDate, createDate, "", total, status);
                    if (listHistory == null) {
                        listHistory = new ArrayList<>();
                    }
                    listHistory.add(dto);
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
    }

    public void searchProductByOrderId(int id, String member) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT I.productId ,I.amount,I.price,I.discount,P.name "
                        + "FROM Orders O, OrderDetail I, Product P "
                        + "WHERE O.member = ? "
                        + "AND O.Id = ? "
                        + "AND O.id = I.orderId "
                        + "AND I.productId = P.id ";
                int count = 0;
                stm = con.prepareStatement(sql);
                stm.setString(++count, member);
                stm.setInt(++count, id);
                rs = stm.executeQuery();

                while (rs.next()) {

                    String productID = rs.getString("productId");
                    int amount = rs.getInt("amount");
                    float price = rs.getFloat("price");
                    String name = rs.getString("name");
                    float discount = rs.getFloat("discount");
                    TblProductDTO dto = new TblProductDTO(productID, name, null, id, price*(1-discount), amount, 0, 0);
                    if (listProduct == null) {
                        listProduct = new ArrayList<>();
                    }
                    listProduct.add(dto);
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
    }
    
    public boolean deleteOrder(int orderId, String email) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE Orders SET status = ? "
                        + "WHERE id=? "
                        + "AND member=? "
                        + "AND rentalDate>?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, 0);
                stm.setInt(2, orderId);
                stm.setString(3, email);
                stm.setTimestamp(4, new Timestamp(new Date().getTime()));
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
            return result;
        }
    }
    
    public List<TblOrderDTO> getListHistory() {
        return listHistory;
    }

    public List<TblProductDTO> getListProduct() {
        return listProduct;
    }

}
