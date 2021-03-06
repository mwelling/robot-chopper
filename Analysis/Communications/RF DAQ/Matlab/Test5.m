function Test5(Y1, Y2)
%CREATEFIGURE(Y1,Y2)
%  Y1:  vector of y data
%  Y2:  vector of y data

%  Auto-generated by MATLAB on 23-May-2010 17:29:24

% Create figure
figure1 = figure;

% Create subplot
subplot1 = subplot(2,1,1,'Parent',figure1);
box(subplot1,'on');
hold(subplot1,'all');

% Create plot
plot(Y1,'Parent',subplot1);

% Create xlabel
xlabel({'Step'});

% Create ylabel
ylabel({'Packet Delay(s)',''});

% Create title
title('Packet Delay');

% Create subplot
subplot2 = subplot(2,1,2,'Parent',figure1);
box(subplot2,'on');
hold(subplot2,'all');

% Create plot
plot(Y2,'Parent',subplot2);

% Create xlabel
xlabel('Step');

% Create ylabel
ylabel({'Distance(ft)',''});

% Create title
title('Distance');

