function [ GaborReal, GaborImg ] = MakeAllGaborKernal( GaborH, GaborW, Gabor_num,Kmax,f,sigma)
% GaborReal, [GaborH,GaborW,40] 40��Gaborģ��ʵ��
% GaborImg,  [GaborH,GaborW,40] 40��Gaborģ���鲿
% ȱʡ����ǰ2������,������� Kmax=2.5*pi/2, f=sqrt(2), sigma=1.5*pi;
% GaborH, GaborW, Gaborģ���С
% U,��������{0,1,2,3,4,5,6,7}
% V,��С����{0,1,2,3,4}
% Kmax,f,sigma ��������

    
GaborReal = zeros( GaborH, GaborW, 40 );    %?????40?
GaborImg = zeros( GaborH, GaborW, 40 );
    
vnum=5;
unum=8;

if Gabor_num~=vnum*unum
    error('The Gabor num is 5 scales and 8 orientations!');
end
        
for v = 0 : (vnum-1)
    for u = 0 : (unum-1)
        [ GaborReal(:,:,v*8+u+1), GaborImg(:,:,v*8+u+1) ] = MakeGaborKernal( GaborH, GaborW, u, v, Kmax,f,sigma );
    end
end


