/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.utiles;

import dntlam.tblmember.TblMemberDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author sasuk
 */
public class DBHelper implements Serializable {

    public static Connection makeConnection() throws NamingException, SQLException {
        Context context = new InitialContext();
        Context tomcatContext = (Context) context.lookup("java:/comp/env");
        DataSource ds = (DataSource) tomcatContext.lookup("dntlam");
        Connection con = ds.getConnection();
        return con;
    }

    public static String getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = null;
        if (session != null) {
            TblMemberDTO member = (TblMemberDTO) session.getAttribute("RESULTLOGIN");
            if (member != null) {
                email = member.getEmail();
            }
        }
        return email;
    }

    public static String getCurrentRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String role = "Guest";
        if (session != null) {
            TblMemberDTO member = (TblMemberDTO) session.getAttribute("RESULTLOGIN");
            if (member != null) {
                role = member.getRole();
            }
        }
        return role;
    }
}
