### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Roman4466/RedRocketTestTask.git
   cd RedRocketTestTask
   ```

2. **Use correct flutter version**
   ```bash
    fvm use
   ```

3**Install dependencies**
   ```bash
   fvm flutter pub get
   ```

4**Generate code**
   ```bash
   fvm dart run build_runner watch --delete-conflicting-outputs
   ```

5**Generate localizations**
   ```bash
   fvm flutter gen-l10n
   ```

6**Run the app**
   ```bash
   fvm flutter run
   ```

## 🧪 Testing Credentials

The app includes a mock API with different test scenarios:

### **Valid Login**
- **Email**: `test@example.com`
- **Password**: `password123`
- **Result**: Successful authentication

### **Error Scenarios**

| Scenario | Email | Password | Expected Result |
|----------|-------|----------|-----------------|
| **Invalid Credentials** | `invalid@test.com` | `wrongpass` | Authentication error (no retry) |
| **Connection Timeout** | `timeout@test.com` | `password123` | Timeout error with retry button |
| **No Internet** | `noconnection@test.com` | `password123` | Connection error with retry |
| **Server Error** | `servererror@test.com` | `password123` | Server error (500) with retry |
| **Rate Limiting** | `ratelimit@test.com` | `password123` | Too many requests with retry |
