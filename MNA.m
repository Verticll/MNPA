G1 = 1;
G2 = 0.5;
G3 = 0.10;
G4 = 10;
Go = 1/1000;
L = 0.2;
C = 0.25;
alpha = 100;
ndev = 10;

G = zeros(8,8);
V = zeros(8,1);

%for Vin = 1:1:10
Vin = 5;

Devices = [struct('type','R', 'pos', 1, 'neg', 2, 'a', G1,'b',6,'c',8),...
           struct('type','R', 'pos', 2, 'neg', 0, 'a', G2,'b',6,'c',8),...
           struct('type','R2', 'pos', 3, 'neg', 0, 'a', G3,'b',6,'c',8),...
           struct('type','R', 'pos', 4, 'neg', 5, 'a', G4,'b',6,'c',8),...
           struct('type','R', 'pos', 5, 'neg', 0, 'a', Go,'b',6,'c',8),...
           struct('type','V', 'pos', 1, 'neg', 0, 'a', Vin,'b',7,'c',8),...
           struct('type','CV', 'pos', 4, 'neg', 0, 'a', alpha,'b',6,'c',8)
           ];

sizeD = size(Devices);
for i = 1:sizeD(1,2)
    device = Devices(i);
    switch device.type
        case 'R'
            if device.pos == 0
                G(device.neg,device.neg) = G(device.neg,device.neg) + device.a;
            elseif device.neg == 0
                G(device.pos,device.pos) = G(device.pos,device.pos) + device.a;
            else
            G(device.pos,device.pos) = G(device.pos,device.pos) + device.a;
            G(device.pos,device.neg) = G(device.pos,device.neg) - device.a;
            G(device.neg,device.pos) = G(device.neg,device.pos) - device.a;
            G(device.neg,device.neg) = G(device.neg,device.neg) + device.a;
            end
        case 'R2'
            if device.pos == 0
                G(device.neg,device.b) = G(device.neg,device.b) - 1;
                G(device.b,device.neg) = G(device.b,device.neg) - 1;
            elseif device.neg == 0
                G(device.pos,device.b) = G(device.pos,device.b) + 1;
                G(device.b,device.pos) = G(device.b,device.pos) + 1;
            else
            G(device.pos,device.b) = G(device.pos,device.b) + 1;
            G(device.neg,device.b) = G(device.neg,device.b) - 1;
            G(device.b,device.pos) = G(device.b,device.pos) + 1;
            G(device.b,device.neg) = G(device.b,device.neg) - 1;
            end
            G(device.b,device.b) = G(device.b,device.b) + (device.a^-1);
        case 'V'
            if device.pos == 0
                G(device.neg,device.b) = G(device.neg,device.b) - 1;
                G(device.b,device.neg) = G(device.b,device.neg) - 1;
            elseif device.neg == 0
                G(device.pos,device.b) = G(device.pos,device.b) + 1;
                G(device.b,device.pos) = G(device.b,device.pos) + 1;
            else
            G(device.pos,device.b) = G(device.pos,device.b) + 1;
            G(device.neg,device.b) = G(device.neg,device.b) - 1;
            G(device.b,device.pos) = G(device.b,device.pos) + 1;
            G(device.b,device.neg) = G(device.b,device.neg) - 1;
            end
            V(device.b) = V(device.b) + device.a;
        case 'CV'
            if device.pos == 0
                G(device.neg,device.c) = G(device.neg,device.c) - 1;
                G(device.c,device.neg) = G(device.c,device.neg) - 1;
            elseif device.neg == 0
                G(device.pos,device.c) = G(device.pos,device.c) + 1;
                G(device.c,device.pos) = G(device.c,device.pos) + 1;
            else
            G(device.pos,device.c) = G(device.pos,device.c) + 1;
            G(device.neg,device.c) = G(device.neg,device.c) - 1;
            G(device.c,device.pos) = G(device.c,device.pos) + 1;
            G(device.c,device.neg) = G(device.c,device.neg) - 1;
            end
            G(device.c,device.b) = G(device.c,device.b) - device.a;
    end
end

linsolve(G,V)

%end