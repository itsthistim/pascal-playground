program TicTacToe;
uses Crt;

const
    PLAYER_X = 'X';
    PLAYER_O = 'O';

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

function chooseMove(board: array of char): integer;
var
    position: integer;
begin
    for position := 0 to 8 do
    begin
        if board[position] = ' ' then
        begin
            // check if move is winning
            board[position] := PLAYER_O;
            if checkWin(board) then
            begin
                board[position] := ' ';
                exit(position);
            end;
            // check if move is blocking
            board[position] := PLAYER_X;
            if checkWin(board) then
            begin
                board[position] := ' ';
                exit(position);
            end;
            // reset board
            board[position] := ' ';
        end;
    end;
    exit (random(9));
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

        if turn mod 2 = 0 then // player X
            begin
                player := PLAYER_X;
                writeln('Player ', player, ', enter your move (0-8): ');
                readln(position);
                if (position < 0) or (position > 8) or (board[position] = PLAYER_X) or (board[position] = PLAYER_O) then
                begin
                    writeln('Invalid move! Try again.');
                    continue;
                end;
            end
        else // player O
            begin
                player := PLAYER_O;
                position := chooseMove(board);
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
