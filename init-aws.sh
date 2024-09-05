#!/bin/bash

awslocal dynamodb create-table \
    --table-name Thread \
    --attribute-definitions \
        AttributeName=ForumName,AttributeType=S \
        AttributeName=Subject,AttributeType=S \
        AttributeName=LastPostDateTime,AttributeType=S \
    --key-schema \
        AttributeName=ForumName,KeyType=HASH \
        AttributeName=Subject,KeyType=RANGE \
    --local-secondary-indexes \
        "IndexName=LastPostIndex,KeySchema=[{AttributeName=ForumName,KeyType=HASH},{AttributeName=LastPostDateTime,KeyType=RANGE}],Projection={ProjectionType=KEYS_ONLY}" \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --tags Key=Owner,Value=BlueTeam \
    --endpoint-url=http://localhost:4566