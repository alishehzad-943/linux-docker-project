#!/bin/bash

#Project1 Script

echo "Starting Project1 Automation"

# Step 1: Update and install Docker
echo "Updating system and installing Docker"
sudo yum  update -y
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
docker --version

# Step 2: Create project folders
echo "Creating project structure"
mkdir -p ~/Project1/Docker1 ~/Project1/Docker2 ~/Project1/Docker3

# Step 3: Create files with content
# Docker1 files
cat <<EOL > ~/Project1/Docker1/aviana.txt
Atticus said to Jem one day, I’d rather you shot at tin cans in the backyard, but I know you’ll go after birds. Shoot all the blue jays you want, if you can hit ‘em, but remember it’s a sin to kill a mockingbird.
EOL

cat <<EOL > ~/Project1/Docker1/bryant.txt
That was the only time I ever heard Atticus say it was a sin to do something, and I asked Miss Maudie about it.
EOL

cat <<EOL > ~/Project1/Docker1/kyron.txt
“Your father’s right,” she said. “Mockingbirds don’t do one thing except make music for us to enjoy.
EOL

cat <<EOL > ~/Project1/Docker1/Rowland.txt
They don’t eat up people’s gardens, don’t nest in corn cribs, they don’t do one thing but sing their hearts out for us.
EOL

cat <<EOL > ~/Project1/Docker1/Suhayb.txt
That’s why it’s a sin to kill a mockingbird.
EOL

# Docker2 files
cat <<EOL > ~/Project1/Docker2/Aaisha.txt
The most important things are the hardest to say. They are the things you get ashamed of, because words diminish them — words shrink things that seemed limitless when they were in your head to no more than living size when they’re brought out.
EOL

cat <<EOL > ~/Project1/Docker2/Aleah.txt
But it’s more than that, isn’t it?
EOL

cat <<EOL > ~/Project1/Docker2/Arnold.txt
The most important things lie too close to wherever your secret heart is buried, like landmarks to a treasure your enemies would love to steal away.
EOL

cat <<EOL > ~/Project1/Docker2/Hall.txt
And you may make revelations that cost you dearly only to have people look at you in a funny way, not understanding what you’ve said at all, or why you thought it was so important that you almost cried while you were saying it.
EOL

cat <<EOL > ~/Project1/Docker2/Rhea.txt
That’s the worst, I think.
EOL

cat <<EOL > ~/Project1/Docker2/Skinner.txt
When the secret stays locked within not for want of a teller but for want of an understanding ear.
EOL

# Docker3 files
cat <<EOL > ~/Project1/Docker3/Chan.txt
“Sometimes fate is like a small sandstorm that keeps changing directions. You change direction but the sandstorm chases you. You turn again, but the storm adjusts. Over and over you play this out, like some ominous dance with death just before dawn.
EOL

cat <<EOL > ~/Project1/Docker3/Costa.txt
Why? Because this storm isn’t something that blew in from far away, something that has nothing to do with you. This storm is you. Something inside of you.
EOL

cat <<EOL > ~/Project1/Docker3/Cydney.txt
So all you can do is give in to it, step right inside the storm, closing your eyes and plugging up your ears so the sand doesn’t get in, and walk through it, step by step.
EOL

cat <<EOL > ~/Project1/Docker3/Frederick.txt
There’s no sun there, no moon, no direction, no sense of time. Just fine white sand swirling up into the sky like pulverized bones. That’s the kind of sandstorm you need to imagine.
EOL

cat <<EOL > ~/Project1/Docker3/Hampton.txt
And you really will have to make it through that violent, metaphysical, symbolic storm. No matter how metaphysical or symbolic it might be, make no mistake about it: it will cut through flesh like a thousand razor blades.
EOL

cat <<EOL > ~/Project1/Docker3/Jane.txt
People will bleed there, and you will bleed too. Hot, red blood. You’ll catch that blood in your hands, your own blood and the blood of others.
EOL

cat <<EOL > ~/Project1/Docker3/Luna.txt
And once the storm is over you won’t remember how you made it through, how you managed to survive. You won’t even be sure, in fact, whether the storm is really over.
EOL

cat <<EOL > ~/Project1/Docker3/Yassin.txt
But one thing is certain. When you come out of the storm you won’t be the same person who walked in. That’s what this storm’s all about.
EOL

# Step 4: Launch Docker containers and iamge download 
docker pull ubuntu
echo "Launching Docker containers..."
cd ~/Project1
sudo docker run -dit --name cont1 -v $(pwd)/Docker1:/texts ubuntu bash
sudo docker run -dit --name cont2 -v $(pwd)/Docker2:/texts ubuntu bash
sudo docker run -dit --name cont3 -v $(pwd)/Docker3:/texts ubuntu bash
sudo docker ps

# Step 5: Sort files for SJN (Student Id last digit 6)
echo "Sorting Docker2 and Docker3 files by size"
sudo docker exec cont2 bash -c "ls -l /texts | sort -k5n"
sudo docker exec cont3 bash -c "ls -l /texts | sort -k5n"

# Step 6: Round Robin Merge (quantum = 2)
echo "Combining files using Round Robin"
cd ~/Project1
touch  HOUSE_OF_THE_DOCKERS.txt

# Round 1
cat Docker1/aviana.txt Docker1/bryant.txt >>  HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker2 | head -n 2 | xargs -I{} echo Docker2/{}) >>  HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker3 | head -n 2 | xargs -I{} echo Docker3/{}) >>  HOUSE_OF_THE_DOCKERS.txt

# Round 2
cat Docker1/kyron.txt Docker1/Rowland.txt >>  HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker2 | sed -n '3,4p' | xargs -I{} echo Docker2/{}) >>  HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker3 | sed -n '3,4p' | xargs -I{} echo Docker3/{}) >>  HOUSE_OF_THE_DOCKERS.txt
# Round 3
cat Docker1/Suhayb.txt >> HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker2 | sed -n '5,6p' | xargs -I{} echo Docker2/{}) >>  HOUSE_OF_THE_DOCKERS.txt
cat $(ls -S Docker3 | sed -n '5,8p' | xargs -I{} echo Docker3/{}) >>  HOUSE_OF_THE_DOCKERS.txt

echo "Round Robin complete. Final book created:  HOUSE_OF_THE_DOCKERS.txt"

# Step 7: Interactive options
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

# Step 8: complete
echo "Automation complete."
