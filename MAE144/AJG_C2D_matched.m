function [Dz] = AJG_C2D_matched(user_Ds, h, user_causal, omega)
    %function: AJG_C2D_matched(Ds, h, causal, omega)
    %INPUTS: Ds is the transfer function that needs to be converted from the s domain to the z domain
    % h = the time step
    % causal = Either "semi" or "strict" - if the user defines "strict" causal then ensure that the order of the numerator is 1 less than the order of the denominator
    % omega = the frequency of interest
    %OUTPUTS: Dz is the transfer function that Ds maps to in the z domain - it will be in RR_tf format
    %TEST CASE: The test case is written in AJG_C2D_matched_test
    %Through editing this test case we can run the program with the intial condition defined in the assignment

    sympref('FloatingPointOutput', true); % Set the solve to bring the numbers to a reasonable decimal
    Ds = user_Ds;

    %convert the zeros and the poles of Ds to Dz through z = e^(s*h)
    zeros_z = exp(h*Ds.z);
    poles_z = exp(h*Ds.p);

    m = Ds.num.n; %order of numer
    n = Ds.den.n; %order of denom

    %Determine number of infinity zeros, bring in zeros at z = -1 t
    if n - m > 0 
        zeros_z = [zeros_z, (zeros([1, n - m]) - 1)];
    end
    
    %Determine amount of zeros by causalty
    if (user_causal == "strict" && n - m > 0) %If the system is required to be strictly causal then make the order or the numerator one less than the order of the denom
        for i = 0: n - m - 1
            zeros_z(end - i) = []; %loops until there are enough z zeros removed such that the system is strictly causal
        end
    end
    
    %Determine Gain
    %Solve for the gain of Dz by plugging in z = e^(omega*h) and equating it to the Ds gain at s = i*omega
    z = exp(omega*h);
    Ds_omega = RR_evaluate(Ds, omega);
    K_z = Ds_omega / (RR_evaluate(RR_poly(zeros_z, 1), z)/ RR_evaluate(RR_poly(poles_z, 1), z));

    %Build Dz
    Dz = RR_tf(zeros_z, poles_z, K_z);
end

%Did I set the system to right right gain?  maybe the gain changes when omega isnt 0