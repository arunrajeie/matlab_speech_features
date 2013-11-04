% msf_lar - log area ratios
function feat = msf_lar(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',      0.025,@(x)gt(x,0));
    addOptional(p,'winstep',     0.01, @(x)gt(x,0));
    addOptional(p,'order',       12,   @(x)ge(x,1));
    addOptional(p,'preemph',     0,    @(x)ge(x,0));
    parse(p,varargin{:});
    in = p.Results;

    frames = msf_framesig(speech,in.winlen*fs,in.winstep*fs,@(x)hamming(x));
    temp = lpc(frames',in.order);
    feat = zeros(size(temp,1),in.order);
    for i = 1:size(temp,1)
        temp2 = poly2rc(temp(i,:));
        feat(i,:) = rc2lar(temp2)';
    end
    
end
