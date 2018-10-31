float units_to_pixels(float input_units) {
  return(circle_scale * input_units);
}

boolean is_prime(int prime_candidate) {
  // checks if the input is a prime number by comapring it to a (finite) list of primes
  for (int i = 0; i < primes.length; i++) {
    if (primes[i] > prime_candidate) {
      return (false);
    } else if (primes[i] == prime_candidate) {
      return (true);
    }
  }
  return(false);
}

int[] factorise(int x) {
  // returns a 1D array of the prime factors of the input
  int[] divisors = {};
  if (x <= 1 | is_prime(x)) {
    divisors = append(divisors, x);
  } else { // if the number is not prime
    for (int i = 2; i <= sqrt(x); i++) {
      if (x % i == 0) {
        int[] factored_i = factorise(i);
        for (int j = 0; j < factored_i.length; j++) {
          divisors = append(divisors, factored_i[j]);
        }
        int[] factored_xi = factorise(x / i);
        for (int j = 0; j < factored_xi.length; j++) {
          divisors = append(divisors, factored_xi[j]);
        }
        break;
      }
    }
  }
  return(divisors);
}

int prime_index(int input_prime) {
  // for an input prime number, returns the index of that number from a list of primes
  if (input_prime <= primes[primes.length - 1]) {
    for (int i = 0; i < primes.length - 1; i++) {
      if (input_prime == primes[i]) {
        return(i + 1);
      }
    }
  }
  return(-1);
}

void ver_line(float x_pos) {
  // draw a vertical line from the top of the canvas to the bottom
  pushMatrix();
  translate(x_pos, 0);
  graphics_export.line(0, 0, 0, image_size[1]);
  popMatrix();
}

void hor_line(float y_pos) {
  // draw a horizontal line from the left of the canvas to the right
  pushMatrix();
  translate(0, y_pos);
  graphics_export.line(0, 0, image_size[0], 0);
  popMatrix();
}
