Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126014B07A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiBJH55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:57:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiBJH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:57:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859771086
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644479871; x=1676015871;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=SLeJsQM2Rsrb5MmRUK0VEdP4kgbadyWBcPetE/s3igo=;
  b=mqUuznnL0hDx3JFuwm1f1WjxJMqrXtRh6KTT2mfflxbpwNqYP4WnpLUk
   5tXyfrxjVbc00Z+eu1DFEom9ruaop+7Cm+lJ/ZZavkqBK4zS/Vw4CKwaE
   vSUxt4UWfyj9Rnat+3I1p+8jU3yaWFVaBzJYdmxISl4VdBErKF0qVJzvS
   86k0RGPaR2GFl9H5w50BcsKf3QoI7e+4XDZgfiWxy8jwqACt4HFlhwlDL
   rDnBtxTZ4mE67Afg3CPfd0oPF2mtNoYcPDcAYaxYa5M2QACU7lPrGIR9K
   gSp/HQWMPevBgG1f8AVUpvYi/2Wsj3imqMNQdrCoIkQfdKuPcPDFDvYk0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="312724092"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="yaml'?scan'208";a="312724092"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:57:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="yaml'?scan'208";a="482658856"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:57:42 -0800
Date:   Thu, 10 Feb 2022 15:57:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     0day robot <lkp@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        aubrey.li@linux.intel.com
Subject: [sched]  e9accc2386:  stress-ng.dccp.ops_per_sec 46.9% improvement
Message-ID: <20220210075739.GE4074@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207034013.599214-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 46.9% improvement of stress-ng.dccp.ops_per_sec due to commit:


commit: e9accc2386f31d149ea339e8be401ad36361c9be ("[PATCH][RFC] sched: Stop searching for idle cpu if the LLC domain is overloaded")
url: https://github.com/0day-ci/linux/commits/Chen-Yu/sched-Stop-searching-for-idle-cpu-if-the-LLC-domain-is-overloaded/20220207-135940
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 6275d291a763090ed1ff8aed7376aebd9f9dd6f5
patch link: https://lore.kernel.org/lkml/20220207034013.599214-1-yu.c.chen@intel.com

in testcase: stress-ng
on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
with following parameters:

	nr_threads: 100%
	testtime: 60s
	class: network
	test: dccp
	cpufreq_governor: performance
	ucode: 0xd000280


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps 16.8% improvement                              |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory |
| test parameters  | cluster=cs-localhost                                                            |
|                  | cpufreq_governor=performance                                                    |
|                  | ip=ipv4                                                                         |
|                  | nr_threads=50%                                                                  |
|                  | runtime=300s                                                                    |
|                  | send_size=5K                                                                    |
|                  | test=TCP_SENDFILE                                                               |
|                  | ucode=0xd000280                                                                 |
+------------------+---------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  network/gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp6/dccp/stress-ng/60s/0xd000280

commit: 
  6275d291a7 ("Merge irq/core into tip/master")
  e9accc2386 ("sched: Stop searching for idle cpu if the LLC domain is overloaded")

