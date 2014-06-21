/*
Class for Pearson Correlation
*/

public class StatObject{
  
  private List<String> keyList;
  
  // Constructor
  public StatObject(){
    keyList = new ArrayList<String>();
  }
  
  // sum
  private float sum(Map<String, Integer> map){
    float sum = 0;
    
    for (String k : this.keyList){
      sum = sum + map.get(k);
    }
    return sum;
   }
    
  // sum of square
  private float sum_square(Map<String, Integer> map){
    float sum_square = 0;
    
    for (String k : this.keyList){
      sum_square = sum_square + pow(map.get(k), 2.0);
    }
    return sum_square;
  }
  
  // sum of products
  private float sum_product(Map<String, Integer> map1, Map<String, Integer> map2){
    float sum_product = 0;
    
    // Get a set of the entries
    for (String k : this.keyList){
      sum_product = sum_product + (map1.get(k) * map2.get(k));
    }
    return sum_product;
  }

  
  // pearson correleation
  public float pearson(WebObject v1, WebObject v2){    
    for (Map.Entry entry : v1.wordCount.wordCount.entrySet()){
      if (v2.wordCount.wordCount.get(entry.getKey()) != null){
        keyList.add((String)entry.getKey());
      }
    }
    
    int iter_size = keyList.size();
    
    // General sums
    float sum1 = sum(v1.wordCount.wordCount);
    float sum2 = sum(v2.wordCount.wordCount);
    
    // Sums of the squares
    float sum1Sq = sum_square(v1.wordCount.wordCount);
    float sum2Sq = sum_square(v2.wordCount.wordCount);
    
    // Sum of the products
    float pSum = sum_product(v1.wordCount.wordCount, v2.wordCount.wordCount);
    
    // Calculate r (Pearson score)
    float num = pSum-((sum1*sum2)/iter_size);
    float val = (sum1Sq-(pow(sum1,2.0)/iter_size))*(sum2Sq-(pow(sum2,2.0)/iter_size));
    float den = sqrt(val);
    if (den == 0){
      return 0;
    }
    //System.out.println(iter_size);
    return (num/den);
  }
}


