function flag = isValidA(A,k)
global con
a = [57, 71, 87, 97, 99, 101, 103, 113, 114, 115, 128, 129, 131, 137, 147, 156, 163, 186];

flag = 1;
if k == con
    if dot(A,a) ~= 1000
        flag = 0;
    end
else
    if dot(A,a) > 1000
        flag = 0;
    end
end
end