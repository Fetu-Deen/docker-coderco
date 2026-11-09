FROM alpine
RUN echo "Hello from inside the image" > /message.txt
CMD [ "cat", "/message.txt"]
