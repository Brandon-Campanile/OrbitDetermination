stk.v.11.0
WrittenBy    STK_v11.6.1

BEGIN Facility

    Name		 DSS_65_Robledo_STDN_DS65

    BEGIN CentroidPosition

        CentralBody		 Earth
        DisplayCoords		 Geodetic
        EcfLatitude		  4.0427206360000000e+01
        EcfLongitude		 -4.2506988899999998e+00
        EcfAltitude		  8.3385400000000004e+02
        HeightAboveGround		  0.0000000000000000e+00
        ComputeTrnMaskAsNeeded		 Off
        SaveTrnMaskDataInBinary		 Off
        DisplayAltRef		 Ellipsoid
        UseTerrainInfo		 Off
        NumAzRaysInMask		 360
        TerrainNormalMode		 UseCbShape

    END CentroidPosition

    BEGIN Extensions

        BEGIN LaserCAT
        END LaserCAT

        BEGIN ExternData
        END ExternData

        BEGIN RFI
        END RFI

        BEGIN ADFFileData
        END ADFFileData

        BEGIN AccessConstraints
            LineOfSight IncludeIntervals
            AzElMask IncludeIntervals
        END AccessConstraints

        BEGIN ObjectCoverage
        END ObjectCoverage

        BEGIN Desc
            BEGIN ShortText
DSS 65 Robledo STDN DS65
Name:           DSS 65 Robledo STDN DS65
Country:        Spain
Location:       Robledo de Chavela
Status:         Active
Type:           GroundStation
Alternate name: DSS 64
Notes:          NASA# 1565, ESN# 65 || Equipment: USB-DSN 34m HEF   || Remarks: 11-89,DSN JPL,08/2005 relocate.
Sources:                       NASA Directory of Station Locations Jan 27 2010
               http://deepspace.jpl.nasa.gov/dsndocs/810-005/301/301F.pdf
               http://sunset.usc.edu/gsaw/gsaw2005/s9a/tai.pdf
Last updated:   2009-12-14Antennas:       
  Type    :ParabolicReflector
  Diameter: 34 [Meters]
  Notes   : 34m High Efficiency (HEF). Uplink (X), Downlink (S, X).
            END ShortText
            BEGIN LongText
Name:           DSS 65 Robledo STDN DS65
Country:        Spain
Location:       Robledo de Chavela
Status:         Active
Type:           GroundStation
Alternate name: DSS 64
Notes:          NASA# 1565, ESN# 65 || Equipment: USB-DSN 34m HEF   || Remarks: 11-89,DSN JPL,08/2005 relocate.
Sources:                       NASA Directory of Station Locations Jan 27 2010
               http://deepspace.jpl.nasa.gov/dsndocs/810-005/301/301F.pdf
               http://sunset.usc.edu/gsaw/gsaw2005/s9a/tai.pdf
Last updated:   2009-12-14Antennas:       
  Type    :ParabolicReflector
  Diameter: 34 [Meters]
  Notes   : 34m High Efficiency (HEF). Uplink (X), Downlink (S, X).
            END LongText
        END Desc

        BEGIN Atmosphere
