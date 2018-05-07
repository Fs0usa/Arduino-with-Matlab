delete(instrfindall); 
clear all; close all; clc;

s = serial('COM8');             
 
set(s, 'InputBufferSize', 1024);  
set(s, 'FlowControl', 'hardware');
set(s, 'BaudRate', 9600);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);  
set(s, 'StopBit', 1);

disp(get(s, 'Name'));           
prop(1) = (get(s, 'BaudRate'));   
prop(2) = (get(s, 'DataBits'));
prop(3) = (get(s, 'StopBit'));
prop(4) = (get(s, 'InputBufferSize'));
disp(['Port Setup Done!!', num2str(prop)]);                   
fopen(s);

fileID = fopen(strcat('data/Dados do dia -', date, '-.txt'), 'wt');

received_data = [];
x = zeros(1, 100); y = zeros(1, 100); 
dados = zeros(1, 7);

while(true)                     
    
  received_data = str2num(fgetl(s));  

  if(~isempty(received_data) && length(received_data(end, :)) == 7)
    dados(end+1, :) = received_data;
    fprintf(fileID, '%g\t', dados(t ,:));
    fprintf(fileID, '\n');
    k = 1;
    [tam1, tam2] = size(dados);
    index = 1 : tam1;
    
    for i = 1 : tam2
        if(i == 1)
            subplot(2, 4, 1)
            plot(index, dados(:, i), 'r'); % coluna  
            grid on;
            title('EIXO X ACCL');
            drawnow;
        end
        
        if(i == 2)
            subplot(2, 4, 2)
            plot(index, dados(:, i), 'g'); % coluna  
            grid on;
            title('EIXO Y ACCL');
            drawnow;
        end
        
        if(i == 3)
            subplot(2, 4, 3)
            plot(index, dados(:, i), 'b'); % coluna  
            grid on;
            title('EIXO Z ACCL');
            drawnow;
        end
        
        if(i == 4)
            subplot(2, 4, 4)
            plot(index, dados(:, i), 'r'); % coluna  
            grid on;
            title('EIXO X GYR');
            drawnow;
        end
        
        if(i == 5)
            subplot(2, 4, 5)
            plot(index, dados(:, i), 'g'); % coluna  
            grid on;
            title('EIXO Y GYR');
            drawnow;
        end
        
        if(i == 6)
            subplot(2, 4, 6)
            plot(index, dados(:, i), 'b'); % coluna  
            grid on;
            title('EIXO X GYR');
            drawnow;
        end
        
        if(i == 7)
            subplot(2, 4, 7)
            plot(index, dados(:, i), 'k'); % coluna  
            grid on;
            title('TEMP');
            drawnow;
        end
        
        
    end
  end

  flushinput(s);  
end
