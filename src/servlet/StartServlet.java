package servlet;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

@WebServlet(name = "StartServlet")
public class StartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        DiskFileItemFactory sf = new DiskFileItemFactory();//实例化磁盘被文件列表工厂
        String path = request.getServletContext().getRealPath("/upload");//得到上传文件的存放目录
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(
                    path + "/三国演义.txt"), "utf-8"));
            ArrayList<String> arrayList = new ArrayList<>();
            String line = "";
            while ((line = br.readLine()) != null) {
                arrayList.add(line);
            }
            HttpSession session = request.getSession();
            session.setAttribute("content", arrayList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        HttpSession session = request.getSession();
        session.setAttribute("self", "0");
        request.getRequestDispatcher("WEB-INF/views/file.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
