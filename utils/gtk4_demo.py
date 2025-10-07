#!/usr/bin/env python3
import gi

gi.require_version("Gtk", "4.0")
gi.require_version("Gdk", "4.0")
from gi.repository import Gtk, Gio, Gdk
import os


class BorderlessWindow(Gtk.ApplicationWindow):
  def __init__(self, app):
    super().__init__(application=app)
    self.set_title("GTK4 Window with Border")
    self.set_decorated(False)
    self.set_resizable(True)

    # Set PNG icon (relative to parent directory)
    parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    icon_path = os.path.join(parent_dir, "myicon.png")
    if os.path.exists(icon_path):
      self.set_icon(Gio.File.new_for_path(icon_path))

    # Main vertical box
    vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
    vbox.set_name("purevision")  # Assign a name for CSS
    self.set_child(vbox)
    vbox.append(Gtk.Box())  # Spacer above

    hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
    vbox.append(hbox)
    button = Gtk.Button(label="Close")
    button.connect("clicked", self.on_button_clicked)
    hbox.append(button)
    checkbox = Gtk.CheckButton()
    hbox.append(checkbox)

    radiobutton = Gtk.CheckButton()
    hbox.append(radiobutton)
    vbox.append(Gtk.Box())  # Spacer below

    # Always on top after mapping
    self.connect("map", self.on_map)

    # Add CSS for border (5px solid border, like set_border_width(5))
    css = """
        #purevision {
            padding: 5px;
        }
        """
    css_provider = Gtk.CssProvider()
    css_provider.load_from_data(css.encode())
    Gtk.StyleContext.add_provider_for_display(
      Gdk.Display.get_default(),
      css_provider,
      Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )

  def on_map(self, *args):
    surface = self.get_surface()
    if hasattr(surface, "set_keep_above"):
      surface.set_keep_above(True)

  def on_button_clicked(self, widget):
    self.close()


class MyApp(Gtk.Application):
  def __init__(self):
    super().__init__(application_id="com.example.Gtk4BorderBorderless")

  def do_activate(self):
    win = BorderlessWindow(self)
    win.present()


app = MyApp()
app.run()
