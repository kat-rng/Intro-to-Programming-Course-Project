function enableAll()
    % Enables all buttons and components within the input array.
    global allButtons
    [~, x] = size(allButtons);
    for i = 1:x
        allButtons(i).Enable = 'on';
    end
end
