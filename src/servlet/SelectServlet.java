package servlet;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.springframework.cglib.proxy.Dispatcher;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.HashMap;

@WebServlet(name = "SelectServlet")
public class SelectServlet extends HttpServlet {//选择调用的Servle

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String range = request.getParameter("range");
        String key = request.getParameter("key");
        String cusKey = request.getParameter("cusKey");
        String splitKey = request.getParameter("splitKey");
        RequestDispatcher dispatcher = null;
        DiskFileItemFactory sf = new DiskFileItemFactory();//实例化磁盘被文件列表工厂
        String path = request.getServletContext().getRealPath("/WEB-INF/static/txt");
        HashMap<String, String> mapKey = keySearch(key, path, cusKey, request);
        if(mapKey==null){
            request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request,response);
        }else {
            HttpSession session = request.getSession();
            session.setAttribute("keyMap", mapKey);
            session.setAttribute("splitKey", splitKey);
            session.setAttribute("key", key);
            if (range.equals("all")) {
                dispatcher = request.getRequestDispatcher("/AllSearchServlet");
                dispatcher.forward(request, response);
            } else if (range.equals("part")) {
                dispatcher = request.getRequestDispatcher("/PartSearchServlet");
                dispatcher.forward(request, response);
            }
        }
    }


    private HashMap<String, String> keySearch(String key, String path, String cusKey, HttpServletRequest request) throws IOException {//获取key值的列表
        BufferedReader br = null;
        HashMap<String, String> mapKey = new HashMap<String, String>();
        if (key != null && key.equals("name")) {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(path + "/sgName.txt"), "utf-8"));
        } else if (key != null && key.equals("place")) {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(path + "/sgPlace.txt"), "utf-8"));
        } else if (key != null && key.equals("noUse")) {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(path + "/noUse.txt"), "utf-8"));
        } else if (key != null && key.equals("custom")) {
            if (cusKey.equals("")) {

                return null;
            }
            String[] cusS = cusKey.split("\n|\r");
            for (String ss : cusS) {
                String b[] = ss.split(" ");
                for (int i = 0; i < b.length; i++) {
                    mapKey.put(b[i], b[0]);
                }
            }

            return mapKey;
        } else {
            return null;
        }


        String line = "";

        while ((line = br.readLine()) != null) {
            String[] b = line.split(" ");
            for (int i = 0; i < b.length; i++) {
                mapKey.put(b[i], b[0]);
            }
        }
        return mapKey;
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
