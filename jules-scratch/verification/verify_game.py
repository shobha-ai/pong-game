from playwright.sync_api import sync_playwright, expect
import os

def run_verification():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        # Get the absolute path to the index.html file
        file_path = os.path.abspath("index.html")

        # Go to the local HTML file
        page.goto(f"file://{file_path}")

        # Move the player to the note and interact
        page.evaluate("player.x = note.x; player.y = note.y;")
        page.keyboard.press('e')

        # Verify the message for getting the key
        message_container = page.locator("#message-container")
        expect(message_container).to_have_text("You found a small, rusty key hidden under the note. It says: 'Freedom lies behind the barrier.'")

        # Move player to the door and unlock it
        page.evaluate("player.x = door.x; player.y = door.y;")
        page.keyboard.press('e')

        # Verify the door unlocks
        expect(message_container).to_have_text("The key fits. The lock clicks open.")

        # Take a screenshot of the final state
        page.screenshot(path="jules-scratch/verification/verification.png")

        browser.close()

run_verification()