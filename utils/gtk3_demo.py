#!/usr/bin/env python3
import gi

gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk
import os


class SimpleWindow(Gtk.Window):
  def __init__(self):
    Gtk.Window.__init__(self, title="PureVision Print GTK 3")
    self.set_border_width(5)
    # self.set_default_size(140, 35)
    self.set_keep_above(True)
    self.set_decorated(False)
    self.set_position(Gtk.WindowPosition.CENTER)

    icon_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "icon.png")
    print(f"Icon path: {icon_path}")
    try:
      self.set_icon_from_file(icon_path)
      print("Icon set successfully!")
    except Exception as e:
      print("Failed to set icon:", e)

    # Main vertical box
    vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
    self.add(vbox)

    # Spacer above
    vbox.pack_start(Gtk.Box(), True, True, 0)

    # Horizontal box for controls
    hbox = Gtk.Box(spacing=10)
    vbox.pack_start(hbox, False, False, 0)

    # Button
    button = Gtk.Button(label="Button")
    button.connect("clicked", self.on_button_clicked)
    hbox.pack_start(button, False, False, 0)

    # Checkbox
    checkbox = Gtk.CheckButton()
    checkbox.set_active(True)
    hbox.pack_start(checkbox, False, False, 0)

    # Radio button
    radiobutton = Gtk.RadioButton.new(None)
    hbox.pack_start(radiobutton, False, False, 0)

    # Spacer below
    vbox.pack_start(Gtk.Box(), True, True, 0)

  def on_button_clicked(self, widget):
    self.close()


win = SimpleWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
