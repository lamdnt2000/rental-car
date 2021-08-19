/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.api;

import com.google.gson.Gson;
import dntlam.tblproduct.Parameter;
import dntlam.tblproduct.TblProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
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
@WebServlet(name = "PagingSearchRentalCar", urlPatterns = {"/api/PagingSearchRentalCar"})
public class PagingSearchRentalCar extends HttpServlet {

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
        String searchName = request.getParameter("txtSearchName");
        String txtRentalDate = request.getParameter("rentalDate");
        String txtReturnDate = request.getParameter("returnDate");
        String txtCatId = request.getParameter("catId");
        String txtAmount = request.getParameter("amountCar");
        
        int catId = 0;
        int amount = 0;
        Date rentalDate = null;
        Date returnDate = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        boolean flag = true;
        
        try {
            /* TODO output your page here. You may use following sample code. */
            try {
                catId = Integer.parseInt(txtCatId);
                amount = Integer.parseInt(txtAmount);
            } catch (NumberFormatException ex) {
                log("PagingSearchRentalCar_NumberFormatException: " + ex.getMessage());
                flag = false;
            }
            try {
                rentalDate = sdf.parse(txtRentalDate);
                returnDate = sdf.parse(txtReturnDate);
            } catch (ParseException ex) {
                log("PagingSearchRentalCar_ParseException: " + ex.getMessage());
                flag = false;
            }
            if (flag) {
                Parameter param = new Parameter(searchName, 1, catId);
                TblProductDAO dao = new TblProductDAO();
                
                int totaCar = dao.countCarSearch(param, amount);
                
                HttpSession session = request.getSession(true);
                session.setAttribute("RENTALDATE", rentalDate);
                session.setAttribute("TXTRENTALDATE", txtRentalDate);
                session.setAttribute("RETURNDATE", returnDate);
                session.setAttribute("TXTRETURNDATE", txtReturnDate);
                int dayRent =returnDate.getDate()-rentalDate.getDate();
                session.setAttribute("DAYRENT", dayRent);
                Hashtable hash = new Hashtable<>();
                hash.put("name", searchName);
                hash.put("catId", catId);
                hash.put("status", 1);
                hash.put("totalCar", totaCar);
                String json = new Gson().toJson(hash);
                out.println(json);
            }

        } catch (NamingException ex) {
            log("PagingSearchRentalCar_NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("PagingSearchRentalCar_SQLException: " + ex.getMessage());
        } finally {
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
