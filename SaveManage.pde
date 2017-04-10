/* Save & Load */
void fileSave(File savedfile)
{
  if (savedfile == null) {
    println("Window was closed or the user hit cancel.");
    globalspeed = 1;
    return;
  } else {
    println("User selected " + savedfile.getAbsolutePath());
  }
  
  // JSON format
  JSONArray saveData = new JSONArray();
  JSONObject saveObject = new JSONObject();
  //Head object
  saveObject.setInt("version", version);
  saveObject.setInt("width", res_x);
  saveObject.setInt("height", res_y);
  saveObject.setInt("insects", Insects.length);
  saveObject.setInt("bgtype", bgtype);
  saveData.setJSONObject(0, saveObject);
  
  //Insect objects
  for (int i = 0; i < Insects.length; i++)
  {
    saveObject = new JSONObject();
    saveObject.setInt("x", Insects[i].px);
    saveObject.setInt("y", Insects[i].py);
    saveObject.setFloat("speed", Insects[i].speed);
    saveObject.setInt("direction", Insects[i].direction);
    
    saveObject.setInt("soundType", Insects[i].soundType);
    saveObject.setInt("soundInst", Insects[i].soundInst);
    saveObject.setInt("soundNoteID", Insects[i].soundNoteID);
    saveData.setJSONObject(1 + i, saveObject);
  }
  
  //Image
  saveObject = new JSONObject();
  byte[] imagedata = new byte[res_x * res_y * 4];
  img.loadPixels();
  for (int i = 0; i < imagedata.length; i += 4)
  {
    imagedata[i + 0] = (byte)((img.pixels[i / 4] & 0xFF000000) >> 24);
    imagedata[i + 1] = (byte)((img.pixels[i / 4] & 0x00FF0000) >> 16);
    imagedata[i + 2] = (byte)((img.pixels[i / 4] & 0x0000FF00) >> 8);
    imagedata[i + 3] = (byte)((img.pixels[i / 4] & 0x000000FF) >> 0);
  }
  
  String base64img = javax.xml.bind.DatatypeConverter.printBase64Binary(imagedata);
  saveObject.setString("image", base64img);
  saveData.setJSONObject(Insects.length + 1, saveObject);
  
  saveJSONArray(saveData, savedfile.getAbsolutePath());
  
  globalspeed = 1;
  ignoreframeinput = true;
}

void fileLoad(File savedfile)
{
  if (savedfile == null) {
    println("Window was closed or the user hit cancel.");
    globalspeed = 1;
    return;
  } else {
    println("User selected " + savedfile.getAbsolutePath());
  }
  
  // JSON format
  JSONArray saveData = loadJSONArray(savedfile.getAbsolutePath());
  JSONObject saveObject = saveData.getJSONObject(0);
  //Head object
  if (saveObject.getInt("version") == version)
  {
    res_x = saveObject.getInt("width", res_x);
    res_y = saveObject.getInt("height", res_y);
    //Scale according to window size
    if (((float)width / res_x * res_y) > (height - 100))
      scale = (float)(height - 100) / res_y;
    else
      scale = (float)width / res_x; 
    nb_insect = saveObject.getInt("insects");
    bgtype = saveObject.getInt("bgtype");
    InsectInit(nb_insect);
    
    //Insect objects
    for (int i = 0; i < Insects.length; i++)
    {
      saveObject = saveData.getJSONObject(1 + i);
      Insects[i].Set(saveObject.getInt("x") * scale + scale / 2, saveObject.getInt("y") * scale + scale / 2, saveObject.getFloat("speed"),
        saveObject.getInt("direction"), saveObject.getInt("soundType"), saveObject.getInt("soundInst"), saveObject.getInt("soundNoteID"), insectColorDefault[i & 3]);
    }
    
    //Image
    saveObject = saveData.getJSONObject(Insects.length + 1);
    String base64img = saveObject.getString("image");
    byte[] imagedata = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64img);
    BitmapInit();
    BitmapBackgroundUpdate();
    img.loadPixels();
    for (int i = 0; i < imagedata.length; i += 4)
    {
      img.pixels[i / 4] = color(((int)imagedata[i + 1] & 0xFF), ((int)imagedata[i + 2] & 0xFF), ((int)imagedata[i + 3] & 0xFF), ((int)imagedata[i + 0] & 0xFF));
    }
    img.updatePixels();
  }
  else
    println("Wrong version");
  globalspeed = 1;
  
  ignoreframeinput = true;
}