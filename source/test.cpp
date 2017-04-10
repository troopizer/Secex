#include <iostream>
#include <stdlib.h>
#include "Secex.h"

int main(int argc, char* argv[])
{
	// parameters
	char dpath[]  = "/dev/ttyACM0";
	int baud_rate = 9600;

	char * path = (argc > 1)? argv[1]: dpath;
	baud_rate   = (argc > 2)? atoi(argv[2]): baud_rate;

	// variables
	char buffer[257] = "comunicating0";
	int size_buffer  = 13;

	// communication
	int fd = secex::open_arduino(path, baud_rate);

	if (!secex::device_open(fd)) {
		std::cout << "Coudln't open " << path << std::endl;
		return 1;
	}
	std::cout << "Device open: " << path << std::endl;

	secex::block_write(fd, buffer, size_buffer);
	for (;;usleep(50)) {
		if (!secex::block_read(fd, buffer, 12)) {
			std::cout  << path << " is closed\n" << std::endl;
			return 2;
		}

		buffer[size_buffer-1] = '\0';
		std::cout << buffer << std::endl;
		buffer[size_buffer-1] = '0';

		if (!secex::block_write(fd, buffer, size_buffer)) {
			std::cout << dpath << " was closed while writing" << std::endl;
			return 3;
		}
	}

	// close serial
	secex::close_arduino(fd);


	return 0;
}