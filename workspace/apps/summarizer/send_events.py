#!/usr/bin/env python
import io
from kafka import KafkaConsumer

def read_file(filename, encoding="utf-8-sig"):
    """Read text from a file."""
    with io.open(filename, encoding=encoding) as f:
        return f.readlines()

def send_events(file_name):
    lines=read_file(file_name)
    print(len(lines))

    from kafka import KafkaProducer
    producer = KafkaProducer(value_serializer=lambda v: v.encode('utf-8'))
    for line in lines:
        producer.send('events', line)

    # >>> # Block until all pending messages are at least put on the network
    # >>> # NOTE: This does not guarantee delivery or success! It is really
    # >>> # only useful if you configure internal batching using linger_ms
    producer.flush()

if __name__ == '__main__':    
    # send_events("./events/file-0.json")
    send_events("./events/file-1.json")

