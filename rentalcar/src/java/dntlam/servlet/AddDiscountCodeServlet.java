/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import dntlam.tbldiscount.TblDiscountDAO;
import dntlam.tbldiscount.TblDiscountDTO;
import dntlam.tblproduct.TblProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
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
@WebServlet(name = "AddDiscountCodeServlet", urlPatterns = {"/AddDiscountCodeServlet"})
public class AddDiscountCodeServlet extends HttpServlet {

    final String URL_REDIRECT = "Cart";

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
        String txtCode = request.getParameter("code");
        String url = "Cart";
        try {
            TblDiscountDAO dao = new TblDiscountDAO();

            TblDiscountDTO dto = dao.checkValidCode(txtCode);

            if (dto != null && dto.getExpiryDate().compareTo(new Date()) > 0) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    CartObj cartObj = (CartObj) session.getAttribute("PRODUCTCART");

                    if (cartObj != null) {
                        cartObj.removeSale();
                        session.removeAttribute("CODE");
                        List<String> listProductId = cartObj.getAllListProduct();
                        TblProductDAO productDAO = new TblProductDAO();
                        listProductId = productDAO.isDiscountValid(listProductId, txtCode);
                        if (listProductId != null) {
                            for (String id : listProductId) {
                                cartObj.getProductFromId(id).setSaleId(dto.getId());
                                cartObj.getProductFromId(id).setSale(dto.getSale());
                            }
                            session.setAttribute("PRODUCTCART", cartObj);
                            session.setAttribute("CODE", dto);
                        }
                    }
                }
            }
            request.setAttribute("CODEVALID", dto);
        } catch (SQLException ex) {
            log("AddDiscountCodeServlet_SQLException: " + ex.getMessage());
        } catch (NamingException ex) {
            log("AddDiscountCodeServlet_NamingException: " + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("AddDiscountCodeServlet_NoSuchAlgorithmException: " + ex.getMessage());
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
