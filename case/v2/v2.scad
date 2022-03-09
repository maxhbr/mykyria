
/* $fa = .01; // minimum angle */
/* $fs = .01; // minimum size */

points = [[[-101.3073,-16.5662],[7,8],0]
         ,[[-66.6750,60.1250],[8,2],0]
         ,[[-57.3761,1.6306],[1,3],0]
         ,[[-13.1637,0.2500],[4,6],0]
         ,[[-7.0000,49.8500],[2,3,5],0]
         ,[[9.5250,47.6250],[2,4,5],0]
         ,[[9.5250,9.5250],[3,4,6],0]
         ,[[-115.7250,1.4721],[0],0]
         ,[[-90.7250,16.185],[0,2],0]
];

trans=[0,0,7.6];
rot2=[-6,13,0];
rot1=[0,0,-5];
//trans=[0,0,15];
//rot2=[0,40,0];
//rot1=[0,0,5];

module base() {
    difference() {
        union(){
            for (p=points) {
                intersection() {
                    translate(trans)rotate(rot2)rotate(rot1)
                        translate([p[0].x, p[0].y, -100])
                        cylinder(h=5+100,d=(3.2+3),$fn=6);
                    translate([-200,-200,0]) cube([400,400,200]);
                }
            }
            for (p=points) {
                hull() {
                    intersection() {
                        translate(trans)rotate(rot2)rotate(rot1)
                            translate([p[0].x, p[0].y, -100])
                            cylinder(h=2.5+100,d=(3.2+3),$fn=6);
                        translate([-200,-200,0]) cube([400,400,200]);
                    }
                    for (i=p[1]) {
                        intersection() {
                            translate(trans)rotate(rot2)rotate(rot1)
                                translate([points[i][0].x, points[i][0].y, -100])
                                cylinder(h=2.5+100,d=(3.2 + 3),$fn=6);
                            translate([-200,-200,0]) cube([400,400,1.5]);
                        }
                    }
                }
            }
        }
        for (p=points) {
            translate(trans)rotate(rot2)rotate(rot1)
                translate([p[0].x, p[0].y, -0.5])
                cylinder(h=6,d=3.2
                        ,$fa = .01 // minimum angle
                        ,$fs = .01 // minimum size
                );
        }
        if (false) {
            for (p=points) {
                hull() {
                    intersection() {
                        translate(trans)rotate(rot2)rotate(rot1)
                            translate([p[0].x, p[0].y, -100])
                            cylinder(h=100,d=1,$fn=6);
                        translate([-200,-200,0]) cube([400,400,200]);
                    }
                    for (i=p[1]) {
                        intersection() {
                            translate(trans)rotate(rot2)rotate(rot1)
                                translate([points[i][0].x, points[i][0].y, -100])
                                cylinder(h=2.5+100,d=1,$fn=6);
                            translate([-200,-200,-1]) cube([400,400,1.5]);
                        }
                    }
                }
            }
        }
        translate([-20,18,0.3])
            rotate([180,0,180])
            linear_extrude(0.31)
            text("github.com/maxhbr",
                    font = "Roboto Condensed:style=Light",
                    size = 4,
                    halign = "center");
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
    translate([-31,100,0]) mirror([0,1,0]) base();
}
