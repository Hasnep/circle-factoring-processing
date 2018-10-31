// the main class that contains information about each circle
class Foss {
  Foss[] sub_fosses; // initialise the list of circles inside this circle
  int value; // the circle's value, the number it represents
  boolean outside_layer; //  whether this circle is on the outside layer, i.e. is not inside another circle
  boolean drawn = true; // whether this circle should be drawn or if it is just a container
  float diameter_units = 0; // number of units wide this circle is

  Foss(int arg_value, boolean arg_outside_layer) {
    value = arg_value;
    outside_layer = arg_outside_layer;
    if (value == 1) {
      drawn = false;
      diameter_units = 0;
    } else {
      int[] factors = factorise(value);
      if (factors.length == 1) {
        int sub_prime = prime_index(value);
        int[] sub_prime_factors = factorise(sub_prime);
        sub_fosses = new Foss[sub_prime_factors.length];
        for (int i = 0; i < sub_prime_factors.length; i++) {
          sub_fosses[i] = new Foss(sub_prime_factors[i], false);
        }
      } else {
        if (outside_layer) {
          drawn = false;
        }
        sub_fosses = new Foss[factors.length];
        for (int i = 0; i < factors.length; i++) {
          sub_fosses[i] = new Foss(factors[i], false);
        }
      }

      // calculate diameter
      diameter_units += circle_margin;
      for (int i = 0; i < sub_fosses.length; i++) {
        diameter_units += sub_fosses[i].diameter_units;
      }
      diameter_units += circle_margin;
    }
  }

  void draw_circles(float x_pos, float y_pos) {
    if (value > 1) {
      float diameter_units_drawn = 0;
      for (int i = 0; i < sub_fosses.length; i++) {
        sub_fosses[i].draw_circles(x_pos + units_to_pixels(-diameter_units/2 + diameter_units_drawn + circle_margin + sub_fosses[i].diameter_units/2), y_pos);
        diameter_units_drawn += sub_fosses[i].diameter_units;
      }
    }
    if (drawn) {
      graphics_export.ellipse(x_pos, y_pos, units_to_pixels(diameter_units), units_to_pixels(diameter_units));
    }
  }
}
