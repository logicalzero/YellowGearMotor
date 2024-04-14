/**
 * The keyed motor shaft, for subtracting a matching hole in another
 * object (e.g., the center of a wheel or gear). This is  generated with
 * the same origin and orientation as `YellowGearMotor`.
 * 
 * @param h: Shaft height (length) from the center of the gear motor.
 */
module MotorShaft(h=18.5) {
    intersection() {
        cylinder(h,2.5,2.5, center=true, $fn=30);
        cube([4,6,h+1], center=true);
    }
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
    translate([-9,-26.5,0]) cylinder(h,r,r, center=true, $fn=10);
    translate([9,-26.5,0]) cylinder(h,r,r, center=true, $fn=10);
    translate([0,12,0]) cylinder(h,r,r, center=true, $fn=10);
}

/**
 * A complete model of a common, cheap DC gear motor, typically in a yellow plastic
 * housing. 
 * 
 * @param shaft: If `true` (default), generate the motor's keyed output shaft.
 * @param doubleSided: If `true` (and `shaft` is `true`), the shaft will protrude
 *     both sides of the motor. This reflects the two models of gear motor.
 * @param holes: If `true` (default), the gear motor's mounting holes will be
 *     generated in the model. Not recommended if differencing `YellowGearMotor`
 *     from another object.
 * @param pad: An amount of padding (in local units) to enlarge the gear motor
 *     model, intended for creating a slightly oversized cavity in another object
 *     for inserting a real gear motor into a printed object.
 */
module YellowGearMotor(shaft=true, doubleSided=false, holes=true, pad=0) {
    // Main body
    color("yellow") {
        difference() {
            union() {
                // Gearbox
                hull() {
                    //$fn=30;
                    translate([0,-12,0]) cube([22+pad,37+pad,18+pad], center=true);
                    translate([-7,6.5,0]) cylinder(18+pad,4+(pad/2),4+(pad/2), center=true);
                    translate([7,6.5,0]) cylinder(18+pad,4+(pad/2),4+(pad/2), center=true);
                }
                
                // Top tab
                translate([0,12,0]) 
                    cube([4.5,4.51,2], center=true);
                
                // Motor (simplified)
                intersection() {
                    rotate([90,0,0]) translate([0,-1,30-pad]) cylinder(25+pad,11+pad,11+pad);
                    translate([0,-40,-.5]) cube([22+pad,37+pad,17+pad], center=true);
                }
                
                // Key nub
                translate([0,-11,0])
                    cylinder(10.5+pad,2+pad,2+pad, $fn=15);
            }
            if (holes)
                MountingHoles(20+(2*pad));
        }
    }
    // Shaft
    if (shaft) {
        if (doubleSided) {
            color("white")
            //translate([0,10,0])
                MotorShaft(37);
        }
        else {
            color("white")
            translate([0,0,9.25])
                MotorShaft(18.5);
        }
    }
}


YellowGearMotor(shaft=true, pad=0);