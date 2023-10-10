function [] = AJG_C2D_matched(Ds, omegab)
% function [] = AJG_C2D_matched(omega, Ds)
% Convert D(s) to D(z)
% INPUTS omega bar (freq of interest), D(s)
% OUTPUTS D(z)


    switch nargin
        case 0
            syms z p
            Ds = RR_tf([ 1 z], [1 p 0])
            h = 1
            z = Ds.z
            p = Ds.p 

            p_z = exp(p * h)
            z_z = exp(z * h)
        Dz = RR_tf(z_z, p_z, 1)
end