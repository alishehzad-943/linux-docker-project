#!/bin/bash
# PROJECT: HOUSE OF THE DOCKERS
#STEP 1: Install Docker and start 
sudo yum update -y
sudo yum upgrade -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
docker -v

#  STEP 2: Create File Structure 
mkdir -p ~/Docker-files/{Docker1,Docker2,Docker3}
cd ~/Docker-files

#STEP 3: Create Text Files and paste content
#Docker1 files
cd Docker1
echo "Atticus said to Jem one day, I’d rather you shot at tin cans in the backyard, but I know you’ll go after birds.Shoot all the blue jays you want, 
if you can hit ‘em, but remember it’s a sin to kill a mockingbird." > Aviana.txt
echo "That was the only time I ever heard Atticus say it was a sin to do something, and I asked Miss Maudie about it." > Bryant.txt
echo "Your father’s right,” she said. “Mockingbirds don’t do one thing except make music for us to enjoy." > Kyron.txt
echo "They don’t eat up people’s gardens, don’t nest in corn cribs, they don’t do one thing but sing their hearts out for us. " > Rowland.txt
echo "That’s why it’s a sin to kill a mockingbird." > Suhayb.txt

#  Docker2 files
cd ../Docker2
echo "The most important things are the hardest to say. They are the things you get ashamed of, because words diminish them — 
words shrink things that seemed limitless when they were in your head to no more than living size when they’re brought out." > Aaisha.txt
echo "But it’s more than that, isn’t it?" > Aleah.txt
echo "The most important things lie too close to wherever your secret heart is buried, like landmarks to a treasure your enemies would love to steal away." > Arnold.txt
echo "And you may make revelations that cost you dearly only to have people look at you in a funny way, not understanding what you’ve said at all, 
or why you thought it was so important that you almost cried while you were saying it." > Hall.txt
echo "That’s the worst, I think." > Rhea.txt
echo "When the secret stays locked within not for want of a teller but for want of an understanding ear." > Skinner.txt

# Docker3 files
cd ../Docker3
echo "Sometimes fate is like a small sandstorm that keeps changing directions. You change direction but the sandstorm chases you. 
You turn again, but the storm adjusts.Over and over you play this out, like some ominous dance with death just before dawn." > Chan.txt
echo "Why? Because this storm isn’t something that blew in from far away, 
something that has nothing to do with you. This storm is you.Something inside of you. " > Costa.txt
echo "So all you can do is give in to it, step right inside the storm, 
closing your eyes and plugging up your ears so the sand doesn’t get in, and walk through it, step by step." > Cydney.txt
echo "There’s no sun there, no moon, no direction, no sense of time. Just fine white sand swirling up into the sky like pulverized bones. 
That’s the kind of sandstorm you need to imagine." > Frederick.txt
echo "And you really will have to make it through that violent, metaphysical, symbolic storm. No matter how metaphysical or symbolic it might be,
make no mistake about it: it will cut through flesh like a thousand razor blades." > Hampton.txt
echo "People will bleed there, and you will bleed too. Hot, red blood. 
You’ll catch that blood in your hands, your own blood and the blood of others." > Jane.txt
echo "And once the storm is over you won’t remember how you made it through, how you managed to survive. 
You won’t even be sure, in fact, whether the storm is really over." > Luna.txt
echo "But one thing is certain. When you come out of the storm you won’t be the same person who walked in. 
That’s what this storm’s all about." > Yassin.txt

#STEP 4: Build Docker Custom Image through Dockerfile
cd ~/Docker-files
echo "FROM ubuntu
WORKDIR /app
COPY . /app" > Dockerfile
sudo docker build -t my-image .

#STEP 5: Run three Containers
sudo docker run -dit --name container1 -v $(pwd)/Docker1:/app my-image bash
sudo docker run -dit --name container2 -v $(pwd)/Docker2:/app my-image bash
sudo docker run -dit --name container3 -v $(pwd)/Docker3:/app my-image bash

#STEP 6: Scheduling Simulation 
Student ID last Digit is equal to Zero(0)
# FCFS – Container1 (No sorting)
echo "FCFS (Container1)"
sudo docker exec container1 bash -c "ls -l /app"

# SJN – Container2 (Sort by file size)
echo "SJN (Container2) "
sudo docker exec container2 bash -c "ls -l /app | sort -k5n"

# SJN – Container3 (Sort by file size)
echo " SJN (Container3)"
sudo docker exec container3 bash -c "ls /app | sort  -k5n"

# STEP 7: Merging files in HOUSE_OF_THE_DOCKERS 
cd ~/Docker-files
touch HOUSE_OF_THE_DOCKERS.txt

# Combine files in FCFS order (Docker1)
cat Docker1/Aviana.txt Docker1/Bryant.txt >> HOUSE_OF_THE_DOCKERS.txt

# Combine shortest files first (Docker2)
cat $(ls -S Docker2 | head -n 3 | xargs -I{} echo Docker2/{}) >> HOUSE_OF_THE_DOCKERS.txt

# Combine few from Docker3 (Round Robin style)
cat $(ls Docker3 | sort | head -n 3 | xargs -I{} echo Docker3/{}) >> HOUSE_OF_THE_DOCKERS.txt

# ROUND 2 
cat Docker1/Kyron.txt Docker1/Rowland.txt >> HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker2 | sed -n '3,4p' | xargs -I{} echo Docker2/{}) >> HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker3 | sed -n '3,4p' | xargs -I{} echo Docker3/{}) >> HOUSE_OF_THE_DOCKERS.txt

# ROUND 3
cat Docker1/Suhayb.txt >> HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker2 | sed -n '5,6p' | xargs -I{} echo Docker2/{}) >> HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker3 | sed -n '5,8p' | xargs -I{} echo Docker3/{}) >> HOUSE_OF_THE_DOCKERS.txt

echo "Round Robin complete. Final book created:  HOUSE_OF_THE_DOCKERS.txt"

# Step 8: Interactive options
FINAL_BOOK=HOUSE_OF_THE_DOCKERS.txt
echo "Finished loading text."

while true; do
    echo "Would you like to read the final book? (Yes/No)"
    read choice
    if [[ "$choice" =~ ^([Yy][Ee][Ss]|[Yy])$ ]]; then
        cat $FINAL_BOOK
    fi

    echo "Would you like to remove any text? (Yes/No)"
    read choice
    if [[ "$choice" =~ ^([Yy][Ee][Ss]|[Yy])$ ]]; then
        echo "Enter exact text or pattern to remove:"
        read pattern
        sed -i "/$pattern/d" $FINAL_BOOK
        echo "Text removed."
    fi

    echo "Would you like to add any text? (Yes/No)"
    read choice
    if [[ "$choice" =~ ^([Yy][Ee][Ss]|[Yy])$ ]]; then
        echo "Enter text to add:"
        read new_text
        echo "$new_text" >> $FINAL_BOOK
        echo "Text added."
    fi

    echo "Would you like to terminate the program? (Yes/No)"
    read choice
    if [[ "$choice" =~ ^([Yy][Ee][Ss]|[Yy])$ ]]; then
        echo "Program terminated."
        break
    fi
done

# Step 9: complete
echo "SCRIPT EXECUTION COMPLETE"
