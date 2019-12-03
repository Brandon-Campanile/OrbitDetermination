stk.v.11.0
WrittenBy    STK_v11.6.1

BEGIN Planet

    Name		 Venus

    BEGIN PathDescription

        CentralBody		 Venus
        UseCbEphemeris		 Yes

        BEGIN EphemerisData

            EphemerisSource		 JplDE

            JplIndex		 1

            JplSpiceId		 299

            ApplyTDTtoTDBCorrectionForDE		 Yes

            OrbitEpoch		  2.4515450000000000e+06
            OrbitMeanDist		  1.0820892500686139e+11
            OrbitEcc		  6.7732300000000727e-03
            OrbitInc		  2.4432965702584330e+01
            OrbitRAAN		  8.0077488975263957e+00
            OrbitPerLong		  1.3221942759356705e+02
            OrbitMeanLong		  1.8266617759356515e+02
            OrbitMeanDistDot		  3.7681051444216291e+00
            OrbitEccDot		 -1.3519507186858317e-09
            OrbitIncDot		  4.1244766351326264e-07
            OrbitRAANDot		 -4.3180134699938781e-07
            OrbitPerLongDot		 -8.5280571764937982e-07
            OrbitMeanLongDot		  1.6021304488902290e+00

        END EphemerisData

    END PathDescription

    BEGIN PhysicalData

        GM		  3.2485859207900000e+14
        Radius		  6.0518000000000000e+06
        Magnitude		  0.0000000000000000e+00
        ReferenceDistance		  0.0000000000000000e+00

    END PhysicalData

    BEGIN AutoRename

        AutoRename		 Yes

    END AutoRename

    BEGIN Extensions

        BEGIN ExternData
        END ExternData

        BEGIN ADFFileData
        END ADFFileData

        BEGIN AccessConstraints
            LineOfSight IncludeIntervals
        END AccessConstraints

        BEGIN Desc
        END Desc

        BEGIN Crdn
        END Crdn

        BEGIN Graphics

            BEGIN Attributes

                MarkerColor		 #ff00ff
                LabelColor		 #ff00ff
                LineColor		 #ff00ff
                LineStyle		 0
                LineWidth		 1
                MarkerStyle		 2
                FontStyle		 0

            END Attributes

            BEGIN Graphics

                Show		 On
                Inherit		 On
                ShowLabel		 On
                ShowPlanetPoint		 On
                ShowSubPlanetPoint		 Off
                ShowSubPlanetLabel		 Off
                ShowOrbit		 On
                NumOrbitPoints		 360
                OrbitTime		  3.1569001211680312e+07
                OrbitDisplay		                OneOrbit		
                TransformTrajectory		 On

            END Graphics
        END Graphics

        BEGIN VO
        END VO

    END Extensions

END Planet

