import java.awt.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.filechooser.FileSystemView;
import java.awt.Color;

public class VentanaPrincipal extends JFrame {
    private final JTextArea areaDeCodigo;
    private final PanelDeDibujo panelDeDibujo;
    private final JButton ejecutar, clr, debug, siguiente, consultarInstrucciones;
    private Parser parser;
    private boolean modoDebug;

    public VentanaPrincipal() {
        super("Logos");

        modoDebug = false;
        parser = new Parser();
        parser.insertarInstrucciones();

        areaDeCodigo = new JTextArea(20, 20);
        JScrollPane scrollCodigo = new JScrollPane(areaDeCodigo);
        scrollCodigo.setBounds(10, 50, 330, 435);
        add(scrollCodigo);

        JButton Archivo_sel = new JButton("Carga un archivo de texto");
        Archivo_sel.setBounds(10, 490, 330, 40);
        Archivo_sel.setVisible(true);

        this.setIconImage(new ImageIcon(getClass().getResource("/turtle.png")).getImage());

        Archivo_sel.addActionListener(event -> {
            JFileChooser chooser = new JFileChooser(FileSystemView.getFileSystemView().getHomeDirectory());
            chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
            FileNameExtensionFilter filter = new FileNameExtensionFilter("TEXT FILES", "txt", "text");
            chooser.setFileFilter(filter);
            int returnVal = chooser.showOpenDialog(this);

            if (returnVal == JFileChooser.APPROVE_OPTION) {
                File file = chooser.getSelectedFile();
                try {
                    BufferedReader in;
                    in = new BufferedReader(new FileReader(file));
                    String linea = in.readLine();
                    if (linea != null) {
                        areaDeCodigo.setText(linea);
                        while ((linea = in.readLine()) != null) {
                            areaDeCodigo.setText(areaDeCodigo.getText() + "\n" + linea);
                        }
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
                //l.setText(chooser.getSelectedFile().getAbsolutePath());
            }
        });
        add(Archivo_sel);

        panelDeDibujo = new PanelDeDibujo();
        panelDeDibujo.setBounds(350, 10, Propiedades.PANEL_DE_DIBUJO_ANCHO, Propiedades.PANEL_DE_DIBUJO_LARGO);
        panelDeDibujo.setBackground(Color.WHITE);
        add(panelDeDibujo);

        ImageIcon icon1 = new ImageIcon(getClass().getResource("/Run.png"));
        Image img1 = icon1.getImage();
        Image imgaux = img1.getScaledInstance(30, 30, java.awt.Image.SCALE_SMOOTH);
        ejecutar = new JButton(new ImageIcon(imgaux));
        ejecutar.setBounds(10, 540, 50, 40);
        ejecutar.addActionListener(event -> {
            parser.limpiar();
            if (parser.compilar(areaDeCodigo.getText()))
                panelDeDibujo.setConfiguracion(parser.ejecutar());
            else {
                parser = new Parser();
                parser.insertarInstrucciones();
                panelDeDibujo.setConfiguracion(parser.getConfiguracion());
            }
            panelDeDibujo.repaint();
        });
        add(ejecutar);

        ImageIcon iconClr = new ImageIcon(getClass().getResource("/Clear.png"));
        Image imgClr = iconClr.getImage();
        Image imgauxClr = imgClr.getScaledInstance(30, 30, java.awt.Image.SCALE_SMOOTH);
        clr = new JButton(new ImageIcon(imgauxClr));
        clr.setBounds(65, 540, 50, 40);
        clr.addActionListener(event -> {
            parser.limpiar();
            areaDeCodigo.setText("");
        });
        add(clr);

        ImageIcon icon2 = new ImageIcon(getClass().getResource("/Bug.png"));
        Image img2 = icon2.getImage();
        Image imgaux2 = img2.getScaledInstance(30, 30, java.awt.Image.SCALE_SMOOTH);
        debug = new JButton(new ImageIcon(imgaux2));
        debug.setBounds(230, 540, 50, 40);
        debug.addActionListener(event -> {
            parser.limpiar();
            if (!modoDebug) {
                if (parser.compilar(areaDeCodigo.getText())) {
                    panelDeDibujo.setConfiguracion(parser.getConfiguracion());
                    cambiarDebug();
                } else {
                    parser = new Parser();
                    parser.insertarInstrucciones();
                    panelDeDibujo.setConfiguracion(parser.getConfiguracion());
                }
            } else {
                cambiarDebug();
            }
            panelDeDibujo.repaint();
        });
        add(debug);

        ImageIcon icon3 = new ImageIcon(getClass().getResource("/Siguiente.png"));
        Image img3 = icon3.getImage();
        Image imgaux3 = img3.getScaledInstance(30, 30, java.awt.Image.SCALE_SMOOTH);
        siguiente = new JButton(new ImageIcon(imgaux3));
        siguiente.setBounds(285, 540, 50, 40);
        siguiente.addActionListener(event -> {
            parser.ejecutarSiguiente();
            panelDeDibujo.setConfiguracion(parser.getConfiguracion());
            panelDeDibujo.repaint();
        });
        siguiente.setEnabled(false);
        add(siguiente);

        consultarInstrucciones = new JButton("Instrucciones");
        consultarInstrucciones.setBounds(10, 10, 200, 30);
        consultarInstrucciones.addActionListener(event -> mostrarInstrucciones());
        add(consultarInstrucciones);

        setLayout(null);
        setBounds(50, 50, (int) (Toolkit.getDefaultToolkit().getScreenSize().getWidth() * 0.9), 730);
        setVisible(true);
        setResizable(false);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    private void cambiarDebug() {
        if (!modoDebug) {
            areaDeCodigo.setEnabled(false);
            ejecutar.setEnabled(false);
            siguiente.setEnabled(true);
        } else {
            areaDeCodigo.setEnabled(true);
            ejecutar.setEnabled(true);
            siguiente.setEnabled(false);
        }
        modoDebug = !modoDebug;
    }

    private void mostrarInstrucciones() {
        JTextArea areaDeInst = new JTextArea(60, 40);
        areaDeInst.setText("1) Para avanzar de posición escriba  FORWARD[X];\n Donde X es lo que avanzará el cursor. \n" +
                "\n2) Para girar de dirección escriba TURN[X];\n Donde X son los grados que girará el cursor. \n" +
                "\n3) Para cambiar el color con el que dibuja escriba COLOR[255,0,0]; usando valores RGB. \n" +
                "\n4) Se pueden crear funciones y estructuras de \ncontrol como condicionales y ciclos. \n" +
                "\n5) Presione el tercer botón a la derecha de la última línea," +
                "el código se irá ejecutando línea por línea mientras vaya presionando el botón de forward.");
        areaDeInst.setLineWrap(true);
        areaDeInst.setFont(new Font("Sans", Font.PLAIN, 16));
        areaDeInst.setEditable(false);
        areaDeInst.setOpaque(false);
        areaDeInst.setBackground(new Color(0, 0, 0, 0));

        JOptionPane.showMessageDialog(this, areaDeInst, "Instrucciones de uso", JOptionPane.PLAIN_MESSAGE);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(VentanaPrincipal::new);
    }
}

