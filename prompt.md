# 1) Add to cart Feature
Context
I have a Flutter app called **The Union Shop**. Please help me develop a new feature. Before proposing code, read the project structure and the pages listed below and comply with the app's current architecture (named routes, shared widgets in `lib/widgets`).

Brief app overview and pages (purpose of each)
- **Home** (`lib/main.dart` — `HomeScreen`): Hero banner + products grid + site footer. Uses `AppHeader` at top. Responsive header hides desktop nav on small screens and exposes a popup menu.
- **Product** (`lib/product_page.dart`): Single product detail view used by `ProductCard` taps (similar layout to the “Classic Hoodies” screenshot: gallery on the left, product title/price/options/quantity + “ADD TO CART” on the right).
- **About** (`lib/about_page.dart`): Info about the shop.
- **Collections** (`lib/collections_page.dart`): Collection landing page (lists collections).
- **Sale** (`lib/sale.dart`): Sale items listing.
- **Clothing** (`lib/clothing.dart`): Clothing collection listing + filters.
- **Merch** (`lib/merch_page.dart`): Merchandise listing (structure very similar to Clothing).
- **Halloween** (`lib/halloween_page.dart`): Themed collection listing.
- **Signature** (`lib/signature_page.dart`): Signature / essentials collection.
- **Print Shack** (`lib/the_print_shack.dart`): Print Shack info page.
- **Print Shack Personalisation** (`lib/print_shack_personalisation.dart`): Personalisation product page with form controls.
- **Authentication / Login** (`lib/authentication.dart`): Login screen.
- **Widgets**:
  - `AppHeader` (`lib/widgets/app_header.dart`): Site header; includes nav links, `ShopNavDropdown`, `PrintShackNavDropdown`, and a popup menu for mobile. This is also where the **cart icon** should live.
  - `ShopNavDropdown` (`lib/widgets/shop_nav_dropdown.dart`): SHOP dropdown items (clothing, merch, halloween, signature).
  - `PrintShackNavDropdown` (`lib/widgets/print_shack_nav_dropdown.dart`): PRINT SHACK dropdown (about, personalisation).
  - (An `AppFooter` widget has been extracted into pages or should be used consistently.)

Current routing  
`MaterialApp` uses named routes: `'/'`, `'/product'`, `'/collections'`, `'/sale'`, `'/clothing'`, `'/merch'`, `'/halloween'`, `'/signature'`, `'/print-shack'`, `'/print-shack-personalisation'`, `'/about'`, `'/login'`, etc.  
You may introduce a new named route for the cart page, e.g. `'/cart'`.

---

### Feature request: Add “Add to Cart” + Cart page

**Goal**  
Implement a basic cart system so that:

1. From a **Product page** (like the “Classic Hoodies” screenshot), when the user clicks **ADD TO CART**:
   - The selected product (including chosen **color**, **size**, and **quantity**) is added to a client-side cart.
   - The **cart icon in the top-right corner of `AppHeader`** shows a badge with the current number of items in the cart (like the “1” badge in the screenshot).
2. When the user clicks the **cart icon** in the header:
   - They are navigated to a **Cart page** that looks and behaves similarly to the second screenshot (“Your cart” view).

**Scope: pages/components to modify**
- `lib/widgets/app_header.dart`  
  - Add a cart icon with an item count badge. Tapping it navigates to `'/cart'`.
- `lib/product_page.dart`  
  - Wire up the **ADD TO CART** button to add the current product (with selected options and quantity) to the shared cart state.
- **New**: `lib/cart_page.dart` (or similarly named)  
  - Implement the “Your cart” screen (title, list of items, quantity controls, line totals, subtotal, “UPDATE” and “CHECK OUT” buttons).
- Optional: a shared cart/service/state file, e.g. `lib/cart/cart_model.dart` or similar, plus any small shared widgets in `lib/widgets` (e.g. `CartIcon`, `CartItemRow`).
- Update `main.dart` (or wherever routes are defined) to register the new `'/cart'` named route.

**Data**
- Cart is **client-side only** (no backend required for now).
- Each cart line item should at least include:
  - `id` (product ID / slug)
  - `name` (e.g. “Classic Hoodies”)
  - `price`
  - `imageUrl` (for the thumbnail on the cart page)
  - `chosenColor`
  - `chosenSize`
  - `quantity`
- Cart-level data:
  - `items` (list of cart items)
  - `subtotal` (sum of line totals)
- State management: Keep it simple and aligned with the existing code style:
  - Prefer a small cart model using `ChangeNotifier` or a simple in-memory singleton that can be accessed from `AppHeader`, `ProductPage`, and `CartPage`.
  - Persistence (e.g. `shared_preferences`) is **nice to have but not required** unless you see an easy way to add it without major refactors.

**UI behavior & acceptance criteria**

**Product page (“Classic Hoodies” view)**
- User selects:
  - Color (dropdown)
  - Size (dropdown)
  - Quantity (numeric field or stepper; default 1)
- When the user taps **ADD TO CART**:
  - If the product (same id + color + size) is **not yet** in the cart, create a new cart line with the selected quantity.
  - If it **already exists**, increase that line’s quantity by the new amount.
  - The cart badge in the header updates to reflect the **total quantity of items** in the cart.
  - Optionally show a small confirmation (e.g. a `SnackBar`: “Added to cart”).

**Header cart icon (`AppHeader`)**
- Always visible in the top-right (both desktop and mobile).
- Shows a small badge with item count (0 can be hidden).
- Tapping it navigates to `'/cart'`.

**Cart page (“Your cart” view)**
- Layout similar to screenshot:
  - Page title: **Your cart**
  - A table/column layout with headings: Product | Price | Quantity | Total.
  - For each line item:
    - Thumbnail image on the left.
    - Product name (“Classic Hoodies”) and its attributes (Color: Purple, Size: XS).
    - A **Remove** action (link or button) under the item.
    - Price (single item price).
    - Quantity input (numeric text field or stepper).
    - Line total (price × quantity).
  - Below the list:  
    - Subtotal section on the right (e.g. “Subtotal £25.00”) and text “Tax included and shipping calculated at checkout”.
    - Buttons: **UPDATE** (recompute totals based on new quantities) and **CHECK OUT** (for now this can just be a stub / TODO or simple navigation or `print`).
- Behavior:
  - Changing a quantity and tapping **UPDATE** should:
    - Update the cart state.
    - Recalculate line totals and subtotal.
    - Update the badge in `AppHeader`.
  - Tapping **Remove** should:
    - Remove that item from the cart.
    - Update badge and subtotal.
  - If the cart is empty:
    - Show a friendly “Your cart is empty” message and a button/link to **Continue shopping** (navigate back to `'/'`).

**Responsive behavior**
- Must work on both desktop and mobile:
  - Respect the existing `AppHeader` responsive behavior (popup menu for small screens).
  - Cart page should stack content vertically on narrow screens (e.g. item rows as cards instead of a strict table if needed).

**Navigation**
- **ADD TO CART** should not leave the page; it only updates cart state & badge.
- Clicking the cart icon pushes `'/cart'` via named routes.
- Back button from the Cart page should return to the previous screen.

**Edge cases**
- Adding with invalid quantity (0 or negative) should be prevented or clamped to minimum 1.
- If user navigates to `'/cart'` with an empty cart, show the empty-state message + “Continue shopping”.
- Handle basic validation for selected options (color/size must be chosen if that’s required by the product).

---

Implementation constraints & conventions
- Use existing named routes and `AppHeader` for global nav links and the cart icon.
- Prefer keeping shared UI in `lib/widgets` (create new widget files there, e.g. `cart_icon.dart`, `cart_item_row.dart`).
- Keep changes minimal and isolated, add `TODO`s for large refactors.
- Use null-safety and follow current project style (mostly `StatelessWidget`/`StatefulWidget`).
- Add unit/widget tests for core logic where feasible (e.g. cart model add/remove/merge behavior).

Deliverables I expect from you
1. A short **implementation plan** (files to change / add) and estimated complexity (low/medium/high).
2. The exact **code patches** (file path + code) for each changed/added file.
3. A **test plan** and example unit/widget test(s) to validate functionality (e.g. cart total updates, badge updates, remove item).
4. How to run and manually verify the feature (commands and example UI flow).

Example prompt line to finalize  
> **Implement the feature described above. Start by giving me the implementation plan and the list of files you'll change. Then produce the code patches. Keep changes additive and reuse `lib/widgets` where possible.**


# 2) app_footer.dart widget
Context  
I have a Flutter app called **The Union Shop**. I need your help to implement a reusable footer widget. Before proposing code, read the project structure and the pages listed below and comply with the app's current architecture (named routes, shared widgets in `lib/widgets`, responsive layouts, and consistent styling with `AppHeader`).

Brief app overview and pages  
- **Home (`lib/main.dart`)**: Hero banner + products grid + footer. Uses `AppHeader`.
- **Product (`lib/product_page.dart`)**: Single product information page.
- **Collections / Clothing / Merchandise / Signature / Sale / Halloween pages**: Product listing pages.
- **Print Shack pages** (`lib/the_print_shack.dart`, `lib/print_shack_personalisation.dart`)
- **About (`lib/about_page.dart`)**
- **Authentication (`lib/authentication.dart`)**
- **Widgets**:
  - `AppHeader` (`lib/widgets/app_header.dart`): Top site header and navigation.
  - `ShopNavDropdown`, `PrintShackNavDropdown`.
  - I want a new **AppFooter** widget here.

Routing  
Uses named routes across the entire app: `'/'`, `'/product'`, `'/collections'`, `'/sale'`, `'/clothing'`, `'/merch'`, `'/signature'`, `'/print-shack'`, `'/print-shack-personalisation'`, `'/about'`, `'/login'`, etc.

---

### Feature request: Create a reusable **AppFooter** widget

**Goal**  
Introduce a reusable footer component (`app_footer.dart`) that can be imported and used across all pages, similar to how `AppHeader` works.

The footer should:
- Match the branding and layout style of The Union Shop (padding, spacing, typography).
- Include sections similar to the mockups on the existing Shopify pages (example: opening hours, help & information, email subscribe form, social links, legal text).
- Be responsive (desktop = multi-column layout; mobile = stacked layout).
- Be simple to drop into the bottom of any page.

**Scope: pages/components to modify**
- Add new file: `lib/widgets/app_footer.dart`
- Update pages that currently *hard-code* footer content (Home, Collections, Product, etc.) to use the new `AppFooter` widget.
- Ensure layout spacing works consistently (footer should sit below page content without layout overlap).

**Footer structure (required sections)**  
Based on the Shopify screenshot and your existing style, the footer should contain:

1. **Opening Hours**  
   - Title: “Opening Hours”  
   - Term time hours  
   - Seasonal hours (e.g., winter break closure)  
   - Styled similarly to existing pages

2. **Help and Information**  
   - Links to: Search, Terms & Conditions, Privacy, Contact, etc.  
   - Use named routes where available.

3. **Latest Offers / Newsletter Signup**  
   - Email input field  
   - "Subscribe" button  
   - (For now, no backend — action can be TODO or local placeholder)

4. **Bottom bar**  
   - Simple copyright / legal text  
   - Centered or justified based on screen width.

**Responsive behavior & acceptance criteria**
- **Desktop (≥900px):**  
  - Layout should show columns (e.g., 3 columns + bottom bar).
  - Consistent spacing with ~40px horizontal padding.
- **Mobile (<900px):**  
  - Each section stacks vertically.
  - Padding adapts appropriately.

**Design constraints & conventions**
- Place the file in `lib/widgets/app_footer.dart`.
- Follow the same style conventions as `AppHeader` (Typography, colors, layout).
- Use `LayoutBuilder` for responsive breakpoints.
- Keep logic minimal — this is mainly presentational UI.
- Footer should not scroll independently; it attaches to bottom of page content.

**Deliverables I expect**
1. A short **implementation plan**:  
   - Files to add/modify  
   - What logic and layout will be included  
   - Estimated complexity (low)

2. **Exact code patches** for each changed/added file, including:
   - `lib/widgets/app_footer.dart`
   - Updates to pages that integrate the footer

3. A **test plan** and example widget tests (e.g., footer renders sections correctly, responsive layout, text presence).

4. Instructions for how to **manually verify** the footer in the running app.

**Example prompt line to finalize**
> “Implement the feature described above. Start by giving me the implementation plan and list of files you'll change. Then provide the code patches. Keep the solution responsive and consistent with the existing AppHeader.”


# Shared footer Prompt
Replace the inline footers with the constant widget app_footer in the following pages:
halloween_page.dart --DONE --
signature_page.dart -- DONE--

specific_collection_page.dart -- created, rooted to navigation, footer DONE --

shop.dart -- Shoudnt be a page?
authentication.dart -- shoudnt have a footer?

# Specific_collection_page
- route that page to collections, onclick of a collection it leads to that page
- why are models needed, can i reuse them across the site, also widget- product_card.dart
- is this page scalable for mobile
- add the products and reuse the page
- add back button so i can go back to all collections page

# Navigation
- add navigation routes for all pages --/page_name

# Next steps: 
- print shack pages to match example ones
- replace all the pictures with generated ones
- the about page doesn't match the original one
- hero image on home page should be a slider with couple of pictures 
- ensure all necessary pages are now created for the coursework 
- ask where the collections page should be linked as it doesnt appear in the header in original website
- remove sandwitch bar from web version, it should only appear in mobile version
- add header text message
- write test functions for all files (learn what tests exactly u need)
- make sure the test functions run and there are no errors
- have a thorough, clean README file -- add at the end so it includes everything
- the union logo should be bigger and the links centralised
- connect all the buttons to pages so they are functional
- fix all problems that terminal says there are
# start on functionality:\
- Add items to bag
- Remove items from bag
- Cart page
- filtering and sorting on collection page

# Advanced:
- user authentication and account management
- cart management and price calculations
- deployment on git maybe, using firebase for database
