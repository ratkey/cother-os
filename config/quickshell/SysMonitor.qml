import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: monitor

    // Output properties that your bar will read
    property int cpuUsage: 0
    property int memUsage: 0

    // Internal state tracking for CPU calculations
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuReader.running = true;
            memReader.running = true;
        }
    }

    Process {
        id: cpuReader
        command: ["cat", "/proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.split("\n");
                if (lines.length === 0) return;
                
                let tokens = lines[0].split(/\s+/).filter(Boolean);
                if (tokens[0] !== "cpu") return;

                let user = parseInt(tokens[1]);
                let nice = parseInt(tokens[2]);
                let system = parseInt(tokens[3]);
                let idle = parseInt(tokens[4]);
                let iowait = parseInt(tokens[5]);
                let irq = parseInt(tokens[6]);
                let softirq = parseInt(tokens[7]);

                let totalIdle = idle + iowait;
                let totalActive = user + nice + system + irq + softirq;
                let total = totalIdle + totalActive;

                let diffIdle = totalIdle - monitor.lastCpuIdle;
                let diffTotal = total - monitor.lastCpuTotal;

                if (monitor.lastCpuTotal !== 0 && diffTotal > 0) {
                    monitor.cpuUsage = Math.round((1.0 - (diffIdle / diffTotal)) * 100);
                }

                monitor.lastCpuIdle = totalIdle;
                monitor.lastCpuTotal = total;
            }
        }
    }

    Process {
        id: memReader
        command: ["cat", "/proc/meminfo"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.split("\n");
                let memTotal = 0;
                let memAvailable = 0;

                for (let i = 0; i < lines.length; i++) {
                    if (lines[i].startsWith("MemTotal:")) {
                        memTotal = parseInt(lines[i].match(/\d+/)[0]);
                    } else if (lines[i].startsWith("MemAvailable:")) {
                        memAvailable = parseInt(lines[i].match(/\d+/)[0]);
                    }
                    if (memTotal && memAvailable) break;
                }

                if (memTotal > 0) {
                    let memUsed = memTotal - memAvailable;
                    monitor.memUsage = Math.round((memUsed / memTotal) * 100);
                }
            }
        }
    }
}
