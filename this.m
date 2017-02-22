classdef this < handle
% OO Matlab Batcher
%
%
%
    
    properties
        Files
        cjob
        funcs
        where
    end
    
    methods
        
        
        
        function obj = SetFiles(obj,varargin)
            Fe  = varargin{1};
            F   = eval(Fe);
            obj.Files = F;
        end
        
        function addjob(obj,varargin)
            name = varargin{1}{1};
            func = varargin{1}{2};

            obj.funcs.(name)   = func;
        end
        
        
        function SelectJob(obj,varargin)
                job = varargin{1};
                if isfield(obj.funcs,job);
                    obj.cjob{2} = obj.funcs.(job);
                    obj.cjob{1} = job;
                else
                    fprintf('Job not found!\n');
                end
            

        end
        
        function Run(obj)
        % Run jobs - on the cluster
            
            job  = obj.cjob{2};
                for s = 1:length(obj.Files)
                    
                    FilesIn  = obj.Files{s};               
                    fprintf('Dataset %d is ready for %s : submitting\n',s,job);
                    assignin('base','fIn',fIn);
                    
                    switch obj.where
                        case 'cluster';  docluster(job,'fIn');
                        case 'local';    feval(job);
                    end
                end
        end        
        
          
        
    end
end