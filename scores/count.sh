while true; do
  google-chrome --headless --disable-gpu --screenshot http://url/;
  now=$(date +"%H:%M:%S")
  convert -quality 25 -strip screenshot.png "img/screenshot$now.jpg";
  sleep 5;
done

