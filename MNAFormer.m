function [G,V] = MNAFormer(Devices,G,V)


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
            G(device.b,device.c) = G(device.b,device.c) + device.a;
    end

 end
