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
import java.security.NoSuchAlgorithmException;
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
@WebServlet(name = "CreateCarServlet", urlPatterns = {"/admin/CreateCarServlet"})
public class CreateCarServlet extends HttpServlet {

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
        int catId = 0;
        float price =0f;
        int quantity = 0;
        int year = 0;
        int status = 0;
        boolean flag = true;
        String msg = "Create new Car fail";
        try {
            /* TODO output your page here. You may use following sample code. */
            try {
                catId = Integer.parseInt(txtCatId);
                quantity = Integer.parseInt(txtQuantity);
                year = Integer.parseInt(txtYear);
                price = Float.parseFloat(txtPrice);
            } catch (NumberFormatException ex) {
                log("CreateCarServlet_NumberFormatException:" + ex.getMessage());
                flag = false;
            }
            String email = DBHelper.getCurrentUser(request);
            TblProductDAO dao = new TblProductDAO();
            TblProductDTO dto = new TblProductDTO(id, name, color, catId, price, quantity, year, 1);
            dto.setUserCreate(email);
            boolean result = dao.createCar(dto);
            if (result) {
                status = 1;
                msg = "Create new car success";

            }

        } catch (SQLException ex) {
            log("CreateCarServlet_SQLException:" + ex.getMessage());
            if (ex.getMessage().contains("duplicate")) {
                msg = "Duplicated car id try again.";
            }
        } catch (NamingException ex) {
            log("CreateCarServlet_NamingException:" + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("CreateCarServlet_NoSuchAlgorithmException:" + ex.getMessage());
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
