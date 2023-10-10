function [Dz] = AJG_C2D_matched(user_Ds, user_omegab)
    % function [] = AJG_C2D_matched(omega, Ds)
    % Convert D(s) to D(z)
    % INPUTS omega bar (freq of interest), D(s)
    % OUTPUTS D(z)

    %assume intial conditions

    syms z p
    Ds = RR_tf([ 1 z], [1 p 0])
    h = 1
    omegab = 1

        switch nargin
            case 1 %Only Ds is user defined
                Ds = user_Ds

            case 2 %User defined Ds and OmegaBar

                Ds = user_Ds
                omegab = user_omegab
        end

    z = Ds.z
    p = Ds.p 
    %map from s to z using z = exp(s*h)
    p_z = exp(p * h)
    z_z = exp(z * h)
    % if there is an infintie zero -> z = -1 
    z_z(z_z == 0) = -1 %make all of the infinte zeros z = -1
    % if strickly casual make an infinte zero z = inf

    %build the gain
    f=2*(1-cos(omegab*h))/(omegab*h*sin(omegab*h))
    c=2/(f*h)
    
    %Pack together - reform the transform fn
    Dz = RR_tf(z_z, p_z, 1)
end

%THings to add
% User defined casualty - If stricly casual then one infinite zero becomes inf
% user defined omega
% user defined Ds
% add the gain --- gain of z matches gain of s at an omegabar
