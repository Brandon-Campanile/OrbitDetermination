stk.v.11.0
WrittenBy    STK_v11.6.1

BEGIN Facility

    Name		 DSS_45_Tidbinbilla_STDN_DS45

    BEGIN CentroidPosition

        CentralBody		 Earth
        DisplayCoords		 Geodetic
        EcfLatitude		 -3.5398457690000001e+01
        EcfLongitude		  1.4897768564000000e+02
        EcfAltitude		  6.7434699999999998e+02
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
DSS 45 Tidbinbilla STDN DS45
Name:           DSS 45 Tidbinbilla STDN DS45
Country:        Australia
Location:       Tidbinbilla
Status:         Active
Type:           GroundStation
Notes:          NASA# 1549, ESN# 45 || Equipment: DSN 34m HEF   || Remarks: 10-89 JPL. Update 11/2007.
Sources:                       NASA Directory of Station Locations Jan 27 2010
               http://deepspace.jpl.nasa.gov/dsndocs/810-005/301/301F.pdf
               http://www.cdscc.nasa.gov
               http://sunset.usc.edu/gsaw/gsaw2005/s9a/tai.pdf
Last updated:   2009-12-14Antennas:       
  Type    :ParabolicReflector
  Diameter: 34 [Meters]
  Notes   : 34m High Efficiency (HEF). Uplink (X), Downlink (S, X).
            END ShortText
            BEGIN LongText
Name:           DSS 45 Tidbinbilla STDN DS45
Country:        Australia
Location:       Tidbinbilla
Status:         Active
Type:           GroundStation
Notes:          NASA# 1549, ESN# 45 || Equipment: DSN 34m HEF   || Remarks: 10-89 JPL. Update 11/2007.
Sources:                       NASA Directory of Station Locations Jan 27 2010
               http://deepspace.jpl.nasa.gov/dsndocs/810-005/301/301F.pdf
               http://www.cdscc.nasa.gov
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
                MinDisplayAlt		 674.347
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

