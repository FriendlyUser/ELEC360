%% This function plots Asymptotes and break in/ break away points
function plotAsymptotes(sys) 
    [num,den]=tfdata(sys,'v'); %Get (and save) numerator and denominator.
    %handles.Num=num; handles.Den=den;
    [z,p]=zpkdata(sys,'v');  %Get zeros and poles (to accuracy of 0.01)
    z=round(real(z)*100)/100+j*round(imag(z)*100)/100;
    p=round(real(p)*100)/100+j*round(imag(p)*100)/100;
    realZIndex=find(abs(imag(z))<1E-3); %Determine which are real (i.e., on
    realPIndex=find(abs(imag(p))<1E-3); % the real axis)...
	z(realZIndex)=real(z(realZIndex));  % and set imag part to zerp.
    p(realPIndex)=real(p(realPIndex));
    handles.Z=z; handles.P=p;  %Store zeros and poles.
    m=length(z); n=length(p);  %Length of numerator and denominator.
    q=n-m;                     %Number of zeros at infinity.
    %handles.M=m; handles.N=n; handles.Q=q; %Store values.
    %Do calcluations.
    sump=sum(p); sumz=sum(z);  %Sum of poles and zeros.
    sigma=real(sump-sumz)/q;   %Intersect on real axis.
    theta=180/q;               %Angle of asymptotes
%     s='';  %Start "s" as an empty string.
%     s{end+1}='Angle of asymptotes at odd multiples of ?180?/q ';
%     eStr=['(i.e., ' sprintf(' ?%g?,',(1:2:q)*180/q)];
%     s{end}=[s{end} eStr(1:(end-1)) ').'];   %Strip off last comma.
%     s{end+1}=' ';
%     s{end+1}=ListString('There exists ', p, ' pole',',');
%     s{end+1}=sprintf('      ...so sum of poles=%g.',sump);
%     s{end+1}=ListString('There exists ', z, ' zero',',');
%     s{end+1}=sprintf('      ...so sum of zeros=%g.',sumz);
%     s{end+1}='(Imaginary components of poles and zeros, if any, cancel when';
%     s{end+1}='  summed because they appear as complex conjugate pairs.)';
%     s{end+1}=' ';
%     s{end+1}='Asymptote intersect is at ( (sum of poles)-(sum of zeros) )/q';
%     s{end+1}=sprintf('Intersect is at ((%g)-(%g))/%g = %g/%g = %5.3g',...
%        sump,sumz,q,sump-sumz,q,sigma);
%     s{end}=[s{end} '  (highlighted by five pointed star).'];

    if q==1,
