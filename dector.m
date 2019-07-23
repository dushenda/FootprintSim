classdef dector < handle
    properties
        firstx = 0;
        firsty = 0;
        radium = 0;
        delta = 15;
    end
    
    methods 
        function obj = dector(varargin) % firstx,firsty,radium,delta
            if nargin == 4
                obj.firstx = varargin{1};
                obj.firsty = varargin{2};
                obj.radium = varargin{3};
                obj.delta = varargin{4};
            elseif nargin == 1
                obj.delta = varargin{1};                
            end
        end
        function dector_cluster = cluster()
        end
    end
end