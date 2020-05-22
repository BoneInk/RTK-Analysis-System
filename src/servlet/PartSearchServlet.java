package servlet;

import cn.edu.ncu.RTKanaly.entity.User;
import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.SegToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "PartSearchServlet")
public class PartSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        ArrayList<String> arrayList = (ArrayList<String>) session.getAttribute("content");
        HashMap<String, String> mapKey = (HashMap<String, String>) session.getAttribute("keyMap");
        String key = (String) session.getAttribute("key");
        String part = "";
        String pattern = "";
        if (session.getAttribute("self").equals("1")) {
            pattern = (String) session.getAttribute("splitKey");
            pattern = pattern + ".*";
        } else {
            pattern = "正文.*";
        }
        ArrayList<String> listPart = new ArrayList();
        boolean start = false;
        for (int i = 0; i < arrayList.size(); i++) {//匹配章节回目
            String line = arrayList.get(i);
            if (!Pattern.matches(pattern, line)) {

                if (!start) {
                    continue;
                } else {
                    part = part + line;
                }
            } else if (Pattern.matches(pattern, line)) {//匹配章节回目
                if (!start) {//寻找第一章节
                    start = true;
                    part = line;
                } else {
                    listPart.add(part);
                    part = line;
                }
            }
        }
        listPart.add(part);

        List<List<Map.Entry<String, Integer>>> resList = new ArrayList<List<Map.Entry<String, Integer>>>();
        for (int i = 0; i < listPart.size(); i++) {
            List<Map.Entry<String, Integer>> list = searchPart(i, listPart.get(i), mapKey, key);
            resList.add(list);

        }
        request.setAttribute("resList", resList);
        request.setAttribute("key", key);
        Map<String, Integer> mostMap = new HashMap<>();
        for (List<Map.Entry<String, Integer>> list : resList) {
            String mostKey = list.get(0).getKey();
            if (mostMap.containsKey(mostKey)) {
                mostMap.put(mostKey, mostMap.get(mostKey) + 1);
            } else mostMap.put(mostKey, 1);
        }
        List<Map.Entry<String, Integer>> mostList = new ArrayList<Map.Entry<String, Integer>>(mostMap.entrySet()); //转换为list
        Collections.sort(mostList, new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        request.setAttribute("mostList", mostList);
        request.getRequestDispatcher("WEB-INF/views/resPart.jsp").forward(request, response);


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    public List<Map.Entry<String, Integer>> searchPart(int i, String part, HashMap<String, String> mapKey, String key) {
        JiebaSegmenter segmenter = new JiebaSegmenter();
        Map<String, Integer> map = new HashMap<String, Integer>();
        List<SegToken> segTokens = segmenter.process(part, JiebaSegmenter.SegMode.SEARCH);
        if (!key.equals("noKey")) {
            for (SegToken segToken : segTokens) {
                String word = segToken.word;
                if (mapKey.containsKey(word)) {
                    String value = mapKey.get(word);
                    if (!map.containsKey(value)) {
                        map.put(value, 1);
                    } else {
                        map.put(value, map.get(value) + 1);
                    }
                }
            }
        } else {
            for (SegToken segToken : segTokens) {
                String word = segToken.word;
                if (checkcountname(word)) {
                    if (map.containsKey(word)) {
                        int value = map.get(word);
                        map.put(word, value + 1);
                    } else
                        map.put(word, 1);
                }
            }
        }

        List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(map.entrySet()); //转换为list
        Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        return list;
    }

    public boolean checkcountname(String countname) {
        Pattern p = Pattern.compile("[\u4e00-\u9fa5]");
        Matcher m = p.matcher(countname);
        if (m.find()) {
            return true;
        }
        return false;
    }
}
