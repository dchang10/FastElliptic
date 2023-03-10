module FastElliptic

export E, F, K

const HALF_PI = π/2
const ONE_DIV_PI = 0.3183098861837907

############################################################################
# Complete Elliptic Integrals (https://doi.org/10.1007/s10569-009-9228-z)
############################################################################

function K( m ) 
    if m < 1.
        poly1(x)  = 1.5910034537907922 + (x * (0.41600074399178694 + (x * (0.24579151426410342 + (x * (0.17948148291490615 + (x * (0.14455605708755515 + (x * (0.12320099331242772 + (x * (0.10893881157429353 + (x * (0.09885340987159291 + (x * (0.09143962920174975 + (x * (0.0858425915954139 + (x * 0.08154111871830322)))))))))))))))))))
        poly2(x)  = 1.63525673226458 + (x * (0.4711906261487323 + (x * (0.3097284108314996 + (x * (0.2522083117731357 + (x * (0.22672562321968465 + (x * (0.21577444672958598 + (x * (0.21310877187734892 + (x * (0.21602912460518828 + (x * (0.2232558316330579 + (x * (0.23418050129420992 + (x * (0.24855768297226408 + (x * 0.26636380989261754)))))))))))))))))))))
        poly3(x)  = 1.685750354812596 + (x * (0.5417318486132803 + (x * (0.40152443839069024 + (x * (0.3696424734208891 + (x * (0.37606071535458363 + (x * (0.4052358870851259 + (x * (0.45329438175399905 + (x * (0.5205189476511842 + (x * (0.609426039204995 + (x * (0.7242635222829089 + (x * (0.8710138477098124 + (x * 1.057652872753547)))))))))))))))))))))
        poly4(x)  = 1.7443505972256133 + (x * (0.6348642753719353 + (x * (0.5398425641644455 + (x * (0.5718927051937874 + (x * (0.6702951362654062 + (x * (0.8325865900109772 + (x * (1.0738574482479333 + (x * (1.4220914606754977 + (x * (1.9203871834023047 + (x * (2.6325525483316543 + (x * (3.6521097473190394 + (x * (5.115867135558866 + (x * 7.224080007363877)))))))))))))))))))))))
        poly5(x)  = 1.8138839368169826 + (x * (0.7631632457005573 + (x * (0.7619286053215958 + (x * (0.9510746536684279 + (x * (1.315180671703161 + (x * (1.9285606934774109 + (x * (2.9375093425313787 + (x * (4.594894405442878 + (x * (7.33007122188172 + (x * (11.871512597425301 + (x * (19.45851374822938 + (x * (32.20638657246427 + (x * (53.73749198700555 + (x * 90.27388602941)))))))))))))))))))))))))
        poly6(x)  = 1.8989249102715535 + (x * (0.9505217946182445 + (x * (1.1510775899590158 + (x * (1.7502391069863006 + (x * (2.952676812636875 + (x * (5.285800396121451 + (x * (9.83248571665998 + (x * (18.787148683275596 + (x * (36.61468615273698 + (x * (72.45292395127771 + (x * (145.1079577347069 + (x * (293.4786396308497 + (x * (598.385181505501 + (x * (1228.4200130758634 + (x * 2536.5297553827645)))))))))))))))))))))))))))
        poly7(x)  = 2.0075983984243764 + (x * (1.2484572312123474 + (x * (1.9262346570764797 + (x * (3.7512896400875877 + (x * (8.119944554932045 + (x * (18.665721308735552 + (x * (44.603924842914374 + (x * (109.50920543094983 + (x * (274.2779548232414 + (x * (697.5598008606327 + (x * (1795.7160145002472 + (x * (4668.38171679039 + (x * (12235.762468136643 + (x * (32290.17809718321 + (x * (85713.07608195965 + (x * (228672.1890493117 + (x * 612757.2711915852)))))))))))))))))))))))))))))))
        poly8(x)  = 2.1565156474996434 + (x * (1.7918056418494632 + (x * (3.8267512874657132 + (x * (10.386724683637972 + (x * (31.403314054680703 + (x * (100.92370394986955 + (x * (337.3268282632273 + (x * (1158.7079305678278 + (x * (4060.9907421936323 + (x * (14454.001840343448 + (x * (52076.661075994045 + (x * (189493.65914621568 + (x * (695184.5762413896 + (x * (2567994.048255285 + (x * (9541921.966748387 + (x * (35634927.44218076 + (x * (133669298.46120408 + (x * (503352186.68662846 + (x * (1901975729.53866 + (x * 7208915015.330104)))))))))))))))))))))))))))))))))))))
        poly9(x)  = 2.3181226217125106 + (x * (2.6169201502912327 + (x * (7.897935075731356 + (x * (30.502397154466724 + (x * (131.48693655235286 + (x * (602.9847637356492 + (x * (2877.024617809973 + (x * (14110.519919151804 + (x * (70621.4408815654 + (x * (358977.266582531 + (x * (1847238.2637239718 + (x * (9600515.416049214 + (x * (50307677.08502367 + (x * (265444188.6527128 + (x * (1408862325.0287027 + (x * 7515687935.373775)))))))))))))))))))))))))))))
        poly10(x) = 2.473596173751344 + (x * (3.727624244118099 + (x * (15.607393035549306 + (x * (84.12850842805888 + (x * (506.98181970406137 + (x * (3252.2770581451236 + (x * (21713.242419574344 + (x * (149037.04518909327 + (x * (1043999.3310899908 + (x * (7427974.817042039 + (x * (53503839.67558661 + (x * (389249886.99487084 + (x * (2855288351.1008105 + (x * (21090077038.76684 + (x * (156699833947.7902 + (x * (1170222242422.44 + (x * (8777948323668.9375 + (x * (66101242752484.95 + (x * (499488053713388.8 + (x * 37859743397240296.0)))))))))))))))))))))))))))))))))))))
        poly11(x) = (x * (0.0625 + (x * (0.03125 + (x * (0.0205078125 + (x * (0.01513671875 + (x * (0.011934280395507812 + (x * (0.009816169738769531 + (x * (0.008315593004226685 + (x * (0.007199153304100037 + (x * (0.00633745662344154 + (x * (0.00565311038371874 + (x * (0.005097046040418718 + (x * (0.004636680381850056 + (x * (0.004249547423822886 + (x * 0.003919665602267974)))))))))))))))))))))))))))
        poly12(x) = 1.5910034537907922 + (x * (0.41600074399178694 + (x * (0.24579151426410342 + (x * (0.17948148291490615 + (x * (0.14455605708755515 + (x * (0.12320099331242772 + (x * (0.10893881157429353 + (x * (0.09885340987159291 + (x * (0.09143962920174975 + (x * (0.0858425915954139 + (x * 0.08154111871830322)))))))))))))))))))


        flag = false
        kdm = 0.0
        td = 0.0
        qd = 0.0
        t = 0.0

        x = m
        if m < 0.0
            x = m / ( m - 1.0 );
            flag = true;
        end
        x == 0.0 && return HALF_PI
        x == 1.0 && return Inf
        x > 1.0 && return NaN
        
        if x < 0.1 
            t = poly1( x - 0.05 );
        elseif ( x < 0.2 ) 
            t = poly2( x - 0.15 );
        elseif ( x < 0.3 ) 
            t = poly3( x - 0.25 );
        elseif ( x < 0.4 ) 
            t = poly4( x - 0.35 );
        elseif ( x < 0.5 ) 
            t = poly5( x - 0.45 );
        elseif ( x < 0.6 ) 
            t = poly6( x - 0.55 );
        elseif ( x < 0.7 ) 
            t = poly7( x - 0.65 );
        elseif ( x < 0.8 ) 
            t = poly8( x - 0.75 );
        elseif ( x < 0.85 ) 
            t = poly9( x - 0.825 );
        elseif ( x < 0.9 ) 
            t = poly10( x - 0.875 );
        else 
            td = 1.0 - x;
            qd = poly11( td );
            kdm = poly12( td - 0.05 );
            t = -log( qd ) * ( kdm * ONE_DIV_PI );
        end
        # Complete the transformation mentioned above for m < 0:
        flag && return t / sqrt( 1.0 - m );
        
        return t
    end
    m == 1. && return Inf
    return NaN
end

function E(m)
    m == 0. && return HALF_PI
    if m < 1.
        poly1(x) =  1.5509733517804722 + (x * (-0.4003010201031985 + (x * (-0.07849861944294194 + (x * (-0.034318853117591995 + (x * (-0.0197180433173655 + (x * (-0.01305950773199331 + (x * (-0.009442372874146548 + (x * (-0.007246728512402157 + (x * (-0.00580742401295609 + (x * -0.004809187786009338)))))))))))))))))
        poly2(x) =  1.5101218320928198 + (x * (-0.41711633390586755 + (x * (-0.09012382040477457 + (x * (-0.04372994401908431 + (x * (-0.027965493064761784 + (x * (-0.020644781177568104 + (x * (-0.016650786739707237 + (x * (-0.01426196082884252 + (x * (-0.012759847429264804 + (x * (-0.011799303775587354 + (x * -0.011197445703074968)))))))))))))))))))
        poly3(x) =  1.4674622093394272 + (x * (-0.43657629094633776 + (x * (-0.10515555766694255 + (x * (-0.05737184359324173 + (x * (-0.04139162772734022 + (x * (-0.03452772850528084 + (x * (-0.031495443512532785 + (x * (-0.030527000890325277 + (x * (-0.0309169840192389 + (x * (-0.03237139531475812 + (x * -0.03478996038640416)))))))))))))))))))
        poly4(x) =  1.4226911334908792 + (x * (-0.4595135196210487 + (x * (-0.12525053982206188 + (x * (-0.07813854509440948 + (x * (-0.06471427847205 + (x * (-0.06208433913173031 + (x * (-0.06519703281557247 + (x * (-0.07279389536257878 + (x * (-0.084959075171781 + (x * (-0.102539850131046 + (x * (-0.12705358515769605 + (x * -0.1607911206912746)))))))))))))))))))))
        poly5(x) =  1.3754019718711163 + (x * (-0.4872021832731848 + (x * (-0.15331170134854022 + (x * (-0.11184944491702783 + (x * (-0.10884095252313576 + (x * (-0.12295422312026907 + (x * (-0.15221716396203505 + (x * (-0.20049532364269734 + (x * (-0.27617433306775174 + (x * (-0.39351311430437586 + (x * (-0.5757544060278792 + (x * (-0.8605232357272398 + (x * -1.3088332057585401)))))))))))))))))))))))
        poly6(x) =  1.3250244979582302 + (x * (-0.5217276475575667 + (x * (-0.19490643048212622 + (x * (-0.17162372682201127 + (x * (-0.20275465292641914 + (x * (-0.27879895311853475 + (x * (-0.42069845728100574 + (x * (-0.675948400853106 + (x * (-1.1363431218392293 + (x * (-1.9767211439543984 + (x * (-3.5316967730957227 + (x * (-6.446753640156048 + (x * -11.97703130208884)))))))))))))))))))))))
        poly7(x) =  1.2707074796501499 + (x * (-0.5668391682878666 + (x * (-0.2621607934324926 + (x * (-0.2922441735330774 + (x * (-0.4403978408504232 + (x * (-0.7749476413813975 + (x * (-1.498870837987561 + (x * (-3.089708310445187 + (x * (-6.6675959033810015 + (x * (-14.89436036517319 + (x * (-34.18120574251449 + (x * (-80.15895841905397 + (x * (-191.34894807629848 + (x * (-463.5938853480342 + (x * -1137.38082216936)))))))))))))))))))))))))))
        poly8(x) =  1.2110560275684594 + (x * (-0.6303064132874558 + (x * (-0.38716640952066916 + (x * (-0.5922782353119346 + (x * (-1.23755558451305 + (x * (-3.0320566617452474 + (x * (-8.18168822157359 + (x * (-23.55507217389693 + (x * (-71.04099935893065 + (x * (-221.879685319235 + (x * (-712.1364793277636 + (x * (-2336.1253314403966 + (x * (-7801.945954775964 + (x * (-26448.19586059192 + (x * (-90799.48341621365 + (x * (-315126.04064491636 + (x * -1104011.3443115912)))))))))))))))))))))))))))))))
        poly9(x) =  1.1613071521962828 + (x * (-0.7011002845552895 + (x * (-0.5805514744654373 + (x * (-1.2436930610777865 + (x * (-3.679383613496635 + (x * (-12.815909243378957 + (x * (-49.25672530759985 + (x * (-202.18187354340904 + (x * (-869.8602699308701 + (x * (-3877.0058473132895 + (x * (-17761.7071017094 + (x * (-83182.69029154233 + (x * (-396650.4505013548 + (x * -1920033.4136826345)))))))))))))))))))))))))
        poly10(x) = 1.1246173251197522 + (x * (-0.7708450563609095 + (x * (-0.8447940536449113 + (x * (-2.4900973094503946 + (x * (-10.239717411543843 + (x * (-49.7490054655148 + (x * (-267.09866751957054 + (x * (-1532.66588382523 + (x * (-9222.313478526092 + (x * (-57502.51612140314 + (x * (-368596.11674161063 + (x * (-2415611.0887010912 + (x * (-16120097.815816568 + (x * (-109209938.52030899 + (x * (-749380758.1942496 + (x * (-5198725846.725541 + (x * -36409256888.1214)))))))))))))))))))))))))))))))
        poly11(x) = 1.5910034537907922 + (x * (0.41600074399178694 + (x * (0.24579151426410342 + (x * (0.17948148291490615 + (x * (0.14455605708755515 + (x * (0.12320099331242772 + (x * (0.10893881157429353 + (x * (0.09885340987159291 + (x * (0.09143962920174975 + (x * (0.0858425915954139 + (x * 0.08154111871830322)))))))))))))))))))
        poly12(x) = 1.5509733517804722 + (x * (-0.4003010201031985 + (x * (-0.07849861944294194 + (x * (-0.034318853117591995 + (x * (-0.0197180433173655 + (x * (-0.01305950773199331 + (x * (-0.009442372874146548 + (x * (-0.007246728512402157 + (x * (-0.00580742401295609 + (x * -0.004809187786009338)))))))))))))))))

        flag = false;
        kdm = 0;
        edm = 0;
        td = 0;
        km = 0;
        t = 0;
        x = 0;

        x = m;
        if  m < 0.0 
            x = m / ( m - 1.0 );
            flag = true;
        end
        x === 0.0 && return HALF_PI
        x === 1.0 && return 1.0
        x > 1.0 && return NaN

        if ( x < 0.1 ) 
            t = poly1( x - 0.05 );
        elseif ( x < 0.2 ) 
            t = poly2( x - 0.15 );
        elseif ( x < 0.3 ) 
            t = poly3( x - 0.25 );
        elseif ( x < 0.4 ) 
            t = poly4( x - 0.35 );
        elseif ( x < 0.5 ) 
            t = poly5( x - 0.45 );
        elseif ( x < 0.6 ) 
            t = poly6( x - 0.55 );
        elseif ( x < 0.7 ) 
            t = poly7( x - 0.65 );
        elseif ( x < 0.8 ) 
            t = poly8( x - 0.75 );
        elseif ( x < 0.85 ) 
            t = poly9( x - 0.825 );
        elseif ( x < 0.9 ) 
            t = poly10( x - 0.875 );
        else 
            td = 0.95 - x;
            kdm = poly11(td);
            edm = poly12(td);
            km = K( x );

            #// To avoid precision loss near 1, we use Eq. 33 from Fukushima (2009):
            t = ( HALF_PI + ( km * (kdm - edm) ) ) / kdm;
        end

        #// Complete the transformation mentioned above for m < 0:
        flag && return t * sqrt( 1.0 - m );

        return t;
    end
    m == 1. && return 1
    return NaN
