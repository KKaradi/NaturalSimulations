boolean[][] createTemplate(int nodesc) {
  boolean[][] template = new boolean[nodesc][nodesc];
  boolean[] full = new boolean[nodesc];
  preGen(template);

  while (true) {
    reflect(template);
    fill(template, full);
    addMuscle(template, full);
    if (isFull(full)) {
      break;
    }
  }
  return(template);
}

int musclesc(boolean[][] template){
  int musclesc = 0;
  for (int i = 0; i < template.length; i++) {
      for (int j = 0; j < i; j++) {
        if (template[i][j]) {
          musclesc++;
        }
      }
    }
  return(musclesc);
  /*
  int musclesc = 0;
    for (int i = 0; i < template.length; i++) {
      for (int j = 0; j < i; j++) {
        if (template[i][j]) {
          musclesc++;
        }
      }
    }
    */
}

void preGen(boolean[][] template) {
  for (int i = 0; i < template.length; i++) {
    int connect = (int)(random(1)*template.length-1);
    //println(connect);
    if (connect == i) {
      connect++;
    }
    template[i][connect] = true;
  }
}

void reflect(boolean[][] template) {
  for (int i = 0; i < template.length; i++) {
    for (int j = 0; j < template[i].length; j++) {
      if (template[i][j]) {
        template[j][i] = true;
      }
    }
  }
}

void fill(boolean[][] template, boolean[] full) {
  int count = 0;
  for (int i = 0; i < template.length; i++) {
    for (int j = 0; j < template[i].length; j++) {
      if (template[i][j]) {
        count++;
      }
      if (count >= 2) {
        full[i] = true;
        break;
      }
    } 
    count = 0;
  }
}

boolean isFull(boolean[] full) {
  for (int i = 0; i < full.length; i++) {
    if (!full[i]) {
      return(false);
    }
  }
  return(true);
}

void addMuscle(boolean[][] template, boolean[]  full) {
  int empty = 0;
  for (int i = 0; i < full.length; i++) {
    if (!full[i]) {
      empty++;
    }
  }
  int choice = (int)(random(1)*(template.length-empty));
  for (int i = 0; i < full.length; i++) {
    if (full[i]) {
      continue;
    }
    if (choice != 0) {
      choice--;
      continue;
    }
    choice = i;
    break;
  }
  addRandom(choice, template);
}

void addRandom(int choice, boolean[][] template) {
  int held = 0;
  for (int i = 0; i < template[choice].length; i++) {
    if (template[choice][i]) {
      held++;
    }
  }
  int pick = (int)(random(1)*(template.length-held-1));
  for (int i = 0; i < template[choice].length; i++) {
    if (i == choice) {
      continue;
    }
    if (template[choice][i]) {
      continue;
    }
    if (pick != 0) {
      pick--;
      continue;
    }
    template[choice][i] = true;
    break;
  }
}
