#!/usr/bin/env node

import { promisify } from "util";
import { exec as execCb } from "child_process";

// Promisify exec for cleaner async handling
const exec = promisify(execCb);

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

// Helper function to run shell commands
const run = async (command) => {
  const { stdout } = await exec(command);
  return stdout.toString().trim();
};

// Function to calculate and return CPU usage percentage
const cpu = async (bg, fg = colors.dark_gray) => {
  // Calculate total CPU usage across all processes
  const cpuUsage = parseFloat(
    await run("ps -A -o %cpu | awk -F. '{s+=$1} END {print s}'"),
  );

  // Get the number of logical CPU cores
  const logicalCpuCount = parseFloat(await run("sysctl -n hw.logicalcpu"));

  // Calculate and format usage percentage
  const usage = Math.round(cpuUsage / logicalCpuCount);
  return `#[fg=${bg}]#[fg=${fg}]#[bg=${bg}]   ${usage}% #[bg=${bg}]`;
};

// Function to fetch battery percentage (stub function)
const battery = async (fg) => {
  // On macOS, pmset -g batt returns lines including percentage.
  // Adjust or expand for your own usage if you want status (charging/discharging).
  const batteryPercentage = await run("pmset -g batt | grep -o '[0-9]*%'");

  // Return the battery display segment
  return `#[fg=${fg}]⚡ ${batteryPercentage} #[fg=${fg}]`;
};

// Function to fetch Node.js and npm versions (stub function)
const node_npm_version = async (fg) => {
  const nodeVersion = await run("node -v"); // e.g., 'v16.17.0'
  const npmVersion = await run("npm -v"); // e.g., '8.15.0'
  return `#[fg=${fg}]Node: ${nodeVersion} | NPM: ${npmVersion} #[fg=${fg}]`;
};

// Function to fetch the status of "mrwatson" (stub function)
const mrwatson = async (fg) => {
  // Replace with actual Watson logic if you use a tool like 'watson'
  return `#[fg=${fg}]🧠 Watson: Active #[fg=${fg}]`;
};

// Function to fetch current datetime
const datetime = async (fg) => {
  const date = new Date();
  const formattedDate = date.toLocaleTimeString(); // e.g., '10:25:13 AM'
  return `#[fg=${fg}]🕒 ${formattedDate} #[fg=${fg}]`;
};

// Main function to assemble the status bar string
const main = async () => {
  let statusRight = "";

  // CPU usage
  statusRight += await cpu(colors.pink);

  // Battery level
  statusRight += await battery(colors.orange);

  // Node/npm versions
  statusRight += await node_npm_version(colors.yellow);

  // Watson status
  statusRight += await mrwatson(colors.green);

  // Current datetime
  statusRight += await datetime(colors.light_purple);

  // Print the constructed tmux status segment to stdout
  console.log(statusRight);
};

// Execute the main function
main();
