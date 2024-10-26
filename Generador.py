import tkinter as tk
from tkinter import messagebox
from tkinter import ttk

class EstacionamientoApp:
    def __init__(self, master):
        # Configuración inicial de la ventana
        self.master = master
        self.master.title("Estacionamiento John Deere")
        self.master.geometry("450x600")
        self.master.configure(bg="#f0f0f0")

        # Variables
        self.secciones = []

        # Validación para solo números
        validate_num = master.register(self.solo_numeros)

        # Entradas principales
        tk.Label(master, text="Lugar de Planta:", font=('Arial', 10, 'bold'), bg="#f0f0f0").pack(pady=5)
        self.planta_entry = tk.Entry(master, font=('Arial', 10), justify='center')
        self.planta_entry.pack(pady=5, padx=20, fill='x')

        tk.Label(master, text="Ancho del Estacionamiento (m):", font=('Arial', 10, 'bold'), bg="#f0f0f0").pack(pady=5)
        self.ancho_entry = tk.Entry(master, font=('Arial', 10), justify='center', validate="key", validatecommand=(validate_num, '%P'))
        self.ancho_entry.pack(pady=5, padx=20, fill='x')

        tk.Label(master, text="Largo del Estacionamiento (m):", font=('Arial', 10, 'bold'), bg="#f0f0f0").pack(pady=5)
        self.largo_entry = tk.Entry(master, font=('Arial', 10), justify='center', validate="key", validatecommand=(validate_num, '%P'))
        self.largo_entry.pack(pady=5, padx=20, fill='x')

        # Frame para secciones con Scroll
        frame_con_scroll = tk.Frame(master, bg="#f0f0f0")
        frame_con_scroll.pack(pady=10, fill='both', expand=True)

        # Canvas y scrollbar
        self.canvas = tk.Canvas(frame_con_scroll, bg="#f0f0f0")
        scrollbar = ttk.Scrollbar(frame_con_scroll, orient="vertical", command=self.canvas.yview)
        self.scrollable_frame = tk.Frame(self.canvas, bg="#f0f0f0")

        self.scrollable_frame.bind("<Configure>", lambda e: self.canvas.configure(scrollregion=self.canvas.bbox("all")))
        self.canvas.create_window((0, 0), window=self.scrollable_frame, anchor="nw")
        self.canvas.configure(yscrollcommand=scrollbar.set)

        # Empaquetar Canvas y scrollbar
        self.canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # Botones
        tk.Button(master, text="Agregar Seccion", command=self.agregar_seccion, font=('Arial', 10), bg="#008CBA", fg="white").pack(pady=10)
        tk.Button(master, text="Guardar Informacion", command=self.guardar_info, font=('Arial', 10), bg="#4CAF50", fg="white").pack(pady=5)

    def solo_numeros(self, value):
        """Valida que el campo contenga solo números."""
        return value.isdigit() or value == ""

    def agregar_seccion(self, seccion=None):
        """Agrega una nueva sección de estacionamiento."""
        seccion_frame = tk.Frame(self.scrollable_frame, bg="#f0f0f0")
        seccion_frame.pack(pady=5)
        
        validate_num = self.master.register(self.solo_numeros)

        # Entradas para la nueva sección
        tk.Label(seccion_frame, text="Nombre de Seccion:", bg="#f0f0f0").grid(row=0, column=0, padx=5, sticky="w")
        nombre_entry = tk.Entry(seccion_frame, font=('Arial', 10), justify='center')
        nombre_entry.grid(row=0, column=1, padx=5)

        tk.Label(seccion_frame, text="Ancho (m):", bg="#f0f0f0").grid(row=1, column=0, padx=5, sticky="w")
        ancho_entry = tk.Entry(seccion_frame, font=('Arial', 10), justify='center', validate="key", validatecommand=(validate_num, '%P'))
        ancho_entry.grid(row=1, column=1, padx=5)

        tk.Label(seccion_frame, text="Largo (m):", bg="#f0f0f0").grid(row=2, column=0, padx=5, sticky="w")
        largo_entry = tk.Entry(seccion_frame, font=('Arial', 10), justify='center', validate="key", validatecommand=(validate_num, '%P'))
        largo_entry.grid(row=2, column=1, padx=5)

        tk.Label(seccion_frame, text="Cantidad de Cajones:", bg="#f0f0f0").grid(row=3, column=0, padx=5, sticky="w")
        cajones_entry = tk.Entry(seccion_frame, font=('Arial', 10), justify='center', validate="key", validatecommand=(validate_num, '%P'))
        cajones_entry.grid(row=3, column=1, padx=5)

        # Productos
        productos_frame = tk.Frame(seccion_frame, bg="#f0f0f0")
        productos_frame.grid(row=4, column=0, columnspan=2, pady=5)
        
        tk.Label(productos_frame, text="Productos:", bg="#f0f0f0", font=('Arial', 10, 'bold')).pack()
        
        productos = []

        def agregar_producto():
            producto_entry = tk.Entry(productos_frame, font=('Arial', 10), justify='center')
            producto_entry.pack(pady=2, padx=5)
            productos.append(producto_entry)

        agregar_producto()
        tk.Button(seccion_frame, text="Agregar Producto", command=agregar_producto, bg="#FFA500", fg="white").grid(row=5, column=0, columnspan=2, pady=5)

        def guardar_seccion():
            """Guarda la sección con los datos proporcionados."""
            nombre = nombre_entry.get()
            ancho = ancho_entry.get()
            largo = largo_entry.get()
            cantidad_cajones = cajones_entry.get()
            productos_list = [p.get() for p in productos if p.get()]
            if nombre and ancho and largo and cantidad_cajones and productos_list:
                if seccion:
                    self.secciones.remove(seccion)

                self.secciones.append({
                    "nombre": nombre,
                    "ancho": int(ancho),
                    "largo": int(largo),
                    "cajones": cantidad_cajones,
                    "productos": productos_list,
                    "area": int(ancho) * int(largo)
                })
                seccion_frame.destroy()
                self.actualizar_secciones_display()
            else:
                messagebox.showwarning("Advertencia", "Por favor, completa todos los campos.")

        tk.Button(seccion_frame, text="Guardar Seccion", command=guardar_seccion, bg="#4CAF50", fg="white").grid(row=6, column=0, columnspan=2, pady=5)

        if seccion:
            nombre_entry.insert(0, seccion["nombre"])
            ancho_entry.insert(0, seccion["ancho"])
            largo_entry.insert(0, seccion["largo"])
            cajones_entry.insert(0, seccion["cajones"])
            for producto in seccion["productos"]:
                agregar_producto()
                productos[-1].insert(0, producto)

    def actualizar_secciones_display(self):
        """Actualiza la visualización de las secciones en pantalla."""
        for widget in self.scrollable_frame.winfo_children():
            widget.destroy()

        tk.Label(self.scrollable_frame, text="Secciones:", font=('Arial', 14, 'bold'), bg="#f0f0f0").pack(pady=5)
        for seccion in self.secciones:
            seccion_text = f"{seccion['nombre']} - Largo {seccion['largo']} m, Ancho {seccion['ancho']} m - Cajones: {seccion['cajones']}"
            seccion_label = tk.Label(self.scrollable_frame, text=seccion_text, fg="blue", cursor="hand2", bg="#f0f0f0")
            seccion_label.pack()
            seccion_label.bind("<Button-1>", lambda e, sec=seccion: self.agregar_seccion(sec))

    def guardar_info(self):
        """Guarda toda la información del estacionamiento en un archivo de texto."""
        try:
            planta = self.planta_entry.get()
            ancho = int(self.ancho_entry.get())
            largo = int(self.largo_entry.get())
            estacionamiento_area = ancho * largo

            area_secciones = sum(seccion["area"] for seccion in self.secciones)

            if area_secciones > estacionamiento_area:
                messagebox.showwarning("Advertencia", "El area total de las secciones excede el area del estacionamiento.")
                return

            dimensiones = f"{ancho}x{largo} metros"
            filename = f"{planta}_estacionamiento.txt"

            with open(filename, "w") as f:
                f.write(f"Lugar de Planta: {planta}\n")
                f.write(f"Dimensiones del Estacionamiento: {dimensiones}\n")
                f.write(f"Area del Estacionamiento: {estacionamiento_area} m2\n")
                f.write("Secciones:\n")
                for seccion in self.secciones:
                    productos = ", ".join(seccion["productos"])
                    f.write(f"- Nombre: {seccion['nombre']}, Largo {seccion['largo']} m, Ancho {seccion['ancho']} m, Area: {seccion['area']} m2, Cajones: {seccion['cajones']}, Productos: {productos}\n")
                f.write(f"\nArea total de las Secciones: {area_secciones} m2\n")

            messagebox.showinfo("Informacion Guardada", f"La informacion del estacionamiento ha sido guardada en {filename}.")

        except ValueError:
            messagebox.showerror("Error", "Por favor, ingresa solo numeros en las dimensiones del estacionamiento.")

root = tk.Tk()
app = EstacionamientoApp(root)
root.mainloop()
