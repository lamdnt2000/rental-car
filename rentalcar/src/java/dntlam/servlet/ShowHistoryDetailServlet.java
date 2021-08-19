/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import dntlam.tblorder.TblOrderDAO;
import dntlam.tblproduct.TblProductDTO;
import dntlam.utiles.DBHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author sasuk
 */
@WebServlet(name = "ShowHistoryDetailServlet", urlPatterns = {"/ShowHistoryDetailServlet"})
public class ShowHistoryDetailServlet extends HttpServlet {

    final String URL_FORWARD = "historyDetail.jsp";

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
        String txtId = request.getParameter("id");
        String member = DBHelper.getCurrentUser(request);
        int id = 0;
        boolean flag = false;
        String url = URL_FORWARD;
        try {
            /* TODO output your page here. You may use following sample code. */
            try {
                id = Integer.parseInt(txtId);
                flag = true;
            } catch (NumberFormatException e) {
                log("NumberFormatExceptionr_ParseException: " + e.getMessage());
            }
            if (flag) {
                TblOrderDAO dao = new TblOrderDAO();
                dao.searchProductByOrderId(id, member);
                List<TblProductDTO> list = dao.getListProduct();
                request.setAttribute("LISTPRODUCT", list);
            }
        } catch (NamingException e) {
            log("NumberFormatExceptionr_NamingException: " + e.getMessage());
        } catch (SQLException e) {
            log("NumberFormatExceptionr_SQLException: " + e.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
