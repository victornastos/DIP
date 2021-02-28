%Νάστος Βίκτωρ ΑΕΜ : 9297
%PERIEXEI TH LYSH TWN ERWTHMATWN 2.2 KAI 2.3

x = imread('lena.bmp');
x = rgb2gray(x);
x = double(x) / 255 ;

n=100;

%Uniform at (0,1)
%d einai to diastima, xwrismeno se n isa kommatia
d = linspace(0, 1, n);
f1 = pdf2hist(d, @(x)unifpdf(x, 0, 1)); 
v=[];
%v einai to meso tou diastimatos
for i = 1 : size(d,2) - 1
    v(i) = [(d(i) + d(i+1))/2];
end
histtransform(x, f1, v);

%Uniform at (0,2)
d = linspace(0, 2, n);
f2 = pdf2hist(d, @(x)unifpdf(x, 0, 2));
v=[];
for i = 1 : size(d,2) - 1
    v(i) = [(d(i) + d(i+1))/4];
end
histtransform(x, f2, v);

%Normal mu = 0.5   s = 0.1
d = linspace(0, 1, n);
f3 = pdf2hist(d, @(x)normpdf(x, 0.5, 0.1));
v=[];
for i = 1 : size(d,2) - 1
    v(i) = [(d(i) + d(i+1))/2];
end
histtransform(x, f3, v); 

function h = pdf2hist(d, f)

result = 0;
h=[];
%ypologizw to aristero athroisma Riemann
for i = 1 : size(d,2) - 1
    dx = d(i+1)-d(i)/size(d(i),2);
    x = linspace(d(i), d(i+1), size(d(i),2)+1);
    for j = 1 : size(d(i),2)
        result = result + feval(f,x(j))*dx;
    end
    h(i)=result;
    result = 0;    
end

end


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
%subplot(221)
%imshow(X)
%title('Original Image')
subplot(121)
imshow(Y);
title('Final Image')
subplot(122)
bar(hx,hn / totalPixels)
title('Histogram')


end