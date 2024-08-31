import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class Zpm {
    private static Map<String, Object> variables = new HashMap<>();

	public static void main(String[] args) {
		int line = 1;
		if (args.length != 1) {
            System.out.println("Couldn't find the file| Usage: java Zpm <fileName>");
            System.exit(line);
        }
		String fileName = args[0];
		 String filePath = fileName;
	        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
	            String input;
	            while ((input = br.readLine()) != null) {
	            	if (input.startsWith("FOR")) {
	            		if (countOccurrences(input,"FOR")==2)
	            		{
	            			nestedLoop(input,line);
	            		}
	            		else
	            		{processForLoop(input,line);}
	            		
	            	}
	            	else if (input.contains("+=")) {
	            		String[] parts = input.split("\\+=");
	            		if (variables.containsKey(parts[0].trim()) && variables.get(parts[0].trim()) instanceof String)
	            		{
	            			concatenate(parts,line);	            			
	            		}
	            		else{summing(parts,line);}
	                } else if (input.contains("*=")) {
	                	String[] parts = input.split("\\*=");
	                	multiplying(parts,line);
	                } else if (input.contains("-=")) {
	                	String[] parts = input.split("\\-=");
	                	subtracting(parts,line);
	                } else if (input.contains("PRINT")) {
	                	printItOut(input, line);
	                } else if (input.contains("=")) {
	                	
	                	String[] parts = input.split("\\=");
	                	String variable = parts[0].trim();
	                    String value = parts[1].replace(";", "").trim();;
	                 // Check if the value is a string (enclosed in quotes)
	                    if (value.startsWith("\"") && value.endsWith("\"")) {
	                        // Remove the quotes and store the string value
	                        variables.put(variable, value.substring(1, value.length() - 1));
	                    } else {
	                        // Try to parse the value as an integer
	                        try {
	                            int intValue = Integer.parseInt(value);
	                            variables.put(variable, intValue);
	                        } catch (NumberFormatException e) {
	                            System.out.println("Invalid value line: " + line);
	                            System.exit(line);
	                        }
	                    }
	                    
	                    
	                } 
	            	line+=1;
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	            System.exit(line);
	        }
	}
	public static void summing(String [] parts, int line) {
		if (parts.length != 2) {
            System.out.println("Invalid input format line "+line);
            System.exit(line);
        }
		String variable = parts[0].trim();
        String expression = parts[1].replace(";", "").trim();;
        
     // Check if the variable exists in the hash map
        if (!variables.containsKey(variable)) {
            System.out.println("Variable " + variable + " does not exist. line: "+ line);
            System.exit(line);
        }
        
        // split to tokens
        String[] tokens = expression.split("\\+");
        int sum = 0;
        for (String token : tokens) {
            token = token.trim();
            if (variables.containsKey(token)) {
                Object value = variables.get(token);
                if (value instanceof Integer) {
                    sum += (Integer) value;
                } else {
                    System.out.println("Invalid token: " + token + " is not an integer. line:"+ line);
                    System.exit(line);
                }
            } else {
                try {
                    sum += Integer.parseInt(token);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid token line : " + line);
                    System.exit(line);
                }
            }
        }
        
     // Update the variable in the hash map
        Object currentValue = variables.get(variable);
        if (currentValue instanceof Integer) {
            variables.put(variable, (Integer) currentValue + sum);
        } else {
            System.out.println("Variable " + variable + " is not an integer. line: "+ line);
            System.exit(line);
        }
		
	}
	
	public static void subtracting(String[] parts, int line) {
	    if (parts.length != 2) {
	        System.out.println("Invalid input format line " + line);
	        System.exit(line);
	    }
	    String variable = parts[0].trim();
	    String expression = parts[1].replace(";", "").trim();;

	    // Check if the variable exists in the hash map
	    if (!variables.containsKey(variable)) {
	        System.out.println("Variable " + variable + " does not exist. line: " + line);
	        System.exit(line);
	    }

	    // Split the expression into tokens
	    String[] tokens = expression.split("\\-");
	    int result = 0;
	    boolean firstToken = true;
	    for (String token : tokens) {
	        token = token.trim();
	        if (variables.containsKey(token)) {
	            Object value = variables.get(token);
	            if (value instanceof Integer) {
	                if (firstToken) {
	                    result = (Integer) value;
	                    firstToken = false;
	                } else {
	                    result -= (Integer) value;
	                }
	            } else {
	                System.out.println("Invalid token: " + token + " is not an integer. line:" + line);
	                System.exit(line);
	            }
	        } else {
	            try {
	                int intValue = Integer.parseInt(token);
	                if (firstToken) {
	                    result = intValue;
	                    firstToken = false;
	                } else {
	                    result -= intValue;
	                }
	            } catch (NumberFormatException e) {
	                System.out.println("Invalid token line: " + line);
	                System.exit(line);
	            }
	        }
	    }

	    // Update the variable in the hash map
	    Object currentValue = variables.get(variable);
	    if (currentValue instanceof Integer) {
	        variables.put(variable, (Integer) currentValue - result);
	    } else {
	        System.out.println("Variable " + variable + " is not an integer. line: " + line);
	        System.exit(line);
	    }
	}
	
	public static void multiplying(String[] parts, int line) {
	    if (parts.length != 2) {
	        System.out.println("Invalid input format line " + line);
	        System.exit(line);
	    }
	    String variable = parts[0].trim();
	    String expression = parts[1].replace(";", "").trim();;

	    // Check if the variable exists in the hash map
	    if (!variables.containsKey(variable)) {
	        System.out.println("Variable " + variable + " does not exist. line: " + line);
	        System.exit(line);
	    }

	    // Split the expression into tokens
	    String[] tokens = expression.split("\\*");
	    int result = 1; // Start with 1 for multiplication
	    for (String token : tokens) {
	        token = token.trim();
	        if (variables.containsKey(token)) {
	            Object value = variables.get(token);
	            if (value instanceof Integer) {
	                result *= (Integer) value;
	            } else {
	                System.out.println("Invalid token: " + token + " is not an integer. line:" + line);
	                System.exit(line);
	            }
	        } else {
	            try {
	                result *= Integer.parseInt(token);
	            } catch (NumberFormatException e) {
	                System.out.println("Invalid token line: " + line);
	                System.exit(line);
	            }
	        }
	    }

	    // Update the variable in the hash map
	    Object currentValue = variables.get(variable);
	    if (currentValue instanceof Integer) {
	        variables.put(variable, (Integer) currentValue * result);

	    } else {
	        System.out.println("Variable " + variable + " is not an integer. line: " + line);
	        System.exit(line);
	    }
	}
	
	public static void printItOut(String input, int line) {
	    // Remove the "PRINT" keyword and the semicolon
	    String variable = input.replace("PRINT", "").replace(";", "").trim();

	    // Check if the variable exists in the hash map
	    if (variables.containsKey(variable)) {
	        System.out.println(variable + "=" + variables.get(variable));
	    } else {
	        System.out.println("Variable " + variable + " does not exist. line: " + line);
	        System.exit(line);
	    }
	    
	
	}

	public static void concatenate(String[] parts, int line) {
	    if (parts.length != 2) {
	        System.out.println("Invalid input format line " + line);
	        return;
	    }
	    String variable = parts[0].trim();
	    String expression = parts[1].replace(";", "").trim(); // Remove the semicolon

	    // Check if the variable exists in the hash map
	    if (!variables.containsKey(variable)) {
	        System.out.println("Variable " + variable + " does not exist. line: " + line);
	        System.exit(line);
	    }

	    // Check if the variable is a string
	    Object currentValue = variables.get(variable);
	    if (!(currentValue instanceof String)) {
	        System.out.println("Variable " + variable + " is not a string. line: " + line);
	        System.exit(line);
	    }

	    // Concatenate the expression to the variable
	    StringBuilder result = new StringBuilder((String) currentValue);
	    String[] tokens = expression.split("\\+");
	    for (String token : tokens) {
	        token = token.trim();
	        if (variables.containsKey(token)) {
	            Object value = variables.get(token);
	            if (value instanceof String) {
	                result.append((String) value);
	            } else {
	                System.out.println("Invalid token: " + token + " is not a string. line:" + line);
	                System.exit(line);
	            }
	        } else {
	            // Check if the token is a string literal
	            if (token.startsWith("\"") && token.endsWith("\"")) {
	                result.append(token.substring(1, token.length() - 1));
	            } else {
	                System.out.println("Invalid token: " + token + " is not a valid string. line:" + line);
	                System.exit(line);
	            }
	        }
	    }

	    // Update the variable in the hash map
	    variables.put(variable, result.toString());
	}
	public static void processForLoop(String input, int line) {
		// del this FOR 2 A += 1 ; A *= 2 ; del this ENDFOR -- > trim
	    // Remove the "FOR" and "ENDFOR" keywords and the semicolon at the end
	    input = input.replace("FOR", "").replace("END", "").trim();
	    
	    String[] parts = input.split(" ", 2);
	    
	    if (parts.length != 2) {
	        System.out.println("Invalid FOR loop format line " + line);
	        System.exit(line);
	    }

	    // Get the number of iterations
	    int iterations;
	    try {
	        iterations = Integer.parseInt(parts[0].trim());
	    } catch (NumberFormatException e) {
	        System.out.println("Invalid number of iterations line " + line);
	        System.exit(line);
	        return ;
	    }

	    // Get the commands inside the loop
	    String commands = parts[1].trim();
	    String[] commandList = commands.split(";");


	    // Execute the commands the specified number of times
	    for (int i = 0; i < iterations; i++) {
	        for (String command : commandList) {
	            command = command.trim();
	            if (command.contains("+=")) {
	                String[] cmdParts = command.split("\\+=");
	               

	                if (variables.get(commandList[0].trim()) instanceof String) {
	                    concatenate(cmdParts, line);

	                } else {
	                    summing(cmdParts, line);
	                }
	            } else if (command.contains("-=")) {
	                String[] cmdParts = command.split("\\-=");
	                subtracting(cmdParts, line);
	            } else if (command.contains("*=")) {
	                String[] cmdParts = command.split("\\*=");
	                multiplying(cmdParts, line);
	            } else if (command.contains("=")) {
	                String[] cmdParts = command.split("=");
	                if (cmdParts[1].trim() instanceof String) {
	                    variables.put(cmdParts[0].trim(), cmdParts[1].trim().replace("\"", ""));
	                } else {
	                	try {
                            int value = Integer.parseInt(cmdParts[1].trim());
                            variables.put(cmdParts[0].trim(), value);
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid value line: " + line);
                            System.exit(line);
                            return;
                        }
	                    
	                }
	            } else {
	            	
	                System.out.println("Invalid command format line " + line);
	                System.exit(line);
	            }
	        }
	    }
	}
	
	public static void nestedLoop(String input, int line) {
        String loop1Amount = input.substring(4, 5).trim();
        int loop1AmountInt = Integer.parseInt(loop1Amount);
		int ind1 = input.indexOf("FOR")+6;
        int indOfFor = input.indexOf("FOR",2)-1;
        int endFor = input.indexOf("ENDFOR");
        String str1 = input.substring(ind1,indOfFor).trim();
        String str2 = input.substring(indOfFor+7,endFor-1).trim();
        String[] loop1 = str1.split(";");
        String[] loop2 = str2.split(";");
        String loop2Amount = input.substring(indOfFor + 5, indOfFor + 6).trim();
        int loop2AmountInt = Integer.parseInt(loop2Amount);
        for (int j=0 ; j<loop1AmountInt ; j+=1)
        {
        for (String str : loop1)
        {
        	input = str;
        
    	if (input.contains("+=")) {
    		String[] parts = input.split("\\+=");
    		if (variables.containsKey(parts[0].trim()) && variables.get(parts[0].trim()) instanceof String)
    		{
    			concatenate(parts,line);	            			
    		}
    		else{summing(parts,line);}
        } else if (input.contains("*=")) {
        	String[] parts = input.split("\\*=");
        	multiplying(parts,line);
        } else if (input.contains("-=")) {
        	String[] parts = input.split("\\-=");
        	subtracting(parts,line);
        } else if (input.contains("PRINT")) {
        	printItOut(input, line);
        } else if (input.contains("=")) {
        	
        	String[] parts = input.split("\\=");
        	String variable = parts[0].trim();
            String value = parts[1].replace(";", "").trim();;
         // Check if the value is a string (enclosed in quotes)
            if (value.startsWith("\"") && value.endsWith("\"")) {
                // Remove the quotes and store the string value
                variables.put(variable, value.substring(1, value.length() - 1));
            } else {
                // Try to parse the value as an integer
                try {
                    int intValue = Integer.parseInt(value);
                    variables.put(variable, intValue);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid value line: " + line);
                    System.exit(line);
                }
            }
            
            
        }
    	for (int i =0 ; i<loop2AmountInt ; i+=1)
    	{
    		for (String st21r2 : loop2)
            {
            	input = st21r2;
            
        	if (input.contains("+=")) {
        		String[] parts = input.split("\\+=");
        		if (variables.containsKey(parts[0].trim()) && variables.get(parts[0].trim()) instanceof String)
        		{
        			concatenate(parts,line);	            			
        		}
        		else{summing(parts,line);}
            } else if (input.contains("*=")) {
            	String[] parts = input.split("\\*=");
            	multiplying(parts,line);
            } else if (input.contains("-=")) {
            	String[] parts = input.split("\\-=");
            	subtracting(parts,line);
            } else if (input.contains("PRINT")) {
            	printItOut(input, line);
            } else if (input.contains("=")) {
            	
            	String[] parts = input.split("\\=");
            	String variable = parts[0].trim();
                String value = parts[1].replace(";", "").trim();;
             // Check if the value is a string (enclosed in quotes)
                if (value.startsWith("\"") && value.endsWith("\"")) {
                    // Remove the quotes and store the string value
                    variables.put(variable, value.substring(1, value.length() - 1));
                } else {
                    // Try to parse the value as an integer
                    try {
                        int intValue = Integer.parseInt(value);
                        variables.put(variable, intValue);
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid value line: " + line);
                        System.exit(line);
                    }
                }
                
                
            }
            }
    	}
    	
       }
       }
	}
	public static int countOccurrences(String text, String targetWord) {
        String[] words = text.split("\\s+");
        int count = 0;
        
        for (String word : words) {
            if (word.equalsIgnoreCase(targetWord)) {
                count++;
            }
        }
        
        return count;
    }


}
