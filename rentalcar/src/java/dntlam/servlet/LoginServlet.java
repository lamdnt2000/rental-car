/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dntlam.servlet;

import com.google.gson.Gson;
import dntlam.responsestatus.ResponseMessage;
import dntlam.tblmember.TblMemberDAO;
import dntlam.tblmember.TblMemberDTO;
import dntlam.utiles.VerifyUtils;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author sasuk
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet", "/admin/LoginServlet"})
public class LoginServlet extends HttpServlet {

    final String LABEL_LOGIN = "login";

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
        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");
        String gCapcha = request.getParameter("g-recaptcha-response");

        int status = -1;
        String msg = "Member not found try again";
        try {
            /* TODO output your page here. You may use following sample code. */
            boolean capcha = VerifyUtils.verify(gCapcha);
            if (capcha) {
                TblMemberDAO dao = new TblMemberDAO();
                TblMemberDTO dto = dao.checkLogin(email, password);
                if (dto != null) {
                    
                    if ("Active".equals(dto.getStatus())) {
                        HttpSession session = request.getSession();
                        session.setAttribute("RESULTLOGIN", dto);
                        String url = request.getContextPath();
                        if ("admin".equals(dto.getRole())) {
                            url = url + "/admin";
                        }
                        status = 1;
                        msg = url;
                    } else {
                        status = 0;
                        msg = "Member not active yet";
                    }

                }
            } else {
                msg = "Check capcha first";
            }

        } catch (SQLException ex) {
            log("LoginServlet_SQLException:" + ex.getMessage());
        } catch (NamingException ex) {
            log("LoginServlet_NamingException:" + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            log("LoginServlet_NoSuchAlgorithmException:" + ex.getMessage());

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
