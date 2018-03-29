# https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html
function dynamo(){
  pushd $(pwd)
  cd ~/.dynamodb_local
  java -Djava.library.path=./DynamoDBLocal_lib/ -jar DynamoDBLocal.jar -sharedDb
  popd
}
