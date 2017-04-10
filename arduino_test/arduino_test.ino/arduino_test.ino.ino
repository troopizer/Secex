
const char C_END = 0x30;

char buff[25] = {};
int size_buff = 0;
char c;

void setup()
{
  Serial.begin(9600);
}

void loop()
{
  delay(100);
  
  if (Serial.available()<1) return;
  
  size_buff = 0;
  while ((c = Serial.read()) != C_END) {
    if (c < 0) continue;
    buff[size_buff++] = c;
  }
  Serial.write(buff, size_buff);
  Serial.flush();
}
