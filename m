Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4336148CB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356535AbiALTJN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jan 2022 14:09:13 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:35838 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356537AbiALTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:08:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:43728)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7izP-008jRt-2A; Wed, 12 Jan 2022 12:08:55 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:44962 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7izM-0017iX-Uq; Wed, 12 Jan 2022 12:08:54 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <20220112134211.GA10024@xsang-OptiPlex-9020>
Date:   Wed, 12 Jan 2022 13:08:23 -0600
In-Reply-To: <20220112134211.GA10024@xsang-OptiPlex-9020> (kernel test robot's
        message of "Wed, 12 Jan 2022 21:42:11 +0800")
Message-ID: <874k68pyag.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n7izM-0017iX-Uq;;;mid=<874k68pyag.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+QwHgyFlXld2lCyqslpaiEChw3kflu0yI=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;kernel test robot <oliver.sang@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1425 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.60
        (0.1%), extract_message_metadata: 31 (2.1%), get_uri_detail_list: 15
        (1.0%), tests_pri_-1000: 10 (0.7%), tests_pri_-950: 1.33 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 280 (19.6%), check_bayes:
        274 (19.3%), b_tokenize: 32 (2.2%), b_tok_get_all: 131 (9.2%),
        b_comp_prob: 7 (0.5%), b_tok_touch_all: 97 (6.8%), b_finish: 1.00
        (0.1%), tests_pri_0: 1073 (75.3%), check_dkim_signature: 0.93 (0.1%),
        check_dkim_adsp: 6 (0.4%), poll_dns_idle: 0.54 (0.0%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 10 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [ucounts]  59ec71575a:  will-it-scale.per_process_ops -10.3%
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed a -10.3% regression of will-it-scale.per_process_ops due to commit:


I am having a bit of a challenge reading this report.  Does the -10.3%
mean that will-it-scale.per_process_ops is performing 70873 operations
per second instead of 78995 aka -10.3% fewer operations per second?

The per-profile.self-cycles-pp.do_dec_rlimits_put_ucounts now takes +2.6
more cycles, and perf-profile.self.cycles.pp.inc_rlimit_get_ucounts now
takes +3.8 more cycles.

Which if I read this correctly is a regression report about two
functions taking 3 or 4 cycles more after the code was rearranged inside
of them.

Is that correct?  Is this a regression report saying those two functions
are taking a few cycles more which leads to
will-it-scale.per_process_ops not being able to perform as many
operations per second?

Given the change in the commit mentioned I think this is all down to a
bug fix causing the code to be rearranged and a compiler optimizations.

I don't see much room to do anything about this.

Eric


> commit: 59ec71575ab440cd5ca0aa53b2a2985b3639fad4 ("ucounts: Fix rlimit max values check")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: will-it-scale
> on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
> with following parameters:
>
> 	nr_task: 100%
> 	mode: process
> 	test: signal1
> 	cpufreq_governor: performance
> 	ucode: 0x7002302
>
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/process/100%/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/signal1/will-it-scale/0x7002302
>
> commit: 
>   v5.16-rc2
>   59ec71575a ("ucounts: Fix rlimit max values check")
>
>        v5.16-rc2 59ec71575ab440cd5ca0aa53b2a 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>   11375458           -10.3%   10205843        will-it-scale.144.processes
>      78995           -10.3%      70873        will-it-scale.per_process_ops
>   11375458           -10.3%   10205843        will-it-scale.workload
>      35.26            +4.6%      36.90        turbostat.RAMWatt
>  1.177e+10           -10.1%  1.058e+10        perf-stat.i.branch-instructions
>   87846548            -6.7%   81932988        perf-stat.i.branch-misses
>      43.42            +2.7       46.09        perf-stat.i.cache-miss-rate%
>   91079467 ±  2%     +27.6%  1.162e+08        perf-stat.i.cache-misses
>  2.086e+08           +20.7%  2.517e+08        perf-stat.i.cache-references
>       7.77           +11.8%       8.68        perf-stat.i.cpi
>       5126           -21.1%       4044        perf-stat.i.cycles-between-cache-misses
>  1.814e+10           -10.6%  1.621e+10 ±  2%  perf-stat.i.dTLB-loads
>   1.17e+10           -11.1%   1.04e+10 ±  2%  perf-stat.i.dTLB-stores
>   53823400           -22.3%   41823499 ± 16%  perf-stat.i.iTLB-load-misses
>      6e+10            -9.9%  5.405e+10        perf-stat.i.instructions
>       0.13           -10.5%       0.12        perf-stat.i.ipc
>     290.39           -10.4%     260.05 ±  2%  perf-stat.i.metric.M/sec
>    5934502 ±  3%     +38.4%    8213006        perf-stat.i.node-load-misses
>     504440 ±  3%     +34.1%     676425 ±  2%  perf-stat.i.node-loads
>       3.48           +34.0%       4.66        perf-stat.overall.MPKI
>       0.75            +0.0        0.77 ±  2%  perf-stat.overall.branch-miss-rate%
>      43.63            +2.5       46.13        perf-stat.overall.cache-miss-rate%
>       7.78           +11.8%       8.70        perf-stat.overall.cpi
>       5128           -21.1%       4045        perf-stat.overall.cycles-between-cache-misses
>       0.13           -10.5%       0.11        perf-stat.overall.ipc
>  1.174e+10           -10.1%  1.055e+10        perf-stat.ps.branch-instructions
>   87583795            -6.8%   81664372        perf-stat.ps.branch-misses
>   90844134 ±  2%     +27.5%  1.158e+08        perf-stat.ps.cache-misses
>  2.082e+08           +20.6%  2.511e+08        perf-stat.ps.cache-references
>  1.809e+10           -10.7%  1.616e+10 ±  2%  perf-stat.ps.dTLB-loads
>  1.167e+10           -11.1%  1.037e+10 ±  2%  perf-stat.ps.dTLB-stores
>   53794169           -22.4%   41750328 ± 16%  perf-stat.ps.iTLB-load-misses
>  5.984e+10           -10.0%  5.388e+10        perf-stat.ps.instructions
>    5915765 ±  3%     +38.4%    8188054        perf-stat.ps.node-load-misses
>     542552 ±  4%     +30.8%     709510 ±  3%  perf-stat.ps.node-loads
>  1.826e+13           -10.5%  1.634e+13        perf-stat.total.instructions
>      48.83            -8.5       40.29        perf-profile.calltrace.cycles-pp.security_task_kill.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64
>      48.72            -8.5       40.21        perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.do_send_specific.do_tkill.__x64_sys_tgkill
>      66.93            -4.7       62.21        perf-profile.calltrace.cycles-pp.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      66.86            -4.7       62.16        perf-profile.calltrace.cycles-pp.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      66.62            -4.7       61.93        perf-profile.calltrace.cycles-pp.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      21.22            -4.1       17.12        perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.do_send_specific.do_tkill
>      95.18            -1.5       93.70        perf-profile.calltrace.cycles-pp.raise
>       2.11            -1.1        0.96 ±100%  perf-profile.calltrace.cycles-pp.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       1.70            -0.9        0.78 ±100%  perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       1.48            -0.8        0.70 ±100%  perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
>      92.89            -0.8       92.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.raise
>      92.54            -0.7       91.80        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       1.04            -0.5        0.50 ±100%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_user.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn
>       2.38 ±  5%      -0.4        1.96 ±  4%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.do_send_specific.do_tkill
>       1.50            -0.4        1.11 ± 23%  perf-profile.calltrace.cycles-pp.__entry_text_start.raise
>       1.56            -0.2        1.40 ±  5%  perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       1.52            -0.2        1.36 ±  5%  perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.20            +0.3        2.54 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       0.62 ±  3%      +0.5        1.12 ± 26%  perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       1.69 ±  2%      +0.6        2.25 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>       1.70 ±  2%      +0.6        2.26 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.handler
>       1.68 ±  2%      +0.6        2.24 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>       1.68 ±  2%      +0.6        2.25 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.handler
>       0.00            +0.6        0.64 ± 15%  perf-profile.calltrace.cycles-pp.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.8        0.84 ± 36%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64
>       0.00            +0.9        0.89 ± 34%  perf-profile.calltrace.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.08 ±  4%      +1.0        2.11 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64
>       2.65            +1.3        3.90 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       4.24            +1.3        5.56 ±  4%  perf-profile.calltrace.cycles-pp.handler
>       1.76 ±  2%      +1.3        3.11 ±  4%  perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>       1.70 ±  2%      +1.4        3.06 ±  4%  perf-profile.calltrace.cycles-pp.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      20.17 ±  2%      +2.5       22.62        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      19.97 ±  2%      +2.5       22.47        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
>      16.45 ±  2%      +3.8       20.23        perf-profile.calltrace.cycles-pp.__send_signal.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill
>      16.19 ±  2%      +3.8       20.00        perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal.do_send_sig_info.do_send_specific.do_tkill
>      15.60 ±  2%      +3.8       19.44        perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.__sigqueue_alloc.__send_signal.do_send_sig_info.do_send_specific
>      17.39 ±  2%      +3.9       21.29        perf-profile.calltrace.cycles-pp.do_send_sig_info.do_send_specific.do_tkill.__x64_sys_tgkill.do_syscall_64
>      48.84            -8.5       40.29        perf-profile.children.cycles-pp.security_task_kill
>      48.81            -8.5       40.27        perf-profile.children.cycles-pp.apparmor_task_kill
>      66.95            -4.7       62.22        perf-profile.children.cycles-pp.__x64_sys_tgkill
>      66.87            -4.7       62.16        perf-profile.children.cycles-pp.do_tkill
>      66.62            -4.7       61.93        perf-profile.children.cycles-pp.do_send_specific
>      21.31 ±  2%      -4.1       17.17        perf-profile.children.cycles-pp.aa_get_task_label
>      95.20            -1.0       94.16        perf-profile.children.cycles-pp.raise
>       1.49            -0.6        0.91 ± 55%  perf-profile.children.cycles-pp.__fpu_restore_sig
>       2.38 ±  5%      -0.4        1.96 ±  4%  perf-profile.children.cycles-pp.aa_may_signal
>       1.92            -0.2        1.73 ±  4%  perf-profile.children.cycles-pp.restore_sigcontext
>       2.12            -0.2        1.93        perf-profile.children.cycles-pp.__setup_rt_frame
>       1.72            -0.2        1.56        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
>       1.52            -0.2        1.37 ±  4%  perf-profile.children.cycles-pp.fpu__restore_sig
>       1.00            -0.1        0.89 ±  2%  perf-profile.children.cycles-pp._copy_from_user
>       1.00            -0.1        0.88        perf-profile.children.cycles-pp.__entry_text_start
>       1.04            -0.1        0.93 ±  7%  perf-profile.children.cycles-pp.restore_fpregs_from_user
>       0.89            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.52            -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       0.49            -0.1        0.44        perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       0.64            -0.0        0.59 ±  5%  perf-profile.children.cycles-pp.__might_fault
>       0.12 ±  4%      -0.0        0.08 ± 27%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.27 ±  2%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__clear_user
>       0.19 ±  2%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.__might_sleep
>       0.25            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_8
>       0.20 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__put_user_nocheck_4
>       0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       0.15            -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__x64_sys_getpid
>       0.63 ±  5%      +0.1        0.75 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.95            +0.1        1.08 ±  7%  perf-profile.children.cycles-pp.fpu__clear_user_states
>       0.63 ±  4%      +0.2        0.83 ± 11%  perf-profile.children.cycles-pp.fpregs_mark_activate
>       1.20            +0.4        1.59        perf-profile.children.cycles-pp.native_irq_return_iret
>       0.66 ±  5%      +0.4        1.08 ± 13%  perf-profile.children.cycles-pp.signal_setup_done
>       3.37            +0.5        3.86 ±  2%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
>       0.63 ±  3%      +0.5        1.13 ± 26%  perf-profile.children.cycles-pp.restore_altstack
>       0.35 ±  5%      +0.5        0.89 ± 34%  perf-profile.children.cycles-pp.do_sigaltstack
>       1.88 ±  4%      +0.6        2.50 ±  2%  perf-profile.children.cycles-pp.recalc_sigpending
>       3.17            +0.9        4.08 ±  5%  perf-profile.children.cycles-pp.handler
>       2.67            +1.2        3.92 ±  3%  perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
>       1.77 ±  2%      +1.3        3.12 ±  4%  perf-profile.children.cycles-pp.sigprocmask
>       2.77 ±  2%      +2.0        4.77 ±  7%  perf-profile.children.cycles-pp.__set_current_blocked
>       2.49 ±  3%      +2.0        4.54        perf-profile.children.cycles-pp._raw_spin_lock_irq
>      15.12 ±  2%      +2.6       17.72        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
>      16.73 ±  2%      +2.7       19.40 ±  2%  perf-profile.children.cycles-pp.dequeue_signal
>      17.48 ±  2%      +2.7       20.15 ±  2%  perf-profile.children.cycles-pp.get_signal
>      21.90 ±  2%      +3.0       24.92        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>      21.34 ±  2%      +3.0       24.39        perf-profile.children.cycles-pp.arch_do_signal_or_restart
>      21.67 ±  2%      +3.1       24.74        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      16.48 ±  2%      +3.8       20.25        perf-profile.children.cycles-pp.__send_signal
>      16.20 ±  2%      +3.8       20.01        perf-profile.children.cycles-pp.__sigqueue_alloc
>      15.60 ±  2%      +3.8       19.44        perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
>      17.40 ±  2%      +3.9       21.30        perf-profile.children.cycles-pp.do_send_sig_info
>      21.19            -4.1       17.07        perf-profile.self.cycles-pp.aa_get_task_label
>      24.97            -4.0       21.02        perf-profile.self.cycles-pp.apparmor_task_kill
>       0.81            -0.4        0.40 ± 85%  perf-profile.self.cycles-pp.restore_fpregs_from_user
>       2.37 ±  5%      -0.4        1.95 ±  4%  perf-profile.self.cycles-pp.aa_may_signal
>       0.89            -0.1        0.78 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.88            -0.1        0.77        perf-profile.self.cycles-pp.raise
>       0.93            -0.1        0.84 ±  2%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
>       0.54            -0.1        0.47 ±  5%  perf-profile.self.cycles-pp.fpu__clear_user_states
>       0.50            -0.1        0.44 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>       0.36 ±  2%      -0.1        0.31 ±  8%  perf-profile.self.cycles-pp.__setup_rt_frame
>       0.47            -0.1        0.42        perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       0.16 ±  3%      -0.0        0.11 ± 26%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.38            -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.43            -0.0        0.38        perf-profile.self.cycles-pp.__entry_text_start
>       0.22            -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.__x64_sys_rt_sigprocmask
>       0.17 ±  2%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__might_sleep
>       0.25            -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__get_user_nocheck_8
>       0.19 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__put_user_nocheck_4
>       0.16 ±  2%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.__send_signal
>       0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__clear_user
>       0.22 ±  2%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.13            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>       0.15            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.12 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp._copy_from_user
>       0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.handler
>       0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.get_signal
>       0.11            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__might_fault
>       0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.__sigqueue_alloc
>       0.09 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.restore_sigcontext
>       0.63 ±  5%      +0.1        0.75 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.60 ±  5%      +0.2        0.81 ± 11%  perf-profile.self.cycles-pp.fpregs_mark_activate
>       1.20            +0.4        1.59        perf-profile.self.cycles-pp.native_irq_return_iret
>       1.48 ±  5%      +0.7        2.22 ± 14%  perf-profile.self.cycles-pp.recalc_sigpending
>       2.48 ±  3%      +2.0        4.53        perf-profile.self.cycles-pp._raw_spin_lock_irq
>      15.12 ±  2%      +2.6       17.72        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
>      15.60 ±  2%      +3.8       19.44        perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
