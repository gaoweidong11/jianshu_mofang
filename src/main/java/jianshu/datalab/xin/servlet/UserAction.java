package jianshu.datalab.xin.servlet;

import com.alibaba.fastjson.JSON;
import jianshu.datalab.xin.util.Db;
import jianshu.datalab.xin.util.Error;
import org.jasypt.util.password.StrongPasswordEncryptor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by mingfei.net@gmail.com
 * 6/27/17 15:25
 * https://github.com/thu/jianshu/
 */
@WebServlet(urlPatterns = "/user")
public class UserAction extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("signUp".equals(action)) {
            signUp(req, resp);
            return;
        }

        if ("isNickOrMobileExisted".equals(action)) {
            isNickOrMobileExisted(req, resp);
            return;
        }

        Error.showError(req, resp);
    }

    private void signUp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nick = req.getParameter("nick").trim();
        String mobile = req.getParameter("mobile").trim();

        if (nick.length() == 0) {
            req.setAttribute("message", "请输入昵称");
            req.getRequestDispatcher("sign_up.jsp").forward(req, resp);
            return;
        }

        if (mobile.length() == 0) {
            req.setAttribute("message", "请输入手机号");
            req.getRequestDispatcher("sign_up.jsp").forward(req, resp);
            return;
        }

        if (isNickExisted(req, resp)) {
            req.setAttribute("message", "昵称 已经被使用");
            req.getRequestDispatcher("sign_up.jsp").forward(req, resp);
            return;
        }

        if (isMobileExisted(req, resp)) {
            req.setAttribute("message", "手机号 已经被使用");
            req.getRequestDispatcher("sign_up.jsp").forward(req, resp);
            return;
        }

        StrongPasswordEncryptor encryptor = new StrongPasswordEncryptor();
        String password = encryptor.encryptPassword(req.getParameter("password"));

        Connection connection = Db.getConnection();
        PreparedStatement preparedStatement = null;

        String sql = "INSERT INTO db_jianshu.user(nick, mobile, password, lastIp) VALUE(?, ?, ?, ?)";

        try {
            if (connection != null) {
                preparedStatement = connection.prepareStatement(sql);
            } else {
                Error.showError(req, resp);
                return;
            }
            preparedStatement.setString(1, nick);
            preparedStatement.setString(2, mobile);
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, req.getRemoteAddr());

            preparedStatement.executeUpdate();

            resp.sendRedirect("/");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Db.close(null, preparedStatement, connection);
        }
    }

    /**
     * for signUp
     */
    private boolean isNickExisted(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return isExisted(req, resp, "nick", req.getParameter("nick").trim());
    }

    /**
     * for signUp
     */
    private boolean isMobileExisted(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return isExisted(req, resp, "mobile", req.getParameter("mobile").trim());
    }

    /**
     * for AJAX
     */
    private void isNickOrMobileExisted(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String field = req.getParameter("field");
        String value = req.getParameter("value").trim();

        boolean isExisted = isExisted(req, resp, field, value);

        resp.setContentType("application/json");
        Writer writer = resp.getWriter();
        Map<String, Object> map = new HashMap<>();
        map.put("isExisted", isExisted);
        writer.write(JSON.toJSONString(map));
    }

    private boolean isExisted(HttpServletRequest req, HttpServletResponse resp, String field, String value) throws ServletException, IOException {
        boolean isNickExisted = false;
        boolean isMobileExisted = false;

        Connection connection = Db.getConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String sql = "SELECT * FROM db_jianshu.user WHERE " + field + " = ?";
        try {
            if (connection != null) {
                preparedStatement = connection.prepareStatement(sql);
            } else {
                Error.showError(req, resp);
                return false; // TODO: 6/29/17
            }
            preparedStatement.setString(1, value);
            resultSet = preparedStatement.executeQuery();

            if (field.equals("nick")) {
                isNickExisted = resultSet.next();
            } else {
                isMobileExisted = resultSet.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Db.close(resultSet, preparedStatement, connection);
        }

        return isNickExisted || isMobileExisted;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
