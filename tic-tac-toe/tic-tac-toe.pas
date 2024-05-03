program TicTacToe;
uses Crt;

procedure drawBoard(board: array of char);
begin
    writeln(' ', board[0], ' | ', board[1], ' | ', board[2]);
    writeln('---|---|---');
    writeln(' ', board[3], ' | ', board[4], ' | ', board[5]);
    writeln('---|---|---');
    writeln(' ', board[6], ' | ', board[7], ' | ', board[8]);
end;

function checkWin(board: array of char): boolean;
var
    i: integer;
begin
    for i := 0 to 2 do
    begin
        if (board[i] <> ' ') and (board[i] = board[i + 3]) and (board[i] = board[i + 6]) then
        begin
            exit(true);
        end;

        if (board[i * 3] <> ' ') and (board[i * 3] = board[i * 3 + 1]) and (board[i * 3] = board[i * 3 + 2]) then
        begin
            exit(true);
        end;
    end;

    if (board[0] <> ' ') and (board[0] = board[4]) and (board[0] = board[8]) then
    begin
        exit(true);
    end;

    if (board[2] <> ' ') and (board[2] = board[4]) and (board[2] = board[6]) then
    begin
        exit(true);
    end;

    exit(false);
end;

type
    ch_array = array[0..8] of char;
var
    turn, i: integer;
    board: ch_array;
    position: integer;
    player: char;
begin
    randomize;
    turn := 0;

    for i := 0 to 8 do
        board[i] := ' ';

    repeat
        clrscr;
        drawBoard(board);

        if turn mod 2 = 0 then
            begin
                player := chr(88);
                writeln('Player ', player, ', enter your move (0-8): ');
                readln(position);
                if (position < 0) or (position > 8) or (board[position] = 'X') or (board[position] = 'O') then
                begin
                    writeln('Invalid move! Try again.');
                    continue;
                end;
            end
        else
            begin
                player := chr(79);
                position := random(9);
                while (board[position] = 'X') or (board[position] = 'O') do
                    position := random(9);
            end;

        board[position] := player;

        // check for win
        if checkWin(board) then
        begin
            clrscr;
            drawBoard(board);
            writeln('Player ', player, ' wins!');
            break;
        end;

        // check for draw
        if turn = 8 then
        begin
            clrscr;
            drawBoard(board);
            writeln('It''s a draw!');
            break;
        end;

        turn := turn + 1;
    until false;
    readkey;
end.
