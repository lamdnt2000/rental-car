/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import com.google.gson.Gson;
import dntlam.responsestatus.ResponseMessage;
import dntlam.tblproduct.TblProductDAO;
import dntlam.tblproduct.TblProductDTO;
import dntlam.utiles.DBHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "UpdateCarServlet", urlPatterns = {"/admin/UpdateCarServlet"})
public class UpdateCarServlet extends HttpServlet {

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
        String id = request.getParameter("txtCarId");
        String name = request.getParameter("txtCarName");
        String color = request.getParameter("txtCarColor");
        String txtQuantity = request.getParameter("carQuantity");
        String txtPrice = request.getParameter("carPrice");
        String txtYear = request.getParameter("carYear");
        String txtCatId = request.getParameter("catId");
        String txtStatus = request.getParameter("status");
        int carStatus = "on".equals(txtStatus)?1:0;
        int status = 0;
        int quantity = 0;
        float price = 0;
        int year = 0;
        int catId = 0;
        String msg = "Update Car fail";
        boolean flag = true;
        try {
            /* TODO output your page here. You may use following sample code. */
            try {
                quantity = Integer.parseInt(txtQuantity);
                price = Float.parseFloat(txtPrice);
                year = Integer.parseInt(txtYear);
                catId = Integer.parseInt(txtCatId);
            } catch (NumberFormatException ex) {
                log("UpdateCarServlet_NumberFormatException:" + ex.getMessage());
                flag = false;
            }
            String email = DBHelper.getCurrentUser(request);
            if (flag) {
                TblProductDAO dao = new TblProductDAO();
                TblProductDTO dto = new TblProductDTO(id, name, color, catId, price, quantity, year, carStatus);
                dto.setUserUpdate(email);
                boolean result = dao.updateCar(dto);
                if (result) {
                    status = 1;
                    msg = "Update car success";

                }
            }

        } catch (SQLException ex) {
            log("UpdateCarServlet_SQLException:" + ex.getMessage());
        } catch (NamingException ex) {
            log("UpdateCarServlet_NamingException:" + ex.getMessage());
        } finally {
            ResponseMessage resMessage = new ResponseMessage(status, msg);
            String json = new Gson().toJson(resMessage);
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