%        s{end+1}='Since q=1, there is a single asymptote at ?180?';
%        s{end+1}='(on negative real axis), so  intersect of this asymptote';
%        s{end+1}='on the axis s not important (but it is shown anyway).';
    end
    plot(sigma,0,'p',...    %Plot intersect with big start.
       'MarkerSize',8,...
       'MarkerEdgeColor','black',...
       'MarkerFaceColor','blue','DisplayName','Asymptotes intersection');
    radius=max(get(gca,'YLim'))*5;   %Make radius big enough to go off page.
    for i=0:(q-1),
       theta_i=(2*i+1)*theta*pi/180 %Plot asymptotes.
       h3 = line([sigma sigma+radius*cos(theta_i)],...
          [0 radius*sin(theta_i)],...
          'Color','cyan',...
          'LineStyle','--',...
          'LineWidth',1,'DisplayName','Asymptotes');
      if(i < q-1)
          % don't mark n-1 asymptotes in the legend, but mark the last one
         set(get(get(h3,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
      end
    end
    set(get(get(h3,'Annotation'),'LegendInformation'),'IconDisplayStyle','on');
    % plotting break away point
    %num=handles.Num;     %N(s)
    %den=handles.Den;     %D(s)
    np=polyder(num);     %N'(s)
    dp=polyder(den);     %D'(s)
    p1=conv(np,den);     %p1=N'(s)D(s)
    p2=conv(dp,num);     %p2=D'(s)N(s)
    np1=length(p1);      %Next lines make p1 and p2 the same order.
    np2=length(p2);
    if np1>np2,
       p2=[zeros(1,np1-np2) p2];
    elseif np2>np1
       p1=[zeros(1,np2-np1) p1];
    end
    pn=p2-p1;            %pn=D'(s)N(s)-N'(s)D(s)
    baway=roots(pn);     %breakaway are at roots of pn.

    % In the next loop, we determine the value of K at each root of "pn".  If K
    % is real and positive, the point is on the locus.  If the point is also
    % real, then it is one of our points.
    realK=[];      %This will hold all breakaway location that occur at real
                   %...values of K,
    posRealK=[];   %...this holds only those for positive real K.
    for i=1:length(baway),
       %Find value of K at the baway location.
       kVal=-polyval(den,baway(i))/polyval(num,baway(i));  
       if isreal(kVal),
          realK=[realK baway(i)];
          if kVal>=0, %If K is real and positive, this point is on locus
             %...so plot it with a square,
             posRealK=[posRealK baway(i)];
             plot(real(baway(i)),imag(baway(i)),'h',... 
                'MarkerSize',10,...
                'MarkerEdgeColor','black',...
                'MarkerFaceColor','cyan','DisplayName','Break-in point');
          else
             %...else, plot it with a diamond (negative value of K).
             % break in point I think
             plot(real(baway(i)),imag(baway(i)),'p',...
                'MarkerSize',10,...
                'MarkerEdgeColor','black',...
                'MarkerFaceColor','magenta','DisplayName','Break-away point');
          end
       end
    end
    
%     %% Not working and not easy to implement, just use RLocusGui and plot the points manually
%     n=0;     %n counts the number of values of k that cause crossing of axis
%     % in top half of s-plane (including real axis).
%     m=0;     %m keeps track of crossings in bottom half of s-plane (not
%     % including real axis.
%     r=(handles.Xmax-handles.Xmin)/15;  %Radius for arcs drawn on plot.
%     %Determine where (and if) the locus crosses the imaginary axis.
%     for i=1:size(r,1),
%        for wx=1:(length(k)-2),  %Don't include last point (often equals Inf)
%           %Check to see if locus has crossed the imaginary axis.
%           x1=real(r(i,wx));  x2=real(r(i,wx+1));
%           %      if (x1<=0 && x2>0) || (x1>0 && x2<0),
%           if (x1*x2)<=0,  %x1=0, x2=0, or x1 and x2 have different signs.
%              %Only need to check for top half of s plane (and real axis),
%              %because roots appear in complex conjugate pairs.
%              if imag(r(i,wx))>=0,
%                 n=n+1;
%                 %kcross is approximate value of k where locus crosses axis,
%                 kcross(n)=interp1([x1 x2],[k(wx) k(wx+1)],0,'linear');
%                 %...wcross is approsimate value of frequency (omega).
%                 wcross(n)=interp1([x1 x2],[imag(r(i,wx)) imag(r(i,wx+1))],...
%                    0,'linear');
%                 lcross(n)=i;   %keep track of which locus (for color on plot).
%              else
%                 m=m+1;
%                 kcross2(m)=interp1([x1 x2],[k(wx) k(wx+1)],0,'linear');
%                 wcross2(m)=interp1([x1 x2],[imag(r(i,wx)) imag(r(i,wx+1))],...
%                    0,'linear');
%                 lcross2(m)=i;
%              end
%           end
%        end
%     end
% 
%     if n==0,
%        doPlot=0;
%        axes(handles.axRules); cla; set(handles.axRules,'Visible','off')
%        fprintf('Locus does not cross imaginary axis.')
%     else
%        doPlot=1;
%        if nargin==1,
%           ax=handles.axRules;
%        end
%        axes(ax); cla;
%        drawRLocus(handles,ax,1.5,length(k)','Locus Crossing Axis');
%        fprintf('Locus crosses imaginary axis at '+ n  +' of K.')
%        %s{2}='These values are normally determined by using Routh''s method.';
%        %s{3}='This program does it numerically, and so is only an estimate.';
%        %s{end+1}=' ';
%        crossLawl = sprintf(' %5.3g,',kcross)
%        fprintf('Locus crosses where K = %s',  crossLawl);
%        %s{end+1}='corresponding to crossing imaginary axis at s=';
%        for i=1:n,
%           if wcross(i)==0,
%              fprintf('0')
%           else
%               Anime = sprintf(' ?%5.3gj,',wcross(i));
%               fprintf('?%5.3gj,',Anime);
%           end
%        end
%        if n>1,
%           %s{end}=[s{end} ' respectively.'];
%        else
%           %s{end}(end)='.';
%        end
%        %s{end+1}=' ';
%        %s{end+1}='These crossings are shown on plot.';
% 
%        for c=1:n %Plot each crossing of axis, along with value of K.
%           plot(0,wcross(c),'o',...
%              'MarkerSize',8,...
%              'MarkerEdgeColor','black',...
%              'MarkerFaceColor','blue');
%           text(-0.25,wcross(c),sprintf('K=%5.3g',kcross(c)),...
%              'Color','red',...
%              'HorizontalAlignment','Right',...
%              'VerticalAlignment','bottom');
%        end
%        for c=1:m
%           plot(0,wcross2(c),'o',...
%              'MarkerSize',8,...
%              'MarkerEdgeColor','black',...
%              'MarkerFaceColor','green');
%           text(-0.25,wcross2(c),sprintf('K=%5.3g',kcross2(c)),...
%              'Color','blue',...
%              'HorizontalAlignment','Right',...
%              'VerticalAlignment','top');
%        end
%     end