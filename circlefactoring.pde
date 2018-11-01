int[] image_size = {5000, 5000}; // the exported image's dimensions
int[] grid_shape = {10, 10}; // number of circles horizontaly and vertically
int starting_number = 1; // first number to draw
float circle_margin = 0.5; // the gap between concentric circles
float circle_thickness = 0.25; // thickness of the lines used to draw the circles
float circle_scale = 50; // multiplier for circles' diameters
String export_filename = "exported.png"; // output filename including extension
color bg_colour = color(0, 0, 0);
color circle_colour = color(255, 255, 255);

// calculate global variables
int n_circles = grid_shape[0] * grid_shape[1];
float[] grid_box_size = new float[2]; // number of pixels horizontally and vertically of each box in the grid
int[] primes; // list of primes
PGraphics graphics_export; // create an empty PGraphics object to export the image

void setup() {
  size(100, 100);

  // create a new PGraphics object
  graphics_export = createGraphics(image_size[0], image_size[1], JAVA2D);
  graphics_export.beginDraw();

  grid_box_size[0] = image_size[0]/grid_shape[0];
  grid_box_size[1] = image_size[1]/grid_shape[1];

  // drawing settings
  graphics_export.background(bg_colour);
  graphics_export.stroke(circle_colour);
  graphics_export.noFill();

  // calculate circle centres
  float[][] circle_centres = new float[n_circles][2];
  int grid_hor_index = 0;
  int grid_ver_index = 0;
  for (int i = 0; i < n_circles; i++) {
    circle_centres[i][0] = (grid_hor_index + 0.5) * grid_box_size[0];
    circle_centres[i][1] = (grid_ver_index + 0.5) * grid_box_size[1];
    grid_hor_index += 1;
    if (grid_hor_index + 1 > grid_shape[0]) {
      grid_hor_index = 0;
      grid_ver_index += 1;
    }
  }

  // read a list of prime numbers from text file
  primes = int(loadStrings("primes.txt"));

  // calculate and draw circles
  graphics_export.strokeWeight(units_to_pixels(circle_thickness));
  Foss[] list_of_fosses = new Foss[n_circles];
  for (int i = 0; i < n_circles; i++) {
    int current_foss_value = starting_number + i;
    list_of_fosses[i] = new Foss(current_foss_value, true);
    list_of_fosses[i].draw_circles(circle_centres[i][0], circle_centres[i][1]);
  }

  // stop drawing and export the image
  graphics_export.endDraw();
  graphics_export.save("exports/" + export_filename);
  exit();
}
