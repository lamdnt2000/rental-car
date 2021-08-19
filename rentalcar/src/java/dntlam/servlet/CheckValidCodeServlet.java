/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import com.google.gson.Gson;
import dntlam.responsestatus.ResponseMessage;
import dntlam.tbldiscount.TblDiscountDAO;
import dntlam.tbldiscount.TblDiscountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;
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
@WebServlet(name = "CheckValidCodeServlet", urlPatterns = {"/CheckValidCodeServlet"})
public class CheckValidCodeServlet extends HttpServlet {


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
        int status =-1;
        String msg = "Invalid code";
        try {
            TblDiscountDAO dao = new TblDiscountDAO();

            TblDiscountDTO dto = dao.checkValidCode(txtCode);
            
            if (dto!=null){
                if (dto.getExpiryDate().compareTo(new Date())<0){
                    status = 0 ;
                    msg = "Experied code";
                }
                else{
                    status = 1;
                    msg = "Valid code";
                }
            }

        } catch (SQLException ex) {
            log("CheckValidCodeServlet_SQLException: " + ex.getMessage());
        } catch (NamingException ex) {
            log("CheckValidCodeServlet_NamingException: " + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("CheckValidCodeServlet_NoSuchAlgorithmException: " + ex.getMessage());
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
