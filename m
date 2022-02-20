Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0724BD06F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbiBTRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:40:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbiBTRkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:40:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22F4A92B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=rx6bPshHOYn+HhILX8jHod/dJBs7+ONDUXo03AfEuVs=; b=naPrCMKXGILKIthtu7Ed/sLs1T
        mrtfPvTcdPryzIIxcbHWt0ap5Pyc/bPOGLHNpvuJdZHsT3vq9aetFvrKHvxA2gYxNDv9me52kUnqD
        Wkh9YZez6KqoNFsU+uTk2Uw5rcKmTedzwWleZ12Xw7Ho2wwB2RM/dwjaeJPkxgBQulXDlBdIupwwC
        TWbg7is/Bvj2mOgoUF9uA2vC2WJo1ISTCVRgZr7jWd+yt81VrSU4fFMkYdV1oijcRhYqbj/qOUW/s
        ArcS0qtqBbmKiRs955qzKNQJ83xWQBByubPmcmeOJR92kv7SLaQIiQ2NGdWuLGwLDszJqmkdrC33T
        gbgxC0LA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLqBX-00BQcz-Pe; Sun, 20 Feb 2022 17:39:48 +0000
Message-ID: <99ea0e5f-cce4-4a79-00e2-b6fb6e7a84e7@infradead.org>
Date:   Sun, 20 Feb 2022 09:39:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] patch : changed Table 1-1 with /proc/pid fields from
 Kernel 5.10.0
Content-Language: en-US
To:     Hans Weber <hwe.kernel@gmail.com>, linux-kernel@vger.kernel.org
References: <20220220155737.117279-1-hwe.kernel@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220220155737.117279-1-hwe.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

First of all, you haven't sent this to any maintainer.
Maintainers don't browse the mailing list to pick up patches,
so it needs to be sent directly to some appropriate maintainer.

Second: where is patch 1/3, assuming there is one?
This one should be patch 2/3 and then patch 3
should be patch 3/3.

3. When applying patch 2, I get this:

Warning: trailing whitespace in lines 12,137,138,151,157,158,160,162,163,165,170,171,175,176,177,179,182,183,184,186,187,189,191,192,194,196,198,199,200,201,203,207 of Documentation/filesystems/proc.rst


That is not acceptable.


