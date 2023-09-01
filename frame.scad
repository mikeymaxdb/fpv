// More faces
$fn=200;

xAxis = [1, 0, 0];
yAxis = [0, 1, 0];
zAxis = [0, 0, 1];
xyAxis = [1, 1, 0];

// All dimensions in mm
propDiameter=80; // 3in = 76.2mm
motorScrewDiameter = 2;
motorShaftDiameter = 4;
motorScrewSpacing = 9;
armWidth = 18;
armLength = 65;
bodyWidth = 30;
bodyLength = 70;
hardwareScrewDiameter = 2;
cameraPlateThickness = 2;

module motorHoles() {
    union() {
        halfSpacing = motorScrewSpacing / 2;

        // Motor screws
        translate([halfSpacing, halfSpacing]) circle(d = motorScrewDiameter);
        translate([halfSpacing, -halfSpacing]) circle(d = motorScrewDiameter);
        translate([-halfSpacing, halfSpacing]) circle(d = motorScrewDiameter);
        translate([-halfSpacing, -halfSpacing]) circle(d = motorScrewDiameter);

        // Motor shaft
        circle(d = motorShaftDiameter);
    }
}

module makeArm() {
    bodyOffset = bodyWidth / 2;

    // Top left arm
    translate([-bodyOffset, bodyOffset]) // Make space for body
    rotate(45, zAxis) // True X
    translate([-armWidth / 2, 0]) // Center arm X axis
    union() {
        difference() {
            square([armWidth, armLength]);
            translate([armWidth / 2, armLength - motorScrewSpacing]) motorHoles();
        }
        // Propeller
        translate([armWidth / 2, armLength - motorScrewSpacing, 10]) %circle(d = propDiameter);
    }
}

module fcHoles() {
    rotate(45, zAxis) union() {
        translate([0, 0]) circle(d = hardwareScrewDiameter);
        hull() {
            translate([16 / 2, 0]) circle(d = hardwareScrewDiameter);
            translate([20 / 2, 0]) circle(d = hardwareScrewDiameter);
        }
        hull() {
            translate([25.5 / 2, 0]) circle(d = hardwareScrewDiameter);
            translate([26.5 / 2, 0]) circle(d = hardwareScrewDiameter);
        }
    }
}

union() {
    // Arms
    makeArm();
    mirror(xAxis) makeArm();
    mirror(yAxis) makeArm();
    mirror(xAxis) mirror(yAxis) makeArm();

    // Body
    difference() {
        translate([-bodyWidth / 2, -bodyLength / 2]) square([bodyWidth, bodyLength]);
        fcHoles();
    }
}
