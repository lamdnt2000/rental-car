/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import com.google.gson.Gson;
import dntlam.responsestatus.ResponseMessage;
import dntlam.tblmember.TblMemberDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author sasuk
 */
@WebServlet(name = "ActiveAccountServlet", urlPatterns = {"/ActiveAccountServlet"})
public class ActiveAccountServlet extends HttpServlet {

    final String URL_REDIRECT = "login";
    final String URL_FORWARD = "login.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("txtEmail");
        String txtCode = request.getParameter("txtCode");
        int code = 0;
        int status = 0;
        boolean flag = true;
        String msg = "Wrong OTP. Try again";
        try {
            /* TODO output your page here. You may use following sample code. */
            try {
                code = Integer.parseInt(txtCode);
            } catch (NumberFormatException ex) {
                log("ActiveAccountServlet_NumberFormatException:" + ex.getMessage());
                flag = false;
            }
            if (email != null && txtCode != null && flag) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    msg = "Invalid code";
                    Integer activeCode = (Integer) session.getAttribute("CODEACTIVE");
                    if (activeCode == null) {
                        status = -1;
                        msg = "Session time out. Try resend OTP";
                    }
                    else if (code == activeCode) {
                        TblMemberDAO dao = new TblMemberDAO();
                        dao.updateMember(email);
                        status = 1;
                        msg = "Active success";
                    }
                }
            }
        } catch (SQLException ex) {
            log("ActiveAccountServlet_SQLException:" + ex.getMessage());
        } catch (NamingException ex) {
            log("ActiveAccountServlet_SQLException:" + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("ActiveAccountServlet_SQLException:" + ex.getMessage());
        } finally {
            ResponseMessage res = new ResponseMessage(status, msg);
            String json = new Gson().toJson(res);
            out.println(json);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
