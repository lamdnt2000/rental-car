/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import dntlam.tblproduct.TblProductDAO;
import dntlam.tblproduct.TblProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "UpdateCartAmountServlet", urlPatterns = {"/UpdateCartAmountServlet"})
public class UpdateCartAmountServlet extends HttpServlet {

    final String URL_CART = "orderCart.jsp";

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
        String[] pkList = request.getParameterValues("pk");
        List<Integer> quantityList = new ArrayList();
        String url = URL_CART;
        try {

            HttpSession session = request.getSession(false);
            if (session != null) {
                CartObj cart = (CartObj) session.getAttribute("PRODUCTCART");
                if (cart != null || cart.getItems() != null || !cart.getItems().isEmpty()) {
                    boolean flag = true;
                    try {
                        for (int i = 0; i < pkList.length; i++) {
                            quantityList.add(Integer.parseInt(request.getParameter("quantity" + pkList[i])));
                        }
                    } catch (NumberFormatException ex) {
                        flag = false;
                        log("UpdateCartAmountServlet_NumberFormatException: " + ex.getMessage());
                    }
                    String msg = "Error when updating product";
                    if (flag) {
                        TblProductDAO dao = new TblProductDAO();
                        boolean result = true;
                        for (int i = 0; i < pkList.length; i++) {
                            String pk = pkList[i];
                            int quantity = quantityList.get(i);
                            TblProductDTO dto = dao.findCarById(pk);
                            if (dto.getQuantity() >= quantity) {
                                cart.updateQuantity(pk, quantity);
                                
                            } else {
                                msg = cart.getProductFromId(pk).getName() + " have " + dto.getQuantity() + " left";
                                result=false;
                                break;
                            }
                        }
                        session.setAttribute("PRODUCTCART", cart);
                        if (result) {
                            msg = "Update cart amount success";
                            request.setAttribute("SUCCESS", msg);
                        } else {
                            request.setAttribute("ERROR", msg);
                        }
                    } else {
                        request.setAttribute("ERROR", msg);
                    }

                }

            }
        } catch (NamingException ex) {
            Logger.getLogger(UpdateCartAmountServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateCartAmountServlet.class.getName()).log(Level.SEVERE, null, ex);
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
