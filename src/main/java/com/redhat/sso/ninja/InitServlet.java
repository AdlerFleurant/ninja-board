package com.redhat.sso.ninja;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.attribute.PosixFilePermission;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalUnit;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.io.IOUtils;

import com.redhat.sso.ninja.utils.DownloadFile;

public class InitServlet extends HttpServlet {
	
  @Override
  public void init(ServletConfig config) throws ServletException {
    super.init(config);
    
    Backup.start(TimeUnit.DAYS.toMillis(1), Database2.STORAGE_AS_FILE.getAbsolutePath());
    
    GoogleDrive2.initialise();
    
    String intervalString=(String)Config.get().getOptions().get("heartbeat.interval");
    if (null==intervalString) intervalString="60000";
    int interval=Integer.parseInt(intervalString);
    boolean heartbeatDisabled="true".equalsIgnoreCase((String)Config.get().getOptions().get("heartbeat.disabled"));
    
    System.out.println("Heartbeat:");
    System.out.println("  Disabled: "+heartbeatDisabled);
    System.out.println("  Interval: "+interval +" (seconds)");
    
    
    if (!heartbeatDisabled)
      Heartbeat2.start(interval);
    
  }

  @Override
  public void destroy() {
    super.destroy();
    Heartbeat2.stop();
    Backup.stop();
  }

}