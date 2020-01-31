ipfs --api /ip4/81.169.194.192/tcp/5001 files rm -r /ace
ipfs --api /ip4/81.169.194.192/tcp/5001 files mkdir /ace
ipfs --api /ip4/81.169.194.192/tcp/5001 files mkdir /ace/snippets

cd ace-1.4.8/src-noconflict/
json="{\"version\":\"1.4.8\""

for file in *.js ; 
do
   echo "Uploading $file to /ace/$file on ipfs"
   ipfs --api /ip4/81.169.194.192/tcp/5001 files write --create /ace/$file $file
   hash=`ipfs --api /ip4/81.169.194.192/tcp/5001 files stat /ace/$file --hash`
   json="$json,\"$file\":\"$hash\""
   echo $hash
done 

cd snippets
for file in *.js ; 
do
  echo "Uploading $file to /ace/snippets/$file on ipfs"
   ipfs --api /ip4/81.169.194.192/tcp/5001 files write --create /ace/snippets/$file $file
   hash=`ipfs --api /ip4/81.169.194.192/tcp/5001 files stat /ace/snippets/$file --hash`
   json="$json,\"$file\":\"$hash\""
   echo $hash
done

json="$json}"
cd ..
echo "$json" > ace.json
ipfs --api /ip4/81.169.194.192/tcp/5001 files write --create /ace/ace.json ace.json
echo "ace.json uploaded with hash"
echo `ipfs --api /ip4/81.169.194.192/tcp/5001 files stat /ace/ace.json --hash`