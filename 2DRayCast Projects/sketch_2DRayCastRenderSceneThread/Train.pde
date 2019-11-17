class Train {

  Boundary[] bounds;

  Train(float x, float y, float scale, int step) {
    JSONArray arr = loadJSONArray("codingtrain.json");

    bounds = new Boundary[arr.size()];
    
    //int step = 20;
    
    
    for (int i = 0; i < arr.size() - 1; i+=step) {
      JSONObject data = arr.getJSONObject(i); 
      float x1 = data.getFloat("x");
      float y1 = data.getFloat("y");
      
      if (i + step > arr.size() - 1) {
        data = arr.getJSONObject(arr.size() - 1);
      } else {
        data = arr.getJSONObject(i + step);
      }
      
      float x2 = data.getFloat("x");
      float y2 = data.getFloat("y");
      
      float hue = map(x + x1 * scale, 0, width/2, 0, 255);
      
      bounds[i] = new Boundary(x + x1 * scale, y + y1 * scale, x + x2 * scale, y + y2 * scale, color(hue, 255, 255));//color(random(255), 255, 255));
      boundaries.add(bounds[i]);
    }

    //for (Boundary bound : bounds) {
    //  boundaries.add(bound);
    //}
  }
}
