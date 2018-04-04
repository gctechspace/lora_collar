
$fn = 60;

box_size = [90, 55, 115];
pole_size = 89;
strap_width = 13 + 1;
squash_amount = .5;
strap_depth = 5 * 1/squash_amount;

wall_size = 5;
collar_box = [
    box_size[0] + wall_size * 2,
    box_size[1] + pole_size / 4 + wall_size * 2,
    (strap_width + wall_size * 2) * 2
];

module ring (d, h, thick) {
    difference() {
        cylinder(d=d, h=h, center=true);
        cylinder(d=d-thick, h=h+1, center=true);
    }
}

module strap_and_curve() {
    scale([1,squash_amount,1]) {
        difference() {
            cylinder(d=collar_box[0], h=collar_box[2], center=true);
            resize([0,collar_box[0]+strap_depth,0]) ring(d=collar_box[0]+strap_depth*2, h=strap_width, thick=strap_depth*2);
            translate([0,collar_box[0]/4+1,0]) cube([collar_box[0]+1,collar_box[0]/2+1,collar_box[2]+1], center=true);
        }
    }
}

%translate ([0,-box_size[1]/2-wall_size,0]) cube(box_size, center=true);
difference() {
    union() {
        translate([0,-collar_box[1]/2+pole_size/4,0]) cube(collar_box, center=true);
        // and a bigger base next to the pole
        //translate([0,-collar_box[1]/2+pole_size/4,0]) scale([1,1,2]) cube(collar_box, center=true);

        // now add the strap groove
        translate([0,-box_size[1]-wall_size*2,0]) strap_and_curve();
    }

    // pole
    translate([0,pole_size/2,0]) cylinder(d=pole_size, h=400, center=true);

    // box
    translate([0,-box_size[1]/2 - wall_size,0]) cube(box_size, center=true);

    // Cut into two parts
    translate([0,-box_size[1]/2,0]) cube([collar_box[0]+1,30,collar_box[2]+1], center = true);
}

