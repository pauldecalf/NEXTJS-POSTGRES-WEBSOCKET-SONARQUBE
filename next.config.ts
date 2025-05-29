import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // React Strict Mode is true by default, which is good.
  // We can add other configurations here as needed.
  // For environment variables, Next.js automatically makes
  // variables prefixed with NEXT_PUBLIC_ available to the browser.
  // For server-side only variables, you can access them directly
  // via process.env.YOUR_VARIABLE_NAME in server-side code (e.g., API routes, getServerSideProps).

  // Example of how you *could* expose variables if not using NEXT_PUBLIC_ prefix
  // or for more complex configurations (though not strictly needed for NEXT_PUBLIC_ variables):
  // publicRuntimeConfig: {
  //   appName: process.env.NEXT_PUBLIC_APP_NAME || "Default App Name",
  // },
};

export default nextConfig;
