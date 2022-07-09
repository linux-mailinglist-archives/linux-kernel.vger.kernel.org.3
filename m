Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B2156CA89
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGIQOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:14:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C81CB12
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:14:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 73so1346364pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4z55C/dFW7rq9+VMDja9vN6mu769clFpEeV7DKip0VQ=;
        b=Ks0uudoj7HpG9+sxTH3aSRztX6CzLugz1GXKDX4nnwHfN8epPT/Xn1ZeVKoH3EYg7/
         jv+WIXEhdRZPFkmDBwQkuETCjCtHbprPZourx7v0yFFQPmJRRrkC1INLBTsGFxvaiUJx
         kQX1NA6hy/2nAAqJit5AiNJNcYnFROMRSA4+/ngZys4647+n0I41dLoI0EMDop3jPnT6
         vc+IKeeNedZe6xzabpeSfZc/HvRyKvHT0BtqjMO4Q18aO1DVtZhQ3qaDIsQC06Pp7kel
         zBeUKq6YohVN0XAQZ9f5pY+v7tmb+k4oQjZYSIEs4ACsCO7zApXRPd0srxkQf8O8uAi2
         p4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4z55C/dFW7rq9+VMDja9vN6mu769clFpEeV7DKip0VQ=;
        b=FVfmCV1m4lyGhSN7EbbLqBFf9eM6GDffzVHG3EyWT7Ll596uAtWGVrqmxiVOdw/bjy
         slNlhx+qk3c10BLk+6vyFC1Dcn/jd07x07VV7BrXDeINK7bSn2D/p603zok/4qrogj3q
         PKV69CiVfjEVX5l9AUJrUwu0PvnMYWvvhkcZuXz0n73HGGuneKHXV/3m4vCZxc1qQaOS
         Yb/ZkpNOp5GEAzTc47YtWCo7Hg4owKNFZuRgtKo9QukpHCUIIHmaRsqBtUNCCgZP21Cs
         /Q2fuyBhNQ604HaZujesTtmLWdM4vtFS9SoWxKdFPBAlZAiVEz4WWrGICTXhbR73q3k/
         wiNQ==
X-Gm-Message-State: AJIora+6P696P0XSIf5i9OgKBZ3DmBd/+k9eFHCROVaGZ7RqHMG/Tx78
        Rx29Q5kEObplcdCtpU8L8zCsSw==
X-Google-Smtp-Source: AGRyM1snK+9NggqWgdcN46JkCKU70X/Gah4nR79JYBDxc32YtxsWmndBsrtdbdJwv6Ifde/9Ul5ANg==
X-Received: by 2002:a05:6a00:1690:b0:517:cc9e:3e2d with SMTP id k16-20020a056a00169000b00517cc9e3e2dmr9546450pfc.0.1657383268053;
        Sat, 09 Jul 2022 09:14:28 -0700 (PDT)
Received: from [10.4.101.155] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00168c52319c3sm1527803plp.149.2022.07.09.09.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 09:14:27 -0700 (PDT)
Message-ID: <9e02396c-0656-e3be-7947-5526fcab48ba@bytedance.com>
Date:   Sun, 10 Jul 2022 00:14:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: [sched/fair] 32fe13cd7a:
 phoronix-test-suite.fio.SequentialWrite.IO_uring.Yes.No.4KB.DefaultTestDirectory.mb_s
 -11.7% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        guobing.chen@intel.com, ming.a.chen@intel.com, frank.du@intel.com,
        Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        aubrey.li@linux.intel.com
References: <YsmT6VAqPybIe9Pu@xsang-OptiPlex-9020>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YsmT6VAqPybIe9Pu@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robot, thanks for your testing!

On 7/9/22 10:42 PM, kernel test robot Wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -11.7% regression of phoronix-test-suite.fio.SequentialWrite.IO_uring.Yes.No.4KB.DefaultTestDirectory.mb_s due to commit:
> 
> 
> commit: 32fe13cd7aa184ed349d698ebf6f420fa426dd73 ("[PATCH v4 7/7] sched/fair: de-entropy for SIS filter")
> url: https://github.com/intel-lab-lkp/linux/commits/Abel-Wu/sched-fair-improve-scan-efficiency-of-SIS/20220619-200743
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git f3dd3f674555bd9455c5ae7fafce0696bd9931b3
> patch link: https://lore.kernel.org/lkml/20220619120451.95251-8-wuyun.abel@bytedance.com
> 
> in testcase: phoronix-test-suite
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory

Does SNC enabled?

> with following parameters:
> 
> 	test: fio-1.14.1
> 	option_a: Sequential Write
> 	option_b: IO_uring
> 	option_c: Yes
> 	option_d: No
> 	option_e: 4KB
> 	option_f: Default Test Directory
> 	cpufreq_governor: performance
> 	ucode: 0x500320a
> 
> test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.vm-rw.ops_per_sec 113.5% improvement                           |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
> | test parameters  | class=memory                                                                        |
> |                  | cpufreq_governor=performance                                                        |
> |                  | nr_threads=100%                                                                     |
> |                  | test=vm-rw                                                                          |
> |                  | testtime=60s                                                                        |
> |                  | ucode=0xd000331                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
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
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/option_a/option_b/option_c/option_d/option_e/option_f/rootfs/tbox_group/test/testcase/ucode:
>    gcc-11/performance/x86_64-rhel-8.3/Sequential Write/IO_uring/Yes/No/4KB/Default Test Directory/debian-x86_64-phoronix/lkp-csl-2sp7/fio-1.14.1/phoronix-test-suite/0x500320a
> 
> commit:
>    fcc108377a ("sched/fair: skip busy cores in SIS search")
>    32fe13cd7a ("sched/fair: de-entropy for SIS filter")

Does the 5th patch applied? It's also important to bail out early if
the system is busy enough that idle cpus can hardly exist.

> 
> fcc108377a7cf79c 32fe13cd7aa184ed349d698ebf6
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      166666           -11.6%     147277 ±  3%  phoronix-test-suite.fio.SequentialWrite.IO_uring.Yes.No.4KB.DefaultTestDirectory.iops
>      651.00           -11.7%     574.83 ±  3%  phoronix-test-suite.fio.SequentialWrite.IO_uring.Yes.No.4KB.DefaultTestDirectory.mb_s
>        3145 ±  5%     -18.4%       2565 ± 12%  meminfo.Writeback
>        0.19 ±  4%      -0.0        0.17 ±  2%  mpstat.cpu.all.iowait%
>        2228 ± 33%     -37.5%       1392 ± 21%  numa-meminfo.node0.Writeback
>      553.33 ± 37%     -35.9%     354.83 ± 18%  numa-vmstat.node0.nr_writeback

I will try to reproduce the test to see why there is such a big change.

>      445604 ±  4%     -12.5%     390116 ±  4%  vmstat.io.bo
>    14697101 ±  3%     -11.0%   13074497 ±  4%  perf-stat.i.cache-misses
>        9447 ±  8%     -37.6%       5890 ±  5%  perf-stat.i.cpu-migrations
>        5125 ±  6%     +12.9%       5786 ±  6%  perf-stat.i.instructions-per-iTLB-miss
>     2330431 ±  4%     -11.4%    2064845 ±  4%  perf-stat.i.node-loads
>        2.55 ±104%      -1.6        0.96 ± 14%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>        2.62 ±102%      -1.6        0.99 ± 14%  perf-profile.children.cycles-pp.poll_idle
>        0.82 ± 23%      -0.3        0.53 ± 23%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>        0.74 ± 23%      -0.3        0.46 ± 23%  perf-profile.children.cycles-pp.sysvec_call_function_single
>        0.69 ± 24%      -0.3        0.44 ± 24%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>        0.38 ± 10%      -0.1        0.28 ± 18%  perf-profile.children.cycles-pp.__perf_event_header__init_id
>        0.16 ± 13%      -0.0        0.11 ± 22%  perf-profile.children.cycles-pp.__task_pid_nr_ns
>        2.10 ±108%      -1.3        0.79 ± 11%  perf-profile.self.cycles-pp.poll_idle
>        0.16 ± 13%      -0.0        0.11 ± 22%  perf-profile.self.cycles-pp.__task_pid_nr_ns
> 
> 
> ***************************************************************************************************
> lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>    memory/gcc-11/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/vm-rw/stress-ng/60s/0xd000331
> 
> commit:
>    fcc108377a ("sched/fair: skip busy cores in SIS search")
>    32fe13cd7a ("sched/fair: de-entropy for SIS filter")
> 
> fcc108377a7cf79c 32fe13cd7aa184ed349d698ebf6
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     7328835 ± 17%   +3441.0%  2.595e+08 ± 12%  stress-ng.time.involuntary_context_switches

It's really horrible..

>      123165 ±  3%     -14.1%     105742 ±  2%  stress-ng.time.minor_page_faults
>        8940           +32.8%      11872 ±  2%  stress-ng.time.percent_of_cpu_this_job_got
>        5268           +33.4%       7027 ±  2%  stress-ng.time.system_time
>      278.70           +21.5%     338.70 ±  2%  stress-ng.time.user_time
>   2.554e+08           +13.3%  2.894e+08        stress-ng.time.voluntary_context_switches
>   1.283e+08          +113.5%   2.74e+08 ±  6%  stress-ng.vm-rw.ops
>     2139049          +113.5%    4567054 ±  6%  stress-ng.vm-rw.ops_per_sec
>       39411 ± 34%     +56.3%      61612 ± 24%  numa-meminfo.node1.Mapped
>        5013           -22.5%       3883 ±  4%  uptime.idle
>   1.798e+09           -60.3%  7.135e+08 ± 21%  cpuidle..time >   1.701e+08           -87.3%   21598951 ± 90%  cpuidle..usage
>       75821 ±  2%     -11.6%      67063 ±  5%  meminfo.Active
>       75821 ±  2%     -11.6%      67063 ±  5%  meminfo.Active(anon)
>       81710 ±  2%     +20.1%      98158 ±  3%  meminfo.Mapped
>       26.00           -59.6%      10.50 ± 18%  vmstat.cpu.id
>      112.00           +10.9%     124.17        vmstat.procs.r
>     6561639           +31.6%    8634043 ±  2%  vmstat.system.cs
>      990604           -62.4%     372118 ± 18%  vmstat.system.in
>       24.13           -16.1        8.03 ± 23%  mpstat.cpu.all.idle%

This indicates that the SIS scan efficiency is largely improved, which
is in line with our expectations.

>        2.71            -1.6        1.11 ± 10%  mpstat.cpu.all.irq%
>        0.17 ±  6%      -0.1        0.06 ± 30%  mpstat.cpu.all.soft%
>       69.33           +17.4       86.71 ±  2%  mpstat.cpu.all.sys%
>        3.66            +0.4        4.09        mpstat.cpu.all.usr%
>   2.024e+09           +93.3%  3.912e+09 ± 16%  numa-vmstat.node0.nr_foll_pin_acquired
>   2.024e+09           +93.3%  3.912e+09 ± 16%  numa-vmstat.node0.nr_foll_pin_released
>   2.043e+09 ±  2%    +119.0%  4.473e+09        numa-vmstat.node1.nr_foll_pin_acquired
>   2.043e+09 ±  2%    +119.0%  4.473e+09        numa-vmstat.node1.nr_foll_pin_released
>        9865 ± 34%     +54.1%      15201 ± 23%  numa-vmstat.node1.nr_mapped
>       18954 ±  2%     -11.5%      16767 ±  5%  proc-vmstat.nr_active_anon
>   4.062e+09          +107.3%  8.419e+09 ±  7%  proc-vmstat.nr_foll_pin_acquired
>   4.062e+09          +107.3%  8.419e+09 ±  7%  proc-vmstat.nr_foll_pin_released
>       87380            +5.3%      92039        proc-vmstat.nr_inactive_anon
>       24453            -3.2%      23658        proc-vmstat.nr_kernel_stack
>       20437 ±  2%     +19.6%      24443 ±  3%  proc-vmstat.nr_mapped
>       18954 ±  2%     -11.5%      16767 ±  5%  proc-vmstat.nr_zone_active_anon
>       87380            +5.3%      92039        proc-vmstat.nr_zone_inactive_anon
>      108777 ±  4%     -17.2%      90014        proc-vmstat.numa_hint_faults
>       96756 ±  6%     -17.6%      79691 ±  2%  proc-vmstat.numa_hint_faults_local
>      490607            -4.4%     469155        proc-vmstat.pgfault
>       80.85           +10.9       91.75        turbostat.Busy%
>        3221            -5.0%       3060        turbostat.Bzy_MHz
>    77259218 ±  3%     -87.0%   10057388 ± 92%  turbostat.C1
>        6.74 ±  2%      -5.9        0.85 ± 90%  turbostat.C1%
>    92212921           -87.8%   11243535 ± 91%  turbostat.C1E
>       12.00 ± 22%      -6.6        5.42 ± 57%  turbostat.C1E%

and this.

>       16.39 ± 16%     -62.0%       6.24 ± 55%  turbostat.CPU%c1
>        0.16 ±  3%     +74.7%       0.29 ±  6%  turbostat.IPC
>    65322725           -62.5%   24502370 ± 18%  turbostat.IRQ
>      339708           -86.5%      45941 ± 88%  turbostat.POLL
>        0.05            -0.0        0.01 ± 82%  turbostat.POLL%
>      165121 ± 23%    -100.0%      39.19 ±101%  sched_debug.cfs_rq:/.MIN_vruntime.avg
>     2462709           -99.9%       3407 ±102%  sched_debug.cfs_rq:/.MIN_vruntime.max
>      607348 ± 11%     -99.9%     348.57 ±100%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
>        0.56 ±  4%     +11.8%       0.62 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
>        2.58 ± 13%     -38.7%       1.58 ± 11%  sched_debug.cfs_rq:/.h_nr_running.max
>        0.54 ±  9%     -39.7%       0.33 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
>      165121 ± 23%    -100.0%      39.19 ±101%  sched_debug.cfs_rq:/.max_vruntime.avg
>     2462709           -99.9%       3407 ±102%  sched_debug.cfs_rq:/.max_vruntime.max
>      607348 ± 11%     -99.9%     348.57 ±100%  sched_debug.cfs_rq:/.max_vruntime.stddev
>     2439879           +43.2%    3493834 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
>     2485561           +49.1%    3705888        sched_debug.cfs_rq:/.min_vruntime.max
>     2129935           +34.5%    2865147 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
>       35480 ± 17%    +324.2%     150497 ± 59%  sched_debug.cfs_rq:/.min_vruntime.stddev
>        0.43 ±  3%     +27.9%       0.55        sched_debug.cfs_rq:/.nr_running.avg
>        0.35 ±  5%     -57.2%       0.15 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
>        2186 ± 15%     -27.9%       1575 ± 11%  sched_debug.cfs_rq:/.runnable_avg.max
>      152.08 ±  6%    +134.5%     356.58 ± 31%  sched_debug.cfs_rq:/.runnable_avg.min
>      399.32 ±  4%     -50.5%     197.69 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
>       25106 ± 50%   +1121.1%     306577 ± 66%  sched_debug.cfs_rq:/.spread0.max
>       35510 ± 17%    +323.3%     150305 ± 59%  sched_debug.cfs_rq:/.spread0.stddev
>      545.95 ±  3%     +16.4%     635.59        sched_debug.cfs_rq:/.util_avg.avg
>        1726 ± 15%     -26.7%       1266 ± 14%  sched_debug.cfs_rq:/.util_avg.max
>      154.67 ±  2%    +112.9%     329.33 ± 30%  sched_debug.cfs_rq:/.util_avg.min
>      317.35 ±  4%     -43.1%     180.53 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
>      192.70 ±  6%    +104.5%     393.98 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>        5359 ±  4%     -26.1%       3958 ±  8%  sched_debug.cpu.avg_idle.min
>        4.69 ±  7%    +136.0%      11.07 ±  5%  sched_debug.cpu.clock.stddev
>        2380 ±  4%     +31.0%       3117        sched_debug.cpu.curr->pid.avg
>        1818 ±  3%     -65.9%     620.26 ±  8%  sched_debug.cpu.curr->pid.stddev
>        0.00 ±  8%     +59.7%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
>        2.58 ± 17%     -41.9%       1.50        sched_debug.cpu.nr_running.max
>        0.52 ±  9%     -43.2%       0.29 ±  5%  sched_debug.cpu.nr_running.stddev
>     1610935           +31.3%    2115112 ±  2%  sched_debug.cpu.nr_switches.avg
>     1661619           +34.5%    2234069        sched_debug.cpu.nr_switches.max
>     1415677 ±  3%     +20.3%    1702445        sched_debug.cpu.nr_switches.min
>       30576 ± 26%    +151.6%      76923 ± 37%  sched_debug.cpu.nr_switches.stddev
>       25.47           -91.3%       2.21 ± 69%  perf-stat.i.MPKI
>   3.342e+10           +84.7%  6.172e+10 ±  5%  perf-stat.i.branch-instructions
>        0.58            -0.3        0.33 ±  5%  perf-stat.i.branch-miss-rate%
>   1.667e+08           -13.2%  1.448e+08 ±  2%  perf-stat.i.branch-misses
>        0.63 ± 17%      +4.8        5.42 ± 39%  perf-stat.i.cache-miss-rate%
>    18939524 ±  4%     -46.6%   10109353 ± 18%  perf-stat.i.cache-misses
>   4.422e+09           -87.1%  5.724e+08 ± 77%  perf-stat.i.cache-references
>     6897069           +30.8%    9023752 ±  2%  perf-stat.i.context-switches
>        2.04           -43.3%       1.16 ±  5%  perf-stat.i.cpi
>   3.523e+11            +3.8%  3.656e+11        perf-stat.i.cpu-cycles
>     2322589           -86.6%     310934 ± 93%  perf-stat.i.cpu-migrations
>       18560 ±  4%    +113.2%      39578 ± 15%  perf-stat.i.cycles-between-cache-misses
>        0.20            -0.2        0.02 ± 70%  perf-stat.i.dTLB-load-miss-rate%
>    85472762           -87.2%   10962661 ± 82%  perf-stat.i.dTLB-load-misses
>   4.266e+10           +83.8%  7.841e+10 ±  5%  perf-stat.i.dTLB-loads
>        0.10 ±  4%      -0.1        0.01 ± 72%  perf-stat.i.dTLB-store-miss-rate%
>    25396322 ±  4%     -86.5%    3437369 ± 90%  perf-stat.i.dTLB-store-misses
>   2.483e+10           +85.2%  4.598e+10 ±  5%  perf-stat.i.dTLB-stores
>   1.699e+11           +85.8%  3.157e+11 ±  5%  perf-stat.i.instructions
>        0.50           +73.4%       0.87 ±  4%  perf-stat.i.ipc
>        2.75            +3.8%       2.86        perf-stat.i.metric.GHz
>      822.90           +77.2%       1458 ±  5%  perf-stat.i.metric.M/sec
>        5691            -3.4%       5500        perf-stat.i.minor-faults
>       91.09            +4.6       95.71        perf-stat.i.node-load-miss-rate%
>      334087 ± 17%     -67.4%     109033 ± 18%  perf-stat.i.node-loads
>       70.09           +17.6       87.68 ±  6%  perf-stat.i.node-store-miss-rate%
>     1559730 ±  5%     -64.9%     548115 ± 56%  perf-stat.i.node-stores
>        5704            -3.3%       5513        perf-stat.i.page-faults
>       26.03           -92.7%       1.89 ± 83%  perf-stat.overall.MPKI
>        0.50            -0.3        0.24 ±  8%  perf-stat.overall.branch-miss-rate%
>        0.43 ±  3%      +2.5        2.91 ± 60%  perf-stat.overall.cache-miss-rate%
>        2.08           -44.0%       1.16 ±  5%  perf-stat.overall.cpi
>       18664 ±  4%    +100.4%      37402 ± 16%  perf-stat.overall.cycles-between-cache-misses
>        0.20            -0.2        0.01 ± 87%  perf-stat.overall.dTLB-load-miss-rate%
>        0.10 ±  4%      -0.1        0.01 ± 96%  perf-stat.overall.dTLB-store-miss-rate%
>        0.48           +79.1%       0.86 ±  4%  perf-stat.overall.ipc
>       91.02            +5.1       96.07        perf-stat.overall.node-load-miss-rate%
>       70.91           +17.6       88.54 ±  6%  perf-stat.overall.node-store-miss-rate%
>   3.289e+10           +85.0%  6.085e+10 ±  5%  perf-stat.ps.branch-instructions
>   1.641e+08           -13.1%  1.425e+08 ±  2%  perf-stat.ps.branch-misses
>    18633656 ±  4%     -46.7%    9931368 ± 18%  perf-stat.ps.cache-misses
>   4.354e+09           -87.1%  5.613e+08 ± 77%  perf-stat.ps.cache-references
>     6788892           +31.0%    8894592 ±  2%  perf-stat.ps.context-switches
>    3.47e+11            +3.9%  3.604e+11        perf-stat.ps.cpu-cycles
>     2286778           -86.7%     304327 ± 94%  perf-stat.ps.cpu-migrations
>    84173329           -87.2%   10770448 ± 82%  perf-stat.ps.dTLB-load-misses
>   4.198e+10           +84.1%   7.73e+10 ±  5%  perf-stat.ps.dTLB-loads
>    25001705 ±  4%     -86.5%    3364501 ± 91%  perf-stat.ps.dTLB-store-misses
>   2.444e+10           +85.5%  4.533e+10 ±  5%  perf-stat.ps.dTLB-stores
>   1.673e+11           +86.1%  3.112e+11 ±  5%  perf-stat.ps.instructions
>       12.40            -1.5%      12.22        perf-stat.ps.major-faults
>        5543            -3.9%       5329        perf-stat.ps.minor-faults
>      332272 ± 17%     -66.0%     112911 ± 16%  perf-stat.ps.node-loads
>     1533930 ±  5%     -65.2%     534337 ± 57%  perf-stat.ps.node-stores
>        5556            -3.9%       5341        perf-stat.ps.page-faults
>   1.065e+13           +86.7%  1.988e+13 ±  5%  perf-stat.total.instructions
>       18.10           -16.2        1.91 ±142%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       17.94           -16.1        1.88 ±142%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       17.93           -16.1        1.88 ±142%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       17.90           -16.0        1.88 ±142%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       15.83            -8.0        7.86 ± 20%  perf-profile.calltrace.cycles-pp.read
>       13.06            -8.0        5.11 ± 30%  perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
>       13.21            -7.9        5.30 ± 29%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       13.58            -7.9        5.68 ± 27%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       14.72            -7.9        6.86 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>       14.51            -7.8        6.73 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       13.77            -7.5        6.23 ± 23%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        9.90            -7.1        2.83 ± 47%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.new_sync_read.vfs_read
>        9.96            -7.0        2.92 ± 45%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
>        7.84            -6.9        0.94 ±142%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>        7.44            -6.8        0.63 ±142%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>        7.07            -6.2        0.85 ±142%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>        7.03            -6.2        0.84 ±142%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>        8.60            -5.3        3.30 ± 44%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
>        8.75            -5.3        3.49 ± 41%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>       10.84            -5.3        5.58 ± 27%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       10.53            -5.2        5.29 ± 28%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        6.70            -5.2        1.49 ± 62%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.new_sync_read
>       10.02            -5.2        4.83 ± 30%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
>        5.64            -5.2        0.48 ±142%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
>       10.08            -5.1        4.98 ± 29%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        8.21            -5.1        3.14 ± 44%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
>        8.25            -5.1        3.20 ± 44%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
>        5.11            -4.7        0.40 ±141%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
>        5.07            -4.7        0.40 ±141%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
>        5.19            -4.6        0.55 ±141%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
>       20.28            -4.6       15.69 ±  5%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core
>       20.55            -4.3       16.22 ±  5%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>       10.91            -3.7        7.17 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       24.78            -3.7       21.12 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv
>       10.95            -3.6        7.30 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       11.15            -3.0        8.18 ± 13%  perf-profile.calltrace.cycles-pp.write
>        1.03 ±  4%      -0.4        0.62 ± 14%  perf-profile.calltrace.cycles-pp.stress_vm_child
>        0.76 ±  4%      +0.5        1.22 ± 10%  perf-profile.calltrace.cycles-pp.stress_vm_rw
>        0.63            +0.5        1.15 ± 23%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
>        0.53 ±  2%      +0.5        1.06 ±  9%  perf-profile.calltrace.cycles-pp.__might_fault.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>        0.64            +0.5        1.18 ± 22%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
>        0.00            +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.__might_resched.copy_page_to_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>        0.00            +1.0        0.96 ± 15%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>        0.00            +1.0        1.02 ± 17%  perf-profile.calltrace.cycles-pp.mod_node_page_state.gup_put_folio.unpin_user_pages.process_vm_rw_single_vec.process_vm_rw_core
>        0.00            +1.0        1.02 ± 10%  perf-profile.calltrace.cycles-pp.__might_fault.copy_page_from_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>        0.00            +1.0        1.03 ± 15%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>        0.00            +1.0        1.04 ± 17%  perf-profile.calltrace.cycles-pp.mod_node_page_state.gup_put_folio.unpin_user_pages_dirty_lock.process_vm_rw_single_vec.process_vm_rw_core
>        0.00            +1.1        1.10 ± 16%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.24 ±  2%      +1.4        2.60 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.follow_page_pte.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec
>        0.00            +1.4        1.40 ± 16%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        0.00            +1.5        1.46 ± 16%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>        1.04            +1.5        2.54 ± 14%  perf-profile.calltrace.cycles-pp.gup_put_folio.unpin_user_pages.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>        0.99 ±  2%      +1.6        2.57 ± 14%  perf-profile.calltrace.cycles-pp.gup_put_folio.unpin_user_pages_dirty_lock.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>        0.00            +1.7        1.69 ± 11%  perf-profile.calltrace.cycles-pp.follow_pud_mask.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core
>        1.35            +1.8        3.20 ± 14%  perf-profile.calltrace.cycles-pp.unpin_user_pages.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv
>        0.00            +2.0        1.97 ± 10%  perf-profile.calltrace.cycles-pp.follow_page_mask.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core
>        1.27 ±  2%      +2.0        3.30 ± 14%  perf-profile.calltrace.cycles-pp.unpin_user_pages_dirty_lock.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev
>        0.00            +2.1        2.12 ± 18%  perf-profile.calltrace.cycles-pp.mod_node_page_state.try_grab_page.follow_page_pte.__get_user_pages.__get_user_pages_remote
>        0.00            +2.3        2.30 ± 11%  perf-profile.calltrace.cycles-pp.follow_pmd_mask.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core
>        3.16 ±  2%      +2.4        5.51 ± 11%  perf-profile.calltrace.cycles-pp.try_grab_page.follow_page_pte.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec
>       32.57            +5.2       37.78 ±  3%  perf-profile.calltrace.cycles-pp.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv.do_syscall_64
>       33.67            +5.6       39.24 ±  3%  perf-profile.calltrace.cycles-pp.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        6.24            +6.1       12.34 ± 10%  perf-profile.calltrace.cycles-pp.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_readv
>       34.23            +6.2       40.39 ±  3%  perf-profile.calltrace.cycles-pp.process_vm_rw.__x64_sys_process_vm_readv.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_readv
>       34.22            +6.2       40.42 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_process_vm_readv.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_readv
>       34.39            +6.3       40.68 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_readv
>       34.49            +6.4       40.88 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.process_vm_readv
>       34.87            +6.6       41.43 ±  3%  perf-profile.calltrace.cycles-pp.process_vm_readv
>        6.26            +6.6       12.83 ± 11%  perf-profile.calltrace.cycles-pp.follow_page_pte.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core
>        7.43            +6.6       14.02 ±  8%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter.process_vm_rw_single_vec.process_vm_rw_core
>        7.70            +6.9       14.64 ±  8%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>        4.80 ±  2%      +7.2       11.95 ± 12%  perf-profile.calltrace.cycles-pp.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev
>        9.52            +9.3       18.86 ±  8%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev
>       10.80           +12.9       23.71 ± 11%  perf-profile.calltrace.cycles-pp.__get_user_pages.__get_user_pages_remote.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw
>       16.02 ±  2%     +19.0       35.05 ± 10%  perf-profile.calltrace.cycles-pp.process_vm_rw_single_vec.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev.do_syscall_64
>       16.70 ±  2%     +19.7       36.44 ± 10%  perf-profile.calltrace.cycles-pp.process_vm_rw_core.process_vm_rw.__x64_sys_process_vm_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       17.15 ±  2%     +20.4       37.51 ± 10%  perf-profile.calltrace.cycles-pp.process_vm_rw.__x64_sys_process_vm_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_writev
>       17.17 ±  2%     +20.4       37.55 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_process_vm_writev.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_writev
>       17.26 ±  2%     +20.5       37.72 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.process_vm_writev
>       17.31 ±  2%     +20.5       37.83 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.process_vm_writev
>       17.60 ±  2%     +20.8       38.42 ± 10%  perf-profile.calltrace.cycles-pp.process_vm_writev
>       18.10           -16.2        1.92 ±141%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       18.10           -16.2        1.92 ±141%  perf-profile.children.cycles-pp.cpu_startup_entry
>       18.08           -16.2        1.92 ±141%  perf-profile.children.cycles-pp.do_idle
>       17.94           -16.0        1.89 ±141%  perf-profile.children.cycles-pp.start_secondary
>       16.00            -8.0        8.02 ± 19%  perf-profile.children.cycles-pp.read
>       12.02            -7.9        4.10 ± 37%  perf-profile.children.cycles-pp.__schedule
>       13.10            -7.9        5.18 ± 30%  perf-profile.children.cycles-pp.pipe_read
>       13.22            -7.9        5.31 ± 29%  perf-profile.children.cycles-pp.new_sync_read
>       13.60            -7.9        5.70 ± 27%  perf-profile.children.cycles-pp.vfs_read
>       13.78            -7.5        6.25 ± 23%  perf-profile.children.cycles-pp.ksys_read
>        7.62            -7.0        0.65 ±142%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
>        7.92            -7.0        0.96 ±142%  perf-profile.children.cycles-pp.cpuidle_idle_call
>        7.18            -6.6        0.59 ±142%  perf-profile.children.cycles-pp.sched_ttwu_pending
>        7.14            -6.3        0.86 ±142%  perf-profile.children.cycles-pp.cpuidle_enter
>        7.24            -6.3        0.98 ±124%  perf-profile.children.cycles-pp.update_cfs_group
>        7.12            -6.3        0.86 ±142%  perf-profile.children.cycles-pp.cpuidle_enter_state
>        9.97            -6.0        3.96 ± 29%  perf-profile.children.cycles-pp.schedule
>        6.52            -5.7        0.79 ±142%  perf-profile.children.cycles-pp.mwait_idle_with_hints
>        7.11            -5.4        1.69 ± 57%  perf-profile.children.cycles-pp.ttwu_do_activate
>        7.07            -5.4        1.66 ± 58%  perf-profile.children.cycles-pp.enqueue_task_fair
>        8.61            -5.3        3.30 ± 44%  perf-profile.children.cycles-pp.__wake_up_common
>       10.86            -5.2        5.61 ± 26%  perf-profile.children.cycles-pp.ksys_write
>        8.76            -5.2        3.51 ± 41%  perf-profile.children.cycles-pp.__wake_up_common_lock
>       10.55            -5.2        5.32 ± 28%  perf-profile.children.cycles-pp.vfs_write
>        6.72            -5.2        1.50 ± 61%  perf-profile.children.cycles-pp.dequeue_task_fair
>       10.04            -5.2        4.88 ± 30%  perf-profile.children.cycles-pp.pipe_write
>       10.10            -5.1        5.00 ± 29%  perf-profile.children.cycles-pp.new_sync_write
>        8.26            -5.1        3.20 ± 44%  perf-profile.children.cycles-pp.autoremove_wake_function
>        8.22            -5.0        3.17 ± 44%  perf-profile.children.cycles-pp.try_to_wake_up
>        5.62            -4.7        0.94 ± 62%  perf-profile.children.cycles-pp.enqueue_entity
>       21.11            -4.4       16.69 ±  5%  perf-profile.children.cycles-pp.copyout
>        5.21            -4.4        0.84 ± 70%  perf-profile.children.cycles-pp.dequeue_entity
>        5.50            -4.3        1.25 ± 48%  perf-profile.children.cycles-pp.update_load_avg
>       25.20            -3.0       22.21 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
>       11.21            -2.9        8.33 ± 13%  perf-profile.children.cycles-pp.write
>        3.29            -2.5        0.83 ± 78%  perf-profile.children.cycles-pp.select_task_rq
>        3.22            -2.4        0.78 ± 83%  perf-profile.children.cycles-pp.select_task_rq_fair
>        2.78            -2.2        0.62 ± 93%  perf-profile.children.cycles-pp.select_idle_sibling
>        1.80 ±  2%      -1.5        0.29 ±137%  perf-profile.children.cycles-pp.available_idle_cpu
>        0.87            -0.6        0.22 ± 57%  perf-profile.children.cycles-pp.finish_task_switch
>        0.98            -0.5        0.45 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        0.94            -0.5        0.41 ± 27%  perf-profile.children.cycles-pp.prepare_to_wait_event
>        0.60 ±  2%      -0.5        0.13 ± 76%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>        1.04 ±  4%      -0.4        0.63 ± 14%  perf-profile.children.cycles-pp.stress_vm_child
>        0.58            -0.3        0.29 ± 28%  perf-profile.children.cycles-pp.update_rq_clock
>        0.69            -0.3        0.40 ± 19%  perf-profile.children.cycles-pp.prepare_task_switch
>        0.89 ±  3%      -0.3        0.62 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>        0.58            -0.3        0.31 ± 21%  perf-profile.children.cycles-pp.__switch_to_asm
>        0.52            -0.2        0.28 ± 21%  perf-profile.children.cycles-pp.___perf_sw_event
>        0.76 ±  4%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>        0.28 ±  3%      -0.2        0.09 ± 52%  perf-profile.children.cycles-pp._find_next_bit
>        0.50            -0.2        0.33 ± 13%  perf-profile.children.cycles-pp.security_file_permission
>        0.26 ±  2%      -0.2        0.09 ± 41%  perf-profile.children.cycles-pp.task_tick_fair
>        0.24 ±  6%      -0.2        0.08 ± 57%  perf-profile.children.cycles-pp.__irq_exit_rcu
>        0.48            -0.2        0.32 ±  5%  perf-profile.children.cycles-pp.set_next_entity
>        0.42 ±  4%      -0.1        0.27 ± 13%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>        0.30 ±  3%      -0.1        0.16 ± 18%  perf-profile.children.cycles-pp.scheduler_tick
>        0.37 ±  4%      -0.1        0.24 ± 13%  perf-profile.children.cycles-pp.tick_sched_timer
>        0.35 ±  4%      -0.1        0.22 ± 14%  perf-profile.children.cycles-pp.tick_sched_handle
>        0.34 ±  4%      -0.1        0.22 ± 15%  perf-profile.children.cycles-pp.update_process_times
>        0.25 ±  3%      -0.1        0.12 ± 40%  perf-profile.children.cycles-pp.find_vma
>        0.19 ±  7%      -0.1        0.07 ± 56%  perf-profile.children.cycles-pp.__softirqentry_text_start
>        0.68            -0.1        0.56 ±  5%  perf-profile.children.cycles-pp.mutex_lock
>        0.26 ±  3%      -0.1        0.14 ± 34%  perf-profile.children.cycles-pp.find_extend_vma
>        0.38 ±  2%      -0.1        0.26 ± 10%  perf-profile.children.cycles-pp.apparmor_file_permission
>        0.37            -0.1        0.27 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>        0.34            -0.1        0.25 ± 10%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>        0.24 ±  3%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
>        0.17 ±  4%      -0.1        0.09 ± 33%  perf-profile.children.cycles-pp.vmacache_find
>        0.64            -0.1        0.56 ±  6%  perf-profile.children.cycles-pp.switch_fpu_return
>        0.53 ±  4%      -0.1        0.46 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>        0.53 ±  4%      -0.1        0.46 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
>        0.19 ±  2%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
>        0.57            -0.1        0.50 ±  5%  perf-profile.children.cycles-pp.__switch_to
>        0.27            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
>        0.10 ±  5%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.anon_pipe_buf_release
>        0.13 ±  2%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>        0.17 ±  2%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.perf_tp_event
>        0.08 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
>        0.10            -0.0        0.09        perf-profile.children.cycles-pp.finish_wait
>        0.14            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.atime_needs_update
>        0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.file_update_time
>        0.06 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__rdgsbase_inactive
>        0.10 ±  6%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__wrgsbase_inactive
>        0.75            +0.0        0.79        perf-profile.children.cycles-pp.pick_next_task_fair
>        0.05            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.pick_next_entity
>        0.19 ±  2%      +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.down_read_killable
>        0.02 ±141%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_switch
>        0.05            +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>        0.02 ± 99%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.kmalloc_slab
>        0.14 ±  2%      +0.1        0.20        perf-profile.children.cycles-pp.down_read
>        0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.resched_curr
>        0.02 ± 99%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>        0.16 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.mmput
>        0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
>        0.13 ±  2%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.get_task_mm
>        0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.idr_find
>        0.24 ±  2%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
>        0.02 ±141%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.__calc_delta
>        0.66            +0.1        0.73 ±  2%  perf-profile.children.cycles-pp.update_curr
>        0.04 ± 44%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.memcg_slab_free_hook
>        0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.cpumask_next_and
>        0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>        0.08 ±  4%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.up_read
>        0.07 ± 11%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
>        0.13            +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.ttwu_do_wakeup
>        0.06 ±  6%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.current_time
>        0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.check_stack_object
>        0.11 ±  4%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.check_preempt_curr
>        0.15 ±  4%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.os_xsave
>        0.12 ±  4%      +0.1        0.23 ±  9%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>        0.16 ±  3%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.reweight_entity
>        0.61 ±  2%      +0.1        0.75 ±  2%  perf-profile.children.cycles-pp.find_get_task_by_vpid
>        0.19 ±  5%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.__radix_tree_lookup
>        0.10 ±  3%      +0.2        0.25 ± 10%  perf-profile.children.cycles-pp.__check_object_size
>        0.13 ±  3%      +0.2        0.29 ±  9%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>        0.11 ±  6%      +0.2        0.26 ± 11%  perf-profile.children.cycles-pp.follow_huge_addr
>        0.37 ±  2%      +0.2        0.53 ±  6%  perf-profile.children.cycles-pp.mm_access
>        0.00            +0.2        0.17 ±  9%  perf-profile.children.cycles-pp.check_preempt_wakeup
>        0.00            +0.2        0.17 ± 14%  perf-profile.children.cycles-pp.put_prev_entity
>        0.15 ±  3%      +0.2        0.39 ± 12%  perf-profile.children.cycles-pp.pud_huge
>        0.14 ±  3%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.mark_page_accessed
>        0.19 ±  3%      +0.3        0.44 ±  9%  perf-profile.children.cycles-pp.kfree
>        0.19 ±  3%      +0.3        0.50 ± 12%  perf-profile.children.cycles-pp.pmd_huge
>        0.31 ±  3%      +0.3        0.65 ±  9%  perf-profile.children.cycles-pp.__kmalloc
>        0.28 ±  3%      +0.4        0.67 ± 10%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>        0.26 ±  3%      +0.4        0.70 ± 12%  perf-profile.children.cycles-pp.vm_normal_page
>        0.28 ±  2%      +0.5        0.73 ± 11%  perf-profile.children.cycles-pp.folio_mark_accessed
>        0.40 ±  2%      +0.5        0.86 ± 10%  perf-profile.children.cycles-pp.__entry_text_start
>        0.77 ±  4%      +0.5        1.24 ± 10%  perf-profile.children.cycles-pp.stress_vm_rw
>        2.54            +0.6        3.10 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
>        0.44 ±  3%      +0.6        1.02 ± 10%  perf-profile.children.cycles-pp.__import_iovec
>        0.46 ±  3%      +0.6        1.05 ± 10%  perf-profile.children.cycles-pp.import_iovec
>        0.57 ±  2%      +0.7        1.26 ±  9%  perf-profile.children.cycles-pp._copy_from_user
>        0.47 ±  3%      +0.7        1.18 ± 11%  perf-profile.children.cycles-pp.rcu_all_qs
>        1.72            +0.9        2.58 ±  6%  perf-profile.children.cycles-pp.__cond_resched
>        0.75 ±  2%      +1.0        1.71 ±  9%  perf-profile.children.cycles-pp.iovec_from_user
>        0.00            +1.1        1.11 ± 16%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>        0.98 ±  2%      +1.1        2.10 ± 10%  perf-profile.children.cycles-pp.__might_sleep
>        0.70            +1.1        1.84 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>        0.76 ±  3%      +1.2        1.95 ± 11%  perf-profile.children.cycles-pp.follow_pud_mask
>        0.79            +1.3        2.06 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>        0.93 ±  2%      +1.3        2.22 ± 10%  perf-profile.children.cycles-pp.follow_page_mask
>        1.30 ±  2%      +1.5        2.80 ±  9%  perf-profile.children.cycles-pp.__might_fault
>        1.03 ±  2%      +1.6        2.67 ± 11%  perf-profile.children.cycles-pp.follow_pmd_mask
>        2.83            +1.7        4.55 ±  7%  perf-profile.children.cycles-pp.__might_resched
>        1.37            +1.9        3.26 ± 14%  perf-profile.children.cycles-pp.unpin_user_pages
>        1.30 ±  2%      +2.1        3.38 ± 14%  perf-profile.children.cycles-pp.unpin_user_pages_dirty_lock
>        3.29 ±  2%      +2.6        5.87 ± 11%  perf-profile.children.cycles-pp.try_grab_page
>       29.19            +2.6       31.78        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>        1.40            +3.0        4.42 ± 17%  perf-profile.children.cycles-pp.mod_node_page_state
>        2.13 ±  2%      +3.2        5.35 ± 14%  perf-profile.children.cycles-pp.gup_put_folio
>       34.26            +6.2       40.45 ±  3%  perf-profile.children.cycles-pp.__x64_sys_process_vm_readv
>       34.96            +6.7       41.64 ±  3%  perf-profile.children.cycles-pp.process_vm_readv
>        8.05            +7.0       15.10 ±  8%  perf-profile.children.cycles-pp.copyin
>        6.54            +7.1       13.60 ± 11%  perf-profile.children.cycles-pp.follow_page_pte
>       10.06            +9.7       19.72 ±  8%  perf-profile.children.cycles-pp.copy_page_from_iter
>       10.99           +13.2       24.22 ± 11%  perf-profile.children.cycles-pp.__get_user_pages
>       11.04           +13.3       24.31 ± 11%  perf-profile.children.cycles-pp.__get_user_pages_remote
>       77.15           +15.3       92.46 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
>       77.51           +15.4       92.94 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       17.18 ±  2%     +20.4       37.56 ± 10%  perf-profile.children.cycles-pp.__x64_sys_process_vm_writev
>       17.69 ±  2%     +20.9       38.64 ± 10%  perf-profile.children.cycles-pp.process_vm_writev
>       48.65           +24.3       72.98 ±  6%  perf-profile.children.cycles-pp.process_vm_rw_single_vec
>       50.39           +25.4       75.74 ±  6%  perf-profile.children.cycles-pp.process_vm_rw_core
>       51.40           +26.5       77.94 ±  6%  perf-profile.children.cycles-pp.process_vm_rw
>        7.23            -6.3        0.97 ±125%  perf-profile.self.cycles-pp.update_cfs_group
>        6.42            -5.6        0.78 ±142%  perf-profile.self.cycles-pp.mwait_idle_with_hints
>        4.82            -4.2        0.67 ± 85%  perf-profile.self.cycles-pp.update_load_avg
>        1.78 ±  2%      -1.5        0.29 ±137%  perf-profile.self.cycles-pp.available_idle_cpu
>        0.96            -0.5        0.42 ± 26%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        0.98 ±  2%      -0.5        0.45 ± 28%  perf-profile.self.cycles-pp.__schedule
>        0.59 ±  2%      -0.5        0.13 ± 78%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>        0.97            -0.4        0.61 ± 15%  perf-profile.self.cycles-pp.stress_vm_child
>        0.45 ±  2%      -0.3        0.14 ± 58%  perf-profile.self.cycles-pp.update_rq_clock
>        0.58            -0.3        0.30 ± 22%  perf-profile.self.cycles-pp.__switch_to_asm
>        0.58            -0.3        0.33 ± 17%  perf-profile.self.cycles-pp.pipe_read
>        0.35 ±  3%      -0.2        0.10 ± 59%  perf-profile.self.cycles-pp.__wake_up_common
>        0.47            -0.2        0.24 ± 23%  perf-profile.self.cycles-pp.___perf_sw_event
>        0.32 ±  2%      -0.2        0.13 ± 39%  perf-profile.self.cycles-pp.finish_task_switch
>        0.38 ±  2%      -0.2        0.21 ± 20%  perf-profile.self.cycles-pp.prepare_to_wait_event
>        0.25 ±  2%      -0.2        0.08 ± 53%  perf-profile.self.cycles-pp._find_next_bit
>        0.31 ±  3%      -0.2        0.14 ± 27%  perf-profile.self.cycles-pp.enqueue_entity
>        0.34 ± 15%      -0.2        0.18 ± 12%  perf-profile.self.cycles-pp.read
>        0.26 ±  2%      -0.2        0.11 ± 20%  perf-profile.self.cycles-pp.try_to_wake_up
>        0.29 ±  3%      -0.2        0.13 ± 30%  perf-profile.self.cycles-pp.prepare_task_switch
>        0.45 ±  2%      -0.1        0.31 ±  9%  perf-profile.self.cycles-pp.mutex_lock
>        0.26            -0.1        0.16 ± 14%  perf-profile.self.cycles-pp.apparmor_file_permission
>        0.13 ±  2%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
>        0.35            -0.1        0.26 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>        0.16 ±  3%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.dequeue_entity
>        0.56            -0.1        0.48 ±  5%  perf-profile.self.cycles-pp.__switch_to
>        0.15 ±  2%      -0.1        0.08 ± 37%  perf-profile.self.cycles-pp.vmacache_find
>        0.18 ±  2%      -0.1        0.11 ± 25%  perf-profile.self.cycles-pp.select_idle_sibling
>        0.19 ±  3%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
>        0.13 ±  3%      -0.1        0.07 ± 17%  perf-profile.self.cycles-pp.security_file_permission
>        0.19            -0.1        0.13 ± 18%  perf-profile.self.cycles-pp.enqueue_task_fair
>        0.35 ±  2%      -0.1        0.30 ±  8%  perf-profile.self.cycles-pp.update_curr
>        0.15 ±  2%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.dequeue_task_fair
>        0.26            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
>        0.38            -0.0        0.34 ±  3%  perf-profile.self.cycles-pp.find_get_task_by_vpid
>        0.09 ±  4%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.anon_pipe_buf_release
>        0.11 ±  4%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.atime_needs_update
>        0.21 ±  2%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.vfs_read
>        0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
>        0.11 ±  4%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.aa_file_perm
>        0.08 ±  6%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.select_task_rq
>        0.05            +0.0        0.06        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>        0.06            +0.0        0.07        perf-profile.self.cycles-pp.set_next_entity
>        0.07 ±  5%      +0.0        0.09        perf-profile.self.cycles-pp.get_task_mm
>        0.06 ±  9%      +0.0        0.08        perf-profile.self.cycles-pp.__get_user_pages_remote
>        0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__rdgsbase_inactive
>        0.10 ±  5%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__wrgsbase_inactive
>        0.11            +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
>        0.09 ±  9%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.ktime_get
>        0.03 ± 70%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.pick_next_entity
>        0.08 ±  6%      +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.vfs_write
>        0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.resched_curr
>        0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_switch
>        0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.put_prev_entity
>        0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
>        0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.idr_find
>        0.22 ±  2%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
>        0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.ksys_write
>        0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__wake_up_common_lock
>        0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.kmalloc_slab
>        0.10 ±  6%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.write
>        0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.check_preempt_wakeup
>        0.08 ±  6%      +0.1        0.15 ±  9%  perf-profile.self.cycles-pp.up_read
>        0.01 ±223%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
>        0.01 ±223%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__calc_delta
>        0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.check_stack_object
>        0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
>        0.02 ±141%      +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.new_sync_write
>        0.02 ±141%      +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>        0.06 ±  8%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.follow_huge_addr
>        0.10 ±  4%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>        0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.current_time
>        0.06            +0.1        0.15 ± 11%  perf-profile.self.cycles-pp.__import_iovec
>        0.05 ±  8%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.__check_object_size
>        0.03 ± 70%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>        0.19 ±  3%      +0.1        0.30 ±  5%  perf-profile.self.cycles-pp.process_vm_readv
>        0.15 ±  3%      +0.1        0.25 ±  5%  perf-profile.self.cycles-pp.os_xsave
>        0.00            +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.memcg_slab_free_hook
>        0.07 ±  5%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp._copy_from_user
>        0.15 ±  2%      +0.1        0.26 ±  6%  perf-profile.self.cycles-pp.pipe_write
>        0.05            +0.1        0.16 ± 12%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>        0.12 ±  3%      +0.1        0.24 ±  8%  perf-profile.self.cycles-pp.__entry_text_start
>        0.00            +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.schedule
>        0.14 ± 12%      +0.1        0.26 ±  5%  perf-profile.self.cycles-pp.process_vm_rw
>        0.38            +0.1        0.51 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>        0.19 ±  7%      +0.1        0.32 ±  6%  perf-profile.self.cycles-pp.__radix_tree_lookup
>        0.09 ±  4%      +0.1        0.23 ± 10%  perf-profile.self.cycles-pp.iovec_from_user
>        0.09            +0.1        0.24 ± 11%  perf-profile.self.cycles-pp.mark_page_accessed
>        0.14 ±  3%      +0.2        0.29 ±  9%  perf-profile.self.cycles-pp.process_vm_rw_core
>        0.13 ±  2%      +0.2        0.28 ±  9%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>        0.13 ±  2%      +0.2        0.29 ± 10%  perf-profile.self.cycles-pp.process_vm_writev
>        0.10 ±  3%      +0.2        0.26 ± 13%  perf-profile.self.cycles-pp.pud_huge
>        0.09 ±  5%      +0.2        0.26 ± 13%  perf-profile.self.cycles-pp.pmd_huge
>        0.14 ±  3%      +0.2        0.31 ± 11%  perf-profile.self.cycles-pp.copyout
>        0.14 ±  4%      +0.2        0.31 ± 10%  perf-profile.self.cycles-pp.kfree
>        0.17 ±  3%      +0.2        0.35 ±  9%  perf-profile.self.cycles-pp.do_syscall_64
>        0.18 ±  3%      +0.2        0.36 ±  9%  perf-profile.self.cycles-pp.__kmalloc
>        0.18 ±  2%      +0.3        0.45 ± 10%  perf-profile.self.cycles-pp.copyin
>        0.24 ±  3%      +0.3        0.50 ±  9%  perf-profile.self.cycles-pp.__might_fault
>        0.11 ±  5%      +0.3        0.41 ± 22%  perf-profile.self.cycles-pp.ksys_read
>        0.30 ±  3%      +0.3        0.65 ± 12%  perf-profile.self.cycles-pp.unpin_user_pages
>        0.22 ±  3%      +0.4        0.58 ± 12%  perf-profile.self.cycles-pp.vm_normal_page
>        0.26 ±  4%      +0.4        0.62 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
>        0.28 ±  2%      +0.4        0.65 ± 10%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>        0.23 ±  3%      +0.4        0.61 ± 12%  perf-profile.self.cycles-pp.folio_mark_accessed
>        0.28 ±  4%      +0.5        0.73 ± 13%  perf-profile.self.cycles-pp.unpin_user_pages_dirty_lock
>        0.67 ±  4%      +0.5        1.15 ± 12%  perf-profile.self.cycles-pp.stress_vm_rw
>        0.56 ±  2%      +0.5        1.06 ±  8%  perf-profile.self.cycles-pp.process_vm_rw_single_vec
>        0.91            +0.6        1.55 ±  8%  perf-profile.self.cycles-pp.__cond_resched
>        0.81 ±  2%      +0.9        1.72 ± 10%  perf-profile.self.cycles-pp.__might_sleep
>        0.61 ±  3%      +0.9        1.55 ± 11%  perf-profile.self.cycles-pp.follow_pud_mask
>        1.94            +0.9        2.89 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
>        1.60            +1.0        2.57 ±  7%  perf-profile.self.cycles-pp.copy_page_to_iter
>        2.56 ±  2%      +1.0        3.61 ±  7%  perf-profile.self.cycles-pp.try_grab_page
>        0.88 ±  2%      +1.1        1.98 ± 10%  perf-profile.self.cycles-pp.copy_page_from_iter
>        0.82 ±  3%      +1.1        1.95 ± 11%  perf-profile.self.cycles-pp.follow_page_mask
>        2.60            +1.4        3.98 ±  6%  perf-profile.self.cycles-pp.__might_resched
>        0.88 ±  2%      +1.4        2.27 ± 11%  perf-profile.self.cycles-pp.follow_pmd_mask
>        0.88 ±  2%      +1.4        2.28 ± 11%  perf-profile.self.cycles-pp.__get_user_pages
>        1.43 ±  2%      +1.7        3.15 ± 12%  perf-profile.self.cycles-pp.gup_put_folio
>        1.50 ±  3%      +2.3        3.79 ± 11%  perf-profile.self.cycles-pp.follow_page_pte
>       28.89            +2.5       31.42        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>        1.26            +2.8        4.04 ± 18%  perf-profile.self.cycles-pp.mod_node_page_state
> 
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