<?xml version = "1.0" standalone = "yes"?>
<VAR name = "STK_Atmosphere_Extension">
    <SCOPE Class = "AtmosphereExtension">
        <VAR name = "Version">
            <STRING>&quot;1.0.0 a&quot;</STRING>
        </VAR>
        <VAR name = "STKVersion">
            <INT>1161</INT>
        </VAR>
        <VAR name = "ComponentName">
            <STRING>&quot;STK_Atmosphere_Extension&quot;</STRING>
        </VAR>
        <VAR name = "Description">
            <STRING>&quot;STK Atmosphere Extension&quot;</STRING>
        </VAR>
        <VAR name = "Type">
            <STRING>&quot;STK Atmosphere Extension&quot;</STRING>
        </VAR>
        <VAR name = "UserComment">
            <STRING>&quot;STK Atmosphere Extension&quot;</STRING>
        </VAR>
        <VAR name = "ReadOnly">
            <BOOL>false</BOOL>
        </VAR>
        <VAR name = "Clonable">
            <BOOL>true</BOOL>
        </VAR>
        <VAR name = "Category">
            <STRING>&quot;&quot;</STRING>
        </VAR>
        <VAR name = "InheritAtmosAbsorptionModel">
            <BOOL>true</BOOL>
        </VAR>
        <VAR name = "AtmosAbsorptionModel">
            <VAR name = "Simple_Satcom">
                <SCOPE Class = "AtmosphericAbsorptionModel">
                    <VAR name = "Version">
                        <STRING>&quot;1.0.1 a&quot;</STRING>
                    </VAR>
                    <VAR name = "STKVersion">
                        <INT>1161</INT>
                    </VAR>
                    <VAR name = "ComponentName">
                        <STRING>&quot;Simple_Satcom&quot;</STRING>
                    </VAR>
                    <VAR name = "Description">
                        <STRING>&quot;Simple Satcom gaseous absorption model&quot;</STRING>
                    </VAR>
                    <VAR name = "Type">
                        <STRING>&quot;Simple Satcom&quot;</STRING>
                    </VAR>
                    <VAR name = "UserComment">
                        <STRING>&quot;Simple Satcom gaseous absorption model&quot;</STRING>
                    </VAR>
                    <VAR name = "ReadOnly">
                        <BOOL>false</BOOL>
                    </VAR>
                    <VAR name = "Clonable">
                        <BOOL>true</BOOL>
                    </VAR>
                    <VAR name = "Category">
                        <STRING>&quot;&quot;</STRING>
                    </VAR>
                    <VAR name = "SurfaceTemperature">
                        <QUANTITY Dimension = "Temperature" Unit = "K">
                            <REAL>293.15</REAL>
                        </QUANTITY>
                    </VAR>
                    <VAR name = "WaterVaporConcentration">
                        <QUANTITY Dimension = "Density" Unit = "g*m^-3">
                            <REAL>7.5</REAL>
                        </QUANTITY>
                    </VAR>
                </SCOPE>
            </VAR>
        </VAR>
        <VAR name = "EnableLocalRainData">
            <BOOL>false</BOOL>
        </VAR>
        <VAR name = "LocalRainIsoHeight">
            <QUANTITY Dimension = "DistanceUnit" Unit = "m">
                <REAL>2000</REAL>
            </QUANTITY>
        </VAR>
        <VAR name = "LocalRainRate">
            <QUANTITY Dimension = "SlowRate" Unit = "mm*hr^-1">
                <REAL>1</REAL>
            </QUANTITY>
        </VAR>
        <VAR name = "LocalSurfaceTemp">
            <QUANTITY Dimension = "Temperature" Unit = "K">
                <REAL>293.15</REAL>
            </QUANTITY>
        </VAR>
    </SCOPE>
</VAR>        END Atmosphere

        BEGIN RadarCrossSection
<?xml version = "1.0" standalone = "yes"?>
<VAR name = "STK_Radar_RCS_Extension">
    <SCOPE Class = "RadarRCSExtension">
        <VAR name = "Version">
            <STRING>&quot;1.0.0 a&quot;</STRING>
        </VAR>
        <VAR name = "STKVersion">
            <INT>1161</INT>
        </VAR>
        <VAR name = "ComponentName">
            <STRING>&quot;STK_Radar_RCS_Extension&quot;</STRING>
        </VAR>
        <VAR name = "Description">
            <STRING>&quot;STK Radar RCS Extension&quot;</STRING>
        </VAR>
        <VAR name = "Type">
            <STRING>&quot;STK Radar RCS Extension&quot;</STRING>
        </VAR>
        <VAR name = "UserComment">
            <STRING>&quot;STK Radar RCS Extension&quot;</STRING>
        </VAR>
        <VAR name = "ReadOnly">
            <BOOL>false</BOOL>
        </VAR>
        <VAR name = "Clonable">
            <BOOL>true</BOOL>
        </VAR>
        <VAR name = "Category">
            <STRING>&quot;&quot;</STRING>
        </VAR>
        <VAR name = "Inherit">
            <BOOL>true</BOOL>
        </VAR>
    </SCOPE>
</VAR>        END RadarCrossSection

        BEGIN RadarClutter
<?xml version = "1.0" standalone = "yes"?>
<VAR name = "STK_Radar_Clutter_Extension">
    <SCOPE Class = "RadarClutterExtension">
        <VAR name = "Version">
            <STRING>&quot;1.0.0 a&quot;</STRING>
        </VAR>
        <VAR name = "STKVersion">
            <INT>1161</INT>
        </VAR>
        <VAR name = "ComponentName">
            <STRING>&quot;STK_Radar_Clutter_Extension&quot;</STRING>
        </VAR>
        <VAR name = "Description">
            <STRING>&quot;STK Radar Clutter Extension&quot;</STRING>
        </VAR>
        <VAR name = "Type">
            <STRING>&quot;STK Radar Clutter Extension&quot;</STRING>
        </VAR>
        <VAR name = "UserComment">
            <STRING>&quot;STK Radar Clutter Extension&quot;</STRING>
        </VAR>
        <VAR name = "ReadOnly">
            <BOOL>false</BOOL>
        </VAR>
        <VAR name = "Clonable">
            <BOOL>true</BOOL>
        </VAR>
        <VAR name = "Category">
            <STRING>&quot;&quot;</STRING>
        </VAR>
        <VAR name = "Inherit">
            <BOOL>true</BOOL>
        </VAR>
    </SCOPE>
</VAR>        END RadarClutter

        BEGIN Identification
        END Identification

        BEGIN Crdn
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_13_Goldstone_STDN_VEND
                Description		 Displacement vector to DSS_13_Goldstone_STDN_VEND
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_13_Goldstone_STDN_VEND
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_13_Goldstone_STDN_VEND-Servo
                Description		 Displacement vector to DSS_13_Goldstone_STDN_VEND-Servo
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_13_Goldstone_STDN_VEND/Sensor/Servo
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_13_Goldstone_STDN_VEND-Servo-DL_DSN
                Description		 Displacement vector to DSS_13_Goldstone_STDN_VEND-Servo-DL_DSN
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_13_Goldstone_STDN_VEND/Sensor/Servo/Receiver/DL_DSN
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_13_Goldstone_STDN_VEND-Servo-Uplink
                Description		 Displacement vector to DSS_13_Goldstone_STDN_VEND-Servo-Uplink
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_13_Goldstone_STDN_VEND/Sensor/Servo/Transmitter/Uplink
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_45_Tidbinbilla_STDN_DS45
                Description		 Displacement vector to DSS_45_Tidbinbilla_STDN_DS45
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_45_Tidbinbilla_STDN_DS45
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_45_Tidbinbilla_STDN_DS45-Servo
                Description		 Displacement vector to DSS_45_Tidbinbilla_STDN_DS45-Servo
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_45_Tidbinbilla_STDN_DS45/Sensor/Servo
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_45_Tidbinbilla_STDN_DS45-Servo-DL_DSN
                Description		 Displacement vector to DSS_45_Tidbinbilla_STDN_DS45-Servo-DL_DSN
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_45_Tidbinbilla_STDN_DS45/Sensor/Servo/Receiver/DL_DSN
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 DSS_45_Tidbinbilla_STDN_DS45-Servo-Uplink
                Description		 Displacement vector to DSS_45_Tidbinbilla_STDN_DS45-Servo-Uplink
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Facility/DSS_45_Tidbinbilla_STDN_DS45/Sensor/Servo/Transmitter/Uplink
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Earth
                Description		 Displacement vector to Earth
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Earth
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun1
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun10
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun11
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun12
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun13
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun14
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun15
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun16
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun17
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun18
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun19
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun2
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun20
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun21
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun22
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun3
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun4
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun5
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun6
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun7
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun8
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Sun9
                Description		 Displacement vector to Sun
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Sun
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 Venus
                Description		 Displacement vector to Venus
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Planet/Venus
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 VenusSat
                Description		 Displacement vector to VenusSat
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Satellite/VenusSat
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 VenusSat-Downlink1
                Description		 Displacement vector to VenusSat-Downlink1
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Satellite/VenusSat/Transmitter/Downlink1
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 VenusSat-Imaging_Instrument1
                Description		 Displacement vector to VenusSat-Imaging_Instrument1
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Satellite/VenusSat/Sensor/Imaging_Instrument1
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 VenusSat-UL_Rcvr1
                Description		 Displacement vector to VenusSat-UL_Rcvr1
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Satellite/VenusSat/Receiver/UL_Rcvr1
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
            BEGIN VECTOR
                Type		 VECTOR_TOVECTOR
                Name		 minAltSat
                Description		 Displacement vector to minAltSat
                Origin		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                END POINT
                Destination		
                BEGIN POINT
                    Type		 POINT_LINKTO
                    Name		 Center
                    RelativePath		 Satellite/minAltSat
                END POINT
                LTDRefSystem		
                BEGIN SYSTEM
                    Type		 SYSTEM_LINKTO
                    Name		 BarycenterICRF
                    AbsolutePath		 CentralBody/Sun
                END SYSTEM
                Apparent		 No
                TimeConvergence		  1.0000000000000000e-03
                TimeSense		 Receive
                IgnoreAberration		 No
            END VECTOR
        END Crdn

        BEGIN Graphics

            BEGIN Attributes

                MarkerColor		 #0000ff
                LabelColor		 #0000ff
                LineStyle		 0
                MarkerStyle		 5
                FontStyle		 0

            END Attributes

            BEGIN Graphics

                Show		 On
                Inherit		 On
                IsDynamic		 Off
                ShowLabel		 On
                ShowAzElMask		 Off
                ShowAzElFill		 Off
                AzElFillStyle		 7
                AzElFillAltTranslucency		 0.5
                UseAzElColor		 Off
                AzElColor		 #ffffff
                MinDisplayAlt		 833.854
                MaxDisplayAlt		 10000000
                NumAzElMaskSteps		 1
                ShowAzElAtRangeMask		 On
                ShowAzElAtRangeFill		 Off
                AzElFillRangeTranslucency		 0.5
                AzElAtRangeFillStyle		 7
                UseAzElAtRangeColor		 Off
                AzElAtRangeColor		 #ffffff
                MinDisplayRange		 0
                MaxDisplayRange		 1000000
                NumAzElAtRangeMaskSteps		 10

                BEGIN RangeContourData
                    Show		 Off
                    ShowRangeFill		 Off
                    RangeFillTranslucency		 0.5
                    LabelUnits		 4
                    NumDecimalDigits		 3

                END RangeContourData

            END Graphics

            BEGIN DisplayTimes
                DisplayType		 AlwaysOn
            END DisplayTimes
        END Graphics

        BEGIN ContourGfx
            ShowContours		 Off
        END ContourGfx

        BEGIN Contours
            ActiveContourType		 Radar Cross Section

            BEGIN ContourSet Radar Cross Section
                Altitude		 0
                ShowAtAltitude		 Off
                Projected		 On
                Relative		 On
                ShowLabels		 Off
                LineWidth		 1
                DecimalDigits		 1
                ColorRamp		 On
                ColorRampStartColor		 #ff0000
                ColorRampEndColor		 #0000ff
                BEGIN ContourDefinition
                    BEGIN CntrAntAzEl
                        CoordinateSystem		 0
                        BEGIN AzElPatternDef
                            SetResolutionTogether		 0
                            NumAzPoints		 361
                            AzimuthRes		 1
                            MinAzimuth		 -180
                            MaxAzimuth		 180
                            NumElPoints		 91
                            ElevationRes		 1
                            MinElevation		 0
                            MaxElevation		 90
                        END AzElPatternDef
                    END CntrAntAzEl
                    BEGIN RCSContour
                        Frequency		 2997924580
                        ComputeType		 0
                    END RCSContour
                END ContourDefinition
            END ContourSet
        END Contours

        BEGIN VO
        END VO

        BEGIN 3dVolume
            ActiveVolumeType		 Radar Cross Section

            BEGIN VolumeSet Radar Cross Section
                Scale		 100
                MinimumDisplayedRcs		 1
                Frequency		  1.4500000000000000e+10
                ShowAsWireframe		 0
                BEGIN AzElPatternDef
                    SetResolutionTogether		 0
                    NumAzPoints		 50
                    AzimuthRes		 7.346938775510203
                    MinAzimuth		 -180
                    MaxAzimuth		 180
                    NumElPoints		 50
                    ElevationRes		 3.673469387755102
                    MinElevation		 0
                    MaxElevation		 180
                END AzElPatternDef
                ColorMethod		 1
                MinToMaxStartColor		 #ff0000
                MinToMaxStopColor		 #0000ff
                RelativeToMaximum		 0
            END VolumeSet
            BEGIN VolumeGraphics
                ShowContours		 No
                ShowVolume		 No
            END VolumeGraphics
        END 3dVolume

    END Extensions

    BEGIN SubObjects

        Class Sensor

            Servo		

        END Class

    END SubObjects

END Facility

