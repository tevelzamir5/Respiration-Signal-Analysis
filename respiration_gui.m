function respiration_gui()
    %% Create Structure
    subject_structure = struct();
    
    %% Create GUI Window
    fig = uifigure('Name', 'respiration Signal Processing', 'Position', [100 100 1200 720]);
    mainGrid = uigridlayout(fig);
    mainGrid.RowHeight = {170, 100, 100, 210, '1x'};
    mainGrid.ColumnWidth = {280, '1x'};

    % leftPanel = uipanel(mainGrid, 'Title', 'Control Panel');
    % leftPanel.Layout.Row = 1;
    % leftPanel.Layout.Column = 1;
    % 
    % rightPanel = uipanel(mainGrid, 'Title', 'Display Area');
    % rightPanel.Layout.Row = 1;
    % rightPanel.Layout.Column = 2;
    % 
    % controlGrid = uigridlayout(leftPanel);
    % controlGrid.RowHeight = {170, 160, 120, 160, '1x'};
    % controlGrid.ColumnWidth = {'1x'};
    %% Left Panel - Control
    loadPanel = uipanel(mainGrid, 'Title', 'Load Subject');
    loadPanel.Layout.Row = 1;
    loadPanel.Layout.Column = 1;

    LMSPanel = uipanel(mainGrid, 'Title', 'LMS Filter');
    LMSPanel.Layout.Row = 2;
    LMSPanel.Layout.Column = 1;

    MoveAvrPanel = uipanel(mainGrid, 'Title', 'Smooth Signal - Moving Average');
    MoveAvrPanel.Layout.Row = 3;
    MoveAvrPanel.Layout.Column = 1;

    PeakDetectPanel = uipanel(mainGrid, 'Title', 'Peak Detcet');
    PeakDetectPanel.Layout.Row = 4;
    PeakDetectPanel.Layout.Column = 1;

    SavePanel = uipanel(mainGrid, 'Title', 'Save');
    SavePanel.Layout.Row = 5;
    SavePanel.Layout.Column = 1;

    % displayPanel = uigridlayout(rightPanel);
    % displayPanel.RowHeight = {350, '1x'};
    % displayPanel.ColumnWidth = {'1x'};

    rawPanel = uipanel(mainGrid, 'Title', 'Raw Signal');
    rawPanel.Layout.Row = [1 2];
    rawPanel.Layout.Column = 2;

    currentPanel = uipanel(mainGrid, 'Title', 'Current Signal');
    currentPanel.Layout.Row = [3 5];
    currentPanel.Layout.Column = 2;

    % Create Left Side - Control Panel
    % 1. Load Subject
    % 1.1. Grid
    LoadPanel = uigridlayout(loadPanel);
    LoadPanel.RowHeight = {25, 25, 25, 25};
    LoadPanel.ColumnWidth = {70, '1x'};
    
    % 1.2 Subject
    SubjectLabel = uilabel(LoadPanel, 'Text', 'Subject');
    SubjectLabel.Layout.Row = 1;
    SubjectLabel.Layout.Column = 1;

    SubjectDropDown = uidropdown(LoadPanel, 'Items', ["AA795", "AC436", "AO606", "AO616", "CS863", "DC639", "EO868", "GD237", "GS904", "HK220", "IF080", "JO645", "LF934","LK791", "LR944", "MA172", "MB292", "MI871", "MM369", "MR867", "ND938", "OD890", "OR296", "OS337", "RS940", "SA506", "SL213", "YB497", "ZF767"]);
    SubjectDropDown.Layout.Row = 1;
    SubjectDropDown.Layout.Column = 2;
    
    % 1.3 Condition
    ConditionLabel = uilabel(LoadPanel, "Text", 'Condition');
    ConditionLabel.Layout.Row = 2;
    ConditionLabel.Layout.Column = 1;

    ConditionDropDown = uidropdown(LoadPanel, 'Items', ["Standing" ,"Walking"]);
    ConditionDropDown.Layout.Row = 2;
    ConditionDropDown.Layout.Column = 2;

    % 1.4 Test
    TestLabel = uilabel(LoadPanel, "Text", 'Test');
    TestLabel.Layout.Row = 3;
    TestLabel.Layout.Column = 1;

    TestDropDown = uidropdown(LoadPanel, 'Items', ["LC", "T1", "T2"]);
    TestDropDown.Layout.Row = 3;
    TestDropDown.Layout.Column = 2;

    % 1.5 Load Button
    LoadButton = uibutton(LoadPanel, 'Text', 'Load');
    LoadButton.Layout.Row = 4;
    LoadButton.Layout.Column = 2;

    % 2. LMS
    LMSPanel = uigridlayout(LMSPanel);
    LMSPanel.RowHeight = {25, 25};
    LMSPanel.ColumnWidth = {15, 100, 15, 100};
   
    % 2.1 mu
    muLabel = uilabel(LMSPanel, 'Text', '\mu', 'Interpreter', 'latex');
    muLabel.Layout.Row = 1;
    muLabel.Layout.Column = 1;

    muField = uieditfield(LMSPanel,"numeric");
    muField.Layout.Row = 1;
    muField.Layout.Column = 2;

    % 2.2 M
    MLabel = uilabel(LMSPanel, 'Text', 'M', 'Interpreter', 'latex');
    MLabel.Layout.Row = 1;
    MLabel.Layout.Column = 3;

    MField = uieditfield(LMSPanel, "Numeric");
    MField.Layout.Row = 1;
    MField.Layout.Column = 4;

    % 2.3 Apply Button
    ApplyLMSButton = uibutton(LMSPanel, 'Text', 'Apply');
    ApplyLMSButton.Layout.Row = 2;
    ApplyLMSButton.Layout.Column = 4;

    % 3. Smooth - Moving Average
    MoveAvrPanel = uigridlayout(MoveAvrPanel);
    MoveAvrPanel.RowHeight = {25, 25};
    MoveAvrPanel.ColumnWidth = {100 '1x'};

    % 3.1. Window Size
    WindowLabel = uilabel(MoveAvrPanel, "Text", "Window Size [sec]");
    WindowLabel.Layout.Row = 1;
    WindowLabel.Layout.Column = 1;

    WindowField = uieditfield(MoveAvrPanel, 'numeric');
    WindowField.Layout.Row = 1;
    WindowField.Layout.Column = 2;

    % 3.2 Apply Button
    ApplySmoothButton = uibutton(MoveAvrPanel, 'Text', 'Apply');
    ApplySmoothButton.Layout.Row = 2;
    ApplySmoothButton.Layout.Column = 2;

    % 4. Peak Detect
    PeakDetectPanel = uigridlayout(PeakDetectPanel);
    PeakDetectPanel.RowHeight = {30, 25, 25, 25};
    PeakDetectPanel.ColumnWidth = {35, 35, 35, 35, 35, 35};
    
    % 4.1 Min Peak Distance
    MinPeakLabel = uilabel(PeakDetectPanel, 'Text', 'Min Peak Distance [sec]', 'WordWrap','on');
    MinPeakLabel.Layout.Row = 1;
    MinPeakLabel.Layout.Column = [1 2];

    MinPeakField = uieditfield(PeakDetectPanel, 'numeric');
    MinPeakField.Layout.Row = 1;
    MinPeakField.Layout.Column = 3;

    % 4.2 Min Amplitude
    MinAmpLabel = uilabel(PeakDetectPanel, 'Text', 'Min Amplitude');
    MinAmpLabel.Layout.Row = 1;
    MinAmpLabel.Layout.Column = [4 5];

    MinAmpField = uieditfield(PeakDetectPanel, 'numeric');
    MinAmpField.Layout.Row = 1;
    MinAmpField.Layout.Column = 6;

    % 4.3 Apply Buttom
    ApplyPeakButton = uibutton(PeakDetectPanel, 'Text', 'Apply');
    ApplyPeakButton.Layout.Row = 2;
    ApplyPeakButton.Layout.Column = [5 6];

    % 4.4 Status
    StatusLabel = uilabel(PeakDetectPanel, 'Text', 'Detect:');
    StatusLabel.Layout.Row = 3;
    StatusLabel.Layout.Column = [1 2];

    StatusFeild = uilabel(PeakDetectPanel, 'Text', '0 inhale, 0 exhale');
    StatusFeild.Layout.Row = 3;
    StatusFeild.Layout.Column = [3 6];

    % 4.5 Manual Edit
    ManualEditButton = uibutton(PeakDetectPanel, 'Text', 'Manual Edit', 'Enable', 'off');
    ManualEditButton.Layout.Row = 4;
    ManualEditButton.Layout.Column = [1 3];

    AddMaxButton = uibutton(PeakDetectPanel, 'Text', 'Add Maximum','Visible','off');
    AddMaxButton.Layout.Row = 4;
    AddMaxButton.Layout.Column = [1 3];

    AddMinButton = uibutton(PeakDetectPanel, 'Text', 'Add Minimum', 'Visible','off');
    AddMinButton.Layout.Row = 5;
    AddMinButton.Layout.Column = [1 3];

    % 4.6 Done Peaks
    DonePeaksButton = uibutton(PeakDetectPanel, 'Text', 'Done', 'Enable', 'off');
    DonePeaksButton.Layout.Row = 4;
    DonePeaksButton.Layout.Column = [4 6];
    
    % 5. Save & Reset
    SavePanel = uigridlayout(SavePanel);
    SavePanel.RowHeight = {35};
    SavePanel.ColumnWidth = {100, 35, 100};

    % 5.1 Reset Button
    ResetButton = uibutton(SavePanel, 'Text', 'Reset All');
    ResetButton.Layout.Row = 1;
    ResetButton.Layout.Column = 1;

    % 5.2 Save Button
    SaveButton = uibutton(SavePanel, 'Text', 'Save Results');
    SaveButton.Layout.Row = 1;
    SaveButton.Layout.Column = 3;    
   
    %% Right Panel - Display
    % 1. Raw Signal Display
    rawPanel = uigridlayout(rawPanel);
    rawPanel.RowHeight = {'1x'};
    rawPanel.ColumnWidth = {'1x'};
    rawAxes = uiaxes(rawPanel);
    rawAxes.Layout.Row = 1;
    rawAxes.Layout.Column = 1;
    title(rawAxes, 'Raw Signal');
    xlabel(rawAxes, 'Time [sec]');
    ylabel(rawAxes, 'Resp');
    grid(rawAxes, "on");

    % 2. Current Signal Display
    currentPanel = uigridlayout(currentPanel);
    currentPanel.RowHeight = {'1x'};
    currentPanel.ColumnWidth = {'1x'};
    currentAxes = uiaxes(currentPanel);
    currentAxes.Layout.Row = 1;
    currentAxes.Layout.Column = 1;
    title(currentAxes, 'Current Signal');
    xlabel(currentAxes, 'Time [sec]');
    ylabel(currentAxes, 'Resp');    
    grid(currentAxes, "on");

    %% Create Gui Functions
    % 1. Load Subject
    LoadButton.ButtonPushedFcn = @LoadButtonPushed;

    function LoadButtonPushed(~, ~)
        subject = SubjectDropDown.Value;
        condition = ConditionDropDown.Value;
        test = TestDropDown.Value;
        
        traildata = struct();
        traildata.Subject = subject;
        traildata.Session = "Experiment";
        traildata.Condition = condition;
        traildata.Test = test;
        
        [raw_time, raw_signal, raw_fs] = LoadRespData(traildata);
        
        subject_structure.traildata = traildata;
        subject_structure.raw.raw_time = raw_time;
        subject_structure.raw.raw_signal = raw_signal;
        subject_structure.raw.raw_fs = raw_fs;

        subject_structure = EventTagGUI(subject_structure);
        cla(rawAxes);
        plot(rawAxes, raw_time, raw_signal);
        xlim(currentAxes, [0, subject_structure.raw.raw_time(end)])

        subject_structure = PreProcessGUI(subject_structure);
        cla(currentAxes);
        plot(currentAxes, subject_structure.preprocess.time, subject_structure.preprocess.signal);
        xlim(currentAxes, [0, subject_structure.preprocess.time(end)])
    end
    
    % 2. Filter LMS
    ApplyLMSButton.ButtonPushedFcn = @ApplyLMSButtonPushed;

    function ApplyLMSButtonPushed(~, ~)
        M = MField.Value;
        mu = muField.Value;

        subject_structure = FilterLMSGUI(subject_structure, M, mu);
        cla(currentAxes);
        plot(currentAxes, subject_structure.preprocess.time, subject_structure.preprocess.signal);
        xlim(currentAxes, [0, subject_structure.preprocess.time(end)])
    end

    % 3. Smooth
    ApplySmoothButton.ButtonPushedFcn = @ApplySmoothButtonPushed;

    function ApplySmoothButtonPushed(~, ~)
        wind_size = WindowField.Value;

        subject_structure = SmoothSignalGUI(subject_structure, wind_size);
        plot(currentAxes, subject_structure.preprocess.time, subject_structure.preprocess.signal);
        xlim(currentAxes, [0, subject_structure.preprocess.time(end)])
    end
    
    % 4. Peak Detect
    % 4.1 Apply Button
    ApplyPeakButton.ButtonPushedFcn = @ApplyPeakButtonPushed;

    function ApplyPeakButtonPushed(~, ~)
        minPeakDist = MinPeakField.Value;
        minAmp = MinAmpField.Value;
        subject_structure = PeakDetectGUI(subject_structure, minPeakDist, minAmp);
        
        cla(currentAxes);
        plot(currentAxes, subject_structure.preprocess.time, subject_structure.preprocess.signal, 'HitTest','off');
        hold(currentAxes, "on");
        scatter(currentAxes, subject_structure.peaks_data.in.t, subject_structure.peaks_data.in.v, 'red');
        hold(currentAxes, "on");
        scatter(currentAxes, subject_structure.peaks_data.ex.t, subject_structure.peaks_data.ex.v, 'blue');
        legend(currentAxes, "respiration signal" ,"end of aspiration", "end of expiration");
        xlim(currentAxes, [0, subject_structure.preprocess.time(end)]);
        StatusFeild.Text = subject_structure.peaks_data.in.N + " inhale, " + subject_structure.peaks_data.ex.N +  " exhale";
        ManualEditButton.Enable = "on";
        DonePeaksButton.Enable = "on";
    end
    
    ManualEditButton.ButtonPushedFcn = @ApplyManualEditButtonPushed;
    DonePeaksButton.ButtonPushedFcn = @DonePeaksButtonPushed;
    function ApplyManualEditButtonPushed(~, ~)
        AddMaxButton.Visible = "on";
        AddMinButton.Visible = "on";

        AddMaxButton.ButtonPushedFcn = @AddMaxButtonPushed;
        AddMinButton.ButtonPushedFcn = @AddMinButtonPushed;

        function AddMaxButtonPushed(~, ~)
            currentAxes.ButtonDownFcn = @CurrentAxesClicked;
            function CurrentAxesClicked(~,event)
                clickedX = event.IntersectionPoint(1);
                clickedX = round(interp1(subject_structure.preprocess.time, 1:numel(subject_structure.preprocess.time), clickedX, 'nearest', 'extrap'));
                new_t = subject_structure.preprocess.time(clickedX);
                new_v = subject_structure.preprocess.signal(clickedX);

                subject_structure.peaks_data.in.t = [subject_structure.peaks_data.in.t; new_t];
                subject_structure.peaks_data.in.v = [subject_structure.peaks_data.in.v; new_v];
                subject_structure.peaks_data.in.N = subject_structure.peaks_data.in.N + 1;
                scatter(currentAxes, new_t, new_v, 'red');
                legend(currentAxes, "Respiration Signal" ,"End of Aspiration", "End of Expiration");
            end            
        end
        function AddMinButtonPushed(~, ~)
            currentAxes.ButtonDownFcn = @CurrentAxesClicked;
            function CurrentAxesClicked(~,event)
                clickedX = event.IntersectionPoint(1);
                clickedX = round(interp1(subject_structure.preprocess.time, 1:numel(subject_structure.preprocess.time), clickedX, 'nearest', 'extrap'));
                new_t = subject_structure.preprocess.time(clickedX);
                new_v = subject_structure.preprocess.signal(clickedX);
                subject_structure.peaks_data.ex.t = [subject_structure.peaks_data.ex.t; new_t];
                subject_structure.peaks_data.ex.v = [subject_structure.peaks_data.ex.v; new_v];
                subject_structure.peaks_data.ex.N = subject_structure.peaks_data.ex.N + 1;
                scatter(currentAxes, new_t, new_v, 'blue');
                legend(currentAxes, "Respiration Signal" ,"End of Aspiration", "End of Expiration");
            end            
        end
    end
    function DonePeaksButtonPushed(~, ~)
        [subject_structure.peaks_data.in.t, idx] = sort(subject_structure.peaks_data.in.t);
        subject_structure.peaks_data.in.v = subject_structure.peaks_data.in.v(idx);
        [subject_structure.peaks_data.ex.t, idx] = sort(subject_structure.peaks_data.ex.t);
        subject_structure.peaks_data.ex.v = subject_structure.peaks_data.ex.v(idx);
        StatusFeild.Text = subject_structure.peaks_data.in.N + " inhale, " + subject_structure.peaks_data.ex.N +  " exhale";
        msgbox('Peaks saved successfully');
    end

    % 5. Save & Reset
    % 5.1 Reset
    ResetButton.ButtonPushedFcn = @ResetButtonPushed;
    function ResetButtonPushed(~, ~)
        subject_structure = struct();
        cla(rawAxes);
        cla(currentAxes);
    end

    % 5.2 Save
    SaveButton.ButtonPushedFcn = @SaveButtonPushed;
    function SaveButtonPushed(~, ~)
        path = "C:\Users\תבל\Desktop\Tevel Zamir\1. BioMedical Engineering\4th Year\Final Project\Data\MatlabData_Vers2\1. Subjects Structs after PreProcess\";
        file_name = path + subject_structure.traildata.Subject + "\" + subject_structure.traildata.Subject + subject_structure.traildata.Condition + subject_structure.traildata.Test + "_data.mat";
        save(file_name, 'subject_structure');
        msgbox('Data saved successfully');
    end
end