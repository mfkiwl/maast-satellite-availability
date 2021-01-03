function svdata = L5_decodeMT39(time, msg, svdata)
%*************************************************************************
%*     Copyright c 2020 The board of trustees of the Leland Stanford     *
%*                      Junior University. All rights reserved.          *
%*     This script file may be distributed and used freely, provided     *
%*     this copyright notice is always kept with it.                     *
%*                                                                       *
%*     Questions and comments should be directed to Todd Walter at:      *
%*     twalter@stanford.edu                                              *
%*************************************************************************
%
% Decodes Message Type 39 
%   per ED-259A
%
% SEE ALSO: L1_decode_messages

%created 29 December, 2020 by Todd Walter

iodg  = bin2dec(msg(17:18)); % IODG
idx = iodg + 1;

svdata.mt39(idx).prn   = bin2dec(msg(11:16)) + 119; % PRN
svdata.mt39(idx).iodg  = iodg; % IODG
svdata.mt39(idx).spid  = bin2dec(msg(19:23)); % SPID

%Keplerian parameters part I
svdata.mt39(idx).cuc   = twos2dec(msg(24:42))*pi*(2^-19)*(1e-4); %C_UC
svdata.mt39(idx).cus   = twos2dec(msg(43:61))*pi*(2^-19)*(1e-4); %C_US
svdata.mt39(idx).idot  = twos2dec(msg(62:83))*7*pi*(2^-21)*(1e-6); %Rate of inclination angle
svdata.mt39(idx).omega = twos2dec(msg(84:117))*pi*(2^-33); %Argument of perigee
svdata.mt39(idx).lan   = twos2dec(msg(118:151))*pi*(2^-33); %Longitude of ascending node of orbital plane
svdata.mt39(idx).M0    = twos2dec(msg(152:185))*pi*(2^-33); %Mean anomaly at te

%Clock parameters
svdata.mt39(idx).agf0  = twos2dec(msg(186:210))*0.02; %Clock offset
svdata.mt39(idx).agf1  = twos2dec(msg(211:226))*4e-5; %Clock rate
svdata.mt39(idx).time  = time;