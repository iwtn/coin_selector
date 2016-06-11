// value, diameter, tickness
coins = [
  [1,    20.0, 1.2],
  [50,   21.0, 1.7],
  [5,    22.0, 1.5],
  [100,  22.6, 1.7],
  [10,   23.5, 1.5],
  [500,  26.5, 2.0],
];

hole_width = 35;
full_length = (len(coins) + 1) * hole_width;
tickness = 1.5;
hole_margin = 0.1;

for(i = [0:len(coins)-1]) {
  coin = coins[i];
  translate([(i + 1) * hole_width, tickness, -0.5]) {
    cube([coin[1], coin[1], tickness + 5]);
  }
}

union() {
  cube([full_length, 30, tickness]);
  cube([full_length, tickness, 5]);
}