6275d291a763090e e9accc2386f31d149ea339e8be4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     90045           +46.9%     132301        stress-ng.dccp.messages_per_sec
  10977133           +46.9%   16128324        stress-ng.dccp.ops
    182946           +46.9%     268798        stress-ng.dccp.ops_per_sec
   1962636 ±  9%  +50620.0%  9.955e+08        stress-ng.time.involuntary_context_switches
     23828           -13.0%      20733        stress-ng.time.minor_page_faults
    321.72 ±  2%     -27.0%     234.84        stress-ng.time.user_time
 2.002e+08          +408.6%  1.018e+09        stress-ng.time.voluntary_context_switches
 1.235e+09           -52.4%  5.879e+08 ± 11%  cpuidle..time
  1.61e+08 ±  2%     -85.6%   23133750 ± 21%  cpuidle..usage
     47363 ± 10%     +26.7%      60009 ± 17%  numa-meminfo.node1.Mapped
    145038 ±  3%     +10.0%     159495 ±  3%  numa-meminfo.node1.Shmem
     14.71            -8.2        6.49 ± 16%  mpstat.cpu.all.idle%
      1.43            -0.4        1.01 ±  5%  mpstat.cpu.all.irq%
     21.85            +9.1       30.94        mpstat.cpu.all.soft%
      4.39            -1.3        3.10        mpstat.cpu.all.usr%
  11920497           +37.7%   16417333        numa-numastat.node0.local_node
  11960088           +37.7%   16473416        numa-numastat.node0.numa_hit
  11819045           +38.4%   16362446        numa-numastat.node1.local_node
  11894761           +38.0%   16420275        numa-numastat.node1.numa_hit
   7316794           +27.4%    9320086 ±  2%  numa-vmstat.node0.numa_hit
   7277597           +27.3%    9262524 ±  2%  numa-vmstat.node0.numa_local
   6104502           +34.8%    8228122 ±  3%  numa-vmstat.node1.numa_hit
   5995904           +35.7%    8138907 ±  3%  numa-vmstat.node1.numa_local
     16.83 ±  2%     -48.5%       8.67 ± 12%  vmstat.cpu.id
    123.00           +40.7%     173.00        vmstat.procs.r
   5869578          +430.0%   31106336        vmstat.system.cs
    759060           -58.5%     314852        vmstat.system.in
      3271            -6.6%       3054        turbostat.Bzy_MHz
 1.349e+08 ±  2%     -85.2%   20007631 ± 20%  turbostat.C1
      7.21 ±  2%      -6.4        0.86 ± 18%  turbostat.C1%
  23689617           -93.7%    1490049 ± 10%  turbostat.C1E
      5.95 ± 35%      -4.3        1.64 ±103%  turbostat.C1E%
  49285246           -58.3%   20566340        turbostat.IRQ
     40345 ±  2%      +9.7%      44254        proc-vmstat.nr_shmem
     86949            -7.8%      80178        proc-vmstat.nr_slab_unreclaimable
      5499 ± 45%     -74.7%       1390 ± 16%  proc-vmstat.numa_hint_faults
      1608 ± 14%     -75.9%     388.17 ± 42%  proc-vmstat.numa_hint_faults_local
  23856870           +38.0%   32925200        proc-vmstat.numa_hit
  23741562           +38.2%   32811289        proc-vmstat.numa_local
     70447 ±  3%      +9.0%      76757 ±  2%  proc-vmstat.pgactivate
  23854818           +38.0%   32923563        proc-vmstat.pgalloc_normal
    443817            -2.1%     434710        proc-vmstat.pgfault
  23637556           +38.3%   32697359        proc-vmstat.pgfree
     21388            +8.0%      23108 ±  2%  proc-vmstat.pgreuse
    100466 ± 27%     -82.6%      17526 ±116%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   2432999           -53.8%    1124652 ± 99%  sched_debug.cfs_rq:/.MIN_vruntime.max
    476335 ± 14%     -71.5%     135698 ±104%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.59 ±  5%     +35.6%       0.79 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
      5426 ±  3%     +77.8%       9647 ± 39%  sched_debug.cfs_rq:/.load.avg
    100466 ± 27%     -82.6%      17526 ±116%  sched_debug.cfs_rq:/.max_vruntime.avg
   2432999           -53.8%    1124652 ± 99%  sched_debug.cfs_rq:/.max_vruntime.max
    476335 ± 14%     -71.5%     135698 ±104%  sched_debug.cfs_rq:/.max_vruntime.stddev
   2060801           -10.9%    1835538 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     39916 ±  8%     +20.6%      48123 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.29 ±  7%     -37.7%       0.18 ± 23%  sched_debug.cfs_rq:/.nr_running.stddev
    410.63 ±  4%     -44.4%     228.36 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
     39957 ±  8%     +20.6%      48195 ±  4%  sched_debug.cfs_rq:/.spread0.stddev
      2089 ± 12%     -38.0%       1295 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    399.61 ±  4%     -51.4%     194.19 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    327.45 ±  3%     +41.1%     461.93        sched_debug.cfs_rq:/.util_est_enqueued.avg
    243.96 ±  5%     -38.9%     148.96 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    694791 ± 21%     +62.7%    1130760 ± 10%  sched_debug.cpu.avg_idle.max
    149474 ±  6%     +43.6%     214589 ±  4%  sched_debug.cpu.avg_idle.stddev
      4.34 ± 12%    +100.5%       8.70 ± 37%  sched_debug.cpu.clock.stddev
      3136 ±  2%     +11.2%       3488        sched_debug.cpu.curr->pid.avg
      1694 ±  7%     -50.2%     843.45 ± 27%  sched_debug.cpu.curr->pid.stddev
      0.58 ±  3%     +40.8%       0.81 ±  3%  sched_debug.cpu.nr_running.avg
   1422138          +431.9%    7563774        sched_debug.cpu.nr_switches.avg
   1536440 ±  3%    +412.3%    7871294        sched_debug.cpu.nr_switches.max
   1211442 ±  2%    +403.3%    6097679 ±  3%  sched_debug.cpu.nr_switches.min
     52546 ± 23%    +280.0%     199667 ±  7%  sched_debug.cpu.nr_switches.stddev
      7.67 ±  2%     -90.1%       0.76 ± 25%  perf-stat.i.MPKI
 5.135e+10           +32.3%  6.795e+10        perf-stat.i.branch-instructions
      1.07            +0.4        1.44        perf-stat.i.branch-miss-rate%
 5.208e+08           +79.7%   9.36e+08        perf-stat.i.branch-misses
      2.43 ±  5%     +20.1       22.48 ±  4%  perf-stat.i.cache-miss-rate%
  46712186           -46.5%   24986570        perf-stat.i.cache-misses
 2.056e+09           -94.4%  1.144e+08 ±  5%  perf-stat.i.cache-references
   6076690          +431.7%   32310480        perf-stat.i.context-switches
      1.41           -25.8%       1.05        perf-stat.i.cpi
 3.795e+11            -2.7%  3.693e+11        perf-stat.i.cpu-cycles
    412360 ±  2%     -99.6%       1832 ±  9%  perf-stat.i.cpu-migrations
      8002           +81.2%      14502        perf-stat.i.cycles-between-cache-misses
      0.01 ± 14%      -0.0        0.01 ± 43%  perf-stat.i.dTLB-load-miss-rate%
  10157566 ±  6%     -88.7%    1146598 ±  6%  perf-stat.i.dTLB-load-misses
 7.806e+10           +32.0%   1.03e+11        perf-stat.i.dTLB-loads
      0.01 ± 14%      -0.0        0.00 ± 30%  perf-stat.i.dTLB-store-miss-rate%
   1874231 ±  8%     -87.9%     227410        perf-stat.i.dTLB-store-misses
 4.738e+10           +30.5%  6.181e+10        perf-stat.i.dTLB-stores
 2.666e+11           +33.5%  3.558e+11        perf-stat.i.instructions
      0.71           +34.6%       0.96        perf-stat.i.ipc
      2.96            -2.7%       2.89        perf-stat.i.metric.GHz
    255.07 ±  2%    +307.7%       1039 ±  3%  perf-stat.i.metric.K/sec
      1397           +30.2%       1819        perf-stat.i.metric.M/sec
     66.73           +24.4       91.16        perf-stat.i.node-load-miss-rate%
   4016095           -17.6%    3310212 ±  2%  perf-stat.i.node-load-misses
   2005931           -85.5%     291098 ±  8%  perf-stat.i.node-loads
     23.26           +48.7       71.99        perf-stat.i.node-store-miss-rate%
  13385913           -88.9%    1488913 ±  3%  perf-stat.i.node-stores
      7.72           -95.8%       0.32 ±  5%  perf-stat.overall.MPKI
      1.02            +0.4        1.38        perf-stat.overall.branch-miss-rate%
      2.29           +19.7       21.99 ±  4%  perf-stat.overall.cache-miss-rate%
      1.42           -27.1%       1.04        perf-stat.overall.cpi
      8076           +82.2%      14714        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  6%      -0.0        0.00 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  8%      -0.0        0.00 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.70           +37.2%       0.96        perf-stat.overall.ipc
     66.24           +25.0       91.26        perf-stat.overall.node-load-miss-rate%
     22.89           +49.7       72.60        perf-stat.overall.node-store-miss-rate%
 5.055e+10           +32.5%  6.697e+10        perf-stat.ps.branch-instructions
  5.13e+08           +79.8%  9.225e+08        perf-stat.ps.branch-misses
  46290158           -46.5%   24744873        perf-stat.ps.cache-misses
 2.026e+09           -94.4%  1.128e+08 ±  5%  perf-stat.ps.cache-references
   5981296          +432.5%   31852990        perf-stat.ps.context-switches
 3.738e+11            -2.6%   3.64e+11        perf-stat.ps.cpu-cycles
    406893 ±  2%     -99.6%       1775 ±  9%  perf-stat.ps.cpu-migrations
  10048476 ±  6%     -88.6%    1145857 ±  6%  perf-stat.ps.dTLB-load-misses
 7.685e+10           +32.1%  1.015e+11        perf-stat.ps.dTLB-loads
   1844285 ±  7%     -87.9%     223675        perf-stat.ps.dTLB-store-misses
 4.664e+10           +30.6%  6.092e+10        perf-stat.ps.dTLB-stores
 2.624e+11           +33.6%  3.507e+11        perf-stat.ps.instructions
   3962058           -17.6%    3266404 ±  2%  perf-stat.ps.node-load-misses
   2019070           -84.5%     312407 ±  7%  perf-stat.ps.node-loads
  13289353           -88.8%    1493356 ±  3%  perf-stat.ps.node-stores
 1.645e+13           +35.2%  2.224e+13        perf-stat.total.instructions
   3613065           +17.3%    4237109 ±  2%  softirqs.CPU0.NET_RX
     30760 ±  4%     +38.7%      42678 ±  3%  softirqs.CPU0.RCU
     26366 ±  5%     -74.2%       6809 ± 10%  softirqs.CPU0.SCHED
     13247 ±  3%     -48.1%       6877 ±  2%  softirqs.CPU0.TIMER
   3614438           +19.0%    4302434        softirqs.CPU1.NET_RX
     28024           +51.7%      42507 ±  2%  softirqs.CPU1.RCU
     24045 ±  3%     -79.5%       4936 ± 18%  softirqs.CPU1.SCHED
     12244           -46.1%       6596 ±  3%  softirqs.CPU1.TIMER
   3612493           +17.6%    4248103 ±  2%  softirqs.CPU10.NET_RX
     27077           +48.3%      40149 ±  2%  softirqs.CPU10.RCU
     22734 ±  2%     -84.9%       3438 ± 13%  softirqs.CPU10.SCHED
     12368           -47.0%       6552 ±  4%  softirqs.CPU10.TIMER
   3621450           +15.8%    4195321 ±  2%  softirqs.CPU100.NET_RX
     26447           +50.9%      39914 ±  2%  softirqs.CPU100.RCU
     22669 ±  4%     -86.4%       3083 ± 21%  softirqs.CPU100.SCHED
     12504 ±  2%     -48.7%       6409        softirqs.CPU100.TIMER
   3615746           +17.1%    4233335        softirqs.CPU101.NET_RX
     26385           +53.9%      40603        softirqs.CPU101.RCU
     22338 ±  2%     -86.4%       3038 ± 17%  softirqs.CPU101.SCHED
     12519 ±  2%     -49.1%       6372        softirqs.CPU101.TIMER
   3649966           +15.1%    4201301        softirqs.CPU102.NET_RX
     26637           +49.6%      39852 ±  2%  softirqs.CPU102.RCU
     22663 ±  3%     -87.2%       2911 ± 15%  softirqs.CPU102.SCHED
     12634 ±  3%     -49.2%       6419        softirqs.CPU102.TIMER
   3674424           +15.9%    4258664        softirqs.CPU103.NET_RX
     26619           +52.5%      40597        softirqs.CPU103.RCU
     22296 ±  2%     -87.2%       2843 ± 18%  softirqs.CPU103.SCHED
     12457           -48.2%       6450        softirqs.CPU103.TIMER
   3709657           +14.1%    4234036 ±  2%  softirqs.CPU104.NET_RX
     26782           +48.8%      39863 ±  3%  softirqs.CPU104.RCU
     22448           -87.9%       2724 ± 15%  softirqs.CPU104.SCHED
     12511           -48.6%       6436        softirqs.CPU104.TIMER
   3631056           +16.2%    4220243 ±  2%  softirqs.CPU105.NET_RX
     26492           +51.4%      40112 ±  2%  softirqs.CPU105.RCU
     22383           -86.5%       3012 ± 24%  softirqs.CPU105.SCHED
     12320           -47.9%       6425        softirqs.CPU105.TIMER
   3695635           +14.2%    4219356 ±  2%  softirqs.CPU106.NET_RX
     26780           +48.8%      39854 ±  2%  softirqs.CPU106.RCU
     22429 ±  2%     -85.8%       3173 ± 27%  softirqs.CPU106.SCHED
     12445 ±  2%     -48.4%       6416        softirqs.CPU106.TIMER
   3688361           +14.2%    4213064 ±  2%  softirqs.CPU107.NET_RX
     26628           +50.6%      40108 ±  3%  softirqs.CPU107.RCU
     22334           -87.5%       2795 ± 19%  softirqs.CPU107.SCHED
     12485 ±  2%     -48.6%       6422        softirqs.CPU107.TIMER
   3601339           +16.4%    4192423 ±  2%  softirqs.CPU108.NET_RX
     26224           +52.5%      39986 ±  3%  softirqs.CPU108.RCU
     22217 ±  2%     -85.5%       3211 ± 26%  softirqs.CPU108.SCHED
     12525 ±  2%     -46.7%       6680 ±  9%  softirqs.CPU108.TIMER
   3629500           +16.0%    4209881 ±  2%  softirqs.CPU109.NET_RX
     26337           +51.3%      39860 ±  3%  softirqs.CPU109.RCU
     22154           -86.3%       3025 ± 23%  softirqs.CPU109.SCHED
     12417 ±  2%     -48.2%       6438        softirqs.CPU109.TIMER
   3672766           +17.2%    4303662        softirqs.CPU11.NET_RX
     27062           +53.8%      41612        softirqs.CPU11.RCU
     22539 ±  2%     -84.0%       3602 ± 34%  softirqs.CPU11.SCHED
     12520           -49.0%       6386        softirqs.CPU11.TIMER
   3642769           +17.8%    4290376        softirqs.CPU110.NET_RX
     26083           +56.0%      40686        softirqs.CPU110.RCU
     22109           -86.7%       2945 ± 18%  softirqs.CPU110.SCHED
     12606 ±  2%     -48.9%       6441        softirqs.CPU110.TIMER
   3657738           +15.2%    4215256        softirqs.CPU111.NET_RX
     26506           +50.6%      39909 ±  3%  softirqs.CPU111.RCU
     22352 ±  2%     -87.2%       2868 ± 18%  softirqs.CPU111.SCHED
     12239 ±  2%     -47.3%       6451        softirqs.CPU111.TIMER
   3649204           +16.5%    4251130        softirqs.CPU112.NET_RX
     26355           +51.2%      39853        softirqs.CPU112.RCU
     22318 ±  2%     -87.0%       2908 ± 18%  softirqs.CPU112.SCHED
     12606           -49.0%       6433        softirqs.CPU112.TIMER
   3611811           +15.6%    4175178 ±  2%  softirqs.CPU113.NET_RX
     26184 ±  2%     +48.5%      38881 ±  3%  softirqs.CPU113.RCU
     22277 ±  2%     -86.4%       3031 ± 14%  softirqs.CPU113.SCHED
     12579 ±  2%     -48.3%       6507        softirqs.CPU113.TIMER
   3588944           +18.5%    4253279        softirqs.CPU114.NET_RX
     26177           +52.5%      39931        softirqs.CPU114.RCU
     22289 ±  2%     -86.6%       2978 ± 17%  softirqs.CPU114.SCHED
     12542           -48.4%       6469        softirqs.CPU114.TIMER
   3689669           +13.8%    4199860        softirqs.CPU115.NET_RX
     26547           +48.8%      39505 ±  3%  softirqs.CPU115.RCU
     22324           -85.3%       3283 ± 27%  softirqs.CPU115.SCHED
     12640 ±  2%     -46.1%       6819 ± 13%  softirqs.CPU115.TIMER
   3670306           +15.3%    4230996        softirqs.CPU116.NET_RX
     26503           +50.9%      39991        softirqs.CPU116.RCU
     22375 ±  2%     -86.5%       3023 ± 14%  softirqs.CPU116.SCHED
     12539 ±  2%     -49.0%       6389        softirqs.CPU116.TIMER
   3638583           +14.8%    4177232 ±  2%  softirqs.CPU117.NET_RX
     26329           +48.7%      39162 ±  3%  softirqs.CPU117.RCU
     22288 ±  2%     -86.8%       2940 ± 13%  softirqs.CPU117.SCHED
     12527           -48.7%       6425        softirqs.CPU117.TIMER
   3618613           +14.1%    4128766 ±  2%  softirqs.CPU118.NET_RX
     26412           +46.4%      38660 ±  2%  softirqs.CPU118.RCU
     22381           -86.7%       2975 ± 16%  softirqs.CPU118.SCHED
     12455           -47.9%       6487        softirqs.CPU118.TIMER
   3681733           +15.7%    4261202        softirqs.CPU119.NET_RX
     26542           +50.5%      39948        softirqs.CPU119.RCU
     22275           -85.9%       3129 ± 20%  softirqs.CPU119.SCHED
     12435 ±  2%     -46.4%       6661 ±  8%  softirqs.CPU119.TIMER
   3639537           +16.0%    4223340 ±  2%  softirqs.CPU12.NET_RX
     27137           +48.2%      40216 ±  2%  softirqs.CPU12.RCU
     22643 ±  2%     -86.2%       3115 ± 20%  softirqs.CPU12.SCHED
     12512 ±  2%     -48.8%       6407 ±  2%  softirqs.CPU12.TIMER
   3659696           +15.5%    4227664        softirqs.CPU120.NET_RX
     26558           +49.0%      39566 ±  2%  softirqs.CPU120.RCU
     22438 ±  2%     -87.0%       2909 ± 10%  softirqs.CPU120.SCHED
     12395 ±  2%     -47.9%       6457        softirqs.CPU120.TIMER
   3662175           +15.7%    4236037        softirqs.CPU121.NET_RX
     26351           +52.1%      40078        softirqs.CPU121.RCU
     22203 ±  2%     -86.9%       2905 ± 16%  softirqs.CPU121.SCHED
     12410           -48.4%       6398        softirqs.CPU121.TIMER
   3650595           +13.9%    4156471 ±  2%  softirqs.CPU122.NET_RX
     26327           +49.4%      39321 ±  2%  softirqs.CPU122.RCU
     22321           -86.7%       2977 ± 17%  softirqs.CPU122.SCHED
     12270 ±  3%     -47.4%       6455 ±  2%  softirqs.CPU122.TIMER
   3608763           +16.1%    4190754 ±  2%  softirqs.CPU123.NET_RX
     26025           +50.3%      39127 ±  3%  softirqs.CPU123.RCU
     22048 ±  2%     -86.4%       3007 ± 19%  softirqs.CPU123.SCHED
     12519 ±  2%     -48.6%       6431        softirqs.CPU123.TIMER
   3631782           +16.4%    4226236        softirqs.CPU124.NET_RX
     26144           +51.6%      39625 ±  2%  softirqs.CPU124.RCU
     22153           -86.7%       2937 ± 18%  softirqs.CPU124.SCHED
     12573           -48.8%       6439        softirqs.CPU124.TIMER
   3600753           +18.3%    4259040        softirqs.CPU125.NET_RX
     26106           +54.1%      40219        softirqs.CPU125.RCU
     22197 ±  2%     -86.2%       3071 ± 32%  softirqs.CPU125.SCHED
     12560 ±  2%     -48.4%       6480        softirqs.CPU125.TIMER
   3643036           +15.9%    4221932        softirqs.CPU126.NET_RX
     26416           +51.4%      39998        softirqs.CPU126.RCU
     22361 ±  2%     -85.7%       3194 ± 15%  softirqs.CPU126.SCHED
     12407 ±  2%     -48.7%       6365 ±  2%  softirqs.CPU126.TIMER
     24630 ±  2%     +43.5%      35356 ±  2%  softirqs.CPU127.RCU
     19919 ±  5%     -84.5%       3097 ± 16%  softirqs.CPU127.SCHED
     10909 ±  5%     -50.8%       5363        softirqs.CPU127.TIMER
   3584110           +19.7%    4291793        softirqs.CPU13.NET_RX
     26647           +56.5%      41702 ±  2%  softirqs.CPU13.RCU
     22555 ±  2%     -83.5%       3729 ± 25%  softirqs.CPU13.SCHED
     12349           -44.9%       6810 ±  7%  softirqs.CPU13.TIMER
   3612703           +18.4%    4276695        softirqs.CPU14.NET_RX
     26878           +52.6%      41016        softirqs.CPU14.RCU
     22407 ±  2%     -84.0%       3575 ± 22%  softirqs.CPU14.SCHED
     12332           -46.9%       6548 ±  6%  softirqs.CPU14.TIMER
   3632140           +17.8%    4280149        softirqs.CPU15.NET_RX
     26970           +51.7%      40910        softirqs.CPU15.RCU
     22697           -83.9%       3649 ± 19%  softirqs.CPU15.SCHED
     12380           -47.2%       6538 ±  4%  softirqs.CPU15.TIMER
   3615938           +17.3%    4241793        softirqs.CPU16.NET_RX
     27866 ±  2%     +45.8%      40631        softirqs.CPU16.RCU
     23132 ±  3%     -84.2%       3650 ± 20%  softirqs.CPU16.SCHED
     12466 ±  5%     -47.9%       6494 ±  5%  softirqs.CPU16.TIMER
   3661467           +16.6%    4268092        softirqs.CPU17.NET_RX
     27308 ±  2%     +49.2%      40747        softirqs.CPU17.RCU
     22603 ±  2%     -84.6%       3476 ± 27%  softirqs.CPU17.SCHED
     12272           -47.2%       6477 ±  4%  softirqs.CPU17.TIMER
   3615459           +18.6%    4286163        softirqs.CPU18.NET_RX
     26885           +53.9%      41388 ±  3%  softirqs.CPU18.RCU
     22564 ±  2%     -83.8%       3648 ± 20%  softirqs.CPU18.SCHED
     12175           -46.7%       6491 ±  4%  softirqs.CPU18.TIMER
   3617218           +18.7%    4292429        softirqs.CPU19.NET_RX
     27082           +51.6%      41044        softirqs.CPU19.RCU
     22586 ±  2%     -84.1%       3586 ± 15%  softirqs.CPU19.SCHED
     12244 ±  2%     -48.1%       6356        softirqs.CPU19.TIMER
   3656892           +18.3%    4327539        softirqs.CPU2.NET_RX
     28667 ±  5%     +45.9%      41827 ±  2%  softirqs.CPU2.RCU
     23403 ±  2%     -80.8%       4500 ±  8%  softirqs.CPU2.SCHED
     12481 ±  4%     -47.7%       6523 ±  2%  softirqs.CPU2.TIMER
   3680328           +16.8%    4297128        softirqs.CPU20.NET_RX
     27910 ±  5%     +47.7%      41237        softirqs.CPU20.RCU
     22551 ±  2%     -83.0%       3842 ± 11%  softirqs.CPU20.SCHED
     12410 ±  4%     -47.1%       6560 ±  4%  softirqs.CPU20.TIMER
   3672767           +16.9%    4291707        softirqs.CPU21.NET_RX
     27188           +50.7%      40985        softirqs.CPU21.RCU
     22725           -83.9%       3652 ± 12%  softirqs.CPU21.SCHED
     12211           -47.9%       6356        softirqs.CPU21.TIMER
   3645881           +17.9%    4299308        softirqs.CPU22.NET_RX
     27031 ±  2%     +52.0%      41083        softirqs.CPU22.RCU
     22353           -83.0%       3790 ± 11%  softirqs.CPU22.SCHED
     12303           -48.3%       6356        softirqs.CPU22.TIMER
   3648414           +15.6%    4218092        softirqs.CPU23.NET_RX
     26615           +51.0%      40181        softirqs.CPU23.RCU
     22251 ±  2%     -83.7%       3630 ± 14%  softirqs.CPU23.SCHED
     12283           -48.7%       6299 ±  2%  softirqs.CPU23.TIMER
   3642421           +15.9%    4221316 ±  2%  softirqs.CPU24.NET_RX
     28828 ± 15%     +40.5%      40491 ±  3%  softirqs.CPU24.RCU
     22624 ±  3%     -84.3%       3550 ± 15%  softirqs.CPU24.SCHED
     12282           -48.5%       6326        softirqs.CPU24.TIMER
   3613656           +17.7%    4254764        softirqs.CPU25.NET_RX
     27143 ±  3%     +48.9%      40430        softirqs.CPU25.RCU
     22632 ±  3%     -84.4%       3539 ± 22%  softirqs.CPU25.SCHED
     12295           -48.4%       6341        softirqs.CPU25.TIMER
   3613067           +18.0%    4263149        softirqs.CPU26.NET_RX
     26664           +52.7%      40706        softirqs.CPU26.RCU
     22475 ±  3%     -83.7%       3674 ± 19%  softirqs.CPU26.SCHED
     12279           -47.6%       6436 ±  4%  softirqs.CPU26.TIMER
   3613233           +18.7%    4288730        softirqs.CPU27.NET_RX
     27290 ±  3%     +47.8%      40332        softirqs.CPU27.RCU
     22413 ±  2%     -83.8%       3639 ± 18%  softirqs.CPU27.SCHED
     12416 ±  3%     -49.1%       6315        softirqs.CPU27.TIMER
   3600851           +19.0%    4285955        softirqs.CPU28.NET_RX
     26779 ±  2%     +51.5%      40580        softirqs.CPU28.RCU
     22418           -84.5%       3483 ± 17%  softirqs.CPU28.SCHED
     12364           -48.5%       6364        softirqs.CPU28.TIMER
   3567960 ±  4%     +18.6%    4232238 ±  2%  softirqs.CPU29.NET_RX
     26704 ±  2%     +49.8%      40008 ±  3%  softirqs.CPU29.RCU
     22290 ±  3%     -83.2%       3735 ± 13%  softirqs.CPU29.SCHED
     12046 ±  6%     -44.4%       6694 ±  9%  softirqs.CPU29.TIMER
   3680360           +16.0%    4270249        softirqs.CPU3.NET_RX
     27123           +51.6%      41121        softirqs.CPU3.RCU
     23119 ±  3%     -83.9%       3723 ± 21%  softirqs.CPU3.SCHED
     12330           -47.9%       6427        softirqs.CPU3.TIMER
   3643999           +17.4%    4278036        softirqs.CPU30.NET_RX
     27134           +48.9%      40400 ±  2%  softirqs.CPU30.RCU
     22951 ±  4%     -85.3%       3382 ± 15%  softirqs.CPU30.SCHED
     12366 ±  5%     -48.6%       6352        softirqs.CPU30.TIMER
   3606600           +19.4%    4304524        softirqs.CPU31.NET_RX
     26870           +51.6%      40740        softirqs.CPU31.RCU
     22750 ±  3%     -85.2%       3360 ± 15%  softirqs.CPU31.SCHED
     12120           -47.3%       6386        softirqs.CPU31.TIMER
   3584145           +17.4%    4208362 ±  2%  softirqs.CPU32.NET_RX
     26552           +50.8%      40049 ±  4%  softirqs.CPU32.RCU
     22296 ±  2%     -86.5%       3003 ± 10%  softirqs.CPU32.SCHED
     12642 ±  2%     -48.2%       6549        softirqs.CPU32.TIMER
   3596209           +18.1%    4246254        softirqs.CPU33.NET_RX
     26436           +53.4%      40549        softirqs.CPU33.RCU
     22278 ±  2%     -85.9%       3145 ± 15%  softirqs.CPU33.SCHED
     12667 ±  2%     -48.3%       6546 ±  2%  softirqs.CPU33.TIMER
   3625597           +16.7%    4230469        softirqs.CPU34.NET_RX
     26409           +51.3%      39967 ±  4%  softirqs.CPU34.RCU
     22113 ±  2%     -85.7%       3153 ± 17%  softirqs.CPU34.SCHED
     12642 ±  2%     -48.6%       6501        softirqs.CPU34.TIMER
   3646457           +17.0%    4267332        softirqs.CPU35.NET_RX
     26453           +53.7%      40670 ±  2%  softirqs.CPU35.RCU
     22411 ±  2%     -86.9%       2935 ± 16%  softirqs.CPU35.SCHED
     13047 ±  6%     -50.0%       6530        softirqs.CPU35.TIMER
   3594222           +18.0%    4241189        softirqs.CPU36.NET_RX
     26586           +52.9%      40650 ±  2%  softirqs.CPU36.RCU
     22185 ±  2%     -86.1%       3083 ± 24%  softirqs.CPU36.SCHED
     12548 ±  2%     -48.4%       6478        softirqs.CPU36.TIMER
   3615955           +16.7%    4221514 ±  2%  softirqs.CPU37.NET_RX
     26595           +49.7%      39820 ±  3%  softirqs.CPU37.RCU
     22268 ±  2%     -85.8%       3168 ± 16%  softirqs.CPU37.SCHED
     12545 ±  2%     -47.9%       6533        softirqs.CPU37.TIMER
   3650060           +17.1%    4272665        softirqs.CPU38.NET_RX
     26817           +52.8%      40966        softirqs.CPU38.RCU
     22608 ±  3%     -86.6%       3040 ± 12%  softirqs.CPU38.SCHED
     12792 ±  3%     -48.5%       6584 ±  4%  softirqs.CPU38.TIMER
   3676388           +13.9%    4185967 ±  2%  softirqs.CPU39.NET_RX
     26878           +48.0%      39767 ±  3%  softirqs.CPU39.RCU
     22221           -86.7%       2948 ± 20%  softirqs.CPU39.SCHED
     12490           -47.7%       6527        softirqs.CPU39.TIMER
   3632448           +16.0%    4212263 ±  2%  softirqs.CPU4.NET_RX
     27052           +51.0%      40845 ±  4%  softirqs.CPU4.RCU
     22939 ±  2%     -83.9%       3686 ± 15%  softirqs.CPU4.SCHED
     12352           -47.5%       6479 ±  5%  softirqs.CPU4.TIMER
   3687159           +15.2%    4249361        softirqs.CPU40.NET_RX
     26954           +50.7%      40611 ±  2%  softirqs.CPU40.RCU
     22325           -87.6%       2775 ± 17%  softirqs.CPU40.SCHED
     12529 ±  2%     -46.2%       6737 ±  7%  softirqs.CPU40.TIMER
   3656948           +15.6%    4226731 ±  2%  softirqs.CPU41.NET_RX
     27037           +48.9%      40257 ±  3%  softirqs.CPU41.RCU
     22420 ±  2%     -86.9%       2941 ± 18%  softirqs.CPU41.SCHED
     12490           -48.0%       6499        softirqs.CPU41.TIMER
   3686293           +15.0%    4239049 ±  2%  softirqs.CPU42.NET_RX
     26788           +50.0%      40177 ±  3%  softirqs.CPU42.RCU
     22308 ±  2%     -87.4%       2816 ± 13%  softirqs.CPU42.SCHED
     12554 ±  2%     -46.3%       6745 ±  7%  softirqs.CPU42.TIMER
   3690320           +15.3%    4255472 ±  2%  softirqs.CPU43.NET_RX
     26798           +51.2%      40512 ±  3%  softirqs.CPU43.RCU
     22349           -87.2%       2856 ± 15%  softirqs.CPU43.SCHED
     12593 ±  2%     -48.2%       6528        softirqs.CPU43.TIMER
   3597093           +18.2%    4250823 ±  2%  softirqs.CPU44.NET_RX
     26362           +53.2%      40394 ±  2%  softirqs.CPU44.RCU
     22245           -86.4%       3033 ± 19%  softirqs.CPU44.SCHED
     12619 ±  2%     -48.4%       6506        softirqs.CPU44.TIMER
   3670097           +16.2%    4263217        softirqs.CPU45.NET_RX
     26561           +53.5%      40771        softirqs.CPU45.RCU
     22620 ±  3%     -86.5%       3059 ± 19%  softirqs.CPU45.SCHED
     13335 ± 12%     -51.1%       6519 ±  2%  softirqs.CPU45.TIMER
   3631299           +14.0%    4140382 ±  2%  softirqs.CPU46.NET_RX
     26496           +48.4%      39308 ±  4%  softirqs.CPU46.RCU
     22106 ±  2%     -84.9%       3337 ± 27%  softirqs.CPU46.SCHED
     12706           -49.0%       6476        softirqs.CPU46.TIMER
   3629260           +17.5%    4265830        softirqs.CPU47.NET_RX
     26725           +53.1%      40921        softirqs.CPU47.RCU
     22471           -87.2%       2874 ± 18%  softirqs.CPU47.SCHED
     13048 ± 10%     -50.3%       6485        softirqs.CPU47.TIMER
   3647705           +15.9%    4227032 ±  2%  softirqs.CPU48.NET_RX
     26372           +50.5%      39677 ±  2%  softirqs.CPU48.RCU
     22175 ±  2%     -85.9%       3124 ± 21%  softirqs.CPU48.SCHED
     12675 ±  2%     -47.4%       6670 ±  6%  softirqs.CPU48.TIMER
   3624077           +17.9%    4271716        softirqs.CPU49.NET_RX
     26469           +52.0%      40239        softirqs.CPU49.RCU
     22306           -86.6%       2988 ± 16%  softirqs.CPU49.SCHED
     12699 ±  2%     -48.8%       6501        softirqs.CPU49.TIMER
   3669943           +16.6%    4277583        softirqs.CPU5.NET_RX
     27410           +50.6%      41268        softirqs.CPU5.RCU
     22796 ±  2%     -83.9%       3668 ± 12%  softirqs.CPU5.SCHED
     12553 ±  2%     -46.2%       6748 ± 12%  softirqs.CPU5.TIMER
   3600094           +16.6%    4198576 ±  2%  softirqs.CPU50.NET_RX
     26576 ±  2%     +48.8%      39532 ±  3%  softirqs.CPU50.RCU
     22385           -86.4%       3034 ± 20%  softirqs.CPU50.SCHED
     12649           -48.7%       6488        softirqs.CPU50.TIMER
   3665510           +16.1%    4256454        softirqs.CPU51.NET_RX
     26651           +49.7%      39898        softirqs.CPU51.RCU
     22159 ±  2%     -86.3%       3039 ± 13%  softirqs.CPU51.SCHED
     12633           -48.7%       6486        softirqs.CPU51.TIMER
   3661634           +16.3%    4258601        softirqs.CPU52.NET_RX
     26462           +50.4%      39801 ±  2%  softirqs.CPU52.RCU
     22159 ±  2%     -85.0%       3322 ± 24%  softirqs.CPU52.SCHED
     12607 ±  2%     -46.6%       6727 ±  6%  softirqs.CPU52.TIMER
   3629833           +17.9%    4278596        softirqs.CPU53.NET_RX
     26494           +51.8%      40211        softirqs.CPU53.RCU
     22362 ±  2%     -86.5%       3013 ± 12%  softirqs.CPU53.SCHED
     12648           -48.6%       6499        softirqs.CPU53.TIMER
   3633047           +18.4%    4301719        softirqs.CPU54.NET_RX
     26544           +51.7%      40264        softirqs.CPU54.RCU
     22432           -86.5%       3023 ± 15%  softirqs.CPU54.SCHED
     12626 ±  2%     -48.3%       6528        softirqs.CPU54.TIMER
   3684799           +14.7%    4227457        softirqs.CPU55.NET_RX
     26582           +49.2%      39670        softirqs.CPU55.RCU
     22311           -86.7%       2964 ± 16%  softirqs.CPU55.SCHED
     12582 ±  2%     -48.6%       6464        softirqs.CPU55.TIMER
   3678360           +14.8%    4221340        softirqs.CPU56.NET_RX
     26689           +48.3%      39586 ±  2%  softirqs.CPU56.RCU
     22502 ±  2%     -86.7%       2982 ± 12%  softirqs.CPU56.SCHED
     12556           -48.3%       6489        softirqs.CPU56.TIMER
   3696599           +14.8%    4244796        softirqs.CPU57.NET_RX
     26612           +48.3%      39460 ±  3%  softirqs.CPU57.RCU
     22286 ±  2%     -85.9%       3147 ± 16%  softirqs.CPU57.SCHED
     12594 ±  2%     -48.3%       6510        softirqs.CPU57.TIMER
   3650121           +18.0%    4307136        softirqs.CPU58.NET_RX
     26702           +51.1%      40342        softirqs.CPU58.RCU
     22431 ±  2%     -86.2%       3084 ± 14%  softirqs.CPU58.SCHED
     13083 ± 11%     -50.3%       6506        softirqs.CPU58.TIMER
   3629890           +17.3%    4258589        softirqs.CPU59.NET_RX
     26283           +51.9%      39933 ±  2%  softirqs.CPU59.RCU
     22057 ±  2%     -85.6%       3174 ± 17%  softirqs.CPU59.SCHED
     12667           -48.9%       6473        softirqs.CPU59.TIMER
   3681289           +16.4%    4285597        softirqs.CPU6.NET_RX
     27708           +48.6%      41163        softirqs.CPU6.RCU
     23158 ±  3%     -83.9%       3737 ± 14%  softirqs.CPU6.SCHED
     12877 ±  5%     -49.9%       6449 ±  2%  softirqs.CPU6.TIMER
   3618162           +17.5%    4251016        softirqs.CPU60.NET_RX
     26384           +50.7%      39755 ±  2%  softirqs.CPU60.RCU
     22446 ±  3%     -87.0%       2927 ± 16%  softirqs.CPU60.SCHED
     12641 ±  2%     -48.6%       6497        softirqs.CPU60.TIMER
   3590012           +17.9%    4234399        softirqs.CPU61.NET_RX
     26267           +51.4%      39759 ±  2%  softirqs.CPU61.RCU
     22170 ±  2%     -87.2%       2837 ± 21%  softirqs.CPU61.SCHED
     12595 ±  2%     -48.0%       6555 ±  2%  softirqs.CPU61.TIMER
   3644555           +16.2%    4235606        softirqs.CPU62.NET_RX
     26574           +48.4%      39449 ±  2%  softirqs.CPU62.RCU
     22368 ±  2%     -84.8%       3407 ± 16%  softirqs.CPU62.SCHED
     12500 ±  2%     -47.4%       6576 ±  3%  softirqs.CPU62.TIMER
   3631527           +12.7%    4093626        softirqs.CPU63.NET_RX
     26773 ±  2%     +46.1%      39121 ±  2%  softirqs.CPU63.RCU
     20929 ±  4%     -85.3%       3072 ± 21%  softirqs.CPU63.SCHED
     12207 ±  2%     -45.0%       6715 ±  6%  softirqs.CPU63.TIMER
   3617652           +16.3%    4207148 ±  2%  softirqs.CPU64.NET_RX
     26771           +52.9%      40932        softirqs.CPU64.RCU
     22548 ±  2%     -86.0%       3161 ± 19%  softirqs.CPU64.SCHED
     12411 ±  4%     -48.9%       6344 ±  2%  softirqs.CPU64.TIMER
   3631482           +14.3%    4151252        softirqs.CPU65.NET_RX
     26880           +51.8%      40815 ±  3%  softirqs.CPU65.RCU
     22564           -83.7%       3683 ± 26%  softirqs.CPU65.SCHED
     12223           -46.1%       6590 ± 11%  softirqs.CPU65.TIMER
   3655602           +12.3%    4105643 ±  2%  softirqs.CPU66.NET_RX
     27050           +48.9%      40289 ±  2%  softirqs.CPU66.RCU
     22563 ±  2%     -84.6%       3471 ± 11%  softirqs.CPU66.SCHED
     12190           -48.7%       6258        softirqs.CPU66.TIMER
   3681546           +14.5%    4215893 ±  2%  softirqs.CPU67.NET_RX
     27337 ±  2%     +49.7%      40923 ±  3%  softirqs.CPU67.RCU
     22985 ±  2%     -86.1%       3200 ± 13%  softirqs.CPU67.SCHED
     12297           -48.6%       6319        softirqs.CPU67.TIMER
   3636012           +16.8%    4245963        softirqs.CPU68.NET_RX
     27091           +54.0%      41729        softirqs.CPU68.RCU
     22729           -84.6%       3501 ± 16%  softirqs.CPU68.SCHED
     12265           -48.7%       6287        softirqs.CPU68.TIMER
   3669903           +14.8%    4211459        softirqs.CPU69.NET_RX
     26760           +54.2%      41267        softirqs.CPU69.RCU
     22711 ±  2%     -85.0%       3407 ± 15%  softirqs.CPU69.SCHED
     12409 ±  2%     -48.0%       6456 ±  7%  softirqs.CPU69.TIMER
   3641533           +17.0%    4258920        softirqs.CPU7.NET_RX
     27174           +49.3%      40558 ±  2%  softirqs.CPU7.RCU
     22960 ±  3%     -83.6%       3774 ± 13%  softirqs.CPU7.SCHED
     12194           -47.6%       6395        softirqs.CPU7.TIMER
   3657044           +15.4%    4221328        softirqs.CPU70.NET_RX
     27122 ±  2%     +52.4%      41329        softirqs.CPU70.RCU
     22663 ±  2%     -84.1%       3603 ± 12%  softirqs.CPU70.SCHED
     12307           -46.3%       6612 ±  9%  softirqs.CPU70.TIMER
   3642201           +14.1%    4156875 ±  2%  softirqs.CPU71.NET_RX
     27465 ±  2%     +46.9%      40348 ±  2%  softirqs.CPU71.RCU
     23158 ±  3%     -84.2%       3661 ± 15%  softirqs.CPU71.SCHED
     12475 ±  4%     -49.6%       6281        softirqs.CPU71.TIMER
   3676096           +14.5%    4207672        softirqs.CPU72.NET_RX
     27662 ±  2%     +50.2%      41540        softirqs.CPU72.RCU
     22927 ±  2%     -84.7%       3509 ± 15%  softirqs.CPU72.SCHED
     12388 ±  3%     -49.4%       6268        softirqs.CPU72.TIMER
   3689025           +13.2%    4174568 ±  2%  softirqs.CPU73.NET_RX
     27008           +50.2%      40562 ±  3%  softirqs.CPU73.RCU
     22782 ±  3%     -85.1%       3405 ± 21%  softirqs.CPU73.SCHED
     12506 ±  4%     -49.2%       6355 ±  2%  softirqs.CPU73.TIMER
   3616064           +16.9%    4227496        softirqs.CPU74.NET_RX
     26843           +53.6%      41238        softirqs.CPU74.RCU
     22664 ±  2%     -84.4%       3539 ± 16%  softirqs.CPU74.SCHED
     12315           -45.7%       6690 ± 13%  softirqs.CPU74.TIMER
   3671200           +13.5%    4168152 ±  2%  softirqs.CPU75.NET_RX
     27178           +49.2%      40536 ±  3%  softirqs.CPU75.RCU
     22627 ±  2%     -84.8%       3430 ± 19%  softirqs.CPU75.SCHED
     12426           -49.1%       6323        softirqs.CPU75.TIMER
   3681366           +16.0%    4270047        softirqs.CPU76.NET_RX
     26915 ±  2%     +54.5%      41570        softirqs.CPU76.RCU
     22458 ±  3%     -84.5%       3490 ± 10%  softirqs.CPU76.SCHED
     12388           -48.8%       6337        softirqs.CPU76.TIMER
   3596148           +15.7%    4159328 ±  2%  softirqs.CPU77.NET_RX
     26726           +51.2%      40397 ±  3%  softirqs.CPU77.RCU
     22588 ±  3%     -84.2%       3569 ± 12%  softirqs.CPU77.SCHED
     12341 ±  2%     -48.2%       6393 ±  2%  softirqs.CPU77.TIMER
   3635295           +16.3%    4227381        softirqs.CPU78.NET_RX
     26682           +55.7%      41535        softirqs.CPU78.RCU
     22375 ±  2%     -83.6%       3672 ± 11%  softirqs.CPU78.SCHED
     12306           -48.3%       6360        softirqs.CPU78.TIMER
   3645083           +15.8%    4219789        softirqs.CPU79.NET_RX
     26970           +53.5%      41411        softirqs.CPU79.RCU
     22406 ±  2%     -84.5%       3478 ± 17%  softirqs.CPU79.SCHED
     12373           -48.9%       6319        softirqs.CPU79.TIMER
   3720755           +14.3%    4254642        softirqs.CPU8.NET_RX
     27688 ±  2%     +46.6%      40594        softirqs.CPU8.RCU
     22942 ±  2%     -83.9%       3697 ± 21%  softirqs.CPU8.SCHED
     12954 ± 11%     -51.0%       6347        softirqs.CPU8.TIMER
   3631957           +17.1%    4252782        softirqs.CPU80.NET_RX
     27044           +50.5%      40690        softirqs.CPU80.RCU
     22725           -84.0%       3637 ± 11%  softirqs.CPU80.SCHED
     12120           -48.1%       6294        softirqs.CPU80.TIMER
   3660719           +16.0%    4247487        softirqs.CPU81.NET_RX
     26763           +52.6%      40837        softirqs.CPU81.RCU
     22568 ±  2%     -84.3%       3554 ± 23%  softirqs.CPU81.SCHED
     12112           -46.9%       6435 ±  4%  softirqs.CPU81.TIMER
   3629949           +15.9%    4208198        softirqs.CPU82.NET_RX
     27234           +49.5%      40712        softirqs.CPU82.RCU
     22685 ±  3%     -82.6%       3946 ± 19%  softirqs.CPU82.SCHED
     12229 ±  2%     -48.2%       6334 ±  4%  softirqs.CPU82.TIMER
   3632157           +15.7%    4203914        softirqs.CPU83.NET_RX
     27060           +51.5%      40995 ±  2%  softirqs.CPU83.RCU
     22736 ±  2%     -81.7%       4162 ± 23%  softirqs.CPU83.SCHED
     12735 ± 12%     -50.5%       6304        softirqs.CPU83.TIMER
   3680232           +14.3%    4208276        softirqs.CPU84.NET_RX
     26928           +52.4%      41052        softirqs.CPU84.RCU
     22617 ±  2%     -83.8%       3663 ± 19%  softirqs.CPU84.SCHED
     12124           -48.0%       6310 ±  2%  softirqs.CPU84.TIMER
   3655138           +15.6%    4226691        softirqs.CPU85.NET_RX
     27031           +52.8%      41305        softirqs.CPU85.RCU
     22699           -84.4%       3547 ± 19%  softirqs.CPU85.SCHED
     12033           -48.0%       6262        softirqs.CPU85.TIMER
   3657642           +15.0%    4205027 ±  2%  softirqs.CPU86.NET_RX
     26494           +52.4%      40376 ±  3%  softirqs.CPU86.RCU
     22418 ±  2%     -84.2%       3547 ± 21%  softirqs.CPU86.SCHED
     12284           -46.5%       6572 ±  9%  softirqs.CPU86.TIMER
   3656695           +16.6%    4263027        softirqs.CPU87.NET_RX
     26728           +51.5%      40505        softirqs.CPU87.RCU
     22431 ±  2%     -83.5%       3697 ± 13%  softirqs.CPU87.SCHED
     12247           -48.7%       6286        softirqs.CPU87.TIMER
   3622507           +16.2%    4207738 ±  2%  softirqs.CPU88.NET_RX
     26453           +50.8%      39898 ±  3%  softirqs.CPU88.RCU
     22402 ±  2%     -84.7%       3422 ± 20%  softirqs.CPU88.SCHED
     12186           -48.1%       6328        softirqs.CPU88.TIMER
   3616597           +17.2%    4239446        softirqs.CPU89.NET_RX
     27224 ±  3%     +50.0%      40825        softirqs.CPU89.RCU
     22622 ±  2%     -84.4%       3535 ± 16%  softirqs.CPU89.SCHED
     12355           -49.3%       6267        softirqs.CPU89.TIMER
   3696490           +15.2%    4258106 ±  2%  softirqs.CPU9.NET_RX
     27811           +47.1%      40919 ±  2%  softirqs.CPU9.RCU
     23244 ±  3%     -83.7%       3781 ± 13%  softirqs.CPU9.SCHED
     13128 ± 11%     -51.4%       6380        softirqs.CPU9.TIMER
   3637524           +16.2%    4225781        softirqs.CPU90.NET_RX
     26646           +51.2%      40286 ±  2%  softirqs.CPU90.RCU
     22588 ±  3%     -84.3%       3547 ± 13%  softirqs.CPU90.SCHED
     12322           -48.9%       6290        softirqs.CPU90.TIMER
   3636814           +15.9%    4213776        softirqs.CPU91.NET_RX
     26548           +53.8%      40842        softirqs.CPU91.RCU
     22554 ±  3%     -83.4%       3738 ± 19%  softirqs.CPU91.SCHED
     12242           -49.1%       6234        softirqs.CPU91.TIMER
   3597522           +17.4%    4222507        softirqs.CPU92.NET_RX
     26505           +52.9%      40529        softirqs.CPU92.RCU
     22390 ±  3%     -84.8%       3406 ± 18%  softirqs.CPU92.SCHED
     12221           -48.7%       6267        softirqs.CPU92.TIMER
   3651412           +16.2%    4242870 ±  2%  softirqs.CPU93.NET_RX
     26954           +49.0%      40157        softirqs.CPU93.RCU
     22826 ±  2%     -84.8%       3465 ± 24%  softirqs.CPU93.SCHED
     12231 ±  4%     -46.7%       6524 ±  8%  softirqs.CPU93.TIMER
   3630129           +15.3%    4183844 ±  2%  softirqs.CPU94.NET_RX
     26916           +48.0%      39838 ±  3%  softirqs.CPU94.RCU
     22702 ±  2%     -85.6%       3270 ± 17%  softirqs.CPU94.SCHED
     12033           -47.9%       6275        softirqs.CPU94.TIMER
   3631483           +15.3%    4185392 ±  2%  softirqs.CPU95.NET_RX
     26805           +49.2%      40002 ±  3%  softirqs.CPU95.RCU
     22824           -85.6%       3292 ± 17%  softirqs.CPU95.SCHED
     12047           -48.0%       6260        softirqs.CPU95.TIMER
   3568253           +18.5%    4228069        softirqs.CPU96.NET_RX
     26043           +55.1%      40402 ±  2%  softirqs.CPU96.RCU
     22147 ±  2%     -87.2%       2838 ± 14%  softirqs.CPU96.SCHED
     12474 ±  2%     -48.5%       6422        softirqs.CPU96.TIMER
   3608937           +17.2%    4228799        softirqs.CPU97.NET_RX
     26134           +54.5%      40368        softirqs.CPU97.RCU
     22231           -86.5%       3009 ± 12%  softirqs.CPU97.SCHED
     12616 ±  2%     -49.3%       6399        softirqs.CPU97.TIMER
   3632811           +16.6%    4235794        softirqs.CPU98.NET_RX
     26230           +53.6%      40295        softirqs.CPU98.RCU
     22127 ±  2%     -86.3%       3031 ± 18%  softirqs.CPU98.SCHED
     12578 ±  2%     -47.2%       6641 ±  7%  softirqs.CPU98.TIMER
   3670765           +14.6%    4205482        softirqs.CPU99.NET_RX
     26376           +51.7%      40025 ±  3%  softirqs.CPU99.RCU
     22274 ±  2%     -86.9%       2911 ± 17%  softirqs.CPU99.SCHED
     12690 ±  2%     -49.2%       6449        softirqs.CPU99.TIMER
 4.657e+08           +16.2%  5.412e+08        softirqs.NET_RX
   3431554           +50.6%    5169164        softirqs.RCU
   2880521 ±  2%     -85.2%     427430 ± 15%  softirqs.SCHED
    445625 ±  3%     -99.2%       3534 ± 14%  softirqs.TASKLET
   1594175           -48.2%     825859        softirqs.TIMER
      9.52 ±  4%      -9.3        0.22 ±141%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      9.44 ±  4%      -9.2        0.21 ±141%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      9.44 ±  4%      -9.2        0.21 ±141%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.40 ±  4%      -9.2        0.21 ±141%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.65            -7.6        0.00        perf-profile.calltrace.cycles-pp.release_sock.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      7.23            -7.2        0.00        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom
      6.06 ±  5%      -6.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.03 ±  5%      -5.9        0.09 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      5.91            -5.9        0.00        perf-profile.calltrace.cycles-pp.dccp_v4_do_rcv.__release_sock.release_sock.dccp_recvmsg.sock_common_recvmsg
      5.64            -5.6        0.00        perf-profile.calltrace.cycles-pp.dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock.dccp_recvmsg
      5.59 ±  5%      -5.6        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.21            -5.2        0.00        perf-profile.calltrace.cycles-pp.dccp_deliver_input_to_ccids.dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock
      5.11            -5.1        0.00        perf-profile.calltrace.cycles-pp.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established.dccp_v4_do_rcv.__release_sock
      5.74 ±  3%      -4.7        1.04 ±  2%  perf-profile.calltrace.cycles-pp.security_socket_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     22.38            -4.6       17.82        perf-profile.calltrace.cycles-pp.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      5.12 ±  3%      -4.4        0.68 ±  2%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     22.46            -4.4       18.04        perf-profile.calltrace.cycles-pp.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.86            -3.9       19.98        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     23.92            -3.7       20.17        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     24.25            -2.7       21.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      3.03 ±  2%      -2.4        0.58        perf-profile.calltrace.cycles-pp.lock_sock_nested.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     24.39            -2.3       22.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv
      1.85            -1.2        0.70        perf-profile.calltrace.cycles-pp.__kfree_skb.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.24            -0.9        0.34 ± 70%  perf-profile.calltrace.cycles-pp.accept
      1.42            -0.9        0.52        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      1.45            -0.9        0.58        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.dccp_recvmsg
      1.66            -0.8        0.88        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.dccp_recvmsg.sock_common_recvmsg
      1.47 ±  2%      -0.6        0.84        perf-profile.calltrace.cycles-pp.dccp_rcv_state_process.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.22 ±  4%      -0.6        0.66        perf-profile.calltrace.cycles-pp.sockfd_lookup_light.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.31            -0.5        0.79        perf-profile.calltrace.cycles-pp.__dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock.dccp_sendmsg
      1.21            -0.5        0.71        perf-profile.calltrace.cycles-pp.__skb_checksum.skb_checksum.dccp_v4_send_check.dccp_transmit_skb.dccp_xmit_packet
      1.23            -0.5        0.76        perf-profile.calltrace.cycles-pp.skb_checksum.dccp_v4_send_check.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit
      2.31            -0.5        1.86        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom
     25.11            -0.4       24.67        perf-profile.calltrace.cycles-pp.recv
      1.31            -0.4        0.88        perf-profile.calltrace.cycles-pp.dccp_v4_send_check.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg
      2.35            -0.4        1.92        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      2.47            -0.4        2.08        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.91            -0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.25            -0.2        1.02        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_rcv_state_process
      1.26            -0.2        1.04        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_rcv_state_process.dccp_v4_do_rcv
      1.27            -0.2        1.06        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.dccp_rcv_state_process.dccp_v4_do_rcv.__release_sock
      1.08            -0.2        0.88        perf-profile.calltrace.cycles-pp.__inet_lookup_established.dccp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      1.31            -0.2        1.12        perf-profile.calltrace.cycles-pp.dccp_transmit_skb.dccp_rcv_state_process.dccp_v4_do_rcv.__release_sock.release_sock
      2.02            -0.1        1.90        perf-profile.calltrace.cycles-pp.dccp_rcv_state_process.dccp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect
      0.93            -0.1        0.82        perf-profile.calltrace.cycles-pp.dccp_v4_conn_request.dccp_rcv_state_process.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu
      0.65            -0.1        0.56        perf-profile.calltrace.cycles-pp.dccp_create_openreq_child.dccp_v4_request_recv_sock.dccp_check_req.dccp_v4_rcv.ip_protocol_deliver_rcu
      2.06            -0.1        1.98        perf-profile.calltrace.cycles-pp.dccp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      2.07            -0.1        2.00        perf-profile.calltrace.cycles-pp.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
      2.06            -0.1        2.00        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect
      0.72            -0.0        0.67        perf-profile.calltrace.cycles-pp.dccp_v4_request_recv_sock.dccp_check_req.dccp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.58            +0.0        0.62        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.dccp_sendmsg
      1.20            +0.1        1.25        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.dccp_connect.dccp_v4_connect.__inet_stream_connect
      1.61            +0.1        1.66        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.dccp_sendmsg.sock_sendmsg
      1.24            +0.1        1.31        perf-profile.calltrace.cycles-pp.dccp_transmit_skb.dccp_connect.dccp_v4_connect.__inet_stream_connect.inet_stream_connect
      1.29            +0.1        1.40        perf-profile.calltrace.cycles-pp.dccp_connect.dccp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
      1.68            +0.1        1.79        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.dccp_sendmsg.sock_sendmsg.__sys_sendto
      0.87            +0.1        1.01        perf-profile.calltrace.cycles-pp.dccp_finish_passive_close.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.41 ±  2%      +0.1        1.55 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.68            +0.1        0.82        perf-profile.calltrace.cycles-pp.dccp_transmit_skb.dccp_finish_passive_close.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom
      0.66            +0.2        0.82        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_finish_passive_close.dccp_recvmsg
      0.65            +0.2        0.81        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_finish_passive_close
      0.66            +0.2        0.82        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.dccp_finish_passive_close.dccp_recvmsg.sock_common_recvmsg
      0.65            +0.2        0.83        perf-profile.calltrace.cycles-pp.dccp_close.inet_release.__sock_release.sock_close.__fput
      0.66            +0.2        0.84        perf-profile.calltrace.cycles-pp.inet_release.__sock_release.sock_close.__fput.task_work_run
      0.68            +0.2        0.86        perf-profile.calltrace.cycles-pp.__sock_release.sock_close.__fput.task_work_run.exit_to_user_mode_prepare
      0.68            +0.2        0.87        perf-profile.calltrace.cycles-pp.sock_close.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.60            +0.2        3.83        perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
      3.65            +0.2        3.88        perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
      3.65            +0.2        3.87        perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
      3.66            +0.2        3.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
      0.56            +0.2        0.79        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.dccp_recvmsg
      3.61            +0.2        3.84        perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52            +0.2        0.75        perf-profile.calltrace.cycles-pp.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      0.51            +0.2        0.75        perf-profile.calltrace.cycles-pp.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      3.66            +0.2        3.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.connect
      0.52            +0.2        0.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__socket
      0.52            +0.2        0.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      0.53            +0.2        0.77        perf-profile.calltrace.cycles-pp.__socket
      3.67            +0.2        3.91        perf-profile.calltrace.cycles-pp.connect
      1.52            +0.3        1.79        perf-profile.calltrace.cycles-pp.dccp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
      0.60            +0.3        0.87        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.dccp_recvmsg.sock_common_recvmsg
      3.34            +0.3        3.67        perf-profile.calltrace.cycles-pp.dccp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
      1.01            +0.4        1.36        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.04            +0.4        1.40        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05            +0.4        1.43        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.06            +0.4        1.43        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.11            +0.4        1.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.11            +0.4        1.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.14            +0.4        1.56        perf-profile.calltrace.cycles-pp.__close
      0.54 ±  2%      +0.4        0.98        perf-profile.calltrace.cycles-pp._copy_from_iter.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.56            +0.4        1.00        perf-profile.calltrace.cycles-pp.dccp_send_ack.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established.dccp_v4_do_rcv
      0.68            +0.5        1.16        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_connect
      0.68            +0.5        1.16        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_connect.dccp_v4_connect
      0.51            +0.5        1.00        perf-profile.calltrace.cycles-pp.skb_checksum.dccp_invalid_packet.dccp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.5        0.50        perf-profile.calltrace.cycles-pp.ip_rcv_core.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll
      0.00            +0.5        0.50        perf-profile.calltrace.cycles-pp.dccp_ackvec_clear_state.dccp_handle_ackvec_processing.dccp_rcv_established.dccp_v4_do_rcv.__release_sock
      0.60            +0.5        1.11        perf-profile.calltrace.cycles-pp.dccp_insert_options.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.save_fpregs_to_fpstate.recv
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.dccp_feat_entry_new.dccp_feat_push_change.dccp_feat_signal_nn_change.ccid2_hc_tx_packet_recv.dccp_rcv_established
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.dccp_feat_push_change.dccp_feat_signal_nn_change.ccid2_hc_tx_packet_recv.dccp_rcv_established.dccp_v4_do_rcv
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.mod_timer.sk_reset_timer.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.dccp_sendmsg.sock_sendmsg
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.dccp_handle_ackvec_processing.dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock
      0.00            +0.6        0.56 ±  4%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__cgroup_bpf_run_filter_skb.sk_filter_trim_cap.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.irqtime_account_irq.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__switch_to_asm.recv
      0.61            +0.6        1.20        perf-profile.calltrace.cycles-pp.dccp_invalid_packet.dccp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.__switch_to_asm.__send
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.__wake_up_common
      0.00            +0.6        0.61        perf-profile.calltrace.cycles-pp.csum_partial.__skb_checksum.skb_checksum.dccp_v4_send_check.dccp_transmit_skb
      0.00            +0.6        0.61        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.dccp_sendmsg.sock_sendmsg.__sys_sendto
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.dccp_feat_signal_nn_change.ccid2_hc_tx_packet_recv.dccp_rcv_established.dccp_v4_do_rcv.__release_sock
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.load_new_mm_cr3.switch_mm_irqs_off.__schedule.preempt_schedule_common.__cond_resched
      0.00            +0.7        0.65        perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.netif_rx.loopback_xmit.dev_hard_start_xmit
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.sk_reset_timer.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg.sock_sendmsg
      0.08 ±223%      +0.7        0.78 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.dccp_parse_options.dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock
      0.00            +0.7        0.71        perf-profile.calltrace.cycles-pp.csum_partial.__skb_checksum.skb_checksum.dccp_invalid_packet.dccp_v4_rcv
      0.00            +0.7        0.73        perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.__wake_up_common.__wake_up_common_lock
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.__wake_up_common.__wake_up_common_lock.dccp_write_space
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.__netif_receive_skb_core.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.dccp_insert_options.dccp_transmit_skb.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established
      0.08 ±223%      +0.8        0.93        perf-profile.calltrace.cycles-pp.__alloc_skb.dccp_send_ack.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established
      0.64 ±  2%      +0.9        1.50 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
      0.00            +0.9        0.89        perf-profile.calltrace.cycles-pp.__skb_checksum.skb_checksum.dccp_invalid_packet.dccp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      0.00            +1.0        0.96        perf-profile.calltrace.cycles-pp.dccp_parse_options.dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu
      0.00            +1.0        0.97        perf-profile.calltrace.cycles-pp.load_new_mm_cr3.switch_mm_irqs_off.__schedule.schedule.schedule_timeout
      0.00            +1.1        1.10        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      0.72            +1.1        1.84        perf-profile.calltrace.cycles-pp.ccid2_hc_tx_packet_recv.dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock
      0.72 ±  3%      +1.2        1.92        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.__dccp_rcv_established
      0.52            +1.2        1.73        perf-profile.calltrace.cycles-pp.netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
     10.36            +1.2       11.57        perf-profile.calltrace.cycles-pp.dccp_transmit_skb.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established.dccp_v4_do_rcv
      0.00            +1.2        1.24        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +1.2        1.24        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.preempt_schedule_common.__cond_resched.__release_sock
      3.43            +1.2        4.68        perf-profile.calltrace.cycles-pp.dccp_v4_do_rcv.__release_sock.release_sock.dccp_sendmsg.sock_sendmsg
      0.00            +1.3        1.27        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      0.00            +1.3        1.31        perf-profile.calltrace.cycles-pp.sk_filter_trim_cap.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      0.85 ±  3%      +1.3        2.19        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.__dccp_rcv_established.dccp_v4_do_rcv
      0.00            +1.4        1.36        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.preempt_schedule_common.__cond_resched.__release_sock
      0.00            +1.5        1.52        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      7.01            +1.6        8.56        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb.ccid2_hc_rx_packet_recv
      0.94 ±  2%      +1.6        2.50        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.__dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb
      1.42            +1.6        2.98        perf-profile.calltrace.cycles-pp.__dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.08 ±223%      +1.6        1.66        perf-profile.calltrace.cycles-pp.netif_rx_internal.netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.00            +1.6        1.58        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.06 ±  2%      +1.6        2.69        perf-profile.calltrace.cycles-pp.sock_def_readable.__dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu
      0.00            +1.7        1.66        perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.18            +1.7        9.84        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established
      1.59            +1.7        3.33        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      7.49            +1.7        9.24        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.dccp_transmit_skb.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids
      2.07            +1.8        3.82        perf-profile.calltrace.cycles-pp.dccp_rcv_established.dccp_v4_do_rcv.__release_sock.release_sock.dccp_sendmsg
      0.00            +1.9        1.89        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.wait_woken
      0.92 ±  3%      +2.0        2.90        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.dccp_write_space
      0.70 ±  3%      +2.0        2.70        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      0.00            +2.6        2.55        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      0.90 ±  3%      +2.8        3.66        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
      2.37            +3.1        5.52        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.dccp_write_space.sock_wfree
      2.60            +3.2        5.76        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.dccp_write_space.sock_wfree.loopback_xmit
      2.96            +3.2        6.18        perf-profile.calltrace.cycles-pp.dccp_write_space.sock_wfree.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      2.69            +3.3        6.02        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.dccp_write_space.sock_wfree.loopback_xmit.dev_hard_start_xmit
      3.06            +3.3        6.39        perf-profile.calltrace.cycles-pp.sock_wfree.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.00            +4.0        4.04        perf-profile.calltrace.cycles-pp.__schedule.preempt_schedule_common.__cond_resched.__release_sock.release_sock
      0.00            +4.2        4.21        perf-profile.calltrace.cycles-pp.preempt_schedule_common.__cond_resched.__release_sock.release_sock.dccp_sendmsg
      0.00            +4.3        4.32        perf-profile.calltrace.cycles-pp.__cond_resched.__release_sock.release_sock.dccp_sendmsg.sock_sendmsg
      5.31            +4.7       10.02        perf-profile.calltrace.cycles-pp.release_sock.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      4.48 ±  3%      +5.0        9.44        perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      4.56            +5.2        9.78        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
      6.17            +5.4       11.59        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb
      3.78            +5.7        9.47        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.dccp_sendmsg.sock_sendmsg.__sys_sendto
      3.10 ±  2%      +6.1        9.21        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      3.14 ±  2%      +6.4        9.56        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg
      6.26            +6.5       12.78        perf-profile.calltrace.cycles-pp.ccid2_hc_rx_packet_recv.dccp_deliver_input_to_ccids.dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb
      6.47            +6.6       13.07        perf-profile.calltrace.cycles-pp.dccp_deliver_input_to_ccids.dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu
      3.18 ±  2%      +6.7        9.90        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.dccp_recvmsg.sock_common_recvmsg
      8.64            +6.8       15.49        perf-profile.calltrace.cycles-pp.dccp_rcv_established.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish
      5.50 ±  2%      +6.9       12.43        perf-profile.calltrace.cycles-pp.sk_wait_data.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      3.39 ±  2%      +7.1       10.46        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.dccp_recvmsg.sock_common_recvmsg.__sys_recvfrom
     11.70            +7.9       19.64        perf-profile.calltrace.cycles-pp.dccp_v4_do_rcv.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
     14.23            +8.3       22.49        perf-profile.calltrace.cycles-pp.__sk_receive_skb.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
     18.53            +8.4       26.96        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
     18.63            +8.6       27.21        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
     18.74            +8.8       27.50        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll
     57.00            +8.9       65.93        perf-profile.calltrace.cycles-pp.__send
     19.81            +8.9       28.75        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     20.39            +9.6       29.96        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
     21.00           +10.0       30.98        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
     17.92           +10.0       27.97        perf-profile.calltrace.cycles-pp.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg.sock_sendmsg
     16.84           +10.1       26.90        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg
     21.04           +10.1       31.13        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
     49.64           +10.2       59.85        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     21.34           +10.3       31.66        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
     49.24           +10.4       59.59        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     16.09           +10.5       26.54        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_xmit_packet.dccp_write_xmit
     15.64           +10.5       26.10        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb.dccp_xmit_packet
     22.42           +10.5       32.91        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
     22.61           +10.7       33.27        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
     22.71           +10.8       33.46        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.dccp_transmit_skb
     51.97           +11.4       63.42        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send
     46.70           +11.5       58.19        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.14           +11.8       62.91        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     24.86           +16.3       41.18        perf-profile.calltrace.cycles-pp.dccp_xmit_packet.dccp_write_xmit.dccp_sendmsg.sock_sendmsg.__sys_sendto
     25.08           +16.4       41.44        perf-profile.calltrace.cycles-pp.dccp_write_xmit.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     39.95           +16.7       56.69        perf-profile.calltrace.cycles-pp.dccp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      9.52 ±  4%      -9.0        0.50 ± 19%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      9.52 ±  4%      -9.0        0.50 ± 19%  perf-profile.children.cycles-pp.cpu_startup_entry
      9.50 ±  4%      -9.0        0.50 ± 19%  perf-profile.children.cycles-pp.do_idle
      9.44 ±  4%      -8.9        0.50 ± 19%  perf-profile.children.cycles-pp.start_secondary
      6.11 ±  5%      -5.7        0.41 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter
      6.09 ±  5%      -5.7        0.41 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter_state
      5.68 ±  5%      -5.3        0.38 ± 20%  perf-profile.children.cycles-pp.intel_idle
      6.57            -5.1        1.45        perf-profile.children.cycles-pp._raw_spin_lock_bh
      6.24 ±  2%      -4.8        1.41 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      5.82 ±  3%      -4.8        1.06 ±  2%  perf-profile.children.cycles-pp.security_socket_sendmsg
      6.13            -4.6        1.50        perf-profile.children.cycles-pp.lock_sock_nested
     22.40            -4.5       17.87        perf-profile.children.cycles-pp.dccp_recvmsg
     22.47            -4.4       18.06        perf-profile.children.cycles-pp.sock_common_recvmsg
     23.88            -3.9       20.01        perf-profile.children.cycles-pp.__sys_recvfrom
     23.93            -3.7       20.22        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     15.88            -3.2       12.65        perf-profile.children.cycles-pp.release_sock
     13.72            -2.0       11.71        perf-profile.children.cycles-pp.__release_sock
      1.90            -1.8        0.06 ±  7%  perf-profile.children.cycles-pp.__slab_free
      2.87            -1.6        1.26        perf-profile.children.cycles-pp.__kfree_skb
      2.24 ±  3%      -1.5        0.74        perf-profile.children.cycles-pp.__entry_text_start
      2.21 ±  3%      -1.3        0.90        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.34            -1.1        0.21 ±  2%  perf-profile.children.cycles-pp.skb_queue_tail
      1.47            -1.1        0.35        perf-profile.children.cycles-pp.skb_set_owner_w
      1.46            -0.9        0.60        perf-profile.children.cycles-pp.copyout
      1.52            -0.8        0.70        perf-profile.children.cycles-pp.skb_release_data
      1.17            -0.8        0.36 ±  2%  perf-profile.children.cycles-pp.dst_release
      1.35            -0.8        0.54        perf-profile.children.cycles-pp.skb_release_head_state
      1.38            -0.8        0.60        perf-profile.children.cycles-pp.skb_release_all
      0.89            -0.8        0.12 ±  4%  perf-profile.children.cycles-pp.inet_accept
      1.67            -0.8        0.91        perf-profile.children.cycles-pp._copy_to_iter
      1.26            -0.8        0.51        perf-profile.children.cycles-pp.accept
      0.83            -0.7        0.09 ±  5%  perf-profile.children.cycles-pp.inet_csk_accept
      1.14            -0.7        0.47 ±  2%  perf-profile.children.cycles-pp.__sys_accept4_file
      1.13            -0.7        0.45        perf-profile.children.cycles-pp.do_accept
      1.15            -0.7        0.48        perf-profile.children.cycles-pp.__x64_sys_accept
      1.15            -0.7        0.48        perf-profile.children.cycles-pp.__sys_accept4
      0.79 ±  2%      -0.7        0.13 ±  7%  perf-profile.children.cycles-pp.ipv4_dst_check
      1.50 ±  2%      -0.7        0.84 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.82            -0.6        1.18        perf-profile.children.cycles-pp.dccp_v4_send_check
      0.90            -0.6        0.27        perf-profile.children.cycles-pp.__sk_dst_check
      1.81            -0.6        1.19        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.42 ±  2%      -0.6        0.79 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.54            -0.6        0.96        perf-profile.children.cycles-pp.dccp_ackvec_clear_state
      2.35            -0.6        1.76        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.61            -0.6        1.04        perf-profile.children.cycles-pp.dccp_handle_ackvec_processing
      1.01 ±  4%      -0.5        0.49        perf-profile.children.cycles-pp.update_cfs_group
      1.52            -0.5        1.01        perf-profile.children.cycles-pp.__inet_lookup_established
      0.81            -0.5        0.30        perf-profile.children.cycles-pp.__ksize
      0.90            -0.5        0.41        perf-profile.children.cycles-pp.dccp_check_seqno
      4.05            -0.5        3.59        perf-profile.children.cycles-pp.dccp_rcv_state_process
      2.32            -0.4        1.88        perf-profile.children.cycles-pp.__skb_datagram_iter
      2.35            -0.4        1.93        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.54 ±  4%      -0.4        1.11        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.76 ±  2%      -0.4        0.34        perf-profile.children.cycles-pp.irq_exit_rcu
      1.17 ±  4%      -0.4        0.77        perf-profile.children.cycles-pp.__fget_light
      0.50 ±  5%      -0.4        0.11 ±  3%  perf-profile.children.cycles-pp.select_idle_cpu
      2.48            -0.4        2.10        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.45 ±  4%      -0.4        0.07 ±  5%  perf-profile.children.cycles-pp.inet_sendmsg
      0.65 ±  2%      -0.4        0.30        perf-profile.children.cycles-pp.dccp_v4_send_response
      2.19            -0.3        1.84        perf-profile.children.cycles-pp.__skb_checksum
      0.58            -0.3        0.25        perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.48 ±  4%      -0.3        0.16 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
     25.28            -0.3       24.96        perf-profile.children.cycles-pp.recv
      0.56            -0.3        0.25        perf-profile.children.cycles-pp.dccp_enqueue_skb
      0.60 ±  4%      -0.3        0.29 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
      0.84 ±  2%      -0.3        0.55        perf-profile.children.cycles-pp.ccid2_hc_tx_alloc_seq
      0.85            -0.3        0.56        perf-profile.children.cycles-pp.ccid2_hc_tx_init
      1.24            -0.3        0.96        perf-profile.children.cycles-pp.__might_resched
      0.89 ±  2%      -0.3        0.62        perf-profile.children.cycles-pp.dccp_hdlr_ccid
      0.89            -0.3        0.61        perf-profile.children.cycles-pp.ccid_new
      0.36 ±  2%      -0.3        0.09        perf-profile.children.cycles-pp.dccp_child_process
      0.34 ± 10%      -0.3        0.07 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.83 ±  2%      -0.3        0.57        perf-profile.children.cycles-pp.__might_sleep
      2.29            -0.3        2.03        perf-profile.children.cycles-pp.skb_checksum
      0.38 ± 10%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.68            -0.2        0.44        perf-profile.children.cycles-pp.ip_rcv_finish
      0.52 ±  7%      -0.2        0.29 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.48 ±  7%      -0.2        0.25 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.47 ±  7%      -0.2        0.24 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.46 ±  8%      -0.2        0.24 ±  5%  perf-profile.children.cycles-pp.update_process_times
      1.06            -0.2        0.86        perf-profile.children.cycles-pp.dccp_feat_activate_values
      0.64 ±  4%      -0.2        0.44 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.65 ±  4%      -0.2        0.44 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.55 ±  3%      -0.2        0.37 ±  5%  perf-profile.children.cycles-pp.stress_dccp_server
      0.26            -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.dccp_feat_list_purge
      0.83 ±  3%      -0.2        0.67        perf-profile.children.cycles-pp.select_task_rq_fair
      0.25 ±  4%      -0.2        0.09        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.41 ±  2%      -0.2        0.26        perf-profile.children.cycles-pp.ccid2_hc_tx_packet_sent
      0.24 ±  3%      -0.2        0.09        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.36 ±  2%      -0.2        0.21        perf-profile.children.cycles-pp.rcu_all_qs
      0.32 ±  3%      -0.1        0.20        perf-profile.children.cycles-pp._raw_spin_unlock_bh
      4.06            -0.1        3.94        perf-profile.children.cycles-pp.dccp_v4_rcv
      0.93            -0.1        0.82        perf-profile.children.cycles-pp.dccp_v4_conn_request
      0.15 ±  3%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.dccp_v4_reqsk_destructor
      0.65            -0.1        0.56        perf-profile.children.cycles-pp.dccp_create_openreq_child
      0.18 ±  2%      -0.1        0.10        perf-profile.children.cycles-pp.dccp_feat_val_destructor
      0.59 ±  2%      -0.1        0.52        perf-profile.children.cycles-pp.finish_task_switch
      0.17 ± 12%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.ktime_get
      0.13            -0.0        0.09        perf-profile.children.cycles-pp.inet_csk_destroy_sock
      0.12            -0.0        0.08        perf-profile.children.cycles-pp.dccp_destroy_sock
      0.14            -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.dccp_sk_destruct
      0.18 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.dccp_send_close
      0.72            -0.0        0.68        perf-profile.children.cycles-pp.dccp_v4_request_recv_sock
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.dccp_set_state
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.getsockname
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__x64_sys_getsockname
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__sys_getsockname
      0.23 ±  3%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.kmalloc_order_trace
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.enqueue_timer
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.ccid2_hc_tx_parse_options
      0.09 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.sk_prot_alloc
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.rb_next
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.alloc_inode
      0.17 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.sock_alloc
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.ioctl
      0.06 ±  6%      +0.0        0.08        perf-profile.children.cycles-pp.dccp_insert_fn_opt
      0.08 ±  6%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.sock_alloc_inode
      1.04            +0.0        1.06        perf-profile.children.cycles-pp.sock_recvmsg
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.d_alloc_pseudo
      0.06            +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__d_alloc
      0.10            +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.sk_alloc
      0.34            +0.0        0.37        perf-profile.children.cycles-pp.dccp_rcv_close
      0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.06 ±  6%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.getpeername
      0.11 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.dccp_rcv_closereq
      0.07            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.inet_csk_clear_xmit_timers
      0.09 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.dccp_feat_push_confirm
      0.05            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.sched_clock
      0.09            +0.0        0.13        perf-profile.children.cycles-pp.ip_route_output_flow
      0.09            +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.eth_type_trans
      0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.apparmor_ip_postroute
      0.07            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.09            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sk_clone_lock
      0.08            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__build_skb_around
      0.12 ±  3%      +0.0        0.17        perf-profile.children.cycles-pp.ip_route_output_key_hash
      0.09 ±  5%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.inet_csk_clone_lock
      0.10            +0.0        0.15        perf-profile.children.cycles-pp.internal_add_timer
      0.05            +0.1        0.10        perf-profile.children.cycles-pp.inet_ehash_insert
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.get_nohz_timer_target
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.apparmor_socket_sock_rcv_skb
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.skb_free_head
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.dccp_sample_rtt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.move_addr_to_user
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rcu_qs
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.evict
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.inet_csk_route_child_sock
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.kfree_skb_reason
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.dccp_feat_propagate_ccid
      1.50            +0.1        1.56        perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.fib_table_lookup
      0.02 ±141%      +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.07 ±  5%      +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.security_file_free
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.dccp_feat_server_ccid_dependencies
      0.15 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.skb_unlink
      0.07            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.06            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.05            +0.1        0.11        perf-profile.children.cycles-pp.inet_csk_reqsk_queue_hash_add
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.kfree_skbmem
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.perf_swevent_event
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.08            +0.1        0.14        perf-profile.children.cycles-pp.__inet_hash_connect
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.dccp_timestamp
      0.01 ±223%      +0.1        0.07        perf-profile.children.cycles-pp.__x64_sys_getpeername
      0.31            +0.1        0.37        perf-profile.children.cycles-pp.__ip_finish_output
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.security_sk_clone
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.apparmor_sk_clone_security
      0.20 ±  5%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.cpuacct_charge
      0.15 ±  2%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.dccp_done
      0.07            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.97            +0.1        1.04        perf-profile.children.cycles-pp.dccp_send_ack
      0.10            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.dccp_make_response
      0.07 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.kmalloc_slab
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.dccp_time_wait
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.inet_lhash2_lookup
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.dccp_insert_options_rsk
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__sys_getpeername
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.inet_unhash
      0.07 ±  5%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.dccp_qpolicy_top
      0.09 ±  4%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__kmalloc_track_caller
      0.01 ±223%      +0.1        0.08        perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__inet_lookup_listener
      0.03 ± 70%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.apparmor_socket_post_create
      0.09 ±  5%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.should_failslab
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.security_socket_post_create
      0.14 ±  3%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.memcpy_erms
      0.12 ±  4%      +0.1        0.20        perf-profile.children.cycles-pp.nf_hook_slow
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.perf_exclude_event
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.08            +0.1        0.16        perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.09            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.raw_local_deliver
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.page_counter_charge
      0.20 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.ip_send_check
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.dccp_ackvec_buflen
      0.12 ±  4%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.dccp_feat_init
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.detach_if_pending
      0.21            +0.1        0.30        perf-profile.children.cycles-pp.dccp_qpolicy_pop
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.16            +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.migrate_disable
      0.12 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.dccp_v4_init_sock
      0.11            +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__feat_register_sp
      0.31            +0.1        0.41        perf-profile.children.cycles-pp.read_tsc
      0.56 ±  2%      +0.1        0.66        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.18            +0.1        0.28        perf-profile.children.cycles-pp.__alloc_file
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.18 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.alloc_empty_file
      0.19            +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.alloc_file
      0.14 ±  5%      +0.1        0.25        perf-profile.children.cycles-pp.__check_heap_object
      0.01 ±223%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.rb_erase
      1.29            +0.1        1.40        perf-profile.children.cycles-pp.dccp_connect
      1.69            +0.1        1.80        perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.80            +0.1        0.92        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.09            +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.dccp_insert_option_padding
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.___ratelimit
      0.26            +0.1        0.39        perf-profile.children.cycles-pp.dccp_feat_insert_opts
      0.07            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.18 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.inet_ehashfn
      0.15 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.migrate_enable
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.switch_ldt
      0.12 ±  3%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.dccp_feat_clone_list
      0.10 ±  3%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.skb_network_protocol
      0.23            +0.1        0.36        perf-profile.children.cycles-pp.inet_create
      0.00            +0.1        0.13        perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.19            +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.stress_dccp_client
      0.08 ±  4%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.dccp_ackvec_add_new
      0.87            +0.1        1.01        perf-profile.children.cycles-pp.dccp_finish_passive_close
      0.16 ±  3%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.skb_push
      0.07            +0.1        0.21        perf-profile.children.cycles-pp.woken_wake_function
      0.11 ±  4%      +0.1        0.25        perf-profile.children.cycles-pp.__fdget
      0.27 ±  2%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.alloc_file_pseudo
      0.00            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.__enqueue_entity
      0.28            +0.1        0.42        perf-profile.children.cycles-pp.sock_alloc_file
      0.38            +0.1        0.52        perf-profile.children.cycles-pp.dccp_feat_parse_options
      0.13 ±  5%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.dput
      0.17            +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.dccp_feat_clone_sp_val
      0.16 ±  3%      +0.1        0.31        perf-profile.children.cycles-pp.dccp_ackvec_input
      0.13 ±  5%      +0.1        0.28        perf-profile.children.cycles-pp.add_wait_queue
      0.00            +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.clear_buddies
      0.31 ±  2%      +0.2        0.47        perf-profile.children.cycles-pp.__ip_local_out
      0.00            +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.place_entity
      0.21 ±  2%      +0.2        0.38 ±  2%  perf-profile.children.cycles-pp.kmemdup
      0.16 ±  3%      +0.2        0.33        perf-profile.children.cycles-pp.__might_fault
      0.02 ± 99%      +0.2        0.19        perf-profile.children.cycles-pp.update_irq_load_avg
      0.87            +0.2        1.04        perf-profile.children.cycles-pp.kmalloc_reserve
      0.37            +0.2        0.54        perf-profile.children.cycles-pp.__sock_create
      0.59            +0.2        0.77        perf-profile.children.cycles-pp.dccp_ackvec_parsed_add
      0.66            +0.2        0.84        perf-profile.children.cycles-pp.dccp_close
      0.66            +0.2        0.84        perf-profile.children.cycles-pp.inet_release
      0.68            +0.2        0.86        perf-profile.children.cycles-pp.__sock_release
      0.36 ±  2%      +0.2        0.55        perf-profile.children.cycles-pp.ip_local_out
      0.68            +0.2        0.87        perf-profile.children.cycles-pp.sock_close
      0.64 ±  3%      +0.2        0.83        perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.perf_trace_buf_update
      0.65 ±  4%      +0.2        0.86        perf-profile.children.cycles-pp.rcu_core
      0.30            +0.2        0.50        perf-profile.children.cycles-pp.lock_timer_base
      2.63            +0.2        2.84        perf-profile.children.cycles-pp.__alloc_skb
      0.28 ±  2%      +0.2        0.50        perf-profile.children.cycles-pp.remove_wait_queue
      3.61            +0.2        3.83        perf-profile.children.cycles-pp.__inet_stream_connect
      0.28            +0.2        0.51        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.24            +0.2        0.46        perf-profile.children.cycles-pp.del_timer
      3.65            +0.2        3.88        perf-profile.children.cycles-pp.__x64_sys_connect
      0.00            +0.2        0.23        perf-profile.children.cycles-pp.se_is_idle
      0.41            +0.2        0.64        perf-profile.children.cycles-pp.mod_timer
      3.65            +0.2        3.88        perf-profile.children.cycles-pp.__sys_connect
      3.61            +0.2        3.84        perf-profile.children.cycles-pp.inet_stream_connect
      0.36            +0.2        0.59        perf-profile.children.cycles-pp.sk_stop_timer
      0.00            +0.2        0.23 ± 10%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.00            +0.2        0.23 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.52            +0.2        0.75        perf-profile.children.cycles-pp.__sys_socket
      0.52            +0.2        0.75        perf-profile.children.cycles-pp.__x64_sys_socket
      0.31            +0.2        0.55        perf-profile.children.cycles-pp.ip_rcv_core
      0.54            +0.2        0.78        perf-profile.children.cycles-pp.__socket
      0.22 ±  3%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.netif_skb_features
      3.67            +0.2        3.92        perf-profile.children.cycles-pp.connect
      0.05 ±  7%      +0.3        0.32        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.48            +0.3        0.74        perf-profile.children.cycles-pp.sk_reset_timer
      0.45 ±  3%      +0.3        0.72        perf-profile.children.cycles-pp.native_sched_clock
      0.37 ±  4%      +0.3        0.64        perf-profile.children.cycles-pp.copyin
      0.23 ±  3%      +0.3        0.51        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      1.52            +0.3        1.80        perf-profile.children.cycles-pp.dccp_v4_connect
      0.46 ±  2%      +0.3        0.74        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.61            +0.3        0.89        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.10 ±  8%      +0.3        0.39        perf-profile.children.cycles-pp.perf_tp_event
      0.18 ±  7%      +0.3        0.48 ±  2%  perf-profile.children.cycles-pp.pick_next_entity
      0.58 ±  4%      +0.3        0.88        perf-profile.children.cycles-pp.update_rq_clock
      0.56            +0.3        0.86        perf-profile.children.cycles-pp.ip_finish_output
      0.00            +0.3        0.32 ±  3%  perf-profile.children.cycles-pp.set_next_buddy
      0.40            +0.3        0.72        perf-profile.children.cycles-pp.dccp_ackvec_parsed_cleanup
      0.00            +0.3        0.32        perf-profile.children.cycles-pp.__calc_delta
      0.12 ±  3%      +0.3        0.45        perf-profile.children.cycles-pp.__virt_addr_valid
      0.55 ±  2%      +0.3        0.88        perf-profile.children.cycles-pp.sched_clock_cpu
      0.15 ± 13%      +0.3        0.49 ±  5%  perf-profile.children.cycles-pp.page_counter_cancel
      0.42 ±  2%      +0.3        0.77        perf-profile.children.cycles-pp.validate_xmit_skb
      1.02            +0.4        1.37        perf-profile.children.cycles-pp.__fput
      0.13 ±  5%      +0.4        0.49 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.52            +0.4        0.87        perf-profile.children.cycles-pp.dccp_ackvec_update_records
      0.37            +0.4        0.73 ±  3%  perf-profile.children.cycles-pp.ktime_get_with_offset
      1.67 ±  2%      +0.4        2.03        perf-profile.children.cycles-pp.kmem_cache_free
      1.04            +0.4        1.40        perf-profile.children.cycles-pp.task_work_run
      0.16 ±  4%      +0.4        0.53 ±  2%  perf-profile.children.cycles-pp.kthread
      0.14 ±  5%      +0.4        0.51 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.16 ±  4%      +0.4        0.53 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.08 ±  4%      +0.4        0.48        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.60            +0.4        1.01        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.16 ± 13%      +0.4        0.56 ±  6%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.14 ±  3%      +0.4        0.54        perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.17 ± 14%      +0.4        0.57 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.45            +0.4        0.86        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.06            +0.4        0.48 ±  7%  perf-profile.children.cycles-pp.update_min_vruntime
      1.14            +0.4        1.57        perf-profile.children.cycles-pp.__close
      0.99            +0.4        1.43        perf-profile.children.cycles-pp.csum_partial
      3.65            +0.4        4.09        perf-profile.children.cycles-pp.__dccp_rcv_established
      0.83 ±  3%      +0.4        1.28        perf-profile.children.cycles-pp.set_next_entity
      0.56 ±  2%      +0.5        1.01        perf-profile.children.cycles-pp._copy_from_iter
      0.84            +0.5        1.31        perf-profile.children.cycles-pp.__check_object_size
      0.48            +0.5        0.96        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.22 ±  3%      +0.5        0.72        perf-profile.children.cycles-pp.___perf_sw_event
      0.86            +0.5        1.36        perf-profile.children.cycles-pp.__cgroup_bpf_run_filter_skb
      0.19 ±  3%      +0.5        0.69        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.90            +0.5        1.41        perf-profile.children.cycles-pp.kfree
      1.68            +0.5        2.19        perf-profile.children.cycles-pp.dccp_parse_options
      0.21            +0.5        0.74        perf-profile.children.cycles-pp.__list_add_valid
      0.08 ±  6%      +0.5        0.62        perf-profile.children.cycles-pp.dccp_feat_push_change
      0.40 ±  2%      +0.5        0.94        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.08            +0.5        0.62        perf-profile.children.cycles-pp.dccp_feat_signal_nn_change
      0.15 ±  3%      +0.5        0.70        perf-profile.children.cycles-pp.dccp_feat_entry_new
      0.73            +0.5        1.28        perf-profile.children.cycles-pp.dccp_invalid_packet
      0.65            +0.8        1.41        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.23 ±  4%      +0.8        1.01        perf-profile.children.cycles-pp.check_preempt_curr
      0.39            +0.8        1.17        perf-profile.children.cycles-pp.kmem_cache_alloc_trace
      0.00            +0.8        0.79        perf-profile.children.cycles-pp.put_prev_entity
      0.25 ±  3%      +0.8        1.08        perf-profile.children.cycles-pp.ttwu_do_wakeup
      1.19            +0.9        2.06        perf-profile.children.cycles-pp.enqueue_entity
      0.90            +0.9        1.77        perf-profile.children.cycles-pp.netif_rx_internal
      0.00            +0.9        0.89        perf-profile.children.cycles-pp.check_preempt_wakeup
      1.09            +0.9        1.98        perf-profile.children.cycles-pp.ccid2_hc_tx_packet_recv
      0.94            +0.9        1.84        perf-profile.children.cycles-pp.netif_rx
     12.30            +0.9       13.22        perf-profile.children.cycles-pp.dccp_deliver_input_to_ccids
      1.24            +0.9        2.17        perf-profile.children.cycles-pp.dccp_insert_options
      0.18 ±  3%      +0.9        1.11 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.09 ±  4%      +0.9        1.04        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
     11.86            +1.0       12.84        perf-profile.children.cycles-pp.ccid2_hc_rx_packet_recv
      0.32 ±  2%      +1.0        1.35        perf-profile.children.cycles-pp.__switch_to
      0.22 ±  2%      +1.0        1.26        perf-profile.children.cycles-pp.__switch_to_asm
      0.08            +1.1        1.14 ±  3%  perf-profile.children.cycles-pp.reweight_entity
      1.92            +1.1        2.98        perf-profile.children.cycles-pp.sock_def_readable
      0.07 ±  5%      +1.2        1.26        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.17 ±  4%      +1.5        1.70        perf-profile.children.cycles-pp.switch_fpu_return
      1.81            +1.6        3.38        perf-profile.children.cycles-pp.dequeue_task_fair
      1.40            +1.7        3.10        perf-profile.children.cycles-pp.update_load_avg
      0.62 ±  2%      +1.9        2.51 ±  2%  perf-profile.children.cycles-pp.update_curr
      1.52 ±  5%      +2.0        3.51        perf-profile.children.cycles-pp.pick_next_task_fair
      1.64 ±  2%      +2.2        3.82        perf-profile.children.cycles-pp.enqueue_task_fair
      1.66 ±  2%      +2.3        3.92        perf-profile.children.cycles-pp.ttwu_do_activate
     17.02            +2.4       19.44        perf-profile.children.cycles-pp.dccp_rcv_established
      3.76            +2.7        6.43        perf-profile.children.cycles-pp.dccp_write_space
      0.04 ± 44%      +2.7        2.76        perf-profile.children.cycles-pp.load_new_mm_cr3
      4.17            +2.8        6.96        perf-profile.children.cycles-pp.sock_wfree
     24.30            +2.8       27.09        perf-profile.children.cycles-pp.dccp_v4_do_rcv
      2.16            +3.1        5.31        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.64            +3.3        4.96        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      4.30            +3.5        7.80        perf-profile.children.cycles-pp.try_to_wake_up
      4.71            +3.5        8.25        perf-profile.children.cycles-pp.__wake_up_common
      0.26            +3.6        3.82        perf-profile.children.cycles-pp.switch_mm_irqs_off
      4.93            +4.0        8.89        perf-profile.children.cycles-pp.__wake_up_common_lock
      5.43            +4.3        9.70        perf-profile.children.cycles-pp.loopback_xmit
      5.60            +4.4       10.01        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.75 ±  3%      +4.5        5.28        perf-profile.children.cycles-pp.__cond_resched
      0.00            +4.7        4.73        perf-profile.children.cycles-pp.preempt_schedule_common
      6.98            +5.0       11.96        perf-profile.children.cycles-pp.__dev_queue_xmit
      3.71 ±  2%      +6.2        9.94        perf-profile.children.cycles-pp.schedule_timeout
      5.51 ±  2%      +7.0       12.48        perf-profile.children.cycles-pp.sk_wait_data
      3.40 ±  2%      +7.1       10.48        perf-profile.children.cycles-pp.wait_woken
      3.68 ±  2%      +7.5       11.21        perf-profile.children.cycles-pp.schedule
     14.69            +8.0       22.74        perf-profile.children.cycles-pp.__sk_receive_skb
     18.98            +8.3       27.24        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     19.07            +8.4       27.48        perf-profile.children.cycles-pp.ip_local_deliver_finish
     19.18            +8.6       27.77        perf-profile.children.cycles-pp.ip_local_deliver
     20.30            +8.8       29.06        perf-profile.children.cycles-pp.ip_rcv
     57.14            +9.1       66.26        perf-profile.children.cycles-pp.__send
     82.42            +9.1       91.57        perf-profile.children.cycles-pp.do_syscall_64
     83.20            +9.3       92.54        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     20.88            +9.4       30.27        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      5.91 ±  2%      +9.6       15.52        perf-profile.children.cycles-pp.__schedule
     21.52            +9.8       31.31        perf-profile.children.cycles-pp.process_backlog
     21.58            +9.8       31.42        perf-profile.children.cycles-pp.__napi_poll
     21.87           +10.1       31.98        perf-profile.children.cycles-pp.net_rx_action
     49.74           +10.1       59.89        perf-profile.children.cycles-pp.__x64_sys_sendto
     49.42           +10.2       59.63        perf-profile.children.cycles-pp.__sys_sendto
     23.79           +10.3       34.07        perf-profile.children.cycles-pp.__softirqentry_text_start
     23.92           +10.4       34.32        perf-profile.children.cycles-pp.__local_bh_enable_ip
     23.12           +10.5       33.63        perf-profile.children.cycles-pp.do_softirq
     32.41           +11.1       43.46        perf-profile.children.cycles-pp.dccp_transmit_skb
     46.83           +11.4       58.23        perf-profile.children.cycles-pp.sock_sendmsg
     28.91           +11.5       40.45        perf-profile.children.cycles-pp.__ip_queue_xmit
     26.35           +11.8       38.19        perf-profile.children.cycles-pp.ip_finish_output2
     27.37           +12.0       39.40        perf-profile.children.cycles-pp.ip_output
     24.93           +16.3       41.22        perf-profile.children.cycles-pp.dccp_xmit_packet
     25.16           +16.4       41.52        perf-profile.children.cycles-pp.dccp_write_xmit
     40.19           +16.7       56.85        perf-profile.children.cycles-pp.dccp_sendmsg
      5.50 ±  5%      -5.1        0.38 ± 19%  perf-profile.self.cycles-pp.intel_idle
      5.24 ±  2%      -4.1        1.14 ±  3%  perf-profile.self.cycles-pp.aa_sk_perm
      3.22            -1.9        1.33        perf-profile.self.cycles-pp._raw_spin_lock_bh
      2.26 ±  3%      -1.9        0.38 ±  4%  perf-profile.self.cycles-pp.__send
      1.86            -1.8        0.06 ±  7%  perf-profile.self.cycles-pp.__slab_free
      2.20 ±  3%      -1.3        0.89        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.44            -1.1        0.34        perf-profile.self.cycles-pp.skb_set_owner_w
      1.55            -1.0        0.57        perf-profile.self.cycles-pp.dccp_recvmsg
      1.14            -0.8        0.34        perf-profile.self.cycles-pp.dst_release
      1.18            -0.8        0.41        perf-profile.self.cycles-pp.__skb_checksum
      0.77 ±  2%      -0.7        0.11 ±  7%  perf-profile.self.cycles-pp.ipv4_dst_check
      2.32            -0.6        1.69        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.34            -0.6        0.72        perf-profile.self.cycles-pp.__inet_lookup_established
      1.78            -0.6        1.16        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.18            -0.6        0.63        perf-profile.self.cycles-pp.__sk_receive_skb
      1.00 ±  4%      -0.6        0.45        perf-profile.self.cycles-pp.update_cfs_group
      0.97 ±  3%      -0.5        0.44        perf-profile.self.cycles-pp.__sys_sendto
      0.80            -0.5        0.28        perf-profile.self.cycles-pp.__ksize
      0.88            -0.5        0.39        perf-profile.self.cycles-pp.dccp_ackvec_clear_state
      0.88            -0.5        0.40        perf-profile.self.cycles-pp.dccp_check_seqno
      0.60 ±  3%      -0.4        0.22 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      1.10 ±  4%      -0.4        0.75        perf-profile.self.cycles-pp.__fget_light
      0.56            -0.3        0.23        perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.55            -0.3        0.24        perf-profile.self.cycles-pp.dccp_enqueue_skb
      0.74 ±  2%      -0.3        0.47        perf-profile.self.cycles-pp.ccid2_hc_tx_alloc_seq
      0.30 ±  3%      -0.2        0.05        perf-profile.self.cycles-pp.inet_sendmsg
      1.09            -0.2        0.86        perf-profile.self.cycles-pp.__might_resched
      0.82 ±  3%      -0.2        0.59        perf-profile.self.cycles-pp.dccp_sendmsg
      0.36 ±  2%      -0.2        0.13 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.53            -0.2        0.30        perf-profile.self.cycles-pp.release_sock
      0.64 ±  2%      -0.2        0.45        perf-profile.self.cycles-pp.__might_sleep
      0.53            -0.2        0.34        perf-profile.self.cycles-pp.dccp_write_space
      0.44 ±  2%      -0.2        0.26        perf-profile.self.cycles-pp.sock_sendmsg
      0.31 ±  4%      -0.2        0.12 ±  4%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.45            -0.2        0.27        perf-profile.self.cycles-pp.__release_sock
      0.47 ±  4%      -0.2        0.29        perf-profile.self.cycles-pp.update_rq_clock
      0.38 ±  3%      -0.2        0.21 ±  3%  perf-profile.self.cycles-pp.lock_sock_nested
      0.29 ±  3%      -0.2        0.13 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.40 ±  2%      -0.2        0.24        perf-profile.self.cycles-pp.ccid2_hc_tx_packet_sent
      0.23 ±  3%      -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.48 ±  5%      -0.1        0.34        perf-profile.self.cycles-pp.security_socket_sendmsg
      0.42 ±  3%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.stress_dccp_server
      0.30 ±  2%      -0.1        0.19        perf-profile.self.cycles-pp.dccp_ackvec_parsed_add
      0.37 ±  3%      -0.1        0.26        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.60            -0.1        0.49        perf-profile.self.cycles-pp.try_to_wake_up
      0.24 ±  3%      -0.1        0.14        perf-profile.self.cycles-pp.rcu_all_qs
      0.48            -0.1        0.38        perf-profile.self.cycles-pp.dccp_deliver_input_to_ccids
      0.18 ±  4%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.33 ±  3%      -0.1        0.24        perf-profile.self.cycles-pp.__wake_up_common
      0.36 ±  5%      -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.set_next_entity
      0.22 ±  3%      -0.1        0.13        perf-profile.self.cycles-pp._raw_spin_unlock_bh
      0.19 ±  2%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.skb_release_data
      0.64 ±  2%      -0.0        0.59        perf-profile.self.cycles-pp.do_syscall_64
      0.70            -0.0        0.66        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.08 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.dccp_send_ack
      0.36 ±  2%      -0.0        0.33        perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.__x64_sys_sendto
      0.19 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.sock_def_readable
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.qpolicy_simple_top
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__dccp_feat_activate
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.dccp_ackvec_input
      0.10 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.__napi_poll
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      1.20            +0.0        1.22        perf-profile.self.cycles-pp.kmem_cache_free
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.dccp_handle_ackvec_processing
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.dccp_v4_do_rcv
      0.06            +0.0        0.09        perf-profile.self.cycles-pp.dccp_ackvec_parsed_cleanup
      0.09            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.06 ±  9%      +0.0        0.09        perf-profile.self.cycles-pp.netdev_core_pick_tx
      0.11 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__sk_dst_check
      0.12 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.dccp_write_xmit
      0.08 ±  4%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.eth_type_trans
      0.07            +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__sk_destruct
      0.03 ± 70%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__inet_hash_connect
      0.06 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.__build_skb_around
      0.08            +0.0        0.12        perf-profile.self.cycles-pp.sk_reset_timer
      0.05            +0.0        0.09        perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.06            +0.0        0.10        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.06            +0.0        0.10        perf-profile.self.cycles-pp.skb_release_head_state
      0.05            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.should_failslab
      0.05 ±  8%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.check_preempt_curr
      0.05            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.ip_local_out
      0.07 ±  5%      +0.0        0.12        perf-profile.self.cycles-pp.sched_clock_cpu
      0.07            +0.0        0.12        perf-profile.self.cycles-pp.__kmalloc_track_caller
      0.06 ±  7%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__dccp_rcv_established
      0.06 ±  6%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.05            +0.1        0.10        perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.skb_copy_datagram_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.skb_release_all
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.skb_unlink
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sk_alloc
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ccid2_hc_tx_parse_options
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.memset_erms
      0.07            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.netif_rx
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.internal_add_timer
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.20 ±  4%      +0.1        0.26 ±  5%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.skb_queue_tail
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.02 ± 99%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.dccp_qpolicy_top
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.dccp_feat_activate_values
      0.30            +0.1        0.36        perf-profile.self.cycles-pp.__ip_finish_output
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.sock_recvmsg
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.dccp_feat_signal_nn_change
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.rb_insert_color
      0.14 ±  3%      +0.1        0.20        perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__raise_softirq_irqoff
      0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.__ip_local_out
      0.08 ±  4%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.ip_finish_output
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.dccp_insert_fn_opt
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.apparmor_sk_clone_security
      0.05 ±  7%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.kmalloc_slab
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.08 ±  5%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.nf_hook_slow
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.inet_lhash2_lookup
      0.80            +0.1        0.87        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.09            +0.1        0.16        perf-profile.self.cycles-pp.dccp_rcv_established
      0.06 ±  6%      +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.remove_wait_queue
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.apparmor_socket_post_create
      0.09            +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.netif_rx_internal
      0.06 ±  6%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.detach_if_pending
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.dccp_feat_entry_new
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.dccp_ackvec_buflen
      0.07 ±  5%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.raw_local_deliver
      0.11            +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.mod_timer
      0.14 ±  2%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.dccp_feat_parse_options
      0.06 ±  8%      +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.lock_timer_base
      0.09 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.skb_checksum
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.page_counter_charge
      0.19 ±  3%      +0.1        0.27        perf-profile.self.cycles-pp.ip_send_check
      0.13 ±  3%      +0.1        0.21        perf-profile.self.cycles-pp.memcpy_erms
      0.09            +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.ip_rcv_finish
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.check_stack_object
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.05            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.dccp_insert_option_padding
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.del_timer
      0.26            +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.dccp_xmit_packet
      0.12 ±  3%      +0.1        0.20        perf-profile.self.cycles-pp.dccp_v4_send_check
      0.14 ±  2%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.migrate_disable
      0.10 ±  4%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.skb_push
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.___ratelimit
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__might_fault
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.add_wait_queue
      0.14 ±  2%      +0.1        0.23        perf-profile.self.cycles-pp.dccp_feat_insert_opts
      0.12 ±  3%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.30            +0.1        0.39        perf-profile.self.cycles-pp.read_tsc
      0.12            +0.1        0.22 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.20            +0.1        0.30        perf-profile.self.cycles-pp.validate_xmit_skb
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.15 ±  2%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.14 ±  3%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.dccp_invalid_packet
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.13 ±  2%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.migrate_enable
      0.17 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.inet_ehashfn
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.09 ±  5%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.ccid2_hc_rx_packet_recv
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.clear_buddies
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
      0.23            +0.1        0.34 ±  4%  perf-profile.self.cycles-pp.recv
      0.09 ±  5%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.skb_network_protocol
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.switch_ldt
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.place_entity
      0.41            +0.1        0.53        perf-profile.self.cycles-pp.sock_wfree
      0.14 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.dccp_ackvec_update_records
      0.06 ±  6%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.15            +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.stress_dccp_client
      0.07 ±  7%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.sock_common_recvmsg
      0.64            +0.1        0.76        perf-profile.self.cycles-pp.dccp_v4_rcv
      0.07 ±  6%      +0.1        0.20        perf-profile.self.cycles-pp.dccp_ackvec_add_new
      0.06 ±  7%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.woken_wake_function
      0.12 ±  4%      +0.1        0.25        perf-profile.self.cycles-pp.netif_skb_features
      0.07            +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.12 ±  7%      +0.1        0.26 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.17 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.preempt_schedule_common
      0.06 ±  7%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.perf_tp_event
      0.09            +0.2        0.24        perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.00            +0.2        0.16 ± 13%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.04 ± 44%      +0.2        0.20        perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.84 ±  2%      +0.2        0.99        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.16 ±  2%      +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.00            +0.2        0.16        perf-profile.self.cycles-pp.se_is_idle
      0.37 ±  6%      +0.2        0.53 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.16 ±  4%  perf-profile.self.cycles-pp.select_idle_sibling
      0.25            +0.2        0.41        perf-profile.self.cycles-pp.enqueue_to_backlog
      0.05 ±  8%      +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.__fdget
      0.26            +0.2        0.44        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.10 ±  6%      +0.2        0.27        perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.11 ±  3%      +0.2        0.29        perf-profile.self.cycles-pp.ip_local_deliver
      1.07            +0.2        1.25        perf-profile.self.cycles-pp.dccp_transmit_skb
      0.65            +0.2        0.83        perf-profile.self.cycles-pp.dccp_parse_options
      0.67            +0.2        0.85        perf-profile.self.cycles-pp.ccid2_hc_tx_packet_recv
      0.17 ±  6%      +0.2        0.37 ±  3%  perf-profile.self.cycles-pp.pick_next_entity
      0.65            +0.2        0.85 ±  2%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.15 ±  3%      +0.2        0.35        perf-profile.self.cycles-pp.ip_rcv
      0.12            +0.2        0.33 ±  5%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.00            +0.2        0.21 ±  2%  perf-profile.self.cycles-pp.put_prev_entity
      0.39            +0.2        0.61        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.00            +0.2        0.22 ±  4%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.11 ±  3%      +0.2        0.33        perf-profile.self.cycles-pp.dequeue_task_fair
      0.14            +0.2        0.36        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.30 ±  2%      +0.2        0.52        perf-profile.self.cycles-pp.ip_output
      0.30            +0.2        0.53        perf-profile.self.cycles-pp.ip_rcv_core
      0.12            +0.2        0.35        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.30 ±  2%      +0.2        0.53        perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.34            +0.2        0.57        perf-profile.self.cycles-pp.__softirqentry_text_start
      0.82 ±  2%      +0.2        1.06        perf-profile.self.cycles-pp.update_load_avg
      0.05 ±  7%      +0.2        0.30        perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.07            +0.3        0.32        perf-profile.self.cycles-pp.security_socket_recvmsg
      0.43 ±  3%      +0.3        0.69        perf-profile.self.cycles-pp.native_sched_clock
      0.24            +0.3        0.49        perf-profile.self.cycles-pp.net_rx_action
      0.42            +0.3        0.68        perf-profile.self.cycles-pp.__alloc_skb
      0.16 ±  2%      +0.3        0.42        perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.14 ±  2%      +0.3        0.40        perf-profile.self.cycles-pp.__sys_recvfrom
      0.00            +0.3        0.26 ±  4%  perf-profile.self.cycles-pp.set_next_buddy
      0.05            +0.3        0.32        perf-profile.self.cycles-pp.schedule_timeout
      0.56            +0.3        0.84        perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
      0.00            +0.3        0.29        perf-profile.self.cycles-pp.__calc_delta
      0.37            +0.3        0.67        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.08            +0.3        0.38 ±  2%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.35            +0.3        0.66        perf-profile.self.cycles-pp.dccp_insert_options
      0.11 ±  3%      +0.3        0.42        perf-profile.self.cycles-pp.__virt_addr_valid
      0.00            +0.3        0.32        perf-profile.self.cycles-pp.schedule
      0.31            +0.3        0.64        perf-profile.self.cycles-pp.process_backlog
      0.09 ±  4%      +0.3        0.43 ±  3%  perf-profile.self.cycles-pp.sk_wait_data
      0.15 ± 14%      +0.3        0.49 ±  5%  perf-profile.self.cycles-pp.page_counter_cancel
      0.10 ±  5%      +0.3        0.44        perf-profile.self.cycles-pp.switch_fpu_return
      0.21 ±  4%      +0.4        0.56        perf-profile.self.cycles-pp.wait_woken
      0.31            +0.4        0.67        perf-profile.self.cycles-pp.kmem_cache_alloc_trace
      1.11            +0.4        1.48        perf-profile.self.cycles-pp._raw_spin_lock
      0.05 ±  7%      +0.4        0.42 ±  8%  perf-profile.self.cycles-pp.update_min_vruntime
      0.08 ±  4%      +0.4        0.46        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.11 ±  4%      +0.4        0.50        perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.20 ±  3%      +0.4        0.59        perf-profile.self.cycles-pp.___perf_sw_event
      0.44            +0.4        0.84        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.00            +0.4        0.42        perf-profile.self.cycles-pp.check_preempt_wakeup
      0.96            +0.4        1.39        perf-profile.self.cycles-pp.csum_partial
      0.18            +0.5        0.65        perf-profile.self.cycles-pp.__list_add_valid
      0.07            +0.5        0.54 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.39 ±  2%      +0.5        0.88        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.86            +0.5        1.36        perf-profile.self.cycles-pp.kfree
      0.22 ±  2%      +0.5        0.73        perf-profile.self.cycles-pp.loopback_xmit
      0.49            +0.5        1.02 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.06            +0.6        0.67 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.22 ±  3%      +0.8        1.04        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.19 ±  3%      +0.8        1.03        perf-profile.self.cycles-pp.update_curr
      0.17 ±  2%      +0.9        1.06 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.09 ±  6%      +0.9        1.02        perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.32 ±  2%      +1.0        1.29        perf-profile.self.cycles-pp.__switch_to
      0.21 ±  2%      +1.0        1.24        perf-profile.self.cycles-pp.__switch_to_asm
      0.07 ±  5%      +1.2        1.25        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.69 ±  2%      +1.2        1.89        perf-profile.self.cycles-pp.__schedule
      0.04 ± 44%      +2.7        2.73        perf-profile.self.cycles-pp.load_new_mm_cr3


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/300s/5K/lkp-icl-2sp2/TCP_SENDFILE/netperf/0xd000280

