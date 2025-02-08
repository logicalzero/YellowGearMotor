/**
 * The keyed motor shaft, for subtracting a matching hole in another
 * object (e.g., the center of a wheel or gear). This is  generated with
 * the same origin and orientation as `YellowGearMotor`.
 * 
 * @param h: Shaft height (length) from the center of the gear motor.
 */
module MotorShaft(h=18.5) {
    color("white")
        intersection() {
            cylinder(h,2.5,2.5, center=true, $fn=30);
            cube([4,6,h+1], center=true);
        }
}


/**
 * A cylinder, intended to be differenced from another object to fit the motor
 * shaft with enough room to turn. This is  generated with the same origin and
 * orientation as `YellowGearMotor`.
 * 
 * @param h: Hole depth (length) from the center of the gear motor.
 * @param r: Hole radius.
 * @param doubleSided: If `true` (and `shaft` is `true`), the shaft will protrude
 *     from both sides of the motor. This reflects the two models of gear motor.
 */
module ShaftHole(h=20, r=2.75, doubleSided=false) {
    if(doubleSided)
        cylinder(h*2, r, r, center=true);
    else
        cylinder(h, r, r);
}


/**
 * MountingHoles: cylinders representing the gear motor's mounting holes, for
 * subtracting matching holes in another model for attachment. These are 
 * generated with the same origin and orientation as `YellowGearMotor`.
 *
 * @param h: Height of the cylinders.
 * @param r: Radius of the cylinders.
 */
module MountingHoles(h=20, r=1.25) {
    translate([-9,-20,0]) cylinder(h,r,r, center=true, $fn=10);
    translate([9,-20,0]) cylinder(h,r,r, center=true, $fn=10);
    translate([0,13,0]) cylinder(h,r,r, center=true, $fn=10);
}

/**
 * A complete model of a common, cheap DC gear motor, typically in a yellow plastic
 * housing. 
 * 
 * @param pad: An amount of padding (in local units) to enlarge the gear motor
 *     model, intended for creating a slightly oversized cavity in another object
 *     for inserting a real gear motor into a printed object.
 * @param shaft: If `true`, generate the motor's keyed output shaft. Not recommended
 *     if differencing `YellowGearMotor` from another object.
 * @param doubleSided: If `true` (and `shaft` is `true`), the shaft will protrude
 *     from both sides of the motor. This reflects the two models of gear motor.
 * @param holes: If `true` (default), the gear motor's mounting holes will be
 *     generated in the model. Not recommended if differencing `YellowGearMotor`
 *     from another object.
 */
module YellowGearMotor(pad=0, shaft=true, doubleSided=false, holes=false) {
    // Main body
    color("yellow") {
        difference() {
            union() {
                // Gearbox
                hull() {
                    //$fn=30;
                    translate([0,-20,0]) cube([22+pad,10+pad,18+pad], center=true);
                    translate([-7,7,0]) cylinder(18+pad,4+(pad/2),4+(pad/2), center=true);
                    translate([7,7,0]) cylinder(18+pad,4+(pad/2),4+(pad/2), center=true);
                }
                
                // Top tab
                translate([0,13,0]) 
                    cube([4.5,4.51,2], center=true);
                
                // Motor (simplified)
                intersection() {
                    rotate([90,0,0]) translate([0,-1,25-pad]) cylinder(27.5+pad,10+pad,10+pad);
                    translate([0,-40,-.5]) cube([21+pad,37+pad,15+pad], center=true);
                }

                // Motor (simplified)
                intersection() {
                    rotate([90,0,0]) translate([0,-1,24-pad]) cylinder(11.5+pad,11+pad,11+pad);
                    translate([0,-40,-.5]) cube([22+pad,37+pad,17+pad], center=true);
                }

                
                // Strap hooks
                translate([0, -30, -.5]) cube([5.25+pad, 3+pad, 22+pad], center=true);
                
                // Strap
                translate([0, -30, -.5]) cube([12+pad, 10+pad, 19+pad], center=true);
                hull() {
                    translate([0, -40, -.5]) 
                        cube([10+pad, 20+pad, 19+pad], center=true);
                    translate([0, -52.25, -8.25]) 
                        rotate([0, 90, 0])
                            cylinder(10+pad, 1.75+pad/2, 1.75+pad/2, center=true);
                    translate([0, -52.25, 7.25]) 
                        rotate([0, 90, 0])
                            cylinder(10+pad, 1.75+pad/2, 1.75+pad/2, center=true);
                }
                
                // Key nub
                translate([0,-10,0])
                    cylinder(10.5+pad,2+pad,2+pad, $fn=15);
            }
            if (holes)
                MountingHoles(20+(2*pad));
        }
    }
    // Shaft
    if (shaft) {
        if (doubleSided) {
            //translate([0,10,0])
                MotorShaft(37);
        }
        else {
            translate([0,0,9.25])
                MotorShaft(18.5);
        }
    }
}

// Example (remove later)
$fa=1;
YellowGearMotor(shaft=false, holes=true, pad=0);
translate([0,0,9.25]) MotorShaft();
