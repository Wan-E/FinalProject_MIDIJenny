% MelBot- collects MIDI information ready for Bach and Cages Seeding Process
% Collects 5 Types of midi data: Velocity, Intervals, Durations, Pitch Variations, Onsets.
% ACTIVE SET
% Ewan Thomas

% Paths to the MIDI files
ActiveMidiData = {
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/AeroSmith_DreamOn.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Aerosmith_SweetEmotion.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/CalvinHarris_Summer.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/DrDre_GThang.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Gorilaz_FeelGood.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/NightFever.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/RappersDelight.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/VengaBoys_Boom.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/VengaBoys_Ibiza.mid'; 
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/Wham_WakeMeUP.mid';
    '/Users/ewanthomas/Desktop/Final_Project/DATA_SET/MIDI_/Active/WuTang_GravelPit.mid';
};



% cell arrays to store data for each song
songChannelData = cell(1, length(ActiveMidiData));
songPitchData = cell(1, length(ActiveMidiData));
songVelocityData = cell(1, length(ActiveMidiData));
songOnsetData = cell(1, length(ActiveMidiData));
songDurationData = cell(1, length(ActiveMidiData));

% create a new file to store pitch intervals
intervalFileName = 'Active_Intervals.txt';
intervalFileID = fopen(intervalFileName, 'w');

% Loop through each MIDI file
for i = 1:length(ActiveMidiData)
    % Convert MIDI file to notematrices
    ActiveNoteMatrix = readmidi(ActiveMidiData{i});
    
    % Get number of notes from each MIDI file
    NoteQuantity = size(ActiveNoteMatrix, 1);
    
    % Initialize arrays to store data for each song
    channelData = zeros(1, NoteQuantity);
    pitchData = zeros(1, NoteQuantity);
    velocityData = zeros(1, NoteQuantity);
    onsetData = zeros(1, NoteQuantity);
    durationData = zeros(1, NoteQuantity);
    
    for j = 1:NoteQuantity
        channelData(j) = channel(ActiveNoteMatrix(j, :));
        pitchData(j) = pitch(ActiveNoteMatrix(j, :)) * 1000; % Multiply pitch by 1000
        velocityData(j) = velocity(ActiveNoteMatrix(j, :));
        onsetData(j) = round(onset(ActiveNoteMatrix(j, :), 'sec'), 10) * 1000; % Multiply and round onsets
        durationData(j) = dur(ActiveNoteMatrix(j, :), 'sec');
    end
    
% Calculate intervals (difference between pitch ranges)
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
    
    % New line for the next song.
    fprintf(intervalFileID, '\n');
    
    % Store data in cell arrays
    songChannelData{i} = channelData;
    songPitchData{i} = pitchData;
    songVelocityData{i} = velocityData;
    songOnsetData{i} = onsetData;
    songDurationData{i} = durationData;
end

fclose(intervalFileID); 






% Text files to store data for each attribute
channelFileName = 'Active_Channel_Data.txt';
pitchFileName = 'Active_Pitch_Data.txt';
velocityFileName = 'Active_Velocity_Data.txt';
onsetFileName = 'Active_Onset_Data.txt';
durationFileName = 'Active_Duration_Data.txt';

% Loop through each songs data
for i = 1:length(ActiveMidiData)
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
    if i < length(ActiveMidiData)
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


