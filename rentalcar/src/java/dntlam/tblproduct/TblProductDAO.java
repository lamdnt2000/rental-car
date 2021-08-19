/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblproduct;

import dntlam.utiles.DBHelper;
import java.io.Serializable;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author sasuk
 */
public class TblProductDAO implements Serializable {

    final int QUESTION_PER_PAGE = 20;
    private List<TblProductDTO> listCar;

    public boolean createCar(TblProductDTO dto) throws SQLException, NamingException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "INSERT INTO Product (id,name,color,catId,price,quantity,year,status,userCreate,createDate) "
                        + "VALUES (?,?,?,?,?,?,?,?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, dto.getId());
                stm.setString(2, dto.getName());
                stm.setString(3, dto.getColor());
                stm.setInt(4, dto.getCatId());
                stm.setFloat(5, dto.getPrice());
                stm.setInt(6, dto.getQuantity());
                stm.setInt(7, dto.getYear());
                stm.setInt(8, dto.getStatus());
                stm.setString(9, dto.getUserCreate());
                Date currentDate = new Date();
                stm.setTimestamp(10, new Timestamp(currentDate.getTime()));
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

    public int countCar(Parameter param) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int row = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String catQuery = (param.getCatId() > 0) ? "AND catId = ?" : "";

                String sql = "SELECT COUNT(id) "
                        + "FROM Product "
                        + "WHERE status = ? "
                        + "AND name LIKE ? "
                        + catQuery;
                stm = con.prepareStatement(sql);
                stm.setInt(1, param.getStatus());
                stm.setString(2, "%" + param.getName() + "%");
                if (!"".equals(catQuery)) {
                    stm.setInt(3, param.getCatId());
                }
                rs = stm.executeQuery();
                if (rs.next()) {
                    row = rs.getInt(1);
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
        return row;
    }

    public int countCarSearch(Parameter param, int amount) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int row = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String catQuery = (param.getCatId() > 0) ? "AND catId = ? " : "";

                String sql = "SELECT TOP 1 SUM(COUNT(id)) OVER() as totalRow,SUM(quantity) OVER() as totalQuantity "
                        + "FROM Product "
                        + "WHERE status = ? "
                        + "AND name LIKE ? "
                        + catQuery
                        + "AND quantity>0 "
                        + "GROUP BY id, quantity ";
                stm = con.prepareStatement(sql);
                stm.setInt(1, param.getStatus());
                stm.setString(2, "%" + param.getName() + "%");
                if (!"".equals(catQuery)) {
                    stm.setInt(3, param.getCatId());
                }
                rs = stm.executeQuery();
                if (rs.next()) {
                    int totalQuantity = rs.getInt("totalQuantity");
                    if (totalQuantity >= amount) {
                        row = rs.getInt("totalRow");
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
        return row;
    }

    public void findAllCar(Parameter param, boolean checkQuantity) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String queryCat = (param.getCatId() > 0) ? "AND P.catId = ? " : "";
                String queryQuantity = (checkQuantity) ? "AND P.quantity>0 " : "";
                String sql = "SELECT P.id, P.name, P.color, P.quantity, P.year, P.price, P.catId, P.createDate, C.name as catName "
                        + "FROM Product P, Category C "
                        + "WHERE P.status = ? "
                        + "AND P.name LIKE ? "
                        + queryCat
                        + queryQuantity
                        + "AND P.catId = C.id "
                        + "ORDER BY P.createDate DESC "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                int count = 0;
                stm = con.prepareStatement(sql);
                stm.setInt(++count, param.getStatus());
                stm.setString(++count, "%" + param.getName() + "%");
                if (queryCat != "") {
                    stm.setInt(++count, param.getCatId());
                }
                stm.setInt(++count, (param.getPage() - 1) * QUESTION_PER_PAGE);
                stm.setInt(++count, QUESTION_PER_PAGE);
                rs = stm.executeQuery();

                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    String color = rs.getString("color");
                    String catName = rs.getString("catName");
                    int catId = rs.getInt("catId");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    int year = rs.getInt("year");
                    Timestamp createDate = rs.getTimestamp("createDate");
                    TblProductDTO dto = new TblProductDTO(id, name, color, catId, price, quantity, year, param.getStatus());
                    dto.setCatName(catName);
                    dto.setCreateDate(createDate);
                    if (listCar == null) {
                        listCar = new ArrayList<>();
                    }
                    listCar.add(dto);
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

    public TblProductDTO findCarById(String id) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblProductDTO result = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT P.id, P.name, P.catId, P.color, P.price, P.quantity, P.year, P.status, C.name as catName "
                        + "FROM Product P, Category C "
                        + "WHERE P.id=? "
                        + "AND P.catId = C.id";

                stm = con.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int catId = rs.getInt("catId");
                    int quantity = rs.getInt("quantity");
                    int year = rs.getInt("year");
                    int status = rs.getInt("status");
                    String name = rs.getString("name");
                    String catName = rs.getString("catName");
                    String color = rs.getString("color");
                    float price = rs.getFloat("price");
                    result = new TblProductDTO(id, name, color, catId, price, quantity, year, status);
                    result.setCatName(catName);
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

    public boolean updateCar(TblProductDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "UPDATE Product "
                        + "SET name=?,catId=?,color=?,status=?,price=?,quantity=?,year=?,updateDate=?,userUpdate=? "
                        + "WHERE id=?";
                stm = con.prepareStatement(query);
                stm.setString(1, dto.getName());
                stm.setInt(2, dto.getCatId());
                stm.setString(3, dto.getColor());
                stm.setInt(4, dto.getStatus());
                stm.setFloat(5, dto.getPrice());
                stm.setInt(6, dto.getQuantity());
                stm.setInt(7, dto.getYear());
                Date date = new Date();
                stm.setTimestamp(8, new Timestamp(date.getTime()));
                stm.setString(9, dto.getUserUpdate());
                stm.setString(10, dto.getId());
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

    public boolean updateQuantityCheckOut(String productId, int quantity) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "UPDATE Product "
                        + "SET quantity=quantity - ? "
                        + "WHERE id=?";
                stm = con.prepareStatement(query);
                stm.setInt(1, quantity);
                stm.setString(2, productId);
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

    public boolean updateQuantityDelete(int orderId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "UPDATE Product SET Product.quantity=quantity+D.amount "
                        + "FROM OrderDetail D , Orders O "
                        + "WHERE O.id=? "
                        + "AND O.id=D.orderId "
                        + "AND Product.id=D.productId ";
                stm = con.prepareStatement(query);
                stm.setInt(1, orderId);
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

    public List<String> isDiscountValid(List<String> ids, String code) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<String> result = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT id "
                        + "FROM Product "
                        + "WHERE id IN ids "
                        + "AND saleId = ?";
                String idList = "";
                for (int i = 0; i < ids.size(); i++) {
                    idList = idList + "\'" + ids.get(i) + "\'";
                    if (i < ids.size() - 1) {
                        idList += ",";
                    }
                }

                sql = sql.replace("ids", "(" + idList + ")");
                stm = con.prepareStatement(sql);
                stm.setString(1, code);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("id");
                    if (result == null) {
                        result = new ArrayList<>();
                    }
                    result.add(id);
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

    public List<TblProductDTO> getListCar() {
        return listCar;
    }

}
