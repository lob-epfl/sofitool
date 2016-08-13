function [latex] = createHelpEquations(help)
%Displays text from the help menus of the SOFItutorial_demoMenu
%
%Inputs:
% help      number specifying which equations to generate since it is different
%           for each help menus
%Outputs:
% latex     Latex string containing the equations for the help menu defined by
%           the input number 'help'

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

switch help
    case 1
        eq1 = ['(1)\hspace{15pt}$I(\textbf{r},t)=\sum_{k=1}^M{\epsilon{}}_kU(\textbf{r}-\textbf{r}_k)s_k(t)+b(\textbf{r})$',char(10),char(10)];

        eq2 = ['(2)\hspace{15pt}$I_{ideal}(\textbf{r})=\sum_{k=1}^M{\epsilon{}}_k\delta{}(\textbf{r}-\textbf{r}_k)$',char(10),char(10)];

        eq3 = ['(3)\hspace{15pt}${\lim_{N\rightarrow{}\infty{}}{S_{N}\{I(\textbf{r},t)\}}\vert{}}_{t\in{}R}=I_{ideal}(\textbf{r})$',char(10),char(10)];

        eq4 = ['(4)\hspace{15pt}${\mu{}}_n(I(\textbf{r}_1,t)+I(\textbf{r}r_2,t))\not={\mu{}}_n(I(\textbf{r}_1,t))+{\mu{}}_n(I(\textbf{r}_2,t))$ for $n\geq{}4$',char(10),char(10)];

        eq5 = ['(5)\hspace{15pt}$C_x(I)=\sum_{U_{p=1}^qI_p=I}{(-1)}^{q-1}(q-1)!\prod_{p=1}^qm_x(I_p)$',char(10),char(10)];


        % --- cumulant properties
        prop1 = ['Cumulant Prop. 1: If ${\lambda{}}_i$, $i=(1,...,n)$ are constants, and $x_i$,\hspace{32pt}',char(10),... 
                '$i=(1,...,n)$ are random variables, then:',char(10),...
                '\hspace{15pt}${\kappa{}}_n({\lambda{}}_1x_1,...,{\lambda{}}_kx_n)=(\prod_{i=1}^n{\lambda{}}_i){\kappa{}}_n(x_1,...,x_n)$',char(10),char(10)];

        prop2 = ['Cumulant Prop. 2: If $\alpha{}$ is a constant, then:',char(10)...
                '\hspace{15pt}${\kappa{}}_n({\alpha{}+x}_1,...,x_n)={\kappa{}}_n(x_1,...,x_n)$',char(10),char(10)];

        prop3 = ['Cumulant Prop. 3: If the random variable $\{x_i\}$ are independent of the',char(10),...
                'random variables $\{y_i\},\ i=(1,...,n)$ then:',char(10),...
                '\hspace{15pt}${\kappa{}}_n(x_1+y_1,...,x_n+y_n)={\kappa{}}_n(x_1,...,x_n)+{\kappa{}}_n(y_1,...,y_n)$',char(10),char(10)];

        % ---

        eq6 = ['(6)\hspace{15pt}${\kappa{}}_n\{I(\textbf{r},t)\}(\tau{})={\kappa{}}_n\{\sum_{k=1}^M{\epsilon{}}_kU(\textbf{r}-{\textbf{r}}_k)s_k(t)+b(\textbf{r})\}(\tau{})$',char(10),char(10),...
               '   \hspace{18pt}$\stackrel{Prop.2}{\rightarrow{}}{\kappa{}}_n\{\sum_{k=1}^M{\epsilon{}}_kU(\textbf{r}-{\textbf{r}}_k)s_k(t)\}(\tau{})$',char(10),char(10),...
               '   \hspace{18pt}$\stackrel{Prop.3}{\rightarrow{}}\sum_{k=1}^M{\kappa{}}_n\{{\epsilon{}}_kU(\textbf{r}-{\textbf{r}}_k)s_k(t)\}(\tau{})$',char(10),char(10),...
               '   \hspace{18pt}$\stackrel{Prop. 1}{\rightarrow{}}\sum_{k=1}^M{\epsilon{}}_k^nU^n(\textbf{r}-{\textbf{r}}_k){\kappa{}}_n\{s_k(t)\}(\tau{})$',char(10),char(10)];

        eq7 = ['(7)\hspace{15pt}${\chi{}\kappa{}}_2\{I(\textbf{r}_1,t),I(\textbf{r}_2,t)\}(\tau{})=E\{I(\textbf{r}_1,t)I(\textbf{r}_2,t+\tau{})\}$',char(10),...
               '   \hspace{20pt}$=U(\frac{\textbf{r}_1-\textbf{r}_2}{\sqrt{2}})\sum_{k=1}^M{\epsilon{}}_k^2U^2(\frac{\textbf{r}_1+\textbf{r}_2}{2}-\textbf{r}_k){\langle{}s_k(t),s_k(t+\tau{})\rangle{}}_t$',char(10),char(10)];

    %     eq8 = ['(8)\hspace{15pt}${\kappa{}}_2\{I(\textbf{r}_1,t)\}(\tau{})=E\{I(\textbf{r}_1,t)I(\textbf{r}_1,t+\tau{})\}$','',...
    %            '$=\sum_{k=1}^M{\epsilon{}}_k^2U^2(\textbf{r}_1-{\textbf{r}}_k){\langle{}s_k(t),s_k(t+\tau{})\rangle{}}_t$',char(10),char(10)];

        eq8 = ['(8)\hspace{15pt}${\kappa{}}_2\{I(\textbf{r}_1,t)\}(\tau{})=E\{I(\textbf{r}_1,t)I(\textbf{r}_1,t+\tau{})\}$',char(10),...
               '   \hspace{20pt}$=\sum_{k=1}^M{\epsilon{}}_k^2U^2(\textbf{r}_1-{\textbf{r}}_k){\langle{}s_k(t),s_k(t+\tau{})\rangle{}}_t$',char(10),char(10)];

        eq9 = '(9)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_S,t)\}=\prod_{j<l}^nU(\frac{\textbf{r}_j{-\textbf{r}}_l}{\sqrt{n}})\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}){\kappa{}}_n\{s_k(t)\}$';

        latex = struct('eq1',eq1,'eq2',eq2,'eq3',eq3,'eq4',eq4,'eq5',eq5,'eq6',eq6,'eq7',eq7,'eq8',eq8,'eq9',eq9,'prop1',prop1,'prop2',prop2,'prop3',prop3);

    case 2
        
        eq1 = ['(1)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}=\prod_{j<l}^nU(\frac{\textbf{r}_j{-\textbf{r}}_l}{\sqrt{n}})\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}){\kappa{}}_n\{s_k(t)\}$',char(10),char(10)];
        
        eq2 = '(2)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}\simeq{}\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}){\kappa{}}_n\{s_k(t)\}$';
        
        latex = struct('eq1',eq1,'eq2',eq2);
        
    case 3
        
        eq1 = ['(1)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}\simeq{}\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}){\kappa{}}_n\{s_k(t)\}$',char(10),char(10)];
        
        eq2 = ['(2)\hspace{15pt}${\rho{}}_{on}=\frac{{\tau{}}_{on}}{{\tau{}}_{on}+{\tau{}}_{off}}$,\hspace{5pt} and \hspace{5pt}',...
               '${\rho{}}_{off}=\frac{{\tau{}}_{off}}{{\tau{}}_{on}+{\tau{}}_{off}}=1-{\rho{}}_{on}$',char(10),char(10)];
        
        eq3 = ['(3)\hspace{15pt}${\kappa{}}_n\{s_k(t)\}={\kappa{}}_n\{{(1-{\xi{}}_k)f}_k(t)\}={{f_n({\rho{}}_{on,k})=(1-{\xi{}}_k)}^n\rho{}}_{on,k}(1-{\rho{}}_{on,k})\frac{\partial{}{\kappa{}}_{n-1}\{s_k(t)\}}{\partial{}{\rho{}}_{on,k}}$',char(10),...
               'with ${\kappa{}}_1\{s_k(t)\}={{(1-{\xi{}}_k)}^1\rho{}}_{on,k}$ \hspace{5pt} and \hspace{5pt}',...
               '${{\kappa{}}_2\{s_k(t)\}={(1-{\xi{}}_k)}^2\rho{}}_{on,k}(1-{\rho{}}_{on,k})$'];
        
        eq4 = ['(4)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_S,t)\}=\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})f_n({\rho{}}_{on,k})={{\epsilon{}}^n(\textbf{r})f}_n({\rho{}}_{on};\textbf{r})\sum_{i=1}^NU^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})$',char(10),char(10)];
        
        eq5 = ['(5)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_S,t)\}={{\epsilon{}}^n(\textbf{r})f}_n({\rho{}}_{on};\textbf{r})\sum_{i=1}^N\delta{}(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})$',char(10),char(10)];
        
        eq6 = '(6)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_S,t)\}={\epsilon{}(\textbf{r})\vert{}f_n\vert{}}^{\frac{1}{n}}({\rho{}}_{on};\textbf{r})\sum_{i=1}^N\delta{}(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})$';
        
        latex = struct('eq1',eq1,'eq2',eq2,'eq3',eq3,'eq4',eq4,'eq5',eq5,'eq6',eq6);
        
    case 4
        
        eq1 = ['(1)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}={\epsilon{}(\textbf{r})\vert{}f_n\vert{}}^{\frac{1}{n}}({\rho{}}_{on};\textbf{r})\sum_{i=1}^N\delta{}(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})$',char(10),char(10)];
        
        eq2 = ['(2)\hspace{15pt}$U^n(\textbf{r})\stackrel{Fourier}{\rightarrow{}}O(\textbf{k})=\hat{U}(\textbf{k})\underbrace{*...*}_{(n-1)times}\hat{U}(\textbf{k})\stackrel{Deconv. and Reconv}{\rightarrow{}}O^{\prime}(\textbf{k})=\hat{U}(n\textbf{k})\stackrel{{Fourier}^{-1}}{\rightarrow{}}U(\frac{\textbf{r}}{n})$'];
        
        eq3 = ['(3)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}\simeq{}\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}){\kappa{}}_n\{s_k(t)\}$',char(10),char(10)];

        eq4 = '(4)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}={\epsilon{}(\textbf{r})\vert{}f_n\vert{}}^{\frac{1}{n}}({\rho{}}_{on};\textbf{r})\sum_{i=1}^NU(\frac{\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}}{n})$';
        
        latex = struct('eq1',eq1,'eq2',eq2,'eq3',eq3,'eq4',eq4);
        
    case 5
        
        eq1 = ['(1)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_S,t)\}=\sum_{i=1}^N{{\epsilon{}}_i^nU}^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})f_n({\rho{}}_{on,k})={{\epsilon{}}^n(\textbf{r})f}_n({\rho{}}_{on};\textbf{r})\sum_{i=1}^NU^n(\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n})$',char(10),char(10)];

        eq2 = ['(2)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}={\epsilon{}(\textbf{r})\vert{}f_n\vert{}}^{\frac{1}{n}}({\rho{}}_{on};\textbf{r})\sum_{i=1}^NU(\frac{\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}}{n})$',char(10),char(10)];
        
        eq3 = '(3)\hspace{15pt}${\chi{}\kappa{}}_n\{I(\textbf{r}_1,t)\dots{}I(\textbf{r}_n,t)\}\simeq{}\epsilon{}(\textbf{r})\sum_{i=1}^NU(\frac{\textbf{r}_i-\frac{\sum_k^n\textbf{r}_k}{n}}{n})$';

        latex = struct('eq1',eq1,'eq2',eq2,'eq3',eq3);
        
    otherwise
        
end









end

