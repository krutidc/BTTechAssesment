public inherited sharing class RestResponse {

    
    public Map<String,Object> metadata;
    public List<Object> errors;
    public Object data;
    public Map<String, String> errorMap;
    public Integer statusCode;
    public String statusMessage;


    public void setData(Object data) {
        this.data = data;
    }

    public RestResponse(Object data) {
        metadata = new Map<String,Object>();
        errors = new List<Object>();
        this.data = data;
    }

    public RestResponse() {
        metadata = new Map<String,Object>();
        errors = new List<Object>();
        errorMap = new Map<String, String>();
    }

    public void generateResponse() {
        RestContext.response.addHeader('Content-Type', 'application/json');
        system.debug(this.errors);
        if (this.errors.size() > 0 || (this.errorMap != null && this.errorMap.keySet().size() > 0) ) {
            RestContext.response.statusCode = 500;
        }
        else if (this.statusCode != null) {
            RestContext.response.statusCode = this.statusCode;
        }
        RestContext.response.responseBody = Blob.valueOf(this.serialize());
    }
    
     public void addError(String errorMessage) {
        this.errors.add(errorMessage);
    }

    private String serialize() {
        return JSON.serialize(this);
    }
  
}