Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886945AC403
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiIDKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiIDKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:54:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC941137;
        Sun,  4 Sep 2022 03:54:25 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oUnGh-0007F2-Tf; Sun, 04 Sep 2022 12:54:23 +0200
Message-ID: <dcecfc3b-0fd9-b406-4123-d414432d0e49@leemhuis.info>
Date:   Sun, 4 Sep 2022 12:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     lkp@lists.01.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
References: <20220826022031.GA76590@inn2.lkp.intel.com>
 <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662288865;49b557a6;
X-HE-SMSGID: 1oUnGh-0007F2-Tf
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

As per recent general discussions with the 0-day folks, I'm dropping
below regression from the list of tracked issues, as this report didn't
gain any traction. That for example can happen if the developers
considered the regression of no practical relevance, as they assume it
only materializes in micro-benchmarks, is due to a broken test case, or
some fluke.

Not sure if that or something else is the reason why this particular
report didn't gain any traction, but I lack the bandwidth to follow-up
on each and every regression some CI system found and reported. At the
same time I don't want to keep these reports in the list of tracked
issues forever, as that creates noise and makes it harder to spot the
important issues in regzbot's reports and lists. That's why I hereby
remove it:

#regzbot invalid: 0-day report that didn't get traction; might be of no
relevance

Ciao, Thorsten

On 26.08.22 04:41, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due to
> commit:
> 
> 
> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferred
> close timeout to be configurable")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: filebench
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @
> 2.10GHz (Cascade Lake) with 128G memory
> with following parameters:
> 
>     disk: 1HDD
>     fs: ext4
>     fs2: cifs
>     test: filemicro_delete.f
>     cpufreq_governor: performance
>     ucode: 0x5003302
> 
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
>  
> gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
> 
> commit:
>   dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we get
> from open_cached_dir")
>   5efdd9122e ("smb3: allow deferred close timeout to be configurable")
> 
> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     515.95           -50.0%     257.98        filebench.sum_operations/s
>       4.81 ±  2%   +1038.4%      54.78 ±  6%  filebench.sum_time_ms/op
>      29.00 ±  8%    +212.1%      90.50 ±  3% 
> filebench.time.percent_of_cpu_this_job_got
>      24629            +2.7%      25297       
> filebench.time.voluntary_context_switches
>  7.685e+08           +19.3%  9.169e+08 ±  4%  cpuidle..time
>       2.53 ±  6%     -20.6%       2.00 ±  3%  iostat.cpu.iowait
>    1506141 ±  8%     +22.4%    1843256 ±  3%  turbostat.IRQ
>       2.00           -50.0%       1.00        vmstat.procs.b
>      21969 ±  2%      -9.5%      19885 ±  2%  vmstat.system.cs
>       3.06 ±  7%      -0.7        2.35 ±  4%  mpstat.cpu.all.iowait%
>       0.79 ±  5%      +0.5        1.27 ±  2%  mpstat.cpu.all.sys%
>       0.89 ±  3%      -0.1        0.79 ±  3%  mpstat.cpu.all.usr%
>      34.55 ± 14%     -34.8%      22.51 ± 27% 
> sched_debug.cfs_rq:/.removed.runnable_avg.avg
>     119.64 ±  3%     -20.0%      95.69 ± 17% 
> sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>      34.55 ± 14%     -34.8%      22.51 ± 27% 
> sched_debug.cfs_rq:/.removed.util_avg.avg
>     119.64 ±  3%     -20.0%      95.69 ± 17% 
> sched_debug.cfs_rq:/.removed.util_avg.stddev
>       5249           +15.8%       6076        meminfo.Active
>       3866 ±  2%     +17.7%       4552        meminfo.Active(anon)
>       1382 ±  4%     +10.3%       1524 ±  4%  meminfo.Active(file)
>      69791 ± 14%     +39.8%      97553 ±  6%  meminfo.AnonHugePages
>      72709 ±  2%     +12.5%      81779 ±  3%  meminfo.Inactive(file)
>      23219           +13.5%      26352 ±  3%  meminfo.KernelStack
>     966.50 ±  2%     +17.7%       1137        proc-vmstat.nr_active_anon
>      74302            +6.3%      78977 ±  2%  proc-vmstat.nr_anon_pages
>      81133            +6.0%      85973        proc-vmstat.nr_inactive_anon
>      18172 ±  2%     +12.5%      20442 ±  3%  proc-vmstat.nr_inactive_file
>      23213           +13.5%      26348 ±  3%  proc-vmstat.nr_kernel_stack
>      17983            +2.3%      18400        proc-vmstat.nr_mapped
>       7446 ±  2%      +5.5%       7853 ±  3%  proc-vmstat.nr_shmem
>      26888            +1.6%      27306       
> proc-vmstat.nr_slab_reclaimable
>      47220            +3.4%      48803       
> proc-vmstat.nr_slab_unreclaimable
>     966.50 ±  2%     +17.7%       1137       
> proc-vmstat.nr_zone_active_anon
>      81133            +6.0%      85973       
> proc-vmstat.nr_zone_inactive_anon
>      18172 ±  2%     +12.5%      20442 ±  3% 
> proc-vmstat.nr_zone_inactive_file
>     361460            +2.5%     370454        proc-vmstat.numa_hit
>     946.67           +18.6%       1122        proc-vmstat.pgactivate
>     361562            +2.5%     370553        proc-vmstat.pgalloc_normal
>     187906            +4.7%     196761        proc-vmstat.pgfault
>       8189            +2.5%       8395        proc-vmstat.pgreuse
>  1.097e+09           +15.5%  1.267e+09 ±  7% 
> perf-stat.i.branch-instructions
>   39079265 ±  6%     -20.9%   30915354 ±  4%  perf-stat.i.branch-misses
>    5093263 ±  4%     -23.7%    3884752 ±  9%  perf-stat.i.cache-misses
>      29213           -18.7%      23764 ±  5%  perf-stat.i.context-switches
>  7.666e+09 ±  4%      +5.7%  8.106e+09 ±  2%  perf-stat.i.cpu-cycles
>       1877 ± 15%     +75.1%       3287 ± 12% 
> perf-stat.i.cycles-between-cache-misses
>    1735450 ±  3%     -12.9%    1512060 ±  3%  perf-stat.i.iTLB-load-misses
>       2898 ±  3%     +34.4%       3895 ±  7% 
> perf-stat.i.instructions-per-iTLB-miss
>       1493           -20.3%       1190 ±  7%  perf-stat.i.major-faults
>       0.09 ±  3%      +5.8%       0.09 ±  2%  perf-stat.i.metric.GHz
>      48.47 ± 11%      +8.4       56.83 ±  7% 
> perf-stat.i.node-store-miss-rate%
>     283426 ±  4%     -21.6%     222190 ± 10%  perf-stat.i.node-stores
>       3.57 ±  7%      -1.1        2.44 ±  6% 
> perf-stat.overall.branch-miss-rate%
>       1508 ±  3%     +39.8%       2108 ±  9% 
> perf-stat.overall.cycles-between-cache-misses
>       3022 ±  3%     +23.6%       3736 ±  5% 
> perf-stat.overall.instructions-per-iTLB-miss
>  9.585e+08           +18.8%  1.138e+09 ±  6% 
> perf-stat.ps.branch-instructions
>   34151514 ±  6%     -18.8%   27725316 ±  4%  perf-stat.ps.branch-misses
>    4450329 ±  5%     -21.7%    3486409 ±  9%  perf-stat.ps.cache-misses
>      25524           -16.4%      21333 ±  4%  perf-stat.ps.context-switches
>      77139            +2.5%      79105        perf-stat.ps.cpu-clock
>  6.704e+09 ±  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-cycles
>   1.06e+09           +11.3%   1.18e+09 ±  5%  perf-stat.ps.dTLB-loads
>    1517349 ±  3%     -10.5%    1357716 ±  2%  perf-stat.ps.iTLB-load-misses
>  4.582e+09           +10.8%  5.075e+09 ±  6%  perf-stat.ps.instructions
>       1296           -18.1%       1061 ±  6%  perf-stat.ps.major-faults
>     247613 ±  4%     -19.5%     199283 ±  9%  perf-stat.ps.node-stores
>      77139            +2.5%      79105        perf-stat.ps.task-clock
>  3.697e+10           +35.3%  5.003e+10        perf-stat.total.instructions
>       8.51 ± 91%      -6.9        1.59 ±223% 
> perf-profile.calltrace.cycles-pp.getdents64
>       8.34 ± 83%      -6.7        1.67 ±141% 
> perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.25 ±107%      -6.2        0.00       
> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
>       6.25 ±107%      -6.2        0.00       
> perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
>       6.25 ±107%      -6.2        0.00       
> perf-profile.calltrace.cycles-pp.open64
>       7.63 ± 84%      -6.0        1.59 ±223% 
> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
>       7.63 ± 84%      -6.0        1.59 ±223% 
> perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>       7.63 ± 84%      -6.0        1.59 ±223% 
> perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>       7.63 ± 84%      -6.0        1.59 ±223% 
> perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
>       6.26 ±115%      -5.4        0.88 ±223% 
> perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.26 ±115%      -5.4        0.88 ±223% 
> perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.26 ±115%      -4.6        1.67 ±141% 
> perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
>       6.26 ±115%      -4.6        1.67 ±141% 
> perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
>       6.26 ±115%      -4.6        1.67 ±141% 
> perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       6.26 ±115%      -4.6        1.67 ±141% 
> perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       4.57 ± 73%      -3.8        0.76 ±223% 
> perf-profile.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
>       4.57 ± 73%      -3.8        0.76 ±223% 
> perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist
>       4.57 ± 73%      -3.8        0.76 ±223% 
> perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__push
>       4.57 ± 73%      -3.8        0.76 ±223% 
> perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
>       3.38 ±103%      -3.4        0.00       
> perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
>       3.38 ±103%      -3.4        0.00       
> perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
>       3.38 ±103%      -3.4        0.00       
> perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>       3.38 ±103%      -3.4        0.00       
> perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
>       8.51 ± 91%      -6.9        1.59 ±223% 
> perf-profile.children.cycles-pp.getdents64
>       8.34 ± 83%      -6.7        1.67 ±141% 
> perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       8.34 ± 83%      -6.7        1.67 ±141% 
> perf-profile.children.cycles-pp.exit_to_user_mode_loop
>       8.34 ± 83%      -6.7        1.67 ±141% 
> perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       6.25 ±107%      -6.2        0.00       
> perf-profile.children.cycles-pp.open64
>       7.63 ± 84%      -6.0        1.59 ±223% 
> perf-profile.children.cycles-pp.__x64_sys_getdents64
>       7.63 ± 84%      -6.0        1.59 ±223% 
> perf-profile.children.cycles-pp.iterate_dir
>       6.26 ±115%      -4.6        1.67 ±141% 
> perf-profile.children.cycles-pp.arch_do_signal_or_restart
>       6.26 ±115%      -4.6        1.67 ±141% 
> perf-profile.children.cycles-pp.get_signal
>       4.57 ± 73%      -3.8        0.76 ±223% 
> perf-profile.children.cycles-pp.perf_mmap__read_head
>       3.38 ±103%      -3.4        0.00       
> perf-profile.children.cycles-pp.unmap_vmas
>       3.38 ±103%      -3.4        0.00       
> perf-profile.children.cycles-pp.unmap_page_range
>       3.38 ±103%      -3.4        0.00       
> perf-profile.children.cycles-pp.zap_pmd_range
>       3.38 ±103%      -3.4        0.00       
> perf-profile.children.cycles-pp.zap_pte_range
>       8.54 ± 43%      +8.6       17.19 ± 38% 
> perf-profile.children.cycles-pp.asm_exc_page_fault
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached
> in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file
> for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are
> provided
> for informational purposes only. Any difference in system hardware or
> software
> design or configuration may affect actual performance.
> 
> 
> #regzbot introduced: 5efdd9122e
> 
> 
