%Νάστος Βίκτωρ ΑΕΜ : 9297
%PERIEXEI TH LYSH TOY ERWTHMATOS 2.1

x = imread('lena.bmp');
x = rgb2gray(x);
x = double(x) / 255 ;

% Case 1
L = 10;
v = linspace(0, 1, L);
h = ones([1, L]) / L;
histtransform(x, h, v);
% Case 2
L = 20;
v = linspace(0, 1, L);
h = ones([1, L]) / L;
histtransform(x, h, v);
% Case 3
L = 10;
v = linspace(0, 1, L);
h = normpdf(v, 0.5) / sum(normpdf(v, 0.5));
histtransform(x, h, v);

function Y = histtransform(X, h, v)

[L,R]=size(X);
totalPixels= size(X,2)^2;

V=X(:); %2D at (256*256)x1
V=V';   %(256*256)x1 at 1x(256*256)
[B,I]=sort(V); %taksinomei ton V kai krataei thn thesi twn shmeiwn tou arxikou pinaka

totalNumv=0; %number of pixels of v(value)
index=1;     %elements of 1D new array

for value = 1 : length(v)
        while((totalNumv / totalPixels) < h(value))
            if(index<=totalPixels)
                B(index) = v(value);
                totalNumv = totalNumv + 1;
                index = index + 1;
            else
                totalNumv = totalNumv + 1;
            end
        end
       totalNumv=0;
end
final(I) = B; %epistrefei ta pixels sthn arxikh thesi tou pinaka
finalImage = reshape(final,[L,R]); %1D at 2D
Y=finalImage;
[hn , hx ] = hist(Y(:), 0:1/255:1);
figure
subplot(122) 
bar(hx,hn/totalPixels)
subplot(121)
imshow(Y);
end