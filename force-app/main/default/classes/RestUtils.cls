/* 
 * Class: RestUtils
 */
public class RestUtils {

    public static void setupRequest() {
        if (!Test.isRunningTest()) {
            Map<String, String> httpHeaders = RestContext.request.headers;
        }
    }

    public static String getBody() {
        if (RestContext.request.requestBody != null) {
            return RestContext.request.requestBody.toString();
        }
        return null;
    }
}