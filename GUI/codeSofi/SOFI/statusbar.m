%Display a status/progress bar and inform about the elapsed time.
%
%Synopsis:
%
%  fig=statusbar
%     Get all status/progress bar handles.
%
%  fig=statusbar(title)
%     Create a new status/progress bar. If title is an empty
%     string, the default 'Progress ...' will be used.
%
%  fig=statusbar(title,fig)
%     Reuse an existing status/progress bar or create a new
%     if the handle became invalid.
%
%  fig=statusbar(done,fig)
%     For 0 < done < 1, update the progress bar and the elap-
%     sed time. On user abort, return an empty handle.
%
%  vis=statusbar('on')
%  vis=statusbar('off')
%     Set default visibility for new statusbars and return
%     the previous setting.
%
%  vis=statusbar('on',fig)
%  vis=statusbar('off',fig)
%     Show or hide an existing statusbar and return the last
%     visibility setting.
%
%  delete(statusbar)
%     Remove all status/progress bars.
%
%  drawnow
%     Refresh all GUI windows.
%
%Example:
%
%  fig=statusbar('Wait some seconds ...');
%  for done=0:0.01:1
%     pause(0.2);
%     fig=statusbar(done,fig);
%     if isempty(fig)
%        break;
%     end
%  end
%  delete(fig);

%Copyright © 2012 Marcel Leutenegger et al, École Polytechnique Fédérale de Lausanne,
%Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
function fig=statusbar(done,fig)
persistent visible;
if nargin < nargout                    % get handles
   fig=findobj(allchild(0),'flat','Tag','statusbar');
elseif nargin && ischar(done)
   if isequal(done,'on') || isequal(done,'off')
      if nargin == 2
         if check(fig)                 % show/hide
            vis=get(fig,'Visible');
            set(fig,'Visible',done);
         end
      else
         vis=visible;
         visible=done;                 % default
         if ~strcmp(vis,'off')
            vis='on';
         end
      end
      fig=vis;
   else
      if nargin < 2 || ~check(fig)
         fig=create(visible);          % create
      end
      app=get(fig,'ApplicationData');
      time=toc(app.start);
      if done
         set(fig,'Name',done);
      end
      set(fig,'CloseRequestFcn','setappdata(gcbo,''close'',true);');
      update(fig,app,0,time);
   end
   drawnow;
elseif nargin == 2 && ishandle(fig)    % update (fast handle check)
   app=get(fig,'ApplicationData');
   if app.close                        % confirm
      if done >= 1 || isequal(questdlg({'Are you sure to stop the execution now?',''},'Abort requested','Stop','Resume','Resume'),'Stop')
         delete(fig);
         fig=[];                       % interrupt
         return;
      end
      setappdata(fig,'close',false);   % continue
   end
   done=max(0,min(done,1));
   %
   % Refresh display if
   %
   %  1. still computing
   %  2. computation just finished
   %    or
   %     more than a second passed since last refresh
   %    or
   %     more than 0.4% computed since last refresh
   %
   time=toc(app.start);
   if done >= 1 || time-app.time > 1 || done-app.done > 0.004
      update(fig,app,done,time);
      drawnow;
   end
end
if ~nargout
   clear;
end


%Check if a given handle is a progress bar.
%
function ok=check(fig)
ok=isscalar(fig) && ishandle(fig) && isequal(get(fig,'Tag'),'statusbar');


%Create the progress bar.
%
function fig=create(visible)
if ~strcmp(visible,'off')
   visible='on';
end
s=[256 56];
t=get(0,'ScreenSize');
fig=figure('DoubleBuffer','on','HandleVisibility','off','MenuBar','none','Name','Progress ...','IntegerHandle','off','NumberTitle','off','Resize','off','Position',[floor((t(3:4)-s)/2) s],'Tag','statusbar','ToolBar','none','Visible',visible);
axe.Parent=axes('Parent',fig,'Position',[0 0 1 1],'Visible','off','XLim',[0 s(1)],'YLim',[0 s(2)]);
rectangle('Position',[4 31 248 22],'EdgeColor','white','FaceColor',[0.7 0.7 0.7],axe);
line([4 4 252],[52 53 53],'Color',[0.5 0.5 0.5],axe);
setappdata(fig,'rect',rectangle('Position',[4 31 0.1 22],'EdgeColor','white','FaceColor','red',axe));
setappdata(fig,'line',line([4 4 4],[31 31 53],'Color',[0.2 0.2 0.2],axe));
setappdata(fig,'info',text(128,41,'0%','FontWeight','bold','VerticalAlignment','middle','HorizontalAlignment','center',axe));
setappdata(fig,'text',text(128,14,'0s','FontWeight','bold','VerticalAlignment','middle','HorizontalAlignment','center',axe));
setappdata(fig,'close',false);
setappdata(fig,'start',tic);


%Update the statusbar.
%
function update(fig,app,done,time)
setappdata(fig,'done',done);
setappdata(fig,'time',time);
if done >= 1
   set(fig,'CloseRequestFcn','delete(gcbo);');
end
time=round(time);
if time < 60
   time=sprintf('%2us elapsed',time);
elseif time < 3600
   time=sprintf('%um %2us elapsed',floor(time/60),mod(time,60));
else
   time=sprintf('%uh %um %2us elapsed',floor(time/3600),mod([floor(time/60) time],60));
end
set(app.text,'String',time);
set(app.info,'String',sprintf('%u%%',round(100.*done)));
done=done.*248;
set(app.rect,'Position',[4 31 max(0.1,done) 22]);
set(app.line,'XData',[4 4+done 4+done]);
