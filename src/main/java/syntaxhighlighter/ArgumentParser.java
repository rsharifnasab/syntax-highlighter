package syntaxhighlighter;

/**
	a class to parse and extract info from args
	it also check is it parsable or not
**/
public class ArgumentParser{

	final private String[] args;

	public ArgumentParser(String[] args){
		this.args = args;
		if(!check()){
			TerminalUtil.PError("bad arguments\n" +
			"usage : \'java -jar program.jar someTextFile.cpp\'");
		}
	}

	/**
		get argument and check if its valid or not
	**/
	private Boolean check(){
		if (args == null)
			return false;
		if (args.length == 1)
			return true;
		return false;
	}

	public java.io.FileReader getFileReader(){
		return FilesUtil.getFileReader(this.args[0]);
	}

}
