ipfs --api /ip4/81.169.194.192/tcp/5001 files rm -r /ace
ipfs --api /ip4/81.169.194.192/tcp/5001 files mkdir /ace
ipfs --api /ip4/81.169.194.192/tcp/5001 files mkdir /ace/snippets

cd ace-1.4.8/src-min/
json="{\"version\":\"1.4.8\""

echo "Start uploading ACE Editor to ipfs"
for file in *.js ; 
do
   if [ "$file" != "ace.js" ]; then
      echo "Uploading $file to /ace/$file on ipfs"
      ipfs --api /ip4/81.169.194.192/tcp/5001 files write --create /ace/$file $file
      hash=`ipfs --api /ip4/81.169.194.192/tcp/5001 files stat /ace/$file --hash`
      json="$json,\"$file\":\"$hash\""
      echo $hash
      fi
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

echo "creating hash file and upload it to ipfs"
json="$json}"
cd ..
echo "$json" > ace.json
ipfs --api /ip4/81.169.194.192/tcp/5001 files write --create /ace/ace.json ace.json
echo "ace.json generated"

echo "updating ace.json hash into ace.js"
hash=`ipfs --api /ip4/81.169.194.192/tcp/5001 files stat /ace/ace.json --hash`
echo $hash
search="###HASHES###"

sed "s&$search&$hash&g" ace.js > out.js
rm ace.js
mv out.js ace.js
echo "uploading new ace version"
ipfs --api /ip4/81.169.194.192/tcp/5001 files write --create /ace/ace.js ace.js
hash=`ipfs --api /ip4/81.169.194.192/tcp/5001 files stat /ace/ace.js --hash`
echo "New ipfs version of ace can be accessed with $hash"