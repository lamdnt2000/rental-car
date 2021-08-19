/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import dntlam.tblorder.TblOrderDAO;
import dntlam.tblorder.TblOrderDTO;
import dntlam.tblorderdetail.TblOrderDetailDAO;
import dntlam.tblorderdetail.TblOrderDetailDTO;
import dntlam.tblproduct.TblProductDAO;
import dntlam.tblproduct.TblProductDTO;
import dntlam.utiles.DBHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;
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
@WebServlet(name = "CheckOutCartServlet", urlPatterns = {"/CheckOutCartServlet"})
public class CheckOutCartServlet extends HttpServlet {

    final String URL_REDIRECT = "History";
    final String URL_FORWARD = "orderCart.jsp";
    final String URL_LOGIN = "login";

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
        String url = URL_LOGIN;
        boolean flag = true;
        try {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(false);
            CartObj cartObj = (CartObj) session.getAttribute("PRODUCTCART");

            if (cartObj != null) {
                Date rentalDate = (Date) session.getAttribute("RENTALDATE");
                Date returnDate = (Date) session.getAttribute("RETURNDATE");
                TblOrderDAO dao = new TblOrderDAO();
                String member = DBHelper.getCurrentUser(request);
                if (member != null) {
                    TblOrderDTO order = dao.createOrder(member, rentalDate, returnDate);

                    float total = 0;
                    if (order != null) {
                        Map<TblProductDTO, Integer> items = cartObj.getItems();
                        TblOrderDetailDAO daoItem = new TblOrderDetailDAO();
                        TblProductDAO productDAO = new TblProductDAO();
                        for (TblProductDTO product : items.keySet()) {
                            int quantity = items.get(product);
                            TblOrderDetailDTO item = new TblOrderDetailDTO(product.getId(), quantity, product.getPrice(), order.getId(), 1 - product.getSale());
                            boolean result = daoItem.addProductToCart(item);
                            if (!result) {
                                flag = false;
                                break;
                            }

                        }
                        if (flag) {
                            for (TblProductDTO product : items.keySet()) {
                                productDAO.updateQuantityCheckOut(product.getId(), items.get(product));
                            }
                            total = cartObj.getTotalPrice() * (Integer) session.getAttribute("DAYRENT");
                            order.setStatus(1);
                            order.setTotal(total);
                            dao.updateOrder(order);
                            url = URL_REDIRECT;
                            session.removeAttribute("PRODUCTCART");
                            session.removeAttribute("CODE");
                            session.removeAttribute("RENTALDATE");
                            session.removeAttribute("TXTRENTALDATE");
                            session.removeAttribute("RETURNDATE");
                            session.removeAttribute("TXTRETURNDATE");
                        } else {
                            order.setStatus(-1);
                            order.setTotal(0);
                            dao.updateOrder(order);
                            request.setAttribute("ERROR", "Out of car please update amount.");
                        }
                    }
                }

            }

        } catch (NamingException ex) {
            log("CheckOutServlet_NamingException:" + ex.getMessage());
        } catch (SQLException ex) {
            log("CheckOutServlet_SQLException:" + ex.getMessage());
        } finally {
            if (url.equals(URL_FORWARD)) {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            } else {
                response.sendRedirect(url);
            }
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
