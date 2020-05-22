package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "CombineServlet")
public class CombineServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<List<Map.Entry<String, Integer>>> resList = (List<List<Map.Entry<String, Integer>>>) session.getAttribute("resList");
        int start = Integer.parseInt(request.getParameter("start"));
        int to = Integer.parseInt(request.getParameter("to"));
        int seg = 0;
        List<Map.Entry<String, Integer>> list1 = null;
        for (int i = 0; i < start; i++) {
            if (i == 0)
                list1 = resList.get(i);
            else list1 = combineKey(list1, resList.get(i));
        }
        List<Map.Entry<String, Integer>> list2 = null;
        for (int i = start; i < to; i++) {
            if (i == start)
                list2 = resList.get(i);
            else list2 = combineKey(list2, resList.get(i));
        }
        List<Map.Entry<String, Integer>> list3 = null;
        for (int i = to; i < resList.size(); i++) {
            if (i == to)
                list3 = resList.get(i);
            else list3 = combineKey(list3, resList.get(i));
        }
        Collections.sort(list1, new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        Collections.sort(list2, new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        Collections.sort(list3, new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });

        request.setAttribute("list1", list1);
        request.setAttribute("list2", list2);
        request.setAttribute("list3", list3);
        request.setAttribute("start", start);
        request.setAttribute("to", to);
        request.getRequestDispatcher("WEB-INF/views/resPartS.jsp").forward(request, response);
    }

    private List<Map.Entry<String, Integer>> combineKey(List<Map.Entry<String, Integer>> list, List<Map.Entry<String, Integer>> listt) {
        list.addAll(listt);
        Map<String, Integer> result1 = new HashMap<String, Integer>();
        for (Map.Entry<String, Integer> map : list) {
            String key = map.getKey();
            int value = map.getValue();
            if (result1.containsKey(key)) {

                value += result1.get(key);
            }
            result1.put(key, value);
        }

        List<Map.Entry<String, Integer>> listtt = new ArrayList<Map.Entry<String, Integer>>(result1.entrySet());
        return listtt;

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
