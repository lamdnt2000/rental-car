/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblcategory;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import dntlam.utiles.DBHelper;

/**
 *
 * @author sasuk
 */
public class TblCategoryDAO implements Serializable{
    private List<TblCategoryDTO> listCategory;
    
    public void findAllCategory() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT id,name, description,createDate  "
                        + "FROM Category "
                        + "order by createDate DESC";
                        
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    Timestamp dateCreate = rs.getTimestamp("createDate");
                    TblCategoryDTO dto = new TblCategoryDTO(name, id, description);
                    dto.setCreateDate(dateCreate);
                    if (listCategory == null) {
                        listCategory = new ArrayList<>();
                    }
                    listCategory.add(dto);
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
    public boolean createCategory(TblCategoryDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "INSERT INTO Category (name,description,createDate) "
                        + "VALUES (?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getDescription());
                Date date = new Date();
                stm.setTimestamp(3, new Timestamp(date.getTime()));
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

    public List<TblCategoryDTO> getListCategory() {
        return listCategory;
    }
    
}