On 2/20/22 07:57, Hans Weber wrote:
> Signed-off-by: Hans Weber <hwe.kernel@gmail.com>
> ---
>  Documentation/filesystems/proc.rst | 106 +++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 061744c436d9..b9d1c6764266 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -9,7 +9,7 @@ The /proc Filesystem
>                         Bodo Bauer <bb@ricochet.net>
>  2.4.x update	       Jorge Nerin <comandante@zaralinux.com>   November 14 2000
>  move /proc/sys	       Shen Feng <shen@cn.fujitsu.com>	        April 1 2009
> -fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
> +fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009 
>  =====================  =======================================  ================
>  
>  
> @@ -134,35 +134,81 @@ never act on any new process that the kernel may, through chance, have
>  also assigned the process ID <pid>. Instead, operations on these FDs
>  usually fail with ESRCH.
>  
> -.. table:: Table 1-1: Process specific entries in /proc
> -
> - =============  ===============================================================
> - File		Content
> - =============  ===============================================================
> - clear_refs	Clears page referenced bits shown in smaps output
> - cmdline	Command line arguments
> - cpu		Current and last cpu in which it was executed	(2.4)(smp)
> - cwd		Link to the current working directory
> - environ	Values of environment variables
> - exe		Link to the executable of this process
> - fd		Directory, which contains all file descriptors
> - maps		Memory maps to executables and library files	(2.4)
> - mem		Memory held by this process
> - root		Link to the root directory of this process
> - stat		Process status
> - statm		Process memory status information
> - status		Process status in human readable form
> - wchan		Present with CONFIG_KALLSYMS=y: it shows the kernel function
> -		symbol the task is blocked in - or "0" if not blocked.
> - pagemap	Page table
> - stack		Report full stack trace, enable via CONFIG_STACKTRACE
> - smaps		An extension based on maps, showing the memory consumption of
> -		each mapping and flags associated with it
> - smaps_rollup	Accumulated smaps stats for all mappings of the process.  This
> -		can be derived from smaps, but is faster and more convenient
> - numa_maps	An extension based on maps, showing the memory locality and
> -		binding policy as well as mem usage (in pages) of each mapping.
> - =============  ===============================================================
> +.. table:: Table 1-1: Process specific entries in a alphabetic order in 
> +           /proc (as of 5.10.0) 
> +
> + ======================================================================================
> + Name   	      T  Content
> + ======================================================================================
> + arch_status          f Task architecture specific information
> + attr                 d API for security modules
> + autogroup            f Kernel scheduler "task group"
> + auxv                 f ELF interpreter information passed to the process at exec time
> + cgroup               f Kernel scheduler group
> + clear_refs	      f Clears page referenced bits shown in smaps output
> + cmdline	      f Command line arguments
> + comm                 f The command name associated with the process
> + coredump_filter      f What memory segments are written to the core dump file 
> + cpu_resctrl_groups   f Navigate from tasks to resctrl groups.
> + cwd		      f Link to the current working directory
> + environ	      f Values of environment variables
> + exe		      f Link to the executable of this process
> + fd		      d Directory, which contains all file descriptors
> + fdinfo               d Open files for the pid, named by its file descriptor 
> + gid_map              f User namespaces        
> + io                   f This file contains I/O statistics for the process
> + limits               f Displays the soft limit, hard limit, and units of measurement for 
> +                        each of the process's resource limits
> + loginuid             f audit login UID 
> + map_files            d This subdirectory contains entries corresponding to memory-mapped files  
> + maps		      f File containing the currently mapped memory regions and their access permissions
> + mem		      f This file can be used to access the pages of a process's memory 
> +                        through open(2), read(2), and lseek(2)
> + mountinfo            f Contains information about mount points in the process's mount namespace
> + mounts               f Lists all the filesystems currently mounted in the process's mount namespace
> + mountstats           f Exports information (statistics, configuration information) on all mounted fs
> + net                  d This directory provides a comprehensive look at various networking 
> +                        parameters and statistics. 
> + ns                   d This directory containing one entry for each namespace that supports being
> +                        manipulated by setns(2)
> + numa_maps            f Displays information about a process's NUMA memory policy and allocation
> + oom_adj              f This file can be used to adjust the score used to select which process 
> +                        should be killed in an out-of-memory (OOM) situation  
> + oom_score            f Displays the current score for out-of-memory (OOM) suituation   
> + oom_score_adj        f This file can be used to adjust the badness heuristic
> + pagemap              f Shows the mapping of each of the process's virtual pages 
> +                        into physical page frames or swap area
> + patch_state          f Livepatch patch operation state (depends on CONFIG_LIVEPATCH)
> + personality          f This read-only file exposes the process's execution domain, as 
> +                        set by personality(2) 
> + projid_map           f Should be corrected by someone other 
> + root		      f Link to the root directory of this process
> + sched                f Contains detailed scheduler info about the process 
> + schedstat            f Contains only 3 fields of scheduler information   
> + sessionid            f Audit session ID
> + setgroups            f Displays the string "allow" if the process is permitted to employ the 
> +                        setgroups(2) system call
> + smaps                f Shows memory consumption for each of the process's mappings  
> + smaps_rollup         f Provides pre-summed memory information for a process.  
> +                        The format is almost identical to /proc/pid/smaps.
> +                        The fields Pss_Anon, Pss_File and Pss_Shmem are not present in 
> +                        /proc/[pid]/smaps
> + stack                f Provides a symbolic trace of the function calls in this process's kernel stack.  
> +                        This file is provided only with the CONFIG_STACKTRACE configuration option
> + stat                 f Status information about the process (not very human readable) 
> + statm                f Provides information about memory usage, measured in pages 
> + status               f Status information about the process in a in a format that's  
> +                        easier for humans to parse 
> + syscall              f Exposes the system call number and argument registers for the
> +                        system call currently being executed 
> + task                 d Contains one subdirectory for each thread in the process
> + timens_offsets       f Associated with each time namespace are offsets
> + timers               f List of the POSIX timers for this process
> + timerslack_ns        f Exposes the process's "current" timer slack value, expressed in nanoseconds 
> + uid_map              f See user_namespaces(7) for more information
> + wchan                f Symbolic name corresponding to the location in the kernel where
> +                        the process is sleeping
> + ======================================================================================
>  
>  For example, to get the status information of a process, all you have to do is
>  read the file /proc/PID/status::

-- 
~Randy
