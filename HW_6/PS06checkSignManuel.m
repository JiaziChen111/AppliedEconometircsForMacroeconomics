function [ res ] = PS06checkSignManuel(R, IRF)
%   Get the size of the Sign Restriction matrix, m is the number of
%   variables in the model
    [m_R, n_R] = size(R);
%   Get the maximum period restriction. Max number of second column in R    
    max_period = max(max(R,[],2));
%   Get dimension of the IRF Matrix
    [m_IRF, n_IRF] = size(IRF);
%   Build 3D - matrix for the sign restrictions. Third dimension is the
%   time dimension vector of all variables
    end_period = R(:,2);
%   sign restriction vector of all variables
    signs = R(:,3);
%   Matrix of sign restrictions for all variables over all periods    
    sign_restriction = zeros(m_R,m_R,max_period);
%   Iterate over the R matrix over max period lengths
%   check if the end period of a variable is > than the actual period and
%   set the sign to the matrix
    for ii = 1:max_period
        for jj = 1:m_R
            if end_period(jj)>=ii
                sign_restriction(:,jj,ii) = signs(jj);
            else
                sign_restriction(:,jj,ii) = 0;
            end
        end
    end    
%   Check first point: Check if the two inputs match. If the dimension does not fit 
%   the identifier is set to 0. 
    if (n_IRF == m_R) && (m_IRF>=max_period)
        identifier = 1;
    else 
        identifier = 0;
    end
%   Check second point: Check if the sign restrictions are satisfied over
%   the specified period.
%   Iterate over all specified restriction periods and as long as the
%   identifier is 1 (no mismatch is found)
    ii = 1;
    while (identifier == 1) && (ii<=max_period)
        %   Iterate over the sign_restriction  matrix
        for jj = 1:m_R
            %   get sign restriction of variable
            element = sign_restriction(:,jj,ii);
            %   if the sign restriction is 1 and IRF for the variable at
            %   period t is >0 the identifier stays 1, otherwise 0
            if element(1) == 1
                if IRF(ii,jj)>0
                    identifier = 1;
                else
                    identifier = 0;
                    % go out of for loop and because of identifier is 0 go
                    % out of while loop and terminate script
                    break;
                end
            %   if the sign restriction is 1 and IRF for the variable at
            %   period t is <0, the identifier stays 1, otherwise 0 
            elseif element(1) == -1
                if IRF(ii,jj)<0
                    identifier = 1;
                else
                    identifier = 0;
                    break;
                end
            %   if sign restriction is not 1 nor -1 then there is no restriction (0 restriction in R)
            %   identifier is 1 because every number is valid in IRF 
            else
                identifier = 1;
            end
        end
        %Increase counter for while loop
        ii = ii+1;
    end
    res.identifier = identifier;
end

