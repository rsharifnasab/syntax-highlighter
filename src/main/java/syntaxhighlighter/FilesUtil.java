package syntaxhighlighter;

import java.io.*;

/** some utilities for working with files */
public class FilesUtil {

    /** get states of a file in an enum more info in FileStatus */
    public static FileStatus getFileState(String fileName) {

        File f = new File(fileName);

        if (f.isDirectory()) return FileStatus.IS_DIR;
        if (f.exists() && f.canWrite()) return FileStatus.WRITABLE;
        if (!f.exists()) return FileStatus.NOT_EXISTS; // but it can be created
        return FileStatus.NOT_OK;
    }

    public static String getJustName(String filename) {
        return new File(filename).getName();
    }

    /** check if a file is writeble (and we can save it ) or no */
    public static Boolean isWritableFile(String fileName) {
        return getFileState(fileName) == FileStatus.WRITABLE;
    }

    /** get all context of file as string with given File */
    public static String readFile(File file) {
        if (file == null) return null;

        FileStatus state = getFileState(file.getAbsolutePath());
        if (state == FileStatus.WRITABLE) {
            try {
                java.util.Scanner sc = new java.util.Scanner(file);
                // we just need to use \\Z as delimiter
                sc.useDelimiter("\\Z");
                return sc.next(); // read whole file!
            } catch (Exception e) {
                e.printStackTrace();
                TerminalUtil.PError("cannot read input file");
                return null;
            }
        } else return null;
    }

    /** read all data from the file with string address */
    public static String readFile(String address) {
        return readFile(new File(address));
    }

    /** wirte specified String to the file with File input */
    public static void writeToFile(String text, File address) {
        try {
            PrintWriter writer = new PrintWriter(address, "UTF-8");
            writer.println(text);
            writer.close();
        } catch (Exception e) {
            TerminalUtil.PError("cant save to file");
        }
    }

    public static FileReader getFileReader(String address) {
        FileStatus status = FilesUtil.getFileState(address);
        switch (status) {
            case WRITABLE:
                try {
                    return new FileReader(address);
                } catch (Exception e) {
                    TerminalUtil.PError("cannot open fileReader");
                }

            case IS_DIR:
                TerminalUtil.PError("error: target is directory: " + address);
                break;

            case NOT_OK:
            case NOT_EXISTS:
                TerminalUtil.PError("error: cant open input file: " + address);
                break;
        }
        throw new RuntimeException("should not reach here!, probalby bad FileStatus enum");
    }

    public static FileWriter getFileWriter(String address) {
        FileStatus status = FilesUtil.getFileState(address);
        switch (status) {
            case WRITABLE:
            case NOT_EXISTS:
                try {
                    return new FileWriter(address);
                } catch (Exception e) {
                    TerminalUtil.PError("cannot open FileWriter");
                }

            case IS_DIR:
                TerminalUtil.PError("error: target is directory: " + address);
                break;

            case NOT_OK:
                TerminalUtil.PError("error: cant write to output file: " + address);
                break;
        }
        throw new RuntimeException("should not reach here!, probalby bad FileStatus enum");
    }

    private FilesUtil() {}
}

/** an enum to determine status of existance and writability of a file ( or even its not file) */
enum FileStatus {
    WRITABLE, // the file is ok and ready to write
    NOT_OK, // can not open file for writing
    NOT_EXISTS, // the file doesnt exists
    IS_DIR, // requested file is directory
}
