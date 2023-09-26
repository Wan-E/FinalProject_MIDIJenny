% Ewan Thomas Excited Midi set 2

MidiData = {
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/@Unlimited_GetReady.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/Blink182_SmallThings.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/DavidBowie_LetsDance.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/Donna_IFeelLove.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/FatBoySlim_PraiseYou.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/FatBoySlim_RightHere.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/FunkyTown.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/GreatestDancer.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/KanyeWest_AllFallsDown.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/KanyeWest_AllTheLights.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/KellyClarkson_SinceYouBeenGone.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/LadyGaga_JustDance.mid' 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/MamboNo5.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/NewOrder_BlueMonday.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/Prodigy_NoGoodForMe.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/Prodigy_YourLove.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/RickJames_GiveItTooMeBaby.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Excited/SkeeLo_IWish.mid';
};


% Initialize cell arrays to store data for each song
songChannelData = cell(1, length(MidiData));
songPitchData = cell(1, length(MidiData));
songVelocityData = cell(1, length(MidiData));
songOnsetData = cell(1, length(MidiData));
songDurationData = cell(1, length(MidiData));

% Create a new file to store pitch intervals
intervalFileName = 'Intervals.txt';
intervalFileID = fopen(intervalFileName, 'w');

% Loop through each MIDI file
for i = 1:length(MidiData)
    % Convert MIDI file to notematrices
    NoteMatrix = readmidi(MidiData{i});
    
    % Get number of notes from each MIDI file
    NoteQuantity = size(NoteMatrix, 1);
    
    % Initialize arrays to store data for each song
    channelData = zeros(1, NoteQuantity);
    pitchData = zeros(1, NoteQuantity);
    velocityData = zeros(1, NoteQuantity);
    onsetData = zeros(1, NoteQuantity);
    durationData = zeros(1, NoteQuantity);
    
    for j = 1:NoteQuantity
        channelData(j) = channel(NoteMatrix(j, :));
        pitchData(j) = pitch(NoteMatrix(j, :)) * 1000; % Multiply pitch by 1000
        velocityData(j) = velocity(NoteMatrix(j, :));
        onsetData(j) = round(onset(NoteMatrix(j, :), 'sec'), 10) * 1000; % Multiply and round onsets
        durationData(j) = dur(NoteMatrix(j, :), 'sec');
    end
    
% Calculate intervals and store them in the interval file, transposed
intervals = round(diff(pitchData), 1);
transposedIntervals = intervals(2:end) - intervals(1:end-1);
for k = 1:length(transposedIntervals)
    fprintf(intervalFileID, '%d', transposedIntervals(k));
    if k < length(transposedIntervals)
        fprintf(intervalFileID, ' ');
    else
        fprintf(intervalFileID, '\n');
    end
end
    
    % Start a new line for the next song's intervals
    fprintf(intervalFileID, '\n');
    
    % Store the data for this song in cell arrays
    songChannelData{i} = channelData;
    songPitchData{i} = pitchData;
    songVelocityData{i} = velocityData;
    songOnsetData{i} = onsetData;
    songDurationData{i} = durationData;
end

fclose(intervalFileID); % Close the interval file






% Create separate text files to store data for each attribute
channelFileName = '_Channel_Data.txt';
pitchFileName = '_Pitch_Data.txt';
velocityFileName = '_Velocity_Data.txt';
onsetFileName = '_Onset_Data.txt';
durationFileName = '_Duration_Data.txt';

% Loop through each song's data
for i = 1:length(MidiData)
    % Write data for each attribute 
    channelFileID = fopen(channelFileName, 'a');
    fprintf(channelFileID, '%d\n', songChannelData{i});
    fclose(channelFileID);
    
    pitchFileID = fopen(pitchFileName, 'a');
    fprintf(pitchFileID, '%d\n', songPitchData{i});
    fclose(pitchFileID);
    
    velocityFileID = fopen(velocityFileName, 'a');
    fprintf(velocityFileID, '%d\n', songVelocityData{i});
    fclose(velocityFileID);
    
    onsetFileID = fopen(onsetFileName, 'a');
    fprintf(onsetFileID, '%f\n', songOnsetData{i});
    fclose(onsetFileID);
    
    durationFileID = fopen(durationFileName, 'a');
    fprintf(durationFileID, '%f\n', songDurationData{i});
    fclose(durationFileID);
    
    % Insert a new line to separate songs in all files
    if i < length(MidiData)
        channelFileID = fopen(channelFileName, 'a');
        fprintf(channelFileID, '\n');
        fclose(channelFileID);
        
        pitchFileID = fopen(pitchFileName, 'a');
        fprintf(pitchFileID, '\n');
        fclose(pitchFileID);
        
        velocityFileID = fopen(velocityFileName, 'a');
        fprintf(velocityFileID, '\n');
        fclose(velocityFileID);
        
        onsetFileID = fopen(onsetFileName, 'a');
        fprintf(onsetFileID, '\n');
        fclose(onsetFileID);
        
        durationFileID = fopen(durationFileName, 'a');
        fprintf(durationFileID, '\n');
        fclose(durationFileID);
    end
end