# RecipeRationalizer

An interactive application for scaling recipes. Anyone can input the ingredient list for a recipe and scale it up or down.
Implemented in Elm (tentative).

## How It Works
* Input a list of ingredients, each with quantity, as strings separated by new line
* The list is rearrangeable by dragging the orange button.
* Double click on X to remove from the list
* Parse input strings in the amount, unit, and the rest, assuming that order
* Ingredients without a quantity is unscalable. Ingredients without a unit is only scalable to integers.
* Input number of servings (floating points) and display in-place the scaled quantities with appropriate units

## Notes
* Travis CI building with version 0.19.0
* Supported format for quantity: integer, float, fraction, mixed fraction, number words (limited)
* Next steps: add more tests