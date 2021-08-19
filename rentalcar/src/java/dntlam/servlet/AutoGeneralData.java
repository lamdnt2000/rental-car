/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import dntlam.tblproduct.TblProductDAO;
import dntlam.tblproduct.TblProductDTO;
import dntlam.utiles.DBHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Random;
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
@WebServlet(name = "AutoGeneralData", urlPatterns = {"/admin/AutoGeneralData"})
public class AutoGeneralData extends HttpServlet {

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
        String[] colors = {"red","blue","black","white","green","yellow","pink","purple","orange"};
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Random random = new Random();
            for (int j = 0; j < 200; j++) {
                String id = random.ints(48, 122 + 1)
                        .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                        .limit(5)
                        .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                        .toString();
                String name = "car-"+random.ints(48, 65+1)
                        .filter(i -> (i <= 57 || i >= 65))
                        .limit(5)
                        .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                        .toString();
                int catId = 2 + (int)(Math.random() * ((6 - 2) + 1));
                int quantity = 1 + (int)(Math.random() * ((100 - 1) + 1));
                int year = 1990 + (int)(Math.random()*(2021-1990)+1);
                float price = 1 + random.nextFloat()*(10000-1);
                
                String color = colors[(0+(int)(Math.random()*9))];
                TblProductDAO dao = new TblProductDAO();
                TblProductDTO dto = new TblProductDTO(id, name, color, catId, price, quantity, year, 1);
                String email = DBHelper.getCurrentUser(request);
                dto.setUserCreate(email);
                boolean result = dao.createCar(dto);
                if (result){
                    out.println("model: "+id+" created success <br>");
                }
                else{
                    out.println("model: "+id+" created failed <br>");
                }
            }
        } catch (SQLException ex) {
            log("AutoGeneralData_NamingException:" + ex.getMessage());
        } catch (NamingException ex) {
            log("AutoGeneralData_NamingException:" + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("AutoGeneralData_NamingException:" + ex.getMessage());
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
