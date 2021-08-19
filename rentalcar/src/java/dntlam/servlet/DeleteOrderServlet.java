/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import dntlam.tblorder.TblOrderDAO;
import dntlam.tblproduct.TblProductDAO;
import dntlam.utiles.DBHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author sasuk
 */
@WebServlet(name = "DeleteOrderServlet", urlPatterns = {"/DeleteOrderServlet"})
public class DeleteOrderServlet extends HttpServlet {

    final String URL_REDIRECT = "History";

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String txtOrderId = request.getParameter("orderId");
        String txtSearchName = request.getParameter("txtSearchName");
        String txtRentalDate = request.getParameter("txtRentalDate");
        int orderId = 0;
        boolean flag = true;
        String url = URL_REDIRECT + "?txtSearchName=";
        if (txtSearchName != null) {
            url += txtSearchName;
        }
        url += "&txtRentalDate=";
        if (txtRentalDate != null) {
            url += txtRentalDate;
        }
        try {
            try {
                orderId = Integer.parseInt(txtOrderId);
            } catch (NumberFormatException ex) {
                log("DeleteOrderServlet_NumberFormatException:" + ex.getMessage());
                flag = false;
            }
            String email = DBHelper.getCurrentUser(request);
            if (flag && email != null) {
                /* TODO output your page here. You may use following sample code. */
                TblOrderDAO dao = new TblOrderDAO();
                boolean result = dao.deleteOrder(orderId, email);
                
                if (result) {
                    TblProductDAO productDAO = new TblProductDAO();
                    productDAO.updateQuantityDelete(orderId);
                }
            }

        } catch (NamingException ex) {
            log("DeleteOrderServlet_NamingException:" + ex.getMessage());
        } catch (SQLException ex) {
            log("DeleteOrderServlet_SQLException:" + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