commit: 
  6275d291a7 ("Merge irq/core into tip/master")
  e9accc2386 ("sched: Stop searching for idle cpu if the LLC domain is overloaded")

6275d291a763090e e9accc2386f31d149ea339e8be4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     17338           +16.8%      20251        netperf.Throughput_Mbps
   1109679           +16.8%    1296078        netperf.Throughput_total_Mbps
    249210 ±  6%  +14650.0%   36758554 ±  5%  netperf.time.involuntary_context_switches
     19077            +3.5%      19753        netperf.time.minor_page_faults
    994.66           +24.4%       1237        netperf.time.user_time
 8.128e+09           +16.8%  9.493e+09        netperf.workload
   1575636 ±  5%     +23.6%    1946780        meminfo.Mapped
     13.78            +0.8       14.58        turbostat.C1%
     15.43            -1.6       13.81        mpstat.cpu.all.soft%
      3.41            +0.7        4.10        mpstat.cpu.all.usr%
    440709 ± 10%     +48.9%     656374 ± 21%  numa-numastat.node0.local_node
    505776 ±  6%     +37.7%     696592 ± 24%  numa-numastat.node0.numa_hit
   4730818            +2.5%    4849620        vmstat.system.cs
   2606454            -4.2%    2496267        vmstat.system.in
      2644 ± 10%     +43.0%       3782 ±  8%  numa-meminfo.node0.Active
      2644 ± 10%     +43.0%       3782 ±  8%  numa-meminfo.node0.Active(anon)
    284023 ±  8%     +98.7%     564442 ± 52%  numa-meminfo.node0.Inactive
    284023 ±  8%     +98.7%     564442 ± 52%  numa-meminfo.node0.Inactive(anon)
      4735 ± 24%     +58.5%       7506 ± 13%  numa-meminfo.node0.PageTables
    660.83 ± 10%     +43.0%     944.83 ±  8%  numa-vmstat.node0.nr_active_anon
     71007 ±  8%     +98.6%     141052 ± 52%  numa-vmstat.node0.nr_inactive_anon
      1184 ± 24%     +58.2%       1874 ± 13%  numa-vmstat.node0.nr_page_table_pages
    660.83 ± 10%     +43.0%     944.83 ±  8%  numa-vmstat.node0.nr_zone_active_anon
     71007 ±  8%     +98.6%     141052 ± 52%  numa-vmstat.node0.nr_zone_inactive_anon
      1.14 ± 29%     -90.2%       0.11 ±111%  sched_debug.cfs_rq:/.load_avg.min
    713960           -12.5%     624526 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
    101.58 ± 52%     -89.2%      10.94 ±133%  sched_debug.cfs_rq:/.runnable_avg.min
    714113           -12.5%     624772 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
     99.69 ± 50%     -89.1%      10.86 ±135%  sched_debug.cfs_rq:/.util_avg.min
    154600 ±  4%     +26.6%     195692 ±  3%  sched_debug.cpu.avg_idle.avg
    162529 ± 10%     +46.9%     238804 ±  6%  sched_debug.cpu.avg_idle.stddev
      4.12 ±  2%     +34.5%       5.54 ±  6%  sched_debug.cpu.clock.stddev
   2550588 ± 12%     +37.9%    3517002 ±  3%  sched_debug.cpu.nr_switches.min
   1221544 ±  2%      -8.5%    1117112 ±  3%  sched_debug.cpu.nr_switches.stddev
   2740194            -1.6%    2695985        proc-vmstat.nr_file_pages
   2168032            -2.0%    2124294        proc-vmstat.nr_inactive_anon
    396169 ±  5%     +23.3%     488448        proc-vmstat.nr_mapped
      2559            +7.8%       2759        proc-vmstat.nr_page_table_pages
   2121254            -2.1%    2077045        proc-vmstat.nr_shmem
   2168032            -2.0%    2124294        proc-vmstat.nr_zone_inactive_anon
    714673 ±  2%      +7.7%     769527 ±  2%  proc-vmstat.numa_hint_faults
    556124 ±  3%      +8.9%     605412 ±  3%  proc-vmstat.numa_hint_faults_local
   6522277            -2.2%    6376540        proc-vmstat.numa_hit
   6430747            -2.3%    6279842        proc-vmstat.numa_local
     10312 ± 31%    +117.3%      22405 ± 33%  proc-vmstat.numa_pages_migrated
    904795 ±  3%     +10.0%     995168 ±  5%  proc-vmstat.numa_pte_updates
   6506590            -2.0%    6378588        proc-vmstat.pgalloc_normal
   2035214            +4.3%    2123372        proc-vmstat.pgfault
     10312 ± 31%    +117.3%      22405 ± 33%  proc-vmstat.pgmigrate_success
     75710 ±  4%      -8.9%      68938 ±  7%  softirqs.CPU0.SCHED
     47782 ±  7%     -16.5%      39896 ± 10%  softirqs.CPU1.SCHED
     47511 ±  6%     -14.3%      40738 ±  3%  softirqs.CPU10.SCHED
     57588 ±  3%     -10.4%      51613 ±  6%  softirqs.CPU114.SCHED
     56773 ±  5%      -8.5%      51962 ±  6%  softirqs.CPU119.SCHED
     60944 ±  8%     -18.1%      49934 ±  7%  softirqs.CPU123.SCHED
     12115 ± 18%     +25.6%      15211 ±  5%  softirqs.CPU123.TIMER
     49116 ±  8%     -20.9%      38854 ±  6%  softirqs.CPU18.SCHED
      7100 ±  6%     +24.3%       8824 ± 17%  softirqs.CPU2.RCU
     48215 ± 14%     -25.4%      35957 ± 13%  softirqs.CPU2.SCHED
     47320 ±  9%     -15.2%      40111 ± 11%  softirqs.CPU20.SCHED
   9098334           +11.3%   10127293 ±  3%  softirqs.CPU24.NET_RX
     48146 ±  4%     -17.4%      39762 ±  7%  softirqs.CPU30.SCHED
     48439 ± 10%     -20.5%      38522 ±  5%  softirqs.CPU32.SCHED
     45724 ±  3%     -14.9%      38921 ±  4%  softirqs.CPU34.SCHED
     46626 ± 10%     -17.6%      38405 ±  8%  softirqs.CPU4.SCHED
     21617 ±  6%     -12.4%      18942 ±  8%  softirqs.CPU49.TIMER
     48749 ± 13%     -22.1%      37979 ± 10%  softirqs.CPU64.SCHED
   9584889 ±  3%      +9.1%   10452366 ±  3%  softirqs.CPU66.NET_RX
     17819 ± 14%     -26.5%      13097 ± 13%  softirqs.CPU66.TIMER
      7481 ±  3%     +19.4%       8936 ± 12%  softirqs.CPU67.RCU
     45843 ±  6%     -16.9%      38115 ± 13%  softirqs.CPU7.SCHED
     56797 ±  5%     -19.6%      45674 ±  8%  softirqs.CPU88.SCHED
     14629 ±  8%     +20.6%      17647 ± 10%  softirqs.CPU88.TIMER
      6.79           -68.3%       2.15 ±  3%  perf-stat.i.MPKI
 5.079e+10           +12.9%  5.733e+10        perf-stat.i.branch-instructions
      0.94            -0.1        0.87        perf-stat.i.branch-miss-rate%
 4.755e+08            +4.0%  4.944e+08        perf-stat.i.branch-misses
  24483752 ± 20%     -53.1%   11479375 ± 16%  perf-stat.i.cache-misses
 1.778e+09           -64.6%  6.299e+08 ±  3%  perf-stat.i.cache-references
   4765951            +2.5%    4884855        perf-stat.i.context-switches
      1.14           -12.8%       0.99        perf-stat.i.cpi
 2.978e+11            -1.7%  2.928e+11        perf-stat.i.cpu-cycles
     18360 ± 10%     -81.0%       3488 ±  4%  perf-stat.i.cpu-migrations
     14283 ± 20%    +126.2%      32316 ± 18%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  3%      -0.0        0.01 ±  5%  perf-stat.i.dTLB-load-miss-rate%
 8.033e+10           +12.9%  9.068e+10        perf-stat.i.dTLB-loads
      0.00 ±  6%      -0.0        0.00 ±  3%  perf-stat.i.dTLB-store-miss-rate%
    675078 ±  7%     -60.8%     264803 ±  4%  perf-stat.i.dTLB-store-misses
 4.317e+10           +12.8%  4.871e+10        perf-stat.i.dTLB-stores
 2.621e+11           +12.9%  2.959e+11        perf-stat.i.instructions
      0.88           +14.8%       1.01        perf-stat.i.ipc
      2.33            -1.7%       2.29        perf-stat.i.metric.GHz
    112.86 ± 10%     -18.6%      91.85 ±  9%  perf-stat.i.metric.K/sec
      1375           +12.1%       1541        perf-stat.i.metric.M/sec
      6373            +4.7%       6671        perf-stat.i.minor-faults
   1946110 ±  9%     -44.8%    1075212 ±  5%  perf-stat.i.node-loads
     53.51 ±  3%      +3.4       56.96        perf-stat.i.node-store-miss-rate%
   1904568 ± 14%     -28.7%    1358474 ± 11%  perf-stat.i.node-stores
      6374            +4.7%       6672        perf-stat.i.page-faults
      6.79           -68.7%       2.13 ±  3%  perf-stat.overall.MPKI
      0.94            -0.1        0.86        perf-stat.overall.branch-miss-rate%
      1.14           -12.9%       0.99        perf-stat.overall.cpi
     12621 ± 17%    +107.4%      26178 ± 15%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  3%      -0.0        0.01 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  7%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.88           +14.9%       1.01        perf-stat.overall.ipc
      9704            -3.3%       9381        perf-stat.overall.path-length
 5.062e+10           +12.9%  5.714e+10        perf-stat.ps.branch-instructions
 4.739e+08            +4.0%  4.928e+08        perf-stat.ps.branch-misses
  24402201 ± 20%     -53.1%   11437642 ± 16%  perf-stat.ps.cache-misses
 1.772e+09           -64.6%  6.274e+08 ±  3%  perf-stat.ps.cache-references
   4749921            +2.5%    4869190        perf-stat.ps.context-switches
 2.968e+11            -1.7%  2.918e+11        perf-stat.ps.cpu-cycles
     18325 ± 10%     -81.0%       3475 ±  4%  perf-stat.ps.cpu-migrations
 8.006e+10           +12.9%  9.038e+10        perf-stat.ps.dTLB-loads
    673376 ±  7%     -60.8%     263708 ±  4%  perf-stat.ps.dTLB-store-misses
 4.302e+10           +12.8%  4.855e+10        perf-stat.ps.dTLB-stores
 2.612e+11           +12.9%  2.949e+11        perf-stat.ps.instructions
      6351            +4.7%       6648        perf-stat.ps.minor-faults
   1937377 ±  9%     -44.7%    1070713 ±  5%  perf-stat.ps.node-loads
   1898897 ± 14%     -28.7%    1354269 ± 11%  perf-stat.ps.node-stores
      6352            +4.7%       6649        perf-stat.ps.page-faults
 7.887e+13           +12.9%  8.906e+13        perf-stat.total.instructions
     26.70            -4.0       22.72        perf-profile.calltrace.cycles-pp.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage.pipe_to_sendpage
     27.16            -3.9       23.26        perf-profile.calltrace.cycles-pp.inet_sendpage.kernel_sendpage.sock_sendpage.pipe_to_sendpage.__splice_from_pipe
     27.49            -3.8       23.67        perf-profile.calltrace.cycles-pp.kernel_sendpage.sock_sendpage.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe
     30.05            -3.8       26.25        perf-profile.calltrace.cycles-pp.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor.do_splice_direct
     27.62            -3.8       23.83        perf-profile.calltrace.cycles-pp.sock_sendpage.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe.direct_splice_actor
     27.94            -3.7       24.22        perf-profile.calltrace.cycles-pp.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor
     30.64            -3.7       26.97        perf-profile.calltrace.cycles-pp.splice_from_pipe.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile
     30.81            -3.6       27.19        perf-profile.calltrace.cycles-pp.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
     43.22            -3.1       40.08        perf-profile.calltrace.cycles-pp.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
     14.23            -2.9       11.34        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
     44.12            -2.8       41.27        perf-profile.calltrace.cycles-pp.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.42            -2.8       11.58        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
     14.49            -2.8       11.70        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
     14.56            -2.7       11.83        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll
     15.17            -2.6       12.52        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     16.21            -2.5       13.71        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
     15.64            -2.5       13.15        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
      6.84 ±  2%      -2.5        4.38 ±  5%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
     16.21            -2.4       13.79        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
     16.51            -2.4       14.11        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
     17.35            -2.3       15.02        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
      5.57 ±  2%      -2.3        3.28 ±  6%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage
     17.54            -2.3       15.25        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
     17.64            -2.3       15.37        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
     10.52            -2.0        8.51        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     10.60            -2.0        8.61        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
     47.55            -2.0       45.59        perf-profile.calltrace.cycles-pp.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      6.82            -1.9        4.95 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.tcp_sendpage.inet_sendpage.kernel_sendpage
      5.98            -1.7        4.24 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_bh.lock_sock_nested.tcp_sendpage.inet_sendpage
      7.50            -1.7        5.81 ±  2%  perf-profile.calltrace.cycles-pp.lock_sock_nested.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
      5.98 ±  3%      -1.6        4.41 ±  3%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      3.93 ±  2%      -1.5        2.40 ±  6%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      3.91 ±  3%      -1.5        2.38 ±  6%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
     49.83            -1.5       48.36        perf-profile.calltrace.cycles-pp.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile.sendfile_tcp_stream
      3.60 ±  2%      -1.3        2.27 ±  6%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendpage.inet_sendpage
      3.57 ±  2%      -1.3        2.25 ±  6%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendpage
     14.18            -1.3       12.90        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      4.70 ±  2%      -1.3        3.44 ±  3%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
     13.84            -1.2       12.66        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
     13.56            -1.2       12.39        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      6.16            -1.2        5.00 ±  2%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      6.61            -1.1        5.47 ±  2%  perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     13.89            -1.0       12.86        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      3.99            -1.0        2.96 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.generic_file_splice_read.splice_direct_to_actor
     50.36            -1.0       49.39        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile.sendfile_tcp_stream.main
      2.73 ±  3%      -0.9        1.81 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      2.53 ±  2%      -0.9        1.67 ±  4%  perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.90 ±  3%      -0.9        2.05 ±  2%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      4.31            -0.8        3.49 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.generic_file_splice_read.splice_direct_to_actor.do_splice_direct
      2.36 ±  3%      -0.8        1.54 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
      2.42 ±  2%      -0.8        1.62 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.17 ±  3%      -0.7        1.46 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
      2.99 ±  4%      -0.4        2.55        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.40 ±  4%      -0.4        1.97        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      1.38 ±  4%      -0.3        1.04 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
      1.40 ±  4%      -0.3        1.08        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
      8.53            -0.3        8.26        perf-profile.calltrace.cycles-pp.filemap_read.generic_file_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      1.22            -0.3        0.96        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.28            -0.2        1.04        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.91            -0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage
      1.53 ±  2%      -0.2        1.38 ±  3%  perf-profile.calltrace.cycles-pp.tcp_current_mss.tcp_send_mss.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage
      0.82 ±  4%      -0.1        0.70        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.93 ±  4%      -0.1        0.83        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      1.31 ±  2%      -0.1        1.21        perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
      1.86 ±  2%      -0.1        1.76 ±  2%  perf-profile.calltrace.cycles-pp.tcp_send_mss.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
      0.64 ±  5%      +0.1        0.71        perf-profile.calltrace.cycles-pp.__tcp_send_ack.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      0.59 ±  5%      +0.1        0.66        perf-profile.calltrace.cycles-pp.__alloc_skb.__tcp_send_ack.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.60            +0.1        0.69        perf-profile.calltrace.cycles-pp.ktime_get.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked
      0.56            +0.1        0.66 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
      2.36            +0.1        2.47        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages
      0.53 ±  2%      +0.1        0.65        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.splice_direct_to_actor.do_splice_direct.do_sendfile
      0.62 ±  2%      +0.1        0.74        perf-profile.calltrace.cycles-pp.security_file_permission.do_splice_to.splice_direct_to_actor.do_splice_direct.do_sendfile
      2.62            +0.1        2.74        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked
      0.65 ±  2%      +0.1        0.78        perf-profile.calltrace.cycles-pp.touch_atime.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      0.44 ± 44%      +0.1        0.57        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
      6.18            +0.1        6.31        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      2.32 ±  5%      +0.1        2.46        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.53 ±  2%      +0.1        0.67        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.generic_file_splice_read.splice_direct_to_actor.do_splice_direct
      6.21            +0.1        6.35        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.56            +0.1        0.70        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.42 ±  5%      +0.1        2.57        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.55 ±  2%      +0.2        0.70        perf-profile.calltrace.cycles-pp.touch_atime.generic_file_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      2.15 ±  5%      +0.2        2.30        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      0.56 ±  2%      +0.2        0.72        perf-profile.calltrace.cycles-pp.__fget_light.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ±  2%      +0.2        0.85 ±  3%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64
      0.57 ±  2%      +0.2        0.75        perf-profile.calltrace.cycles-pp.netperf_sendfile.sendfile_tcp_stream.main.__libc_start_main
      2.19 ±  5%      +0.2        2.37        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.60 ±  2%      +0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.96            +0.2        1.18        perf-profile.calltrace.cycles-pp._copy_from_user.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      1.07 ±  2%      +0.2        1.31        perf-profile.calltrace.cycles-pp.do_splice_to.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      1.06 ±  2%      +0.3        1.31        perf-profile.calltrace.cycles-pp.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.44            +0.3        4.71        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage
      1.55            +0.3        1.83        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.generic_file_splice_read.splice_direct_to_actor.do_splice_direct
      0.26 ±100%      +0.3        0.55        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg
      4.55            +0.3        4.86        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
      0.08 ±223%      +0.5        0.58 ±  2%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.generic_file_splice_read.splice_direct_to_actor
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.generic_file_splice_read.splice_direct_to_actor.do_splice_direct
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.__might_fault._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      0.17 ±141%      +0.6        0.81 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      0.64            +0.7        1.34        perf-profile.calltrace.cycles-pp.__entry_text_start.sendfile.sendfile_tcp_stream.main.__libc_start_main
     10.96 ±  2%      +0.8       11.72        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.00            +0.8        0.78 ±  6%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_timeout
     11.09 ±  2%      +0.8       11.88        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      5.21 ±  2%      +1.0        6.17        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      5.42 ±  2%      +1.0        6.44        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      6.64 ±  2%      +1.4        8.06        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
     27.10            -4.1       23.03        perf-profile.children.cycles-pp.tcp_sendpage
     27.52            -4.0       23.53        perf-profile.children.cycles-pp.inet_sendpage
     27.83            -3.9       23.91        perf-profile.children.cycles-pp.kernel_sendpage
     27.96            -3.9       24.08        perf-profile.children.cycles-pp.sock_sendpage
     28.28            -3.8       24.47        perf-profile.children.cycles-pp.pipe_to_sendpage
     30.41            -3.8       26.61        perf-profile.children.cycles-pp.__splice_from_pipe
     30.94            -3.7       27.25        perf-profile.children.cycles-pp.splice_from_pipe
     31.08            -3.6       27.43        perf-profile.children.cycles-pp.direct_splice_actor
     14.95            -3.4       11.59        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     14.76            -3.3       11.44        perf-profile.children.cycles-pp.tcp_rcv_established
     43.27            -3.0       40.24        perf-profile.children.cycles-pp.splice_direct_to_actor
     14.36            -2.9       11.44        perf-profile.children.cycles-pp.tcp_v4_rcv
     14.53            -2.9       11.65        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     14.59            -2.8       11.75        perf-profile.children.cycles-pp.ip_local_deliver_finish
     44.17            -2.8       41.34        perf-profile.children.cycles-pp.do_splice_direct
     14.66            -2.8       11.89        perf-profile.children.cycles-pp.ip_local_deliver
     15.28            -2.7       12.60        perf-profile.children.cycles-pp.ip_rcv
     22.76            -2.6       20.18        perf-profile.children.cycles-pp.__tcp_transmit_skb
     16.32            -2.5       13.78        perf-profile.children.cycles-pp.process_backlog
     15.75            -2.5       13.22        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     16.38            -2.5       13.86        perf-profile.children.cycles-pp.__napi_poll
     21.43            -2.5       18.93        perf-profile.children.cycles-pp.__ip_queue_xmit
      7.98            -2.4        5.53 ±  3%  perf-profile.children.cycles-pp.release_sock
     16.63            -2.4       14.19        perf-profile.children.cycles-pp.net_rx_action
     20.62            -2.4       18.22        perf-profile.children.cycles-pp.ip_output
     19.87            -2.4       17.47        perf-profile.children.cycles-pp.ip_finish_output2
     17.52            -2.4       15.14        perf-profile.children.cycles-pp.__softirqentry_text_start
     17.66            -2.3       15.33        perf-profile.children.cycles-pp.do_softirq
      6.42            -2.3        4.12 ±  4%  perf-profile.children.cycles-pp.__release_sock
     18.20            -2.2       15.98        perf-profile.children.cycles-pp.__local_bh_enable_ip
      8.26            -2.1        6.16        perf-profile.children.cycles-pp._raw_spin_lock_bh
     47.68            -1.9       45.75        perf-profile.children.cycles-pp.do_sendfile
      6.26            -1.9        4.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.13            -1.7        6.42        perf-profile.children.cycles-pp.lock_sock_nested
     11.97            -1.5       10.44        perf-profile.children.cycles-pp.tcp_write_xmit
     12.07            -1.5       10.56        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     49.97            -1.4       48.53        perf-profile.children.cycles-pp.__x64_sys_sendfile64
     85.97            -1.3       84.62        perf-profile.children.cycles-pp.do_syscall_64
     86.63            -1.2       85.46        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.06            -1.0        3.02        perf-profile.children.cycles-pp.filemap_get_read_batch
      2.89 ±  2%      -1.0        1.93 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      3.98            -0.9        3.07        perf-profile.children.cycles-pp.tcp_ack
      3.02 ±  2%      -0.9        2.12 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      3.24            -0.9        2.36        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      2.62 ±  2%      -0.9        1.75 ±  3%  perf-profile.children.cycles-pp.sock_def_readable
      4.38            -0.8        3.57        perf-profile.children.cycles-pp.filemap_get_pages
      2.46 ±  2%      -0.8        1.64 ±  2%  perf-profile.children.cycles-pp.__wake_up_common_lock
      2.38 ±  2%      -0.8        1.57 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      2.58            -0.7        1.84 ±  3%  perf-profile.children.cycles-pp.__kfree_skb
      2.21 ±  2%      -0.7        1.49 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      2.14            -0.6        1.51 ±  2%  perf-profile.children.cycles-pp.skb_release_data
      0.84 ±  4%      -0.3        0.53 ±  8%  perf-profile.children.cycles-pp.ipv4_mtu
      0.60 ±  3%      -0.3        0.30 ± 12%  perf-profile.children.cycles-pp.dst_release
      0.92            -0.3        0.64 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_established
      1.29            -0.2        1.05        perf-profile.children.cycles-pp.schedule_idle
      0.49            -0.2        0.26 ±  2%  perf-profile.children.cycles-pp.__ksize
      0.64            -0.2        0.42        perf-profile.children.cycles-pp.__slab_free
      0.40            -0.2        0.20 ±  6%  perf-profile.children.cycles-pp.sock_put
      8.75            -0.2        8.55        perf-profile.children.cycles-pp.filemap_read
      0.42 ±  3%      -0.2        0.24 ±  7%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.49            -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.page_cache_pipe_buf_confirm
      0.45 ±  2%      -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.tcp_rate_check_app_limited
      0.86 ±  3%      -0.2        0.70 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.87 ±  4%      -0.2        0.72 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.60            -0.2        0.44 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.23 ±  5%      -0.2        0.08 ±  8%  perf-profile.children.cycles-pp.select_idle_sibling
      0.29 ±  3%      -0.2        0.14 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.41 ±  2%      -0.2        0.26 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.24            -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.skb_clone
      0.40 ±  3%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.skb_release_head_state
      1.74 ±  2%      -0.1        1.61 ±  2%  perf-profile.children.cycles-pp.tcp_current_mss
      0.44 ±  3%      -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.skb_release_all
      0.48            -0.1        0.34 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.86            -0.1        0.73        perf-profile.children.cycles-pp.dequeue_entity
      0.96            -0.1        0.84        perf-profile.children.cycles-pp.dequeue_task_fair
      0.23 ±  2%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.irqentry_enter
      0.48            -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.sysvec_reschedule_ipi
      2.52            -0.1        2.42        perf-profile.children.cycles-pp.__dev_queue_xmit
      0.42            -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.31 ±  3%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.ipv4_dst_check
      1.33            -0.1        1.24        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.14 ±  3%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.14 ±  3%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.24 ±  2%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.tcp_mtu_probe
      0.22 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.17 ±  2%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.remove_wait_queue
      3.48            -0.1        3.40        perf-profile.children.cycles-pp.__schedule
      1.96 ±  2%      -0.1        1.88        perf-profile.children.cycles-pp.tcp_send_mss
      0.58 ±  2%      -0.1        0.51        perf-profile.children.cycles-pp.sk_reset_timer
      0.54 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.mod_timer
      0.62            -0.1        0.55        perf-profile.children.cycles-pp.update_load_avg
      0.92            -0.1        0.86        perf-profile.children.cycles-pp._raw_spin_lock
      0.32            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__skb_clone
      0.29 ±  2%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.__sk_dst_check
      0.43            -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.23 ±  5%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.tcp_eat_recv_skb
      0.14 ±  6%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.perf_tp_event
      0.14 ±  3%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.pick_next_entity
      0.27            -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.32            -0.1        0.26        perf-profile.children.cycles-pp.kmem_cache_free
      0.19 ±  3%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.13 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.cpuacct_charge
      0.22 ±  4%      -0.1        0.17 ±  8%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.20 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.migrate_disable
      0.17 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.14 ±  2%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.14 ±  3%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
      0.20            -0.0        0.17 ± 13%  perf-profile.children.cycles-pp.tick_sched_timer
      0.31 ±  3%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.ip_rcv_finish
      0.27 ±  3%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.19 ±  2%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.tick_sched_handle
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.18 ±  2%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.update_process_times
      0.25 ±  2%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.check_preempt_curr
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tcp_chrono_stop
      0.24 ±  2%      -0.0        0.22 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.09            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.tcp_rate_skb_delivered
      0.11 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rcu_dynticks_inc
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__tcp_select_window
      0.14 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.tcp_queue_rcv
      0.15            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.rcu_nmi_enter
      0.55            -0.0        0.53        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.27 ±  2%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.lock_timer_base
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rb_first
      0.15 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.tcp_skb_entail
      0.12 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.30            -0.0        0.28        perf-profile.children.cycles-pp.kfree
      0.16            -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.tcp_wfree
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__sock_wfree
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.08 ±  4%      +0.0        0.09        perf-profile.children.cycles-pp.iov_iter_pipe
      0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__ip_finish_output
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__build_skb_around
      0.05 ±  7%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.tcp_options_write
      0.06            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.skb_push
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.apparmor_socket_sock_rcv_skb
      0.09 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.tcp_v4_inbound_md5_hash
      0.08            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__fdget
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  4%      +0.0        0.10        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.28            +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.13 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.inet_ehashfn
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.skb_network_protocol
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.aa_sk_perm
      0.11 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.migrate_enable
      0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.xas_start
      0.29 ±  2%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.recv_tcp_stream
      0.12 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.splice_from_pipe_next
      0.17            +0.0        0.20        perf-profile.children.cycles-pp.tcp_tx_timestamp
      0.10 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.demo_interval_tick
      0.15 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.tcp_release_cb
      0.15            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.tcp_push
      0.16 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.13 ±  6%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.03 ± 70%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.20 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_bh
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.20 ±  2%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.18 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      1.08 ±  2%      +0.0        1.13        perf-profile.children.cycles-pp.loopback_xmit
      0.18 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.16 ±  2%      +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.15 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.netif_skb_features
      0.14 ±  7%      +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
      0.47            +0.0        0.52 ±  2%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.13 ±  2%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.tcp_newly_delivered
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.pipe_lock
      0.22            +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.demo_stream_interval
      0.67            +0.1        0.72        perf-profile.children.cycles-pp.__tcp_send_ack
      0.25            +0.1        0.30        perf-profile.children.cycles-pp.ip_rcv_core
      0.23 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.07 ±  5%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.50            +0.1        0.56        perf-profile.children.cycles-pp.tcp_established_options
      0.29 ±  2%      +0.1        0.35        perf-profile.children.cycles-pp.rw_verify_area
      0.18 ±  7%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.25 ±  3%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.09 ± 11%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      1.22 ±  2%      +0.1        1.28        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.25 ±  3%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.should_failslab
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.39            +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.22 ±  2%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.sanity
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.33 ±  2%      +0.1        0.41        perf-profile.children.cycles-pp.timestamp_truncate
      0.31            +0.1        0.40        perf-profile.children.cycles-pp.rcu_all_qs
      0.06 ± 45%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.16 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.46            +0.1        0.54        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.54            +0.1        0.62        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.35            +0.1        0.44        perf-profile.children.cycles-pp.validate_xmit_skb
      0.26 ±  2%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.47            +0.1        0.56        perf-profile.children.cycles-pp.sched_clock_cpu
      2.38            +0.1        2.48        perf-profile.children.cycles-pp.schedule_timeout
      0.51 ±  2%      +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.38 ±  2%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      2.48            +0.1        2.59        perf-profile.children.cycles-pp.wait_woken
      0.46            +0.1        0.57        perf-profile.children.cycles-pp.__put_user_nocheck_8
      0.09 ±  5%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.18 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.84            +0.1        0.98        perf-profile.children.cycles-pp.read_tsc
      0.38 ±  2%      +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      1.14 ±  3%      +0.1        1.27 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.25 ±  3%      +0.1        0.39        perf-profile.children.cycles-pp.tick_nohz_next_event
      6.23            +0.1        6.38        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.57            +0.2        0.72        perf-profile.children.cycles-pp.aa_file_perm
      6.26            +0.2        6.42        perf-profile.children.cycles-pp.cpuidle_enter
      0.66            +0.2        0.82        perf-profile.children.cycles-pp.__cond_resched
      0.40 ±  2%      +0.2        0.55        perf-profile.children.cycles-pp.__virt_addr_valid
      1.40            +0.2        1.56 ±  2%  perf-profile.children.cycles-pp.ktime_get
      0.36 ±  3%      +0.2        0.52 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.77            +0.2        0.94        perf-profile.children.cycles-pp.__fsnotify_parent
      0.82            +0.2        1.00        perf-profile.children.cycles-pp.__entry_text_start
      0.76            +0.2        0.96        perf-profile.children.cycles-pp.__fget_light
      2.25            +0.2        2.45        perf-profile.children.cycles-pp.schedule
      0.67 ±  2%      +0.2        0.87        perf-profile.children.cycles-pp.netperf_sendfile
      0.61 ±  2%      +0.2        0.82 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.84 ±  2%      +0.2        1.05        perf-profile.children.cycles-pp.current_time
      0.58            +0.2        0.79        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     10.87            +0.2       11.10        perf-profile.children.cycles-pp.do_tcp_sendpages
      1.03            +0.2        1.26        perf-profile.children.cycles-pp._copy_from_user
      1.12            +0.3        1.38        perf-profile.children.cycles-pp.do_splice_to
      0.97            +0.3        1.22        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.3        0.26 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.85            +0.3        1.13        perf-profile.children.cycles-pp.__might_sleep
      1.62            +0.3        1.93        perf-profile.children.cycles-pp.copy_page_to_iter
      0.47 ±  7%      +0.3        0.78 ±  6%  perf-profile.children.cycles-pp.newidle_balance
      1.21            +0.3        1.56        perf-profile.children.cycles-pp.__might_fault
      1.63            +0.4        2.00 ±  2%  perf-profile.children.cycles-pp.common_file_perm
      1.54            +0.4        1.92        perf-profile.children.cycles-pp.atime_needs_update
      1.63            +0.4        2.01        perf-profile.children.cycles-pp.__might_resched
      1.86            +0.5        2.32        perf-profile.children.cycles-pp.touch_atime
      2.35            +0.5        2.88        perf-profile.children.cycles-pp.security_file_permission
     11.05 ±  2%      +0.8       11.84        perf-profile.children.cycles-pp.__skb_datagram_iter
     11.09 ±  2%      +0.8       11.89        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      5.48 ±  2%      +1.0        6.53        perf-profile.children.cycles-pp.copyout
      6.00 ±  2%      +1.2        7.17        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      6.75 ±  2%      +1.5        8.22        perf-profile.children.cycles-pp._copy_to_iter
      6.21            -1.9        4.33        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.38 ±  2%      -1.1        1.23 ±  4%  perf-profile.self.cycles-pp.__check_object_size
      3.79            -1.1        2.70        perf-profile.self.cycles-pp.filemap_get_read_batch
      1.40            -0.4        0.98 ±  2%  perf-profile.self.cycles-pp.skb_release_data
      0.81 ±  4%      -0.3        0.49 ±  8%  perf-profile.self.cycles-pp.ipv4_mtu
      0.73            -0.3        0.42 ±  4%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.58 ±  3%      -0.3        0.28 ± 13%  perf-profile.self.cycles-pp.dst_release
      0.79            -0.3        0.50 ±  2%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.84 ±  2%      -0.3        0.58 ±  4%  perf-profile.self.cycles-pp.__dev_queue_xmit
      2.00            -0.3        1.74        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.48            -0.2        0.25 ±  2%  perf-profile.self.cycles-pp.__ksize
      0.63            -0.2        0.41        perf-profile.self.cycles-pp.__slab_free
      0.40            -0.2        0.18 ±  8%  perf-profile.self.cycles-pp.sock_put
      0.94            -0.2        0.73        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.46            -0.2        0.27 ±  2%  perf-profile.self.cycles-pp.page_cache_pipe_buf_confirm
      0.61            -0.2        0.43        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.30            -0.2        0.12 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.42 ±  3%      -0.2        0.25 ±  4%  perf-profile.self.cycles-pp.tcp_rate_check_app_limited
      0.26 ±  2%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.26 ±  2%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.set_next_entity
      0.23 ±  3%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.skb_clone
      0.50            -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.tcp_sendpage_locked
      0.46            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.18            -0.1        1.05        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.27 ±  3%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.14            -0.1        0.03 ±100%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.15 ±  2%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__wake_up_common
      0.30 ±  3%      -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.15 ±  3%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.irqentry_enter
      0.23 ±  3%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.tcp_mtu_probe
      0.11 ±  6%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.perf_tp_event
      0.16 ±  4%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.tcp_stream_alloc_skb
      0.13 ±  3%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
      0.25            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.__skb_clone
      0.26            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.15 ±  3%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__release_sock
      0.14 ±  2%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.32 ±  2%      -0.1        0.26        perf-profile.self.cycles-pp.kmem_cache_free
      0.22 ±  5%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.13 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.cpuacct_charge
      0.16 ±  4%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.sock_def_readable
      0.13 ±  3%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_eat_recv_skb
      0.18 ±  4%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.migrate_disable
      0.14            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.tcp_add_backlog
      0.13            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.schedule_timeout
      0.16 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.16 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.85            -0.0        0.80 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.25            -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.tcp_rcv_space_adjust
      0.26 ±  3%      -0.0        0.23        perf-profile.self.cycles-pp.mod_timer
      0.11 ±  3%      -0.0        0.08        perf-profile.self.cycles-pp.tcp_chrono_stop
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__list_add_valid
      1.27            -0.0        1.24        perf-profile.self.cycles-pp.tcp_write_xmit
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.40            -0.0        0.37 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.tcp_rate_skb_delivered
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.tcp_queue_rcv
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.rcu_dynticks_inc
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.rb_first
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.ip_send_check
      0.15 ±  3%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__tcp_select_window
      0.25            -0.0        0.23        perf-profile.self.cycles-pp.folio_mark_accessed
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.tcp_wfree
      0.29            -0.0        0.27        perf-profile.self.cycles-pp.kfree
      0.14 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
      0.10 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.dequeue_task_fair
      0.11 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__napi_poll
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__sock_wfree
      0.12 ±  4%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.kfree_skbmem
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__ip_finish_output
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.skb_release_head_state
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.raw_local_deliver
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.asm_sysvec_reschedule_ipi
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_v4_inbound_md5_hash
      0.21 ±  2%      +0.0        0.22        perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.05 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.11 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.11 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.28            +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.13 ±  4%      +0.0        0.15        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.inet_ehashfn
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.skb_network_protocol
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.ip_rcv_finish
      0.23 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.do_idle
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.recv
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.migrate_enable
      0.38            +0.0        0.40        perf-profile.self.cycles-pp.__alloc_skb
      0.10 ±  5%      +0.0        0.12        perf-profile.self.cycles-pp.generic_file_read_iter
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.inet_recvmsg
      0.20            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.tcp_tx_timestamp
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.12 ±  3%      +0.0        0.15        perf-profile.self.cycles-pp.tcp_release_cb
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.splice_from_pipe_next
      0.24 ±  3%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.recv_tcp_stream
      0.10            +0.0        0.13        perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.13 ±  4%      +0.0        0.16        perf-profile.self.cycles-pp._raw_spin_unlock_bh
      0.13            +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_push
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.netif_skb_features
      0.08            +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.demo_interval_tick
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp._copy_from_user
      0.13 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.demo_stream_interval
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.sock_sendpage
      0.13 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.10            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.10 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.10 ±  6%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.17            +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.23 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.ip_output
      0.45 ±  3%      +0.0        0.48 ±  2%  perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
      0.18 ±  3%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.12 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.direct_splice_actor
      0.28            +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.13 ±  2%      +0.0        0.17        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.12 ±  4%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.copyout
      0.15 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.do_softirq
      0.10 ±  5%      +0.0        0.14        perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.19 ±  3%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.19 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.do_splice_to
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.21 ±  3%      +0.0        0.26        perf-profile.self.cycles-pp.rw_verify_area
      0.16 ±  3%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.schedule_idle
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.skb_push
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tcp_options_write
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_irq_load_avg
      0.24            +0.1        0.29        perf-profile.self.cycles-pp.ip_rcv_core
      0.23 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.lock_sock_nested
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.schedule
      0.01 ±223%      +0.1        0.06        perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.apparmor_socket_sock_rcv_skb
      0.22 ±  2%      +0.1        0.27 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.25            +0.1        0.31        perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.update_blocked_averages
      0.14 ±  3%      +0.1        0.19        perf-profile.self.cycles-pp.simple_copy_to_iter
      0.31 ±  3%      +0.1        0.37 ±  2%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.45            +0.1        0.51        perf-profile.self.cycles-pp.tcp_established_options
      0.82            +0.1        0.88        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.32 ±  2%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp.tcp_send_mss
      0.27            +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.tcp_sendpage
      0.09 ±  6%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.ip_rcv
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.27            +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.__might_fault
      0.07            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.ip_local_deliver
      0.48            +0.1        0.54 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.24 ±  3%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.38            +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.29            +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.29 ±  2%      +0.1        0.36        perf-profile.self.cycles-pp.timestamp_truncate
      0.31 ±  2%      +0.1        0.38        perf-profile.self.cycles-pp.kernel_sendpage
      0.19            +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.sanity
      0.32            +0.1        0.39        perf-profile.self.cycles-pp.pipe_to_sendpage
      0.21 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.net_rx_action
      0.14            +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.04 ± 44%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.34 ±  2%      +0.1        0.41        perf-profile.self.cycles-pp.inet_sendpage
      0.43 ±  4%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.__x64_sys_sendfile64
      0.33            +0.1        0.41        perf-profile.self.cycles-pp.__cond_resched
      0.27 ±  2%      +0.1        0.35 ±  3%  perf-profile.self.cycles-pp.do_splice_direct
      0.33 ±  2%      +0.1        0.41 ±  2%  perf-profile.self.cycles-pp.current_time
      0.34 ±  2%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.touch_atime
      0.37            +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.50            +0.1        0.59        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.53            +0.1        0.63        perf-profile.self.cycles-pp.tcp_current_mss
      0.16 ±  8%      +0.1        0.26 ±  5%  perf-profile.self.cycles-pp.newidle_balance
      0.27 ±  2%      +0.1        0.38        perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.46            +0.1        0.57        perf-profile.self.cycles-pp.__put_user_nocheck_8
      0.50 ±  2%      +0.1        0.61 ±  2%  perf-profile.self.cycles-pp.splice_from_pipe
      0.42            +0.1        0.53 ±  2%  perf-profile.self.cycles-pp.generic_file_splice_read
      0.51            +0.1        0.62        perf-profile.self.cycles-pp.splice_direct_to_actor
      0.58            +0.1        0.70        perf-profile.self.cycles-pp.do_syscall_64
      0.62            +0.1        0.74 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.81            +0.1        0.94        perf-profile.self.cycles-pp.read_tsc
      0.48            +0.1        0.61 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      4.83            +0.1        4.96        perf-profile.self.cycles-pp.acpi_idle_do_entry
      0.56            +0.1        0.71        perf-profile.self.cycles-pp.sendfile
      0.37 ±  3%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.73            +0.2        0.88        perf-profile.self.cycles-pp.__fsnotify_parent
      1.78            +0.2        1.94        perf-profile.self.cycles-pp.filemap_read
      0.67            +0.2        0.84        perf-profile.self.cycles-pp.sendfile_tcp_stream
      0.73            +0.2        0.89        perf-profile.self.cycles-pp.__splice_from_pipe
      0.67            +0.2        0.83        perf-profile.self.cycles-pp.atime_needs_update
      0.60 ±  2%      +0.2        0.78        perf-profile.self.cycles-pp.netperf_sendfile
      0.73            +0.2        0.92        perf-profile.self.cycles-pp.__fget_light
      0.68            +0.2        0.86        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.31            +0.2        0.53 ±  2%  perf-profile.self.cycles-pp.filemap_get_pages
      1.39            +0.2        1.62        perf-profile.self.cycles-pp.copy_page_to_iter
      1.08            +0.2        1.32 ±  2%  perf-profile.self.cycles-pp.common_file_perm
      0.70            +0.2        0.94        perf-profile.self.cycles-pp.__might_sleep
      0.82 ±  2%      +0.2        1.06        perf-profile.self.cycles-pp._copy_to_iter
      0.96            +0.2        1.21        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.48            +0.3        1.81        perf-profile.self.cycles-pp.__might_resched
      1.18            +0.3        1.51 ±  2%  perf-profile.self.cycles-pp.do_sendfile
      5.92 ±  2%      +1.1        7.06        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-rc2-00110-ge9accc2386f3"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.17.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=m
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=128
	export testtime=60
	export job_origin='stress-ng-class-network.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='lkp-icl-2sp6'
	export tbox_group='lkp-icl-2sp6'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='62048006d149866fe7994c23'
	export job_file='/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-dccp-60s-ucode=0xd000280-debian-10.4-x86_64-20200603.cgz-e9accc2386f31d149ea339e8be401ad36361-20220210-28647-o3bozw-3.yaml'
	export id='45b43a1e2c76b9db7ed81686e5230f4ada0c3167'
	export queuer_version='/lkp-src'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=128
	export memory='128G'
	export nr_ssd_partitions=3
	export nr_hdd_partitions=6
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20SPZX-08UA7_WD-WXE2EA06X8DA-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204002V800RGN-part*'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K8400NGN-part1'
	export kernel_cmdline_hw='acpi_rsdp=0x69ffd014'
	export brand='Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz'
	export need_kconfig=
	export commit='e9accc2386f31d149ea339e8be401ad36361c9be'
	export ucode='0xd000280'
	export bisect_dmesg=true
	export enqueue_time='2022-02-10 11:01:26 +0800'
	export _id='62048006d149866fe7994c23'
	export _rt='/result/stress-ng/network-performance-100%-dccp-60s-ucode=0xd000280/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='85aa4933a0e46978701fd7fce83c2fd324802a70'
	export base_commit='dfd42facf1e4ada021b939b4e19c935dcdd55566'
	export branch='linux-review/Chen-Yu/sched-Stop-searching-for-idle-cpu-if-the-LLC-domain-is-overloaded/20220207-135940'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/stress-ng/network-performance-100%-dccp-60s-ucode=0xd000280/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/3'
	export scheduler_version='/lkp/lkp/.src-20220209-114222'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/stress-ng/network-performance-100%-dccp-60s-ucode=0xd000280/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/vmlinuz-5.17.0-rc2-00110-ge9accc2386f3
branch=linux-review/Chen-Yu/sched-Stop-searching-for-idle-cpu-if-the-LLC-domain-is-overloaded/20220207-135940
job=/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-dccp-60s-ucode=0xd000280-debian-10.4-x86_64-20200603.cgz-e9accc2386f31d149ea339e8be401ad36361-20220210-28647-o3bozw-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=e9accc2386f31d149ea339e8be401ad36361c9be
acpi_rsdp=0x69ffd014
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20220209.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20220209.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220205.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-90c9e950c0de-1_20220205.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.17.0-rc3-wt-ath-07385-g1a20fff7c404'
	export repeat_to=6
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/vmlinuz-5.17.0-rc2-00110-ge9accc2386f3'
	export dequeue_time='2022-02-10 11:31:55 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-dccp-60s-ucode=0xd000280-debian-10.4-x86_64-20200603.cgz-e9accc2386f31d149ea339e8be401ad36361-20220210-28647-o3bozw-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='network' test='dccp' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env class='network' test='dccp' $LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/stress-ng-class-network.yaml:
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 100%
testtime: 60s
stress-ng:
  class: network
  test: dccp
job_origin: stress-ng-class-network.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-icl-2sp6
tbox_group: lkp-icl-2sp6
kconfig: x86_64-rhel-8.3
submit_id: 62044401d14986376db36203
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-dccp-60s-ucode=0xd000280-debian-10.4-x86_64-20200603.cgz-e9accc2386f31d149ea339e8be401ad36361-20220210-14189-1ajbzab-2.yaml"
id: 754c41c5698ecf3fc6998a70c89e0637b010119e
queuer_version: "/lkp-src"
:#! hosts/lkp-icl-2sp6:
model: Ice Lake
nr_node: 2
nr_cpu: 128
memory: 128G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20SPZX-08UA7_WD-WXE2EA06X8DA-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204002V800RGN-part*"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K8400NGN-part1"
kernel_cmdline_hw: acpi_rsdp=0x69ffd014
brand: Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/stress-ng:
need_kconfig:
:#! include/queue/cyclic:
commit: e9accc2386f31d149ea339e8be401ad36361c9be
:#! include/testbox/lkp-icl-2sp6:
ucode: '0xd000280'
bisect_dmesg: true
enqueue_time: 2022-02-10 06:45:21.333634304 +08:00
_id: 62044413d14986376db36205
_rt: "/result/stress-ng/network-performance-100%-dccp-60s-ucode=0xd000280/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 85aa4933a0e46978701fd7fce83c2fd324802a70
base_commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
branch: linux-devel/devel-hourly-20220209-023058
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/stress-ng/network-performance-100%-dccp-60s-ucode=0xd000280/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/0"
scheduler_version: "/lkp/lkp/.src-20220209-114222"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/stress-ng/network-performance-100%-dccp-60s-ucode=0xd000280/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/vmlinuz-5.17.0-rc2-00110-ge9accc2386f3
- branch=linux-devel/devel-hourly-20220209-023058
- job=/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-dccp-60s-ucode=0xd000280-debian-10.4-x86_64-20200603.cgz-e9accc2386f31d149ea339e8be401ad36361-20220210-14189-1ajbzab-2.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=e9accc2386f31d149ea339e8be401ad36361c9be
- acpi_rsdp=0x69ffd014
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20220209.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20220209.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220205.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-90c9e950c0de-1_20220205.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220207215749/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.17.0-rc3
repeat_to: 3
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e9accc2386f31d149ea339e8be401ad36361c9be/vmlinuz-5.17.0-rc2-00110-ge9accc2386f3"
dequeue_time: 2022-02-10 06:49:03.945235179 +08:00
job_state: finished
loadavg: 74.79 32.25 11.89 1/1197 10087
start_time: '1644447010'
end_time: '1644447072'
version: "/lkp/lkp/.src-20220209-114307:6ff2367d:79e0ea6c8"

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--dccp" "128"

--2Z2K0IlrPCVsbNpk--
