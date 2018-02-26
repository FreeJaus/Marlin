// The size of the hot bed
xHotBedSize = 215;
yHotBedSize = 215;

// The size of the glass
xGlassBedSize = 210;
yGlassBedSize = 200;

// The size of the print bed
xBedSize = 200;
yBedSize = 200;

// Z Probe to nozzle (X,Y) offset, relative to (0, 0).
// X and Y offsets must be integers (mm)
xProbeOffsetFromExtruder = 4;    // X offset: -left  +right  [of the nozzle]
yProbeOffsetFromExtruder = -44;   // Y offset: -front +behind [the nozzle]
zProbeOffsetFromExtruder = -1.45; // Z offset: -below +over [the nozzle]

//#define Z_CLEARANCE_DEPLOY_PROBE   10 // Z Clearance for Deploy/Stow
//#define Z_CLEARANCE_BETWEEN_PROBES  5 // Z Clearance between probe points

// Travel limits (mm) after homing, corresponding to endstop positions.
xMinPos = -12;
yMinPos = -8;
zMinPos = 0;
xMaxPos = -xMinPos+xBedSize;
yMaxPos = -yMinPos+yBedSize;
zMaxPos = 200;

// Set the number of grid points per dimension.
xGridMaxPoints = 4;
yGridMaxPoints = xGridMaxPoints;

// The Z probe minimum outer margin (to validate G29 parameters).
//#define MIN_PROBE_EDGE 10

// Set the boundaries for probing (where the probe can reach).
leftProbeBedPosition = 10;
rightProbeBedPosition = xMaxPos - xProbeOffsetFromExtruder - 14;
frontProbeBedPosition = 15;
backProbeBedPosition = yMaxPos + yProbeOffsetFromExtruder - 25;

//---

xHome = .5*xBedSize;
yHome = .5*yBedSize;

xMesh = .8*xBedSize;
yMesh = .7*yBedSize;

/*
%  #define ABL_PROBE_PT_1_X 15
%  #define ABL_PROBE_PT_1_Y 180
%  #define ABL_PROBE_PT_2_X 15
%  #define ABL_PROBE_PT_2_Y 20
%  #define ABL_PROBE_PT_3_X 170
%  #define ABL_PROBE_PT_3_Y 20

%  #define UBL_PROBE_PT_1_X 39       // Probing points for 3-Point leveling of the mesh
%  #define UBL_PROBE_PT_1_Y 180
%  #define UBL_PROBE_PT_2_X 39
%  #define UBL_PROBE_PT_2_Y 20
%  #define UBL_PROBE_PT_3_X 180
%  #define UBL_PROBE_PT_3_Y 20

%#if ENABLED(Z_SAFE_HOMING)
%  #define Z_SAFE_HOMING_X_POINT ((xBedSize) / 2)    // X point for Z homing when homing all axes (G28).
%  #define Z_SAFE_HOMING_Y_POINT ((yBedSize) / 2)    // Y point for Z homing when homing all axes (G28).
%#endif
*/

translate([.5*xHotBedSize-30,yMinPos-15,0]) text("FRONT");
translate([.5*xHotBedSize-30,yHotBedSize+7.5,0]) text("BACK");
translate([xMinPos-10,.5*yHotBedSize-30,0]) rotate([0,0,90]) text("LEFT");
translate([xHotBedSize+17.5,.5*yHotBedSize-30,0]) rotate([0,0,90]) text("RIGHT");

// Hot bed
color("orange")

    cube([xHotBedSize,yHotBedSize,5]);

// Glass bed
color("cyan")
  translate([2.5,7.5,5])
    cube([xGlassBedSize,yGlassBedSize,4]);

// Allowed area
color("green")
  translate([xMinPos,yMinPos,0])
    cube([xMaxPos-xMinPos,yMaxPos-yMinPos,1]);

// Bed
  %translate([0,0,10])
    cube([xBedSize,yBedSize,1]);

// Nozzle and sensor
  translate([xHome,yHome,10]) {
    cylinder(r=2,h=10);
    translate([xProbeOffsetFromExtruder,yProbeOffsetFromExtruder,zProbeOffsetFromExtruder])
      cylinder(r=2,h=10);
  }
  
  color("red") translate([leftProbeBedPosition,frontProbeBedPosition,15]) {
    dx = rightProbeBedPosition-leftProbeBedPosition;
    dy = backProbeBedPosition-frontProbeBedPosition;
    for (i = [0:xGridMaxPoints-1]) {
      for (j = [0:xGridMaxPoints-1]) {
        translate([i*dx/(xGridMaxPoints-1),j*dy/(yGridMaxPoints-1),0]) cylinder(r=1,h=1);      //cube([,,1]);
      }
    }
  }
/*
  \coordinate (o) at (0,0);

  \draw (o) circle (.1);
  \node[] () at ($(o)+(.75,-.5)$) {$(0,0)$};

  \draw[->] ($(o)+(.5,.5)$) -- ($(o)+(1,.5)$);
  \draw[->] ($(o)+(.5,.5)$) -- ($(o)+(.5,1)$);
  \node[] () at ($(o)+(1.25,.5)$) {$X$};
  \node[] () at ($(o)+(.5,1.25)$) {$Y$};
*/