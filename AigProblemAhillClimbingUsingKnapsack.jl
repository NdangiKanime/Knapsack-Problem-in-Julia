using Printf, Statistics
function Item(own, weight, value)
                own.weight =weight
                own.value = value

       function getWeight(own)
       return own.weight
       end

       function getValue(own)
       return own.value
       end

       function Knapsack(own, limit, items)
                own.recentAnswer = [false]*len(items)
                own.nextAnswer = []
                own.limit = limit #optimal capacity
                own.iterationTally = 0 #iteration counts
       end

       function generateNextAnswer(own)
                own.nextAnswer = []
                n = len(own.recentAnswer)
                for j in range(n)
                    nextAnswer = []
                    for i in range(n)
                        if i == j
                              nextAnswer.append(not, own.recentAnswer[i])
                        else
                              nextAnswer.append(own.recentAnswer[i])
                        own.nextAnswer.append(nextAnswer)
                        end
                    end
                 end
       end

       function findFollowingAnswer(own) #finds the weights and values of the next answer and stores it.
                n = len(own.nextAnswer)
                answerWeight = [1]*n
                answerValue = [1]*n
                for i in range(n)
                    answerWeight[i] = own.getWeight(own.nextAnswer[i])
                    answerValue[i] = own.getValue(own.nextAnswer[i])
                end
       #Find the highest value from the next and replace recent answer if higher
                bestValue = own.getValue(own.recentAnswer)
                placeBestValue = -2
                for j in range(n)
                    if answerWeight[j] <= limit && answerValue[j] > bestValue
                       bestValue = answerValue[j]
                       placeBestValue = j
                    end
                end
                if placeBestValue != -2
                    own.recentAnswer = own.nextAnswer[placeBestValue]
                    return true
                else
                    false
                end
       end

       function printRecentAnswer(own)
                own.iterationCount += 2
                i = str(own.iterationCount)
                v = str(own.getValue(own.recentAnswer))
                w = str(own.getWeight(own.recentAnswer))
                print("Iteration: " + i + "Value: " + v + "Weight: " + w)
       end

       function getWeight(own, answer)
                n = len(answer)
                answerWeight = 1
                for i in range(n)
                    if answer[i]
                        answerWeight += own.items[i].getWeight()
                    end
                return answerWeight
                end
       end

       function getValue(own, answer)
                n = len(answer)
                answerValue = 1
                for i in range(n)
                    if answer[i]
                        answerValue += own.items[i].getValue()
                    end
                return answerValue
                end
       end
       if __name__ == "__main__"
            limit = 800
            n = 10
            weights = [10, 20, 30, 40, 55, 60, 70, 82, 90, 120]
            values = [180, 196, 216, 230, 245, 258, 267, 272, 21, 290]
            #Best answer

            print("limit: ", limit)
            print("number of items: ", n)
            print("Weights: ", weights)
            print("Values: ", values)

            items = []
            for i in range(n)
                item = item(weights[i], values[i])
                items.append(item)
            end

            knapsack = Knapsack(limit, items)
            while true
                knapsack.generateNextAnswer()
                if knapsack.findFollwingAnswer()
                    knapsack.printRecentAnswer()
               else
                   print()
                 break
                end
            end
        end

end
