/*
Class for Search Engine API 
This uses FAROO SEARCH ENGINE API for general searches
*/

public class SearchObj{
  
  // public variables
  private String FAROO_API_KEY = "aR93zwyxjLN1Psecz@GTMXPLqB8_";

  public ArrayList<String> titles;
  public ArrayList<String> urls;
  public ArrayList<String> keywrds;
  
  public int len;
  public String query;
  public String json;
  public String jsonStr;
  
  // Constructor
  public SearchObj(String query, int len){
    // assign memory for ArrayLists
    this.titles = new ArrayList<String>();
    this.urls = new ArrayList<String>();
    this.keywrds = new ArrayList<String>();
    this.len = len;
    this.query = query.split("\\s")[0];   
    
    String strFarooAPI = String.format("http://www.faroo.com/api?q=%s&start=1&length=%d&l=en&src=web&i=false&f=json&key=%s",
      this.query,
      this.len,
      this.FAROO_API_KEY);
      
    // generate empty Gson Object;
    Gson gson = new Gson();
    
    try {
      this.json = loadStrings(strFarooAPI)[0];
      JsonElement jelement = new JsonParser().parse(this.json);
      JsonObject jobject = jelement.getAsJsonObject();
      JsonArray jarray = jobject.getAsJsonArray("results");
      
      for (int i=0; i < this.len; i++){
        JsonObject tmpJsonObj = jarray.get(i).getAsJsonObject();
        this.urls.add(tmpJsonObj.get("url").toString());
        this.titles.add(tmpJsonObj.get("title").toString());
        this.keywrds.add(tmpJsonObj.get("kwic").toString());
      }
    } catch (Exception e){
      System.out.print(e);
      this.urls = null;
      this.titles = null;
      this.keywrds = null;
    }
  }
  
  // get size
  public Integer size(){
    return this.urls.size();
  }
  
  // initialize titles map
  public void getTitles(Map<String, String> map){
    Iterator<String> iterator_url = this.urls.iterator();
    Iterator<String> iterator_title = this.titles.iterator();
    while (iterator_url.hasNext()){
      String url_name = iterator_url.next();
      String title_name = iterator_title.next();
      map.put(url_name, title_name);
    }
  }
  
  // copy url to reference passed
  public void getUrls(List<String> strLs){
    try {
      for (String s : this.urls){
        // have to get rid "'s
        s = s.substring(1,s.length()-1);
        // add to passed List<String>
        strLs.add(s);
      }
    } catch (Exception e){
      System.out.println(e);
    }
  }
}

