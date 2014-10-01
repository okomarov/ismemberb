function [Lia, Locb] = ismemberb(A, B, nblocks, varargin)

% ISMEMBERB Apply ismember with flexible (reduced) memory footprint

% Author: Oleg Komarov (o.komarov11@imperial.ac.uk)
% Tested on R2014a Win7 64bit
% 01 Oct 2014 - Created

if nargin < 3 || isempty(nblocks)
    nbA = 2;
    nbB = 2;
elseif isscalar(nblocks)
    [nbA,nbB] = deal(nblocks);
elseif numel(nblocks) == 2
    nbA = nblocks(1);
    nbB = nblocks(2);
else
    error
end

isvecA = isvector(A);
if isvecA
    if isrow(A)
        dim = 2;
    else
        dim = 1;
    end
    rA = numel(A);
else
    rA = size(A,1);
end

isvecB = isvector(B);
if isvecB
    rB = numel(B);
else
    rB = size(B,1);
end


edgesA = cast2uint(rA, ceil(linspace(0,rA,nbA+1)));
edgesB = cast2uint(rB, ceil(linspace(0,rB,nbB+1)));

out = cell(nbA,nargout);
tmp = cell(  1,nargout);
for a = 1:nbA
    blockA = edgesA(a)+1:edgesA(a+1);
    for b = 1:nbB
        blockB   = edgesB(b)+1:edgesB(b+1);
        if isvecA, blkA = A(blockA); else blkA = A(blockA,:); end
        if isvecB, blkB = B(blockB); else blkB = B(blockB,:); end
        [tmp{:}] = ismember(blkA, blkB, varargin{:});
        if b == 1
            out(a,1) = tmp(1);
            if nargout == 2
                out{a,2} = cast2uint(rB, tmp{2});
            end
        else
            out{a,1} = out{a,1} | tmp{1};
            if nargout == 2
                out{a,2}(tmp{1}) = cast2uint(rB, tmp{2}(tmp{1})) + edgesB(b);
            end
        end
    end
end

Lia = cat(dim,out{:,1});
if nargout == 2
    Locb = cat(dim,out{:,2});
end

end

function varargout = cast2uint(n,varargin)
% Which unsigned integer class  
[~,bin] = histc(n, [1 256 65536 4294967296 18446744073709551616]);
if bin == 5
    throwAsCaller(MException('MATLAB:pmaxsize','Maximum variable size allowed by the program is exceeded.'))
end

% Pick the conversion fun
fun = {@uint8, @uint16, @uint32, @uint64};
fun = fun{bin};

% Convert
varargout = cell(nargout,1);
for ii = 1:nargout
    varargout{ii} = fun(varargin{ii});
end
end