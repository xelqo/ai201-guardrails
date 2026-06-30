#!/bin/bash
BASE="http://localhost:5001"

echo "=== 1. Submit clearly-human text ==="
curl -s -X POST $BASE/submit -H "Content-Type: application/json" \
  -d '{"text": "ok so i tried that ramen place and honestly it was kinda mid, too salty, probably wont go back", "creator_id": "demo-user"}' | python3 -m json.tool

echo ""
echo "=== 2. Submit clearly-AI text (capturing its content_id) ==="
CID=$(curl -s -X POST $BASE/submit -H "Content-Type: application/json" \
  -d '{"text": "In conclusion, it is important to note that organizations must leverage synergies. Moreover, stakeholders should optimize workflows. Furthermore, it is crucial to maximize efficiency.", "creator_id": "demo-user"}' \
  | python3 -c "import sys, json; print(json.load(sys.stdin)['content_id'])")
echo "Captured content_id: $CID"

echo ""
echo "=== 3. Appeal that AI verdict ==="
curl -s -X POST $BASE/appeal -H "Content-Type: application/json" \
  -d "{\"content_id\": \"$CID\", \"creator_reasoning\": \"I wrote this myself, I am a non-native English speaker.\"}" | python3 -m json.tool

echo ""
echo "=== 4. Show the audit log ==="
curl -s $BASE/log | python3 -m json.tool
