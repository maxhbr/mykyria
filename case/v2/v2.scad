
$fa = .01; // minimum angle
$fs = .01; // minimum size

points = [[[-101.3073,-16.5662],[0,7,8],0]
         ,[[-66.6750,60.1250],[8,1,2],0]
         ,[[-57.3761,1.6306],[1,2,3],0]
         ,[[-13.1637,0.2500],[2,3,6],0]
         ,[[-7.0000,49.8500],[2,3,4],0]
         ,[[9.5250,47.6250],[2,4,5],0]
         ,[[9.5250,9.5250],[2,3,6],0]
         ,[[-115.7250,1.4721],[0,7,8],0]
         ,[[-90.7250,16.185],[0,1,8],0]
];

trans=[0,0,3];
rot2=[0,13,0];
rot1=[0,0,5];
//trans=[0,0,15];
//rot2=[0,40,0];
//rot1=[0,0,5];

module base() {
    translate(trans)rotate(rot2)rotate(rot1)
    difference() {
        union(){
            for (p=points) {
                translate([p[0].x, p[0].y, - (p[2])])
                    cylinder(h=5+p[2],d=(3.2+ 2* 2),$fn=6);
            }
            for (p=points) {
                hull() {
                    translate([p[0].x, p[0].y, - (p[2])])
                        cylinder(h=2,d=(3.2+ 2* 2),$fn=6);
                    rotate(-rot1)rotate(- rot2)translate(-trans)
                        for (i=p[1]) {
                            translate([points[i][0].x, points[i][0].y, 0])
                                cylinder(h=1,d=10,$fn=6);
                        }
                }
            }
        }
        for (p=points) {
            translate([p[0].x, p[0].y, -0.5])
                cylinder(h=6,d=(3.2));
        }
    }
}

module kyria() {
    translate(trans)rotate(rot2)rotate(rot1) {
        translate([0,0,5])
            color("green",0.5)
            difference() {
                linear_extrude(height = 1.5, center = false, convexity = 10)
                    import (file = "../../submodules/kyria/Edge Cuts.dxf");
                for (p=points) {
                    translate([p[0].x, p[0].y, -0.5])
                        cylinder(h=6,d=(2));
                }
            }
        translate([0,0,5 + 3.5])
            color("black",0.5)
            difference() {
                linear_extrude(height = 1.5, center = false, convexity = 10)
                    import (file = "../../submodules/kyria/Plate Case/Kyria Plate Case Top - 6 columns - No Kerf.dxf");
                for (p=points) {
                    translate([p[0].x, p[0].y, -0.5])
                        cylinder(h=6,d=(2));
                }
            }
    }
}

base();

if($preview) {
    kyria();
} else {
    translate([-33,100,0]) mirror([0,1,0]) base();
}
