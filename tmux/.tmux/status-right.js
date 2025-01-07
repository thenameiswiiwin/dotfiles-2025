#!/usr/bin/env node

import { exec } from "child_process";
import { promisify } from "util";

// Helper function to execute shell commands
const run = async (command) => {
  const { stdout } = await promisify(exec)(command);
  return stdout.toString().trim();
};

// Define color constants
const colors = {
  white: "#f8f8f2",
  gray: "#44475a",
  dark_gray: "#282a36",
  light_purple: "#bd93f9",
  dark_purple: "#6272a4",
  cyan: "#8be9fd",
  green: "#50fa7b",
  orange: "#ffb86c",
  red: "#ff5555",
  pink: "#ff79c6",
  yellow: "#f1fa8c",
};

// Function to get CPU usage
const cpu = async (bg, fg = colors.dark_gray) => {
  const value = parseFloat(
    await run("ps -A -o %cpu | awk -F. '{s+=$1} END {print s}'"),
  );
  const cores = parseFloat(await run("sysctl -n hw.logicalcpu"));
  const usage = Math.round((value / cores) * 100) / 100;
  return `#[fg=${bg}]#[fg=${fg}]#[bg=${bg}]   ${usage.toFixed(
    0,
  )}% #[bg=${bg}]`;
};

// Function to get battery status
const battery = async (bg, fg = colors.dark_gray) => {
  const status = await run(
    "pmset -g batt | grep 'InternalBattery' | awk '{print $4}' | tr -d ';'",
  );
  const percentage = await run("pmset -g batt | grep -Eo '[0-9]+%'");
  const chargingIcons = ["", "", "", "", "", "", ""];
  const dischargingIcons = ["", "", "", "", "", "", "", "", ""];
  let icon = "";

  if (status === "charging") {
    icon = chargingIcons[Math.floor(parseInt(percentage, 10) / 10)] || "";
  } else {
    icon = dischargingIcons[Math.floor(parseInt(percentage, 10) / 10)] || "";
  }

  return `#[fg=${bg}]#[fg=${fg}]#[bg=${bg}] ${icon} ${percentage} #[bg=${bg}]`;
};

// Function to get Node.js and NPM versions
const nodeNpmVersion = async (bg, fg = colors.dark_gray) => {
  const nodeVersion = await run("node --version | sed 's/v//'");
  const npmVersion = await run("npm --version");
  return `#[fg=${bg}]#[fg=${fg}]#[bg=${bg}]  ${nodeVersion}  ${npmVersion} #[bg=${bg}]`;
};

// Function to get Watson status
const mrwatson = async (bg, fg = colors.dark_gray) => {
  let status = await run("watson status");
  status = status === "No project started." ? "" : "";
  const total = await run(
    "watson report -dcG | grep 'Total:' | sed 's/Total: //'",
  ).trim();
  return `#[fg=${bg}]#[fg=${fg}]#[bg=${bg}] ${status} ${total} #[bg=${bg}]`;
};

// Function to get date and time
const datetime = async (bg, fg = colors.dark_gray) => {
  const date = await run("date +'%b-%d %I:%M %p'");
  return `#[fg=${bg}]#[fg=${fg}]#[bg=${bg}]  ${date}`;
};

// Main function to build the status line
const main = async () => {
  let statusRight = "";
  statusRight += await cpu(colors.pink);
  statusRight += await battery(colors.orange);
  statusRight += await nodeNpmVersion(colors.yellow);
  statusRight += await mrwatson(colors.green);
  statusRight += await datetime(colors.light_purple);
  console.log(statusRight);
};

main().catch((err) => {
  console.error("Error:", err.message);
});
