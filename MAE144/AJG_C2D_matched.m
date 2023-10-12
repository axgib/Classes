function [Dz] = AJG_C2D_matched(user_Ds, h, user_causal, omega)
    sympref('FloatingPointOutput', true);
    Ds = user_Ds;

    
    zeros_z = exp(h*Ds.z);
    poles_z = exp(h*Ds.p);

    m = Ds.num.n; %order of numer
    n = Ds.den.n; %order of denom

    %Determine number of infintie zeros
    if n - m > 0 
        zeros_z = [zeros_z, (zeros([1, n - m]) - 1)];
    end
    disp(zeros_z)
    %Determine amount of zeros by causalty
    if (user_causal == "strict" && n - m > 0)
        for i = 0: n - m - 1
            zeros_z(end - i) = []; %loops until there are enough z zeros removed such that the system is strictly proper
        end
    end
    
    %Determine Gain
    z = exp(omega*h);
    disp(z)
    disp("zeros")
    disp(zeros_z)
    disp("poles")
    disp(poles_z)
    disp("evaluate zeros poly")
    disp(RR_evaluate(RR_poly(zeros_z, 1), z))
    disp("make poles poly")
    disp(RR_poly(poles_z, 1))
    disp("evaluate poles poly at z")
    disp(RR_evaluate(RR_poly(poles_z, 1), z))
    disp("evaluate zero poly at z")
    disp(RR_evaluate(RR_tf(zeros_z, poles_z), z))
    disp(" zeros / poles")
    disp((RR_evaluate(RR_poly(zeros_z, 1), z)/ RR_evaluate(RR_poly(poles_z, 1), z)))
    disp("final")
    disp(Ds.K / (RR_evaluate(RR_poly(zeros_z, 1), z)/ RR_evaluate(RR_poly(poles_z, 1), z)));

    K_z = Ds.K / (RR_evaluate(RR_poly(zeros_z, 1), z)/ RR_evaluate(RR_poly(poles_z, 1), z));
    Dz = RR_tf(zeros_z, poles_z, K_z);
end

%THings to add
% User defined casualty - If stricly casual then one infinite zero becomes inf
% user defined omega
% user defined Ds
% If we want ds at a frequency it changes our gain
