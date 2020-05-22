package servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class UploadServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        DiskFileItemFactory sf = new DiskFileItemFactory();//实例化磁盘被文件列表工厂
        String path = request.getServletContext().getRealPath("/upload");//得到上传文件的存放目录
        sf.setRepository(new File(path));//设置文件存放目录
        sf.setSizeThreshold(1024 * 1024);//设置文件上传小于1M放在内存中
        ServletFileUpload sfu = new ServletFileUpload(sf);
        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");
        try {
            List<FileItem> lst = sfu.parseRequest(request);//得到request中所有的元素
            for (FileItem fileItem : lst) {
                BufferedReader br = new BufferedReader(new InputStreamReader(fileItem.getInputStream(), "utf-8"));
                String line = "";
                ArrayList<String> arrayList = new ArrayList<>();
                while ((line = br.readLine()) != null) {
                    arrayList.add(line);

                }
                session.setAttribute("content", arrayList);
                fileItem.delete();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("self", "1");
        request.getRequestDispatcher("WEB-INF/views/file.jsp").forward(request, response);
        out.flush();
        out.close();


    }
}
