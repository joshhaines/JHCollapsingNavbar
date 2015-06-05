# JHCollapsingNavbar

![Navbar](/Assets/navbar.gif)

This is a custom collapsing view that you can place at the top of your view controller, and will collapse as you pan up or down on a designated scroll view. It currently works with UIScrollView's and UITableView. The plan is to add support for other views that inherit from UIScrollView.

### Installation

After you download the contents of this repository:

1. Copy the folder "JHCollapsingNavbar" to your Xcode project.
2. Include the following import in your view controller that will contain the collapsing view:

  ```objective-c
  #import "JHCollapsingNavbar/JHCollapsingNavbar.h"
  ```
3. Your collapsing view should be of type `JHCollapsingView`.
4. **Scroll View** - If you would like the collapsing view to respond to a scroll view, then the scroll view must be of type:
  
  `JHScrollView`
5. **Table View** - If you would like it to respond to a table view, then the table view must be of type:

  `JHTableView`

### Getting the Collapsing View to Work

1. Connect your top constraint for your collapsing view as a property in your view controller. I've named mine `self.topConstraint` in this example.
1. Connect your collapsing view as a property in your view controller. I've named mine `self.collapsingView` in this example.
1. Add these three lines of code to your `viewDidLoad` method in your view controller:

  ```objective-c
  [self.collapsingView setTopConstraint:self.topConstraint];
  [self.scrollView setCollapsingView:self.collapsingView];
  [self.scrollView setViewChildren:nil];
  ```
  
  **Note:** The last method `setViewChildren:` is optional, but recommended. It is used to fade the alpha of any buttons, labels, etc. in your collapsing view. You may pass in an array of the children UI elements of the collapsing view. This could be an array of UIButton's, UILabel's, etc. They must be a subclass of UIView.
2. In your Scroll View's delegate method `scrollViewDidScrollToTop:`, include the following line of code:

  ```objective-c
  [self.collapsingView displayViewWithChildren:nil withScrollView:self.scrollView];
  ```
  
  **Note:** Again, the children array is optional here, but recommended.
  
That's it! Be sure to check out the Sample folder for examples on how to get it working.
