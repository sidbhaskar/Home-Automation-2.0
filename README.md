![WhatsApp Image 2024-07-31 at 12 35 24_cdcde676](https://github.com/user-attachments/assets/e7d18bb0-73d0-462a-bae0-b7bc671be0fe)

# IntelliNest (Smart Home Automation System)

Overview:
IntelliNest is an advanced home automation system powered by an ESP32 microcontroller. It integrates various sensors and provides users with the ability to control home appliances via a mobile app or website. Additionally, it offers real-time alerts for critical situations, ensuring enhanced safety and convenience.
## Key Features:

#### Central Control Hub:

- Powered by an ESP32 microcontroller.
- Integrates seamlessly with various sensors for comprehensive home automation.
#### Sensor Integration:

- DHT-11 Sensor: Monitors temperature and humidity levels.
- Water Depth Sensor: Tracks water levels to prevent overflow or flooding.
- MQ2 Gas Sensor: Detects gas leaks for safety alerts.
#### Remote Control:

- Control lights and electrical appliances remotely via a mobile app or website.
- Secure internet-based connectivity for global access.
#### Safety Alerts:

- Fire detection through integrated sensors.
- Gas leakage alerts via the MQ2 sensor.
- Over-moistured soil warnings to prevent plant damage.
#### User Notifications:

- Real-time alerts sent directly to the user's mobile app or website dashboard.
- Ensures prompt response to potential hazards.

## Flowchart
![Screenshot 2024-08-10 221606](https://github.com/user-attachments/assets/dfaf61c3-64aa-4ece-aae1-a161902dfa69)

#### Mobile App Sends Data:

- The user interacts with the mobile app to set commands (e.g., turning lights on/off).
- The app sends this data (e.g., ON/OFF commands) to the Firebase database.
#### Firebase Database:

- The Firebase database stores the commands sent by the mobile app.
#### ESP32 Fetches Data:

- The ESP32 module continuously checks the Firebase database for new commands.
- It fetches the relevant data (e.g., commands for lights, fans, or appliances).
#### ESP32 Controls Relay Channels:

- Based on the fetched values, the ESP32 controls the relay channels.
- The relays then switch the connected lights, fans, or appliances on or off.
#### Appliances Operate:

- The lights, fans, and other appliances operate as per the commands received.



## Screenshots
         
<img src="https://github.com/user-attachments/assets/38d90e24-f1fe-4a87-97e9-e9c2ee6d01a3" width="200" height="400">  <img src="https://github.com/user-attachments/assets/204d23c5-1e8f-4919-98b3-848784ea8f5b" width="200" height="400">  <img src="https://github.com/user-attachments/assets/b80961cf-ef5c-4c3b-a709-1db7e25f9aab" width="200" height="400">






