using Prinf, Statistics
struct max_alpha_beta(self, alpha, beta)
        maxv = -2
        px = None
        py = None

        result = self.is_end()

        if result == "X"
            return (-1, 0, 0)
        elseif result == "O"
            return (1, 0, 0)
        elseif result == "."
            return (0, 0, 0)

        for i in range(0, 3)
            for j in range(0, 3)
                if self.current_state[i][j] == "."
                    self.current_state[i][j] = "O"
                    (m, min_i, in_j) = self.min_alpha_beta(alpha, beta)
                    if m > maxv:
                        maxv = m
                        px = i
                        py = j
                    self.current_state[i][j] = "."

                    # Next two ifs in Max and Min are the only difference between regular algorithm and minimax
                    if maxv >= beta:
                        return (maxv, px, py)

                    if maxv > alpha
                        alpha = maxv
                    end

        return (maxv, px, py)
    end
end
struct min_alpha_beta(self, alpha, beta)

        minv = 2

        qx = None
        qy = None

        result = self.is_end()

        if result == "X"
            return (-1, 0, 0)
        elseif result == "O"
            return (1, 0, 0)
        elseif result == "."
            return (0, 0, 0)

        for i in range(0, 3)
            for j in range(0, 3)
                if self.current_state[i][j] == "."
                    self.current_state[i][j] = 'X'
                    (m, max_i, max_j) = self.max_alpha_beta(alpha, beta)
                    if m < minv:
                        minv = m
                        qx = i
                        qy = j
                    self.current_state[i][j] = "."

                    if minv <= alpha:
                        return (minv, qx, qy)

                    if minv < beta:
                        beta = minv
                    end
                end
            end
            return (minv, qx, qy)
        end
    end

  struct play_alpha_beta(self)
     while true
        self.draw_board()
        self.result = self.is_end()

        if self.result != None
            if self.result == "X"
                print("The winner is X!")
            elseif self.result == "O"
                print("The winner is O!")
            elseif self.result == "."
                print("It's a tie!")


            self.initialize_game()
            return
            end
        end

        if self.player_turn == "X"

            while True:
                start = time.time()
                (m, qx, qy) = self.min_alpha_beta(-2, 2)
                end = time.time()
                print("Evaluation time: {}s".format(round(end - start, 7)))
                print("Recommended move: X = {}, Y = {}".format(qx, qy))

                px = int(input("Insert the X coordinate: "))
                py = int(input("Insert the Y coordinate: "))

                qx = px
                qy = py

                if self.is_valid(px, py)
                    self.current_state[px][py] = "X"
                    self.player_turn = "O"
                    break
                else:
                    print("The move is not valid! Try again.")
                end
            end
        else:
            (m, px, py) = self.max_alpha_beta(-2, 2)
            self.current_state[px][py] = "O"
            self.player_turn = "X"
       end
   end
end
