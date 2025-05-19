# Radar-system

🛠️ What is it?
The Radar Simulation System is a beginner-friendly electronics project that simulates a basic radar setup. It uses an ultrasonic sensor (HC-SR04) mounted on a servo motor, controlled by an Arduino, to scan for nearby objects. This data is then sent to a computer and visualized in real-time using Processing IDE as a sweeping radar interface — just like a real air defense system.

🔧 Components Required

| Component                    | Quantity |
|------------------------------|----------|
| Arduino Uno / Nano           | 1        |
| HC-SR04 Ultrasonic Sensor    | 1        |
| Servo Motor (SG90 or MG996R) | 1        |
| Jumper Wires                 | as needed|
| Breadboard                   | 1        |
| USB Cable                    | 1        |
| Computer with Processing IDE | 1        |


## 🖥️ How It Works:

1. The **servo motor** sweeps the ultrasonic sensor across 0° to 180°.
2. The **sensor** reads the distance to any object in its path.
3. The **Arduino** sends angle and distance via Serial in the format:  
   `angle,distance.`
4. The **Processing** script reads this and displays it as a radar on screen with a plane icon and distance visualization.


## 🚀 Steps to Build (For Beginners)

1. **Setup Arduino IDE**  
   Upload the `radar.ino` sketch to your Arduino.

2. **Install Processing IDE**  
   Download from: [https://processing.org/download](https://processing.org/download)

3. **Add Image**  
   Place `plane.png` in the same folder as your processing code file.

4. **Connect your circuit**  
   Wire everything as shown in the circuit diagram.

5. **Run Processing Sketch**  
   Make sure to update the COM port in `Serial myPort = new Serial(this, "COMX", 9600);`.

6. **Watch it in action!**  
   The radar interface will display object detection with a cool visual.

---

## 🎯 Project Highlights

- Real-time radar simulation
- Object detection with range visualization
- Rotating servo mechanism
- Processing-based GUI
- Tribute to India’s defense system 💂‍♂️



## 🙌 Credits

This project is **Ft. Sudarshan Chakra** – a symbolic tech tribute to **India’s advanced defense systems** and **Op Sindoor Chakra**.

---

## 📌 Tags

`#RadarSimulation` `#ArduinoProject` `#IoT` `#ElectronicsForBeginners` `#S400Inspired` `#TheStudentProjects`
