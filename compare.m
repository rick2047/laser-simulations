function [ diff ] = compare( laser1, laser2)
%compares two lasers to give difference in amp
    diff = sum((laser1.amplitude - laser2.amplitude).^2);

end

