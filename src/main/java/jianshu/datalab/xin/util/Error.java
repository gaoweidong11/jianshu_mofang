package jianshu.datalab.xin.util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mingfei.net@gmail.com
 * 6/27/17 15:22
 * https://github.com/thu/jianshu/
 */
public class Error {
    public static void showError(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("message", "ERROR.");
        try {
            request.getRequestDispatcher("default.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
        }
    }
}
