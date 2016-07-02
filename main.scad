// value, diameter, tickness
coins = [
  [1,    20.0, 1.2],
  [50,   21.0, 1.7],
  [5,    22.0, 1.5],
  [100,  22.6, 1.7],
  [10,   23.5, 1.5],
  [500,  26.5, 2.0],
];

plate_height = 32;
tickness = 1.5;
hole_margin = 0.1;
hole_width_margin = 3;

function suml2(v, i) = (i==0 ? v[i] : v[i] + suml2(v,i-1));
function suml(v, i) = suml2(v, len(v) - 1);
function select(vector,indices) = [ for (index = indices) vector[index] ];
function index_vector(i) = ([ for(a = [0:i]) a ]);

module plate(coins, hole_width_margin) {
  diameters = [ for (a = coins) a[1] ];
  l = suml(diameters);
  full_length = l + 30 + hole_width_margin * len(coins) * 2;

  union() {
    cube([full_length, plate_height, tickness]);
    cube([full_length, tickness, 5]);
  }
}

module holes(coins, hole_width_margin) {
  union() {
    diameters = [ for (a = coins) a[1] ];
    index_vecs = ([ for(a = [0:len(diameters) - 1]) index_vector(a) ]);
    diameters_vecs = [ for(idxs = index_vecs) select(diameters, idxs) ];
    start_positions = [ for(dias = diameters_vecs) suml(dias) ];

    for (i = [0:len(coins)-1]) {
      coin = coins[i];
      diameter = coin[1];
      start_position = 30 - diameter + start_positions[i] + i * hole_width_margin * 2;
      translate([start_position, tickness, -0.5]) {
        cube([diameter + hole_width_margin, diameter + hole_margin, tickness + 5]);
      }
    }
  }
}

difference() {
  plate(coins, hole_width_margin);
  holes(coins, hole_width_margin);
}
