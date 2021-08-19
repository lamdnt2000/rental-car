/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.tblmember;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import dntlam.utiles.DBHelper;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author sasuk
 */
public class TblMemberDAO implements Serializable {

    public TblMemberDTO checkLogin(String username, String password) throws SQLException, NamingException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblMemberDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT email, name, role, status "
                        + "FROM Member "
                        + "WHERE email=? AND password=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String role = rs.getString("role");
                    String status = rs.getString("status");
                    dto = new TblMemberDTO();
                    dto.setEmail(email);
                    dto.setName(name);
                    dto.setRole(role);
                    dto.setStatus(status);
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
    
    public TblMemberDTO checkSendOTP(String username) throws SQLException, NamingException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblMemberDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT email, name, role, status "
                        + "FROM Member "
                        + "WHERE email=? AND status=?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                stm.setString(2, "New");
                rs = stm.executeQuery();
                if (rs.next()) {
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String role = rs.getString("role");
                    String status = rs.getString("status");
                    dto = new TblMemberDTO();
                    dto.setEmail(email);
                    dto.setName(name);
                    dto.setRole(role);
                    dto.setStatus(status);
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

    public boolean createUser(TblMemberDTO dto) throws SQLException, NamingException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "INSERT INTO Member (email,password,name,phone,address,role,createDate,status) "
                        + "VALUES (?,?,?,?,?,?,?,?)";
                stm = con.prepareStatement(query);
                stm.setString(1, dto.getEmail());
                stm.setString(2, dto.getPassword());
                stm.setString(3, dto.getName());
                stm.setString(4, dto.getPhone());
                stm.setString(5, dto.getAddress());
                stm.setString(6, dto.getRole());
                Date currentDate = new Date();
                stm.setTimestamp(7, new Timestamp(currentDate.getTime()));
                stm.setString(8, dto.getStatus());
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
    
    public boolean updateMember(String email) throws SQLException, NamingException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;
        try {
            con = DBHelper.makeConnection();

            if (con != null) {

                String query = "UPDATE Member SET status='Active' "
                        + "WHERE email=?";
                stm = con.prepareStatement(query);
                stm.setString(1, email);
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
