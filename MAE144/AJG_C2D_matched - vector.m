function [Dz] = AJG_C2D_matched(user_Ds, args)
    % function [] = AJG_C2D_matched(omega, Ds)
    % Convert D(s) to D(z)
    % INPUTS omega bar (freq of interest), D(s), "semi-casual" or "strictly-casual"
    % OUTPUTS D(z)
    % TESTS if left uninitiated, the program will run the test for:
    % when Ds = (s + z)/(s*(s+p))
    % omega = 0
    % casual = semi-casual
    
    syms z p

    Ds = input("Enter a Ds to convert to Dz using RR_tf[] format(test case is D(s) = (s + z)/(s*(s+p))): ")
    if isempty(Ds)
        Ds = RR_tf([ 1 z], [1 p 0]);
    end

    casual = input("Enter 'strictly' casual or 'semi' casual(test case is 'semi'): ", 's')
    if isempty(casual)
        casual = "semi";
    end

    omega = input("Enter a desired frequency of interest(test case is omega = 0):")
    if isempty(omega)
        omega = 0;
    end
        
    h = 1;
    %pull zeros poles and gain from s
    z_s = Ds.z;
    p_s = Ds.p ;
    K_s = Ds.K;

    %map from s to z using z = exp(s*h)
    p_z = exp(p_s * h);
    z_z = exp(z_s * h);

    % if there is an infinte zero -> z = -1 
    z_z(z_z == 0) = -1; %make all of the infinte zeros z = -1

    % if strickly casual make an infinte zero z = inf
    if (casual == strictly-casual) 
        z_z(z_z == 0, 1) = inf; 
    end

    %build the gain
    %not needed -> f=2*(1-cos(omegab*h))/(omegab*h*sin(omegab*h));
    %not needed -> c=2/(f*h);

    K_z = K_s;
    
    %Pack together - reform the transform fn
    Dz = RR_tf(z_z, p_z, K_z);
end

%THings to add
% User defined casualty - If stricly casual then one infinite zero becomes inf
% user defined omega
% user defined Ds
% If we want ds at a frequency it changes our gain