end

############################################################################
# First Incomplete Elliptic Integral and Inverse Jacobi Functions 
# (https://doi.org/10.1007/s00211-010-0321-8)
############################################################################
function serf(y, m)
    return 1. + y*(0.166667 + 0.166667*m + 
    y*(0.075 + (0.05 + 0.075*m)*m + 
       y*(0.0446429 + m*(0.0267857 + (0.0267857 + 0.0446429*m)*m) + 
          y*(0.0303819 + 
             m*(0.0173611 + 
                m*(0.015625 + (0.0173611 + 0.0303819*m)*m)) + 
             y*(0.0223722 + 
                m*(0.012429 + 
                   m*(0.0106534 + 
                    m*(0.0106534 + (0.012429 + 0.0223722*m)*m))) + 
                y*(0.0173528 + 
                   m*(0.00946514 + 
                    m*(0.00788762 + 
                    m*(0.00751202 + 
                    m*(0.00788762 + (0.00946514 + 0.0173528*m)*m)))) +
                    y*(0.0139648 + 
                    m*(0.00751953 + 
                    m*(0.00615234 + 
                    m*(0.00569661 + 
                    m*(0.00569661 + 
                    m*(0.00615234 + (0.00751953 + 
                    0.0139648*m)*m))))) + 
                    y*(0.0115518 + 
                    m*(0.00616096 + 
                    m*(0.00497616 + 
                    m*(0.00452378 + 
                    m*(0.00439812 + m*(0.00452378 + 
                    m*(0.00497616 + (0.00616096 + 
                    0.0115518*m)*m)))))) + (0.00976161 + 
                    m*(0.00516791 + 
                    m*(0.00413433 + 
                    m*(0.0037103 + m*(0.00354165 + 
                    m*(0.00354165 + m*(0.0037103 + 
                    m*(0.00413433 + (0.00516791 + 
                    0.00976161*m)*m))))))))*y))))))))
    #return 1 + y*(1/6 + m/6 + 
    #    y*(3/40 + (1/20 + (3*m)/40)*m + 
    #    y*(5/112 + m*(3/112 + (3/112 + (5*m)/112)*m) + 
    #        y*(35/1152 + 
    #            m*(5/288 + m*(1/64 + (5/288 + (35*m)/1152)*m)) + 
    #            y*(63/2816 + 
    #                m*(35/2816 + 
    #                m*(15/1408 + 
    #                    m*(15/1408 + (35/2816 + (63*m)/2816)*m))) + 
    #                y*(231/13312 + 
    #                m*(63/6656 + 
    #                    m*(105/13312 + 
    #                    m*(25/3328 + 
    #                    m*(105/13312 + (63/6656 + (231*m)/13312)*m)))) + 
    #                y*(143/10240 + 
    #                    m*(77/10240 + 
    #                    m*(63/10240 + 
    #                    m*(35/6144 + 
    #                    m*(35/6144 + m*(63/
    #                    10240 + (77/10240 + (143*m)/10240)*m))))) + 
    #                    y*(6435/557056 + 
    #                    m*(429/69632 + 
    #                    m*(693/139264 + 
    #                    m*(315/69632 + 
    #                    m*(1225/278528 + m*(315/69632 + 
    #                    m*(693/139264 + (429/69632 + (6435*m)/
    #                    557056)*m)))))) + (12155/1245184 + 
    #                    m*(6435/1245184 + 
    #                    m*(1287/311296 + 
    #                    m*(1155/311296 + m*(2205/622592 + 
    #                    m*(2205/622592 + m*(1155/311296 + 
    #                    m*(1287/311296 + (6435/1245184 + (12155*m)/
    #                    1245184)*m))))))))*y))))))))
 
end

function asn(s, m)
    yA = 0.04094 - 0.00652*m
    y = s * s
    if y < yA
        return s*serf(y, m)
    end
    p = 1
    for _ in 1:10
        y = y / ((1+√(1-y))*(1+√(1-m*y)))
        p *= 2
        y < yA && return p*√y*serf(y, m)
    end
end

function acn(c, mc)
    m = one(1) - mc
    x = c^2
    p = one(c)
    for _ in 1:10
        if (x > 0.5) 
            return p*asn(√(1-x), m)
        end
        d = √(mc + m * x)
        x = (√x + d)/(1+d)
        p *= 2
    end
end

function _rawF(φ, m)
    m == 0.0 && return φ
    sinφ = sin(φ)
    m == 1.0 && return atanh(sinφ)
    signφ = sign(φ)
    φ = abs(φ)
    
    sinφ^2 ≤ 0.9 && return signφ*asn(sinφ, m)

    mc = 1 - m

    c = sin(HALF_PI-φ)
    z = c/√(mc+m*c^2)
    z^2 ≤ 0.9 && return signφ*(K(m) - asn(z, m))

    w = √(1-z^2)
    c > w && return signφ*acn(c, m)
    return signφ*(K(m) - acn(w, m))
end

function _F(φ, m)
    abs(φ) < HALF_PI && sign(φ)*return _rawF(abs(φ), m)
    j = round(φ/π)

    newφ = φ - j*π
    return 2*j*K(m) + sign(newφ)*_rawF(abs(newφ), m)
end

function F(φ, m)
    if m > 1.
        ## Abramowitz & Stegum (17.4.15)
        m12 = sqrt(m)
        theta = asin(m12*sin(φ))
        return 1/m12*_F(theta, 1/m)
        #return NaN
    elseif m < 0
        # Abramowitz & Stegum (17.4.17)
        n = -m
        m12 = 1/sqrt(1+n)
        m1m = n/(1+n)
        return (m12*K(m1m) - m12*_F(HALF_PI-φ, m1m)) 
    end
    return _F(φ, m)
end

#https://doi-org.ezp-prod1.hul.harvard.edu/10.031007/s10569-008-9177-y
#https://link.springer.com/article/10.1007/s10569-008-9177-y
#TODO: Implement Δsn algorithm for half angle transformation
const HALF_PI = 1.5707963267948966

_Kscreen(m) = HALF_PI*(1.0 + m*(0.25 + m*(0.36 + m*(0.09765625 + m*0.07476806640625))))

function _ΔSN(up, m, Kscreen, Kactual, kp)
    if up > 0.031
        u = up/2
        return 2/(1-m*_SN(u,m,Kscreen, Kactual, kp)^4)*(_CN(u,m,Kscreen,Kactual, kp)*_DN(u,m,Kscreen,Kactual, kp)*_ΔSN(u,m,Kscreen,Kactual, kp)+u*(_ΔCN(u,m,Kscreen,Kactual, kp)+_ΔDN(u,m,Kscreen,Kactual, kp)-_ΔCN(u,m,Kscreen,Kactual, kp)*_ΔDN(u,m,Kscreen,Kactual, kp)-m*_SN(u,m,Kscreen,Kactual, kp)^4))
    else
        return up - _SN(up, m, Kscreen, Kactual, kp)
    end
end
function _ΔCN(up, m, Kscreen, Kactual, kp)
    if up > 0.031
        u = up/2
        return ((1+_CN(u,m,Kscreen,Kactual, kp))*_ΔCN(u,m,Kscreen,Kactual, kp)+(1-2*m*_SN(u,m,Kscreen,Kactual, kp)^2)*_SN(u,m,Kscreen,Kactual, kp)^2)/(1-m*_SN(u,m,Kscreen,Kactual, kp)^4)
    else 
        return 1 - _CN(up, m, Kscreen, Kactual, kp)
    end
end
function _ΔDN(up, m, Kscreen, Kactual, kp) 
    if up > 0.031
        u = up/2 
        return ((1+_DN(u,m,Kscreen,Kactual, kp))*_ΔDN(u,m,Kscreen,Kactual, kp)+m*(1-2*_SN(u,m,Kscreen,Kactual, kp)^2)*_SN(u,m,Kscreen,Kactual, kp)^2)/(1-m*_SN(u,m,Kscreen,Kactual, kp)^4)
    else 
        return 1 - _CN(up, m, Kscreen, Kactual, kp)
    end
end

function _XNloop(u, m ,n)

    up = u / (2.0^n)
    sn = up*(up2*(up2*((m*((-(m/5040)-3/112)*m-3/112)-1/5040)*up2+(m/120+7/60)*m+1/120)-m/6-1/6)+1)
    cn = 1 + up2*(-(1/2)+up2*(1/24+m/6+up2*(-(1/720)+(-(11/180)-m/45)*m+(-(1/40320)+m*(-(17/1680)+(-(19/840)-m/630)*m))*up2)))
    dn = m*(m*(up^4*(1/24-(11*up2)/180)-(m*up^6)/720) + (up2*(1/6-up2/45)-1/2)*up2) + 1 

    for _ in 1:n
        sn2 = sn^2
        cn2 = cn^2
        dn2 = dn^2

        den = 1/(1.0-m*sn2^2)
        sn = 2.0*(sn*cn*dn)*den
        cn = (cn2-sn2*dn2)*den
        dn = (dn2-m*sn2*cn2)*den
    end
    return sn, cn, dn
end
function _ΔXNloop(u, m ,n)

    up = u / (2.0^n)
    up2 = up^2
    sn = up*(up2*(up2*((m*((-(m/5040)-3/112)*m-3/112)-1/5040)*up2+(m/120+7/60)*m+1/120)-m/6-1/6)+1)
    cn = 1 + up2*(-(1/2)+up2*(1/24+m/6+up2*(-(1/720)+(-(11/180)-m/45)*m+(-(1/40320)+m*(-(17/1680)+(-(19/840)-m/630)*m))*up2)))
    dn = m*(m*(up2^2*(1/24-(11*up2)/180)-(m*up2^3)/720) + (up2*(1/6-up2/45)-1/2)*up2) + 1 
    Δsn = up-sn
    Δcn = 1-cn
    Δdn = 1-dn


    for _ in 1:n
        sn2 = sn*sn
        sn4 = sn2*sn2
        
        den = 1/(1.0-m*sn4)
        Δsn = 2.0*(Δsn*cn*dn + up*(Δcn*(1 - Δdn) + Δdn  - m*sn4))*den
        Δcn = ((1+cn)*Δcn + sn2-2*m*sn4)*den
        Δdn = ((1+dn)*Δdn + m*(sn2-2*sn4))*den


        up *= 2
        sn = up - Δsn
        cn = 1 - Δcn
        dn = 1 - Δdn

    end
    return sn, cn, dn
end

function fold_0_25(u1, m, kp) 
    u1 == 0 && return 0, 1, 1
    sn, cn, dn = _ΔXNloop(u1, m, u1 > 0 ? max(6+Int(floor(log2(u1))), 1) : 0)
    den = 1/(1+kp-m*sn^2)
    return den*√(1+kp)*(cn*dn-kp*sn), den*√(kp*(1+kp))*(cn+sn*dn), den*√kp*((1+kp)*dn+m*sn*cn)
end

function fold_0_50(u1, m, Kscreen, Kactual, kp)
    u1 == 0 && return 0, 1, 1

    if u1 > 0.25Kscreen 
        sn, cn, dn = fold_0_25(Kactual/2 - u1, m, kp)
    else
        sn, cn, dn =  _ΔXNloop(u1, m, u1 > 0 ?  max(6+Int(floor(log2(u1))), 1) : 0)
    end
    return cn/dn, kp*sn/dn, kp/dn
end

function fold_1_00(u1, m, Kscreen, Kactual, kp)
    u1 == 0 && return 0, 1, 1

    if u1 > 0.5Kscreen
        sn, cn, dn = fold_0_50(Kactual - u1, m, Kscreen, Kactual, kp)
    elseif u1 > 0.25Kscreen 
        sn, cn, dn = fold_0_25(Kactual/2 - u1, m, kp)
    else
        #sn, cn, dn = _XNloop(u1, m, u1 > 0 ?  max(6+Int(floor(log2(u1))), 1) : 0)
        sn, cn, dn = _ΔXNloop(u1, m, u1 > 0 ?  max(6+Int(floor(log2(u1))), 1) : 0)
    end
    return cn/dn, -kp*sn/dn, kp/dn
end

funcs = ((:_SN, :_rawSN), (:_CN, :rawCN), (:_DN, :rawDN))
for (enum, funcpair) in enumerate(funcs)
    (func, helper) = funcpair
    @eval begin
        function $(helper)(u, m, Kscreen, Kactual, kp) 
            u = u > 4Kscreen ?  u % 4Kactual : u
            u = u > 2Kscreen ? u - 2Kactual : u
            u > Kscreen && return fold_1_00(u - Kactual, m, Kscreen, Kactual, kp)[$enum]
            u > 0.5Kscreen && return fold_0_50(Kactual - u, m, Kscreen, Kactual, kp)[$enum]
            u > 0.25Kscreen && return fold_0_25(Kactual/2 - u, m, kp)[$enum]
            return _ΔXNloop(u, m, u > 0 ? max(6+Int(floor(log2(u))), 1) : 0)[$enum]
        end

        $(func)(u, m) = $(helper)(u, m, K(m), K(m), √(1-m))
    end
end

function sn(u, m)  

    m < 1 && return _SN(u, m)
    sqrtm = √m
    return sn(u*sqrtm, 1/m)/sqrtm

end

_sc_helper(jacobituple) = jacobituple[1]/jacobituple[2]
function _rawSC(u, m, Kscreen, Kactual, kp) 
    u = u > 4Kscreen ?  u % 4Kactual : u
    u = u > 2Kscreen ? u - 2Kactual : u
    u > Kscreen && return _sc_helper(fold_1_00(u - Kactual, m, Kscreen, Kactual, kp))
    u > 0.5Kscreen && return _sc_helper(fold_0_50(Kactual - u, m, Kscreen, Kactual, kp))
    u > 0.25Kscreen && return _sc_helper(fold_0_25(Kactual/2 - u, m, kp))
    return _sc_helper(_ΔXNloop(u, m, u > 0 ? max(6+Int(floor(log2(u))), 1) : 0))
end
_SC(u, m) = _rawSC(u, m, K(m), K(m), √(1-m))

_sd_helper(jacobituple) = jacobituple[1]/jacobituple[3]
function _rawSD(u, m, Kscreen, Kactual, kp) 
    u = u > 4Kscreen ?  u % 4Kactual : u
    u = u > 2Kscreen ? u - 2Kactual : u
    u > Kscreen && return _sd_helper(fold_1_00(u - Kactual, m, Kscreen, Kactual, kp))
    u > 0.5Kscreen && return _sd_helper(fold_0_50(Kactual - u, m, Kscreen, Kactual, kp))
    u > 0.25Kscreen && return _sd_helper(fold_0_25(Kactual/2 - u, m, kp))
    return _sd_helper(_ΔXNloop(u, m, u > 0 ? max(6+Int(floor(log2(u))), 1) : 0))
end
_SD(u, m) = _rawSD(u, m, K(m), K(m), √(1-m))


function sn(u, m)  
    signu = sign(u)
    u = abs(u)
    m < 1 && return signu*_SN(u, m)
    sqrtm = √m
    return signu*_SN(u*sqrtm, 1/m)/sqrtm
end

function cn(u, m)  
    u = abs(u)
    m < 1 && return _CN(u, m)
    sqrtm = √m
    return _DN(u*sqrtm, 1/m)
end

function dn(u, m)  
    u = abs(u)
    m < 1 && return _DN(u, m)
    sqrtm = √m
    return _CN(u*sqrtm, 1/m)
end

function sc(u, m)
    signu = sign(u)
    u = abs(u)

    m < 1 && return signu*_SC(u, m)
    sqrtm = √m
    return signu*_SD(u*sqrtm, 1/m)/sqrtm

end

function sd(u, m)
    signu = sign(u)
    u = abs(u)

    m < 1 && return signu*_SD(u, m)
    sqrtm = √m
    return signu*_SC(u*sqrtm, 1/m)/sqrtm

end

end
