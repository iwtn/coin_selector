// value, diameter, tickness
coins = [
  [1,    20.0, 1.2],
  [50,   21.0, 1.7],
  [5,    22.0, 1.5],
  [100,  22.6, 1.7],
  [10,   23.5, 1.5],
  [500,  26.5, 2.0],
];

unit_witdh = 35;
hole_width = 30;
plate_height = 32;
full_length = (len(coins) + 1) * unit_witdh;
tickness = 1.5;
hole_margin = 0.2;

rotate([-90, 0, 0]) {
  difference() {
    union() {
      cube([full_length, plate_height, tickness]);
      cube([full_length, tickness, 5]);
    }

    union() {
      for(i = [0:len(coins)-1]) {
        coin = coins[i];
        translate([(i + 1) * unit_witdh, tickness, -0.5]) {
          cube([hole_width, coin[1] + hole_margin, tickness + 5]);
        }
      }
    }
  }
}
