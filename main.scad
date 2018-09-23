function suml2(v, i) = (i==0 ? v[i] : v[i] + suml2(v,i-1));
function suml(v, i) = suml2(v, len(v) - 1);
function select(vector,indices) = [ for (index = indices) vector[index] ];
function index_vector(i) = ([ for(a = [0:i]) a ]);

module plate(coins, start_plate_size, tickness, hole_width_margin, guard) {
  diameters = [ for (a = coins) a[1] ];
  l = suml(diameters);
  full_length = l + start_plate_size + hole_width_margin * len(coins) * 2;
  plate_height = max(diameters) + tickness + 5;

  union() {
    cube([full_length, plate_height, tickness]);
    cube([full_length, tickness, 5]);
  }
}

module holes(coins, start_plate_size, tickness, hole_margin, hole_width_margin, guard) {
  difference() {
    union() {
      diameters = [ for (a = coins) a[1] ];
      index_vecs = ([ for(a = [0:len(diameters) - 1]) index_vector(a) ]);
      diameters_vecs = [ for(idxs = index_vecs) select(diameters, idxs) ];
      start_positions = [ for(dias = diameters_vecs) suml(dias) ];

      for (i = [0:len(coins)-1]) {
        coin = coins[i];
        diameter = coin[1];
        start_position = start_plate_size - diameter + start_positions[i] + i * hole_width_margin * 2;
        translate([start_position, guard, -0.5]) {
          cube([diameter, diameter + hole_margin, tickness + 5]);
        }
        translate([start_position + diameter, guard + diameter / 2, -0.5]) {
          cylinder(h=tickness + 5, r=diameter / 2, center=true);
        }
      }
    }
    cube([300, guard + tickness, 10]);
  }
}

// value, diameter, tickness
coins = [
  [1,    20.0, 1.2],
  [50,   21.0, 1.7],
  [5,    22.0, 1.5],
  [100,  22.6, 1.7],
  [10,   23.5, 1.5],
  [500,  26.5, 2.0],
];

start_plate_size = 30;
tickness = 1.5;
hole_margin = 0.15;
hole_width_margin = 10;
guard = 1.5;

difference() {
  plate(coins, start_plate_size, tickness, hole_width_margin, guard);
  holes(coins, start_plate_size, tickness, hole_margin, hole_width_margin, guard);
}
