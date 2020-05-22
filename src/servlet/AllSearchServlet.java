package servlet;

import com.alibaba.fastjson.JSONObject;
import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.SegToken;
import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "AllSearchServlet")
public class AllSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<String> arrayList = (ArrayList<String>) session.getAttribute("content");
        String content = String.join("", arrayList);
        HashMap<String, String> mapKey = (HashMap<String, String>) session.getAttribute("keyMap");
        JiebaSegmenter segmenter = new JiebaSegmenter();
        String key = (String) session.getAttribute("key");
        Map<String, Integer> map = new HashMap<String, Integer>();
        List<SegToken> segTokens = segmenter.process(content, JiebaSegmenter.SegMode.SEARCH);
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

        request.setAttribute("res", list);
        request.setAttribute("key", key);
        request.getRequestDispatcher("WEB-INF/views/res.jsp").forward(request, response);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
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
