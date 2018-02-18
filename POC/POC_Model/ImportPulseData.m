DataFiles = dir('*.txt');
numfiles = length(DataFiles);
pulse = cell(1, (numfiles));

for k = 1:(numfiles)
  if(endsWith(DataFiles(k).name,'.txt'))
    pulse{k} = importdata(DataFiles(k).name);
  end
end

clearvars dirName numfiles DataFiles k;

