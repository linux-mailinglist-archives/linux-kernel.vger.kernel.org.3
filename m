Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A74EEAA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344693AbiDAJoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbiDAJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:44:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD366F86
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648806148; x=1680342148;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GXPNkK2b7Pcv+hzezj8cNITZj4cKbQ/KVopFLz0IZ1Y=;
  b=iiOYRjz3JiFhiiEa7tNIF7vrA33vfgVZhn4Fj2scnq9aqfgIrEAt+Qel
   wGZKA+53E8UDLOQRuBdRebxQWVvlx1DG0EqPRGeLiav1TlzqL/HQu2ucr
   pVHGXfBqlVm+2JTGiJeizn202WTMic/HWG3D2W73QFcpVoT27QOpzJ6Qx
   xB+twnMr/D7OJzeL5u2XEwPfMwB9J5wfB8FDTdtuHcB2zHiWKPq5VvVoj
   nt6TXQ3mkO2HHl1Dw1lh93MZILM7C0r256apoShq9/Crw+HoN6hs4WdYd
   UgJnL+2zp+4OdqgsLI1QHIICeVnMBNl0Vy6nKZahdYk//EleGPTMWAhDn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="257671548"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="257671548"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:42:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="522713285"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:42:21 -0700
Date:   Fri, 1 Apr 2022 17:42:14 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Subject: [NUMA Balancing]  e39bb6be9f:  will-it-scale.per_thread_ops 64.4%
 improvement
Message-ID: <20220401094214.GA8368@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 64.4% improvement of will-it-scale.per_thread_ops due to commit:


commit: e39bb6be9f2b39a6dbaeff484361de76021b175d ("NUMA Balancing: add page promotion counter")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: will-it-scale
on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	nr_task: 50%
	mode: thread
	test: fallocate1
	cpufreq_governor: performance
	ucode: 0x500320a

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale





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
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap4/fallocate1/will-it-scale/0x500320a

commit: 
  ee97347fe0 ("powerpc/fadump: opt out from freeing pages on cma activation failure")
  e39bb6be9f ("NUMA Balancing: add page promotion counter")

ee97347fe058d020 e39bb6be9f2b39a6dbaeff48436 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3314361 ±  3%     +64.4%    5449130        will-it-scale.96.threads
     34524 ±  3%     +64.4%      56761        will-it-scale.per_thread_ops
   3314361 ±  3%     +64.4%    5449130        will-it-scale.workload
      7820 ±  9%     -13.4%       6772 ±  3%  numa-meminfo.node2.KernelStack
      4035            +5.1%       4240        vmstat.system.cs
      0.04           +50.0%       0.06        turbostat.IPC
    241.82            +5.3%     254.69        turbostat.PkgWatt
      0.67 ±  3%      +0.1        0.80 ±  2%  mpstat.cpu.all.irq%
      0.13 ±  3%      +0.0        0.16 ±  3%  mpstat.cpu.all.soft%
      0.09 ±  8%      +0.0        0.13 ±  2%  mpstat.cpu.all.usr%
     42314            +8.4%      45859        proc-vmstat.nr_slab_reclaimable
     2e+09 ±  3%     +64.2%  3.285e+09        proc-vmstat.numa_hit
 1.999e+09 ±  3%     +64.3%  3.284e+09        proc-vmstat.numa_local
 1.998e+09 ±  3%     +64.1%  3.279e+09        proc-vmstat.pgalloc_normal
 1.998e+09 ±  3%     +64.1%  3.279e+09        proc-vmstat.pgfree
 4.014e+08 ±  2%     +88.2%  7.555e+08        numa-numastat.node0.local_node
 4.015e+08 ±  2%     +88.2%  7.555e+08        numa-numastat.node0.numa_hit
 5.288e+08 ±  3%     +56.7%  8.283e+08 ±  3%  numa-numastat.node1.local_node
  5.29e+08 ±  3%     +56.6%  8.286e+08 ±  3%  numa-numastat.node1.numa_hit
  5.29e+08 ±  7%     +66.5%  8.806e+08        numa-numastat.node2.local_node
 5.291e+08 ±  7%     +66.5%  8.811e+08        numa-numastat.node2.numa_hit
 5.402e+08 ±  2%     +51.6%  8.192e+08 ±  2%  numa-numastat.node3.local_node
 5.405e+08 ±  2%     +51.6%  8.196e+08 ±  2%  numa-numastat.node3.numa_hit
      9874 ±  8%     +14.6%      11314 ±  8%  numa-vmstat.node0.nr_mapped
 4.014e+08 ±  2%     +88.2%  7.555e+08        numa-vmstat.node0.numa_hit
 4.013e+08 ±  2%     +88.3%  7.555e+08        numa-vmstat.node0.numa_local
  5.29e+08 ±  3%     +56.7%  8.286e+08 ±  3%  numa-vmstat.node1.numa_hit
 5.288e+08 ±  3%     +56.7%  8.283e+08 ±  3%  numa-vmstat.node1.numa_local
      7820 ±  9%     -13.4%       6768 ±  3%  numa-vmstat.node2.nr_kernel_stack
 5.291e+08 ±  7%     +66.5%  8.811e+08        numa-vmstat.node2.numa_hit
 5.289e+08 ±  7%     +66.5%  8.806e+08        numa-vmstat.node2.numa_local
 5.405e+08 ±  2%     +51.6%  8.196e+08 ±  2%  numa-vmstat.node3.numa_hit
 5.402e+08 ±  2%     +51.7%  8.192e+08 ±  2%  numa-vmstat.node3.numa_local
      6.76            +7.4%       7.26        perf-stat.i.MPKI
 9.427e+09 ±  2%     +31.5%   1.24e+10        perf-stat.i.branch-instructions
      0.38 ±  2%      +0.0        0.40        perf-stat.i.branch-miss-rate%
  35577299 ±  3%     +36.6%   48601753        perf-stat.i.branch-misses
  92457638 ±  3%     +44.7%  1.337e+08 ±  2%  perf-stat.i.cache-misses
 2.979e+08 ±  3%     +45.8%  4.344e+08        perf-stat.i.cache-references
      3950            +5.3%       4158        perf-stat.i.context-switches
      6.73 ±  2%     -26.0%       4.98        perf-stat.i.cpi
    197.62            +4.6%     206.68        perf-stat.i.cpu-migrations
      3224 ±  3%     -30.7%       2235 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.183e+10 ±  2%     +37.8%  1.631e+10        perf-stat.i.dTLB-loads
      0.00 ±  7%      -0.0        0.00 ±  9%  perf-stat.i.dTLB-store-miss-rate%
 5.184e+09 ±  3%     +62.5%  8.425e+09        perf-stat.i.dTLB-stores
     87.42            +1.0       88.38        perf-stat.i.iTLB-load-miss-rate%
  21992707 ±  2%     +15.4%   25374748        perf-stat.i.iTLB-load-misses
   3105517 ±  2%      +7.0%    3324290        perf-stat.i.iTLB-loads
 4.405e+10 ±  2%     +35.9%  5.988e+10        perf-stat.i.instructions
      2002 ±  2%     +18.0%       2362 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.15 ±  2%     +34.7%       0.20        perf-stat.i.ipc
    174.73 ±  4%     +35.4%     236.61 ±  2%  perf-stat.i.metric.K/sec
    139.22 ±  2%     +40.4%     195.54        perf-stat.i.metric.M/sec
  17761842 ±  4%     +24.6%   22130000 ±  3%  perf-stat.i.node-load-misses
  10797107 ±  3%     +68.9%   18236349 ±  2%  perf-stat.i.node-store-misses
      6.76            +7.3%       7.26        perf-stat.overall.MPKI
      0.38            +0.0        0.39        perf-stat.overall.branch-miss-rate%
      6.75 ±  2%     -26.1%       4.99        perf-stat.overall.cpi
      3217 ±  3%     -30.6%       2233 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.00 ± 19%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  4%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     87.63            +0.8       88.42        perf-stat.overall.iTLB-load-miss-rate%
      2003 ±  2%     +17.8%       2360 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.15 ±  2%     +35.3%       0.20        perf-stat.overall.ipc
   4027119           -17.8%    3310074        perf-stat.overall.path-length
 9.398e+09 ±  2%     +31.5%  1.235e+10        perf-stat.ps.branch-instructions
  35560785 ±  2%     +36.4%   48518588        perf-stat.ps.branch-misses
  92159444 ±  3%     +44.6%  1.333e+08 ±  2%  perf-stat.ps.cache-misses
 2.971e+08 ±  3%     +45.7%  4.329e+08        perf-stat.ps.cache-references
      3932            +5.2%       4136        perf-stat.ps.context-switches
    197.26            +4.4%     205.95        perf-stat.ps.cpu-migrations
  1.18e+10 ±  2%     +37.7%  1.625e+10        perf-stat.ps.dTLB-loads
 5.167e+09 ±  3%     +62.4%  8.393e+09        perf-stat.ps.dTLB-stores
  21922146 ±  2%     +15.3%   25283252        perf-stat.ps.iTLB-load-misses
   3093993 ±  2%      +7.0%    3310806        perf-stat.ps.iTLB-loads
 4.391e+10 ±  2%     +35.9%  5.967e+10        perf-stat.ps.instructions
  17706806 ±  4%     +24.5%   22051204 ±  3%  perf-stat.ps.node-load-misses
  10761992 ±  3%     +68.8%   18167295 ±  2%  perf-stat.ps.node-store-misses
 1.334e+13 ±  2%     +35.2%  1.804e+13        perf-stat.total.instructions
     22.90 ± 14%      -6.7       16.21 ±  9%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.shmem_getpage_gfp.shmem_fallocate.vfs_fallocate
     40.42 ± 12%      -6.7       33.74 ± 10%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_fallocate.vfs_fallocate.ksys_fallocate.__x64_sys_fallocate
     22.96 ± 14%      -6.7       16.30 ±  9%  perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_getpage_gfp.shmem_fallocate.vfs_fallocate.ksys_fallocate
     40.78 ± 12%      -6.5       34.29 ± 10%  perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.ksys_fallocate.__x64_sys_fallocate.do_syscall_64
     40.87 ± 12%      -6.4       34.42 ± 10%  perf-profile.calltrace.cycles-pp.vfs_fallocate.ksys_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.95 ± 14%      -6.4       14.53 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
     40.94 ± 12%      -6.4       34.52 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     40.93 ± 12%      -6.4       34.52 ± 10%  perf-profile.calltrace.cycles-pp.ksys_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     20.98 ± 14%      -6.4       14.57 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.shmem_getpage_gfp
     20.98 ± 14%      -6.4       14.58 ±  9%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.shmem_getpage_gfp.shmem_fallocate
     40.97 ± 12%      -6.4       34.56 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     40.98 ± 12%      -6.4       34.59 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     41.08 ± 12%      -6.3       34.74 ± 10%  perf-profile.calltrace.cycles-pp.fallocate64
     10.27 ±  7%      -4.5        5.73 ± 17%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__pagevec_release
     10.30 ±  7%      -4.5        5.77 ± 16%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__pagevec_release.shmem_undo_range.shmem_truncate_range
     10.29 ±  7%      -4.5        5.77 ± 16%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__pagevec_release.shmem_undo_range
      2.93 ±  8%      -1.7        1.24 ± 14%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
      2.94 ±  8%      -1.7        1.26 ± 14%  perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      2.72 ±  7%      -1.6        1.08 ± 14%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      3.15 ±  8%      -1.5        1.61 ± 13%  perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_truncate_range
      3.32 ±  8%      -1.5        1.84 ± 13%  perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_truncate_range.shmem_setattr
      3.45 ±  8%      -1.4        2.04 ± 12%  perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_truncate_range.shmem_setattr.notify_change
      2.24 ± 11%      -1.2        1.06 ± 10%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_fallocate.vfs_fallocate
      1.93 ± 11%      -1.1        0.85 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_fallocate
      1.60 ± 10%      -0.5        1.06 ± 16%  perf-profile.calltrace.cycles-pp.uncharge_folio.__mem_cgroup_uncharge_list.release_pages.__pagevec_release.shmem_undo_range
      1.26 ± 11%      -0.5        0.74 ± 11%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__pagevec_lru_add.folio_add_lru.shmem_getpage_gfp.shmem_fallocate
      0.84 ± 11%      -0.2        0.65 ± 11%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_add_drain_cpu.lru_add_drain.__pagevec_release.shmem_undo_range
      0.84 ± 11%      -0.2        0.65 ± 11%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.__pagevec_release.shmem_undo_range.shmem_truncate_range
      0.82 ± 11%      -0.2        0.63 ± 11%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__pagevec_lru_add.lru_add_drain_cpu.lru_add_drain.__pagevec_release
      0.82 ± 11%      -0.2        0.63 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.lru_add_drain_cpu.lru_add_drain
      0.82 ± 11%      -0.2        0.62 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.lru_add_drain_cpu
      0.84 ± 11%      -0.2        0.65 ± 11%  perf-profile.calltrace.cycles-pp.lru_add_drain.__pagevec_release.shmem_undo_range.shmem_truncate_range.shmem_setattr
      0.49 ± 45%      +0.4        0.89 ± 10%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_acct_page.shmem_getpage_gfp.shmem_fallocate.vfs_fallocate.ksys_fallocate
      0.00            +0.7        0.66 ±  9%  perf-profile.calltrace.cycles-pp.shmem_alloc_page.shmem_alloc_and_acct_page.shmem_getpage_gfp.shmem_fallocate.vfs_fallocate
      0.46 ± 44%      +1.1        1.52 ± 11%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.try_charge_memcg.charge_memcg.__mem_cgroup_charge
      5.80 ±  8%      +1.9        7.69 ± 12%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_fallocate
      1.30 ± 10%      +2.2        3.54 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.charge_memcg.__mem_cgroup_charge.shmem_add_to_page_cache
      1.72 ± 10%      +3.0        4.71 ± 13%  perf-profile.calltrace.cycles-pp.try_charge_memcg.charge_memcg.__mem_cgroup_charge.shmem_add_to_page_cache.shmem_getpage_gfp
      3.18 ± 22%      +3.8        6.97 ± 11%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages
     22.70 ± 10%      +5.2       27.91 ± 12%  perf-profile.calltrace.cycles-pp.__pagevec_release.shmem_undo_range.shmem_truncate_range.shmem_setattr.notify_change
     21.85 ± 10%      +5.4       27.26 ± 12%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.shmem_undo_range.shmem_truncate_range.shmem_setattr
      4.86 ± 18%      +6.6       11.45 ± 12%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages
     10.48 ± 17%      +9.9       20.42 ± 11%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__pagevec_release.shmem_undo_range.shmem_truncate_range
      8.06 ± 20%     +10.4       18.46 ± 11%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.__pagevec_release
      8.88 ± 19%     +10.5       19.35 ± 11%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_list.release_pages.__pagevec_release.shmem_undo_range
     32.10 ± 11%     -11.2       20.92 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     32.16 ± 11%     -11.2       21.00 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     32.16 ± 11%     -11.1       21.01 ± 11%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     23.80 ± 14%      -6.9       16.89 ±  9%  perf-profile.children.cycles-pp.__pagevec_lru_add
     40.49 ± 12%      -6.7       33.78 ± 10%  perf-profile.children.cycles-pp.shmem_getpage_gfp
     23.00 ± 14%      -6.7       16.32 ±  9%  perf-profile.children.cycles-pp.folio_add_lru
     40.79 ± 12%      -6.5       34.30 ± 10%  perf-profile.children.cycles-pp.shmem_fallocate
     40.87 ± 12%      -6.4       34.42 ± 10%  perf-profile.children.cycles-pp.vfs_fallocate
     40.94 ± 12%      -6.4       34.52 ± 10%  perf-profile.children.cycles-pp.ksys_fallocate
     40.94 ± 12%      -6.4       34.53 ± 10%  perf-profile.children.cycles-pp.__x64_sys_fallocate
     41.12 ± 12%      -6.3       34.79 ± 10%  perf-profile.children.cycles-pp.fallocate64
      6.62 ±  9%      -3.5        3.15 ± 12%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      5.18 ±  9%      -2.9        2.30 ± 12%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.95 ±  8%      -1.7        1.27 ± 14%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      3.16 ±  8%      -1.5        1.62 ± 13%  perf-profile.children.cycles-pp.__filemap_remove_folio
      3.32 ±  8%      -1.5        1.84 ± 13%  perf-profile.children.cycles-pp.filemap_remove_folio
      3.46 ±  8%      -1.4        2.05 ± 12%  perf-profile.children.cycles-pp.truncate_inode_folio
      1.60 ± 10%      -0.5        1.07 ± 16%  perf-profile.children.cycles-pp.uncharge_folio
      0.85 ± 11%      -0.2        0.66 ± 11%  perf-profile.children.cycles-pp.lru_add_drain
      0.85 ± 11%      -0.2        0.66 ± 11%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.27 ±  6%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.05 ± 45%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.06 ± 14%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.06 ± 16%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.07 ± 16%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.shmem_pseudo_vma_init
      0.08 ± 12%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.folio_unlock
      0.06 ± 11%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.xas_clear_mark
      0.05 ± 46%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.__entry_text_start
      0.05 ± 45%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.10 ± 17%      +0.0        0.14 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.09 ± 15%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.xas_alloc
      0.08 ± 18%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.02 ± 99%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.down_write
      0.02 ± 99%      +0.0        0.07 ± 13%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.02 ± 99%      +0.0        0.07 ± 13%  perf-profile.children.cycles-pp.folio_mapping
      0.02 ± 99%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.02 ±141%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.05 ± 46%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.__list_add_valid
      0.09 ± 12%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.08 ± 19%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__fget_light
      0.09 ± 15%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.__might_resched
      0.03 ±100%      +0.0        0.08 ± 15%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.09 ± 15%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.10 ± 13%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.xas_create
      0.08 ± 14%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.xas_start
      0.09 ± 14%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.xas_find_conflict
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__set_page_dirty_no_writeback
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.filemap_free_folio
      0.09 ± 13%      +0.1        0.15 ± 10%  perf-profile.children.cycles-pp.xas_init_marks
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.13 ± 14%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.11 ± 14%      +0.1        0.18 ± 12%  perf-profile.children.cycles-pp.free_unref_page_list
      0.13 ± 18%      +0.1        0.22 ± 17%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.19 ± 10%      +0.1        0.29 ± 12%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.09 ± 14%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.kthread
      0.18 ± 17%      +0.1        0.28 ± 16%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.09 ± 14%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      0.18 ± 11%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.08 ± 12%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.08 ± 12%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.17 ± 11%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.10 ± 18%      +0.1        0.22 ± 15%  perf-profile.children.cycles-pp.memcg_check_events
      0.19 ± 13%      +0.1        0.31 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      0.20 ± 12%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.rcu_core
      0.20 ± 13%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.rcu_do_batch
      0.20 ± 12%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.22 ± 18%      +0.1        0.37 ± 20%  perf-profile.children.cycles-pp.find_lock_entries
      0.27 ± 15%      +0.2        0.43 ± 10%  perf-profile.children.cycles-pp.xas_store
      0.27 ± 12%      +0.2        0.44 ± 10%  perf-profile.children.cycles-pp.__alloc_pages
      0.35 ± 12%      +0.2        0.55 ± 10%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.43 ± 13%      +0.2        0.67 ±  9%  perf-profile.children.cycles-pp.shmem_alloc_page
      0.57 ± 12%      +0.3        0.90 ± 10%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      5.82 ±  8%      +1.9        7.70 ± 12%  perf-profile.children.cycles-pp.charge_memcg
      1.31 ± 10%      +2.2        3.56 ± 13%  perf-profile.children.cycles-pp.page_counter_try_charge
      1.72 ± 10%      +3.0        4.73 ± 13%  perf-profile.children.cycles-pp.try_charge_memcg
      3.77 ± 20%      +4.8        8.61 ± 10%  perf-profile.children.cycles-pp.propagate_protected_usage
     22.70 ± 10%      +5.2       27.91 ± 12%  perf-profile.children.cycles-pp.__pagevec_release
     21.93 ± 10%      +5.4       27.36 ± 12%  perf-profile.children.cycles-pp.release_pages
      4.96 ± 18%      +6.7       11.66 ± 12%  perf-profile.children.cycles-pp.page_counter_cancel
     10.48 ± 17%      +9.9       20.42 ± 11%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      8.88 ± 19%     +10.5       19.35 ± 11%  perf-profile.children.cycles-pp.uncharge_batch
      8.19 ± 19%     +10.5       18.73 ± 11%  perf-profile.children.cycles-pp.page_counter_uncharge
     32.10 ± 11%     -11.2       20.92 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.57 ±  9%      -3.5        3.08 ± 12%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      3.84 ±  9%      -1.3        2.58 ± 14%  perf-profile.self.cycles-pp.charge_memcg
      3.02 ±  8%      -1.2        1.85 ± 14%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.59 ± 10%      -0.5        1.05 ± 16%  perf-profile.self.cycles-pp.uncharge_folio
      0.39 ± 13%      -0.2        0.16 ± 14%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.05 ± 45%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.fallocate64
      0.06 ± 15%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.04 ± 45%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.06 ± 15%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.xas_clear_mark
      0.06 ± 11%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.shmem_getpage_gfp
      0.05 ± 45%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.06 ± 14%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.shmem_pseudo_vma_init
      0.06 ± 16%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.xas_load
      0.07 ± 12%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.folio_unlock
      0.05 ± 46%      +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.__list_add_valid
      0.03 ±100%      +0.0        0.07 ±  9%  perf-profile.self.cycles-pp.folio_add_lru
      0.02 ± 99%      +0.0        0.07 ± 13%  perf-profile.self.cycles-pp.folio_mapping
      0.02 ± 99%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.09 ± 15%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__might_resched
      0.08 ± 16%      +0.0        0.13 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      0.09 ± 15%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.xas_store
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.shmem_alloc_and_acct_page
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__fget_light
      0.09 ± 12%      +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.filemap_free_folio
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__set_page_dirty_no_writeback
      0.10 ± 13%      +0.1        0.17 ± 10%  perf-profile.self.cycles-pp.shmem_fallocate
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.11 ± 13%      +0.1        0.18 ± 12%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ± 12%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ± 13%      +0.1        0.21 ±  9%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.13 ± 18%      +0.1        0.21 ± 18%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.08 ± 17%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.memcg_check_events
      0.20 ± 12%      +0.1        0.31 ± 14%  perf-profile.self.cycles-pp.release_pages
      0.19 ± 19%      +0.1        0.32 ± 22%  perf-profile.self.cycles-pp.find_lock_entries
      0.30 ± 13%      +0.2        0.48 ± 11%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.41 ±  8%      +0.8        1.16 ± 14%  perf-profile.self.cycles-pp.try_charge_memcg
      0.76 ± 10%      +1.2        2.01 ± 14%  perf-profile.self.cycles-pp.page_counter_try_charge
      3.74 ± 20%      +4.8        8.53 ± 10%  perf-profile.self.cycles-pp.propagate_protected_usage
      4.92 ± 18%      +6.6       11.56 ± 12%  perf-profile.self.cycles-pp.page_counter_cancel




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-00154-ge39bb6be9f2b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.17.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
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
# CONFIG_X86_MCE_AMD is not set
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
# CONFIG_MICROCODE_AMD is not set
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
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
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
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
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
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
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
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
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
--Dxnq1zWXvFF0Q93v--
