%Νάστος Βίκτωρ ΑΕΜ : 9297
%PERIEXEI TH LYSH TWN ERWTHMATWN 1.A KAI 1.B


x = imread('lena.bmp');
x = rgb2gray(x);
x = double(x) / 255 ;

[hn , hx ] = hist(x(:), 0:1/255:1);
figure 
bar(hx,hn)

%1a
y =  pointtransform(x,0.1961, 0.0392, 0.8039, 0.9608);
%[hn , hx ] = hist(x(:), 0:1/255:1);
%figure 
%bar(hx,hn)

%1b
y =  pointtransform(x,0.5, 0, 0.5, 1);
%[hn , hx ] = hist(x(:), 0:1/255:1);
%figure 
%bar(hx,hn)

function Y = pointtransform(X , x1 , y1 , x2 , y2  )
r = 0:1/100:1;
%In case of y1 is not equal to 0
if (y1 ~= 0)
    f = [((y1/x1)*(0:1/100:x1))   (((y2-y1)/(x2-x1))*((x1:1/100:x2) - x1) + y1)   (((1-y2)/(1-x2))*((x2:1/100:1) - x2) + y2)];
    figure
    subplot(131)
    imshow(X)
    title('Original image')
    subplot(132)
    plot(r , f)
    title('Diagram' );
    subplot(133)
    Y=f(floor(100*X)+1);
    imshow(Y)
    title('Contrast Stretching Image' );
%In case of y1 is equal to 0
else (y1 == 0) 
    M(r<=0.5) = 0;
    M(r>=0.5) = 1;
    figure
    subplot(131)
    imshow(X)
    title('Original Image')
    subplot(132)
    plot(r, M)
    title('Clipping Diagram')
    subplot(133)
    Y=M(floor(100*X)+1);
    imshow(Y)
    title('Clipping Image')
end
end