Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20D4BCFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiBTP6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:58:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiBTP63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:58:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA03434AD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:58:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so27007975ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4G9Q2lK04LYqen7M8bWTKwNM8u46ky/VHG8a9Ko7axE=;
        b=EkNuF9BwfjZrxH8xcuF9qHagjLF48Id3jeIub0/gESJ0YWPdNEQ+sN73r1o89l6QjK
         iXKAAl1hve5853Mk2AC0Eb34B1GpuiVwamqUzhvHtOJyCSNULr9w4EF948e5mDB6wGu9
         ABKwouiQGuIajyNCofAl2bG2BDiqh577UOstpc/anNHI6YotuzvDbOk5Z8O7vTg5ygWf
         9QAa7Am2tjwRY58SntQdRkbnfDfKQ3c5ViFuHgjO8Qr7J2uABJTr1jGmMnFgHn2ukt69
         SQXOrZ9d7WPw57gMpnk8KhXabY8C1BnY4jt0D36nALcGDxpStxdkE48R5jCfYOCnCELW
         ET4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4G9Q2lK04LYqen7M8bWTKwNM8u46ky/VHG8a9Ko7axE=;
        b=50VLhWdSQhSHEjZk/31TpAHdCgR0sLTaM1YFFUFIAkqLNELps2DYgKxwUG6/tDIip0
         SrGW1iwSFvhzJN7Wz8kalJdJ3MJ5/u3hRvI8En0y6Syya76Z00iFqOz7o2ENb+AvNhxe
         ltSQuOItaZdxhNWC9Mx8hNDqkwTzRsNzmn+YIcCrABBRjlKy5RRYzEyx0tyJsAXIlNZV
         kwOcl63XkQpRPc9TCFhFkNX+tIP7gqLl0u39LCMH/ixU2ffR1Qe5WjDFntSnXfXev38l
         aGDpRUpu4LXiuOBygs/2o9zzfo96Ar+DWwWinGeiXDeTlSP32vd6uX3s/9Uf9SAYuysO
         EoaA==
X-Gm-Message-State: AOAM5300x+pVEUa4JcnHjvVG/crZep4w/wnKDhQ4ZQ2D7XkaRaXYEQfE
        ELhf004H61zrvtaE4n/z6hRM6sOPHW7WJA1z1huQSg==
X-Google-Smtp-Source: ABdhPJyJsLd3PO2jPf09Rdkw7FwLjCO+bAOS0bYqXF/1yaC85SrDQlfFx96e5xQjc23g8bTA2jvkrg==
X-Received: by 2002:a17:906:2549:b0:6cd:8c6:490d with SMTP id j9-20020a170906254900b006cd08c6490dmr12890284ejb.306.1645372685046;
        Sun, 20 Feb 2022 07:58:05 -0800 (PST)
Received: from localhost.localdomain ([217.61.0.106])
        by smtp.gmail.com with ESMTPSA id f3sm6079540edy.72.2022.02.20.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:58:04 -0800 (PST)
From:   Hans Weber <hwe.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Weber <hwe.kernel@gmail.com>
Subject: [PATCH 2/2] patch : changed Table 1-1 with /proc/pid fields from Kernel 5.10.0
Date:   Sun, 20 Feb 2022 16:57:37 +0100
Message-Id: <20220220155737.117279-1-hwe.kernel@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hans Weber <hwe.kernel@gmail.com>
---
 Documentation/filesystems/proc.rst | 106 +++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..b9d1c6764266 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -9,7 +9,7 @@ The /proc Filesystem
                        Bodo Bauer <bb@ricochet.net>
 2.4.x update	       Jorge Nerin <comandante@zaralinux.com>   November 14 2000
 move /proc/sys	       Shen Feng <shen@cn.fujitsu.com>	        April 1 2009
-fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
+fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009 
 =====================  =======================================  ================
 
 
@@ -134,35 +134,81 @@ never act on any new process that the kernel may, through chance, have
 also assigned the process ID <pid>. Instead, operations on these FDs
 usually fail with ESRCH.
 
-.. table:: Table 1-1: Process specific entries in /proc
-
- =============  ===============================================================
- File		Content
- =============  ===============================================================
- clear_refs	Clears page referenced bits shown in smaps output
- cmdline	Command line arguments
- cpu		Current and last cpu in which it was executed	(2.4)(smp)
- cwd		Link to the current working directory
- environ	Values of environment variables
- exe		Link to the executable of this process
- fd		Directory, which contains all file descriptors
- maps		Memory maps to executables and library files	(2.4)
- mem		Memory held by this process
- root		Link to the root directory of this process
- stat		Process status
- statm		Process memory status information
- status		Process status in human readable form
- wchan		Present with CONFIG_KALLSYMS=y: it shows the kernel function
-		symbol the task is blocked in - or "0" if not blocked.
- pagemap	Page table
- stack		Report full stack trace, enable via CONFIG_STACKTRACE
- smaps		An extension based on maps, showing the memory consumption of
-		each mapping and flags associated with it
- smaps_rollup	Accumulated smaps stats for all mappings of the process.  This
-		can be derived from smaps, but is faster and more convenient
- numa_maps	An extension based on maps, showing the memory locality and
-		binding policy as well as mem usage (in pages) of each mapping.
- =============  ===============================================================
+.. table:: Table 1-1: Process specific entries in a alphabetic order in 
+           /proc (as of 5.10.0) 
+
+ ======================================================================================
+ Name   	      T  Content
+ ======================================================================================
+ arch_status          f Task architecture specific information
+ attr                 d API for security modules
+ autogroup            f Kernel scheduler "task group"
+ auxv                 f ELF interpreter information passed to the process at exec time
+ cgroup               f Kernel scheduler group
+ clear_refs	      f Clears page referenced bits shown in smaps output
+ cmdline	      f Command line arguments
+ comm                 f The command name associated with the process
+ coredump_filter      f What memory segments are written to the core dump file 
+ cpu_resctrl_groups   f Navigate from tasks to resctrl groups.
+ cwd		      f Link to the current working directory
+ environ	      f Values of environment variables
+ exe		      f Link to the executable of this process
+ fd		      d Directory, which contains all file descriptors
+ fdinfo               d Open files for the pid, named by its file descriptor 
+ gid_map              f User namespaces        
+ io                   f This file contains I/O statistics for the process
+ limits               f Displays the soft limit, hard limit, and units of measurement for 
+                        each of the process's resource limits
+ loginuid             f audit login UID 
+ map_files            d This subdirectory contains entries corresponding to memory-mapped files  
+ maps		      f File containing the currently mapped memory regions and their access permissions
+ mem		      f This file can be used to access the pages of a process's memory 
+                        through open(2), read(2), and lseek(2)
+ mountinfo            f Contains information about mount points in the process's mount namespace
+ mounts               f Lists all the filesystems currently mounted in the process's mount namespace
+ mountstats           f Exports information (statistics, configuration information) on all mounted fs
+ net                  d This directory provides a comprehensive look at various networking 
+                        parameters and statistics. 
+ ns                   d This directory containing one entry for each namespace that supports being
+                        manipulated by setns(2)
+ numa_maps            f Displays information about a process's NUMA memory policy and allocation
+ oom_adj              f This file can be used to adjust the score used to select which process 
+                        should be killed in an out-of-memory (OOM) situation  
+ oom_score            f Displays the current score for out-of-memory (OOM) suituation   
+ oom_score_adj        f This file can be used to adjust the badness heuristic
+ pagemap              f Shows the mapping of each of the process's virtual pages 
+                        into physical page frames or swap area
+ patch_state          f Livepatch patch operation state (depends on CONFIG_LIVEPATCH)
+ personality          f This read-only file exposes the process's execution domain, as 
+                        set by personality(2) 
+ projid_map           f Should be corrected by someone other 
+ root		      f Link to the root directory of this process
+ sched                f Contains detailed scheduler info about the process 
+ schedstat            f Contains only 3 fields of scheduler information   
+ sessionid            f Audit session ID
+ setgroups            f Displays the string "allow" if the process is permitted to employ the 
+                        setgroups(2) system call
+ smaps                f Shows memory consumption for each of the process's mappings  
+ smaps_rollup         f Provides pre-summed memory information for a process.  
+                        The format is almost identical to /proc/pid/smaps.
+                        The fields Pss_Anon, Pss_File and Pss_Shmem are not present in 
+                        /proc/[pid]/smaps
+ stack                f Provides a symbolic trace of the function calls in this process's kernel stack.  
+                        This file is provided only with the CONFIG_STACKTRACE configuration option
+ stat                 f Status information about the process (not very human readable) 
+ statm                f Provides information about memory usage, measured in pages 
+ status               f Status information about the process in a in a format that's  
+                        easier for humans to parse 
+ syscall              f Exposes the system call number and argument registers for the
+                        system call currently being executed 
+ task                 d Contains one subdirectory for each thread in the process
+ timens_offsets       f Associated with each time namespace are offsets
+ timers               f List of the POSIX timers for this process
+ timerslack_ns        f Exposes the process's "current" timer slack value, expressed in nanoseconds 
+ uid_map              f See user_namespaces(7) for more information
+ wchan                f Symbolic name corresponding to the location in the kernel where
+                        the process is sleeping
+ ======================================================================================
 
 For example, to get the status information of a process, all you have to do is
 read the file /proc/PID/status::
-- 
2.30.2

