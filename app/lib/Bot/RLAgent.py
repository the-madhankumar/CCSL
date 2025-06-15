import firebase_admin
from firebase_admin import credentials, db

cred = credentials.Certificate("D:/projects/Project CCSL/app/serviceAccount.json")

firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://ccsl-909d7-default-rtdb.firebaseio.com/'
})

ref = db.reference('RLAgentData')

turns = [1, 2, 3, 4, 5, 6]
powerCards = [0, 1, 2]
cooldowns = [0, 1]
freeHits = [0, 1]

rl_agent_data = {}

for t in turns:
    for p in powerCards:
        for c in cooldowns:
            for f in freeHits:
                key = f'T{t}_P{p}_C{c}_F{f}'
                rl_agent_data[key] = {
                    "0": 0.0,
                    "1": 0.0,
                    "2": 0.0,
                    "3": 0.0,
                    "4": 0.0,
                    "6": 0.0
                }

ref.set(rl_agent_data)
print(f"✅ RL Q-table uploaded ({len(rl_agent_data)} states)")
