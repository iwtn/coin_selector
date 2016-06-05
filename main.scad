width = 200;
tickness = 2;

// value, diameter, tickness
coins = [
  [1,    20.0, 1.2],
  [5,    22.0, 1.5],
  [10,   23.5, 1.5],
  [50,   21.0, 1.7],
  [100,  22.5, 1.7],
  [500,  26.5, 2.0],
];

union() {
  cube([width, 20, tickness]);
  cube([width, tickness, 5]);
}
