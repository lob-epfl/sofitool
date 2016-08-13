function displayText(hObject,handles,help)
%Displays text from the help menus of the SOFItutorial_demoMenu
%
%Inputs:
% hObject   current handle object
% handles   handles to SOFItutorial_demoMenu interface [Figure] 
% help      number specifying which text to display since it is different
%           for each help menus

% Copyright © 2015 Arik Girsault 
% École Polytechnique Fédérale de Lausanne,
% Laboratoire d'Optique Biomédicale, BM 5.142, Station 17, 1015 Lausanne, Switzerland.
% arik.girsault@epfl.ch, tomas.lukes@epfl.ch
% http://lob.epfl.ch/
 
% This file is part of SOFIsim.
%
% SOFIsim is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% SOFIsim is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with SOFIsim.  If not, see <http://www.gnu.org/licenses/>.

latex = createHelpEquations(help);
htmlStr = createHelpText(help);

% Write Equations
if help == 1
    axes(handles.axes5);text(0,0.5,[latex.eq1,latex.eq2,latex.eq3,latex.eq5,latex.prop1,latex.prop2],'interpreter','latex','fontsize',11,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes5,'off');
    %axes(handles.axes6);text(0,0.5,[latex.prop1,latex.prop2,latex.prop3],'interpreter','latex','fontsize',10.5);set(gca,'XTick',[]);set(gca,'YTick',[]);
    axes(handles.axes6);text(0,0.5,[latex.prop3,latex.eq6],'interpreter','latex','fontsize',10.5,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes6,'off');
    axes(handles.axes7);text(0,0.5,[latex.eq7,latex.eq8,latex.eq9],'interpreter','latex','fontsize',11,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes7,'off');
elseif help == 2
    axes(handles.axes2);text(0,0.5,[latex.eq1,latex.eq2],'interpreter','latex','fontsize',12,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes2,'off');
elseif help == 3
    axes(handles.axes3);text(0,0.5,[latex.eq1,latex.eq2,latex.eq3],'interpreter','latex','fontsize',12,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes3,'off');
    axes(handles.axes4);text(0,0.5,[latex.eq4,latex.eq5,latex.eq6],'interpreter','latex','fontsize',12,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes4,'off');
elseif help == 4
    axes(handles.axes3);text(0,0.5,[latex.eq1,latex.eq2],'interpreter','latex','fontsize',12,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes3,'off');
    axes(handles.axes4);text(0,0.5,[latex.eq3,latex.eq4],'interpreter','latex','fontsize',12,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes4,'off');
elseif help == 5
    axes(handles.axes2);text(0,0.5,[latex.eq1,latex.eq2,latex.eq3],'interpreter','latex','fontsize',12,'BackgroundColor','white');set(gca,'XTick',[]);set(gca,'YTick',[]);axis(handles.axes2,'off');    
end

% Write Text - hEditbox = handles.helpMenu_edit;
% Get the Java scroll-pane container reference
jScrollPane = findjobj(handles.helpMenu_edit);
% We need the internal hgTextEditMultiline object
jViewPort = jScrollPane.getViewport;
jEditbox = jViewPort.getComponent(0);

% jEditbox.setEditorKit(javax.swing.text.html.HTMLEditorKit);
jEditbox.setContentType('text/html');
jEditbox.setText(htmlStr);

end