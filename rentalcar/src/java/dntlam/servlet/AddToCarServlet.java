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
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tblorderdetail.CartObj;

/**
 *
 * @author sasuk
 */
@WebServlet(name = "AddToCarServlet", urlPatterns = {"/AddToCarServlet"})
public class AddToCarServlet extends HttpServlet {

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
        String id = request.getParameter("id");
        String txtAmount = request.getParameter("amount");
        int amount = 0;
        boolean flag = true;
        int status = 0;
        String msg = "Add to cart fail";
        try {
            try {
                amount = Integer.parseInt(txtAmount);
            } catch (NumberFormatException ex) {
                log("AddToCarServlet_NumberFormatException: " + ex.getMessage());
                flag = false;
            }
            if (flag) {
                TblProductDAO dao = new TblProductDAO();
                TblProductDTO dto = dao.findCarById(id);
                if (dto != null) {
                    HttpSession session = request.getSession(true);
                    CartObj cart = (CartObj) session.getAttribute("PRODUCTCART");
                    if (cart == null) {
                        cart = new CartObj();
                        
                    }
                    cart.addItemToCart(dto, amount);
                    session.setAttribute("PRODUCTCART", cart);
                    status = 1;
                    msg = "Add to cart success";
                }
            }
        } catch (NamingException ex) {
            log("AddToCarServlet_NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            log("AddToCarServlet_NamingException: " + ex.getMessage());
        }
        finally{
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
