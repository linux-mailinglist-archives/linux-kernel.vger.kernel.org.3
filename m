Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8451E696
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392255AbiEGLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 07:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiEGLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 07:15:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F238DB2;
        Sat,  7 May 2022 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651921875; x=1683457875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HOklJb8wsdg05AgWNjwvCkGq2Zt+n3RK56AXtdDjhRc=;
  b=MDwK1vbJ6NHmdH3Rhkk7flOYuGIWpE8va6NrYgdJJSzHke6qk7pgNmr0
   HVaIAGCw+6EsxslldgJE5SHOuZHQRV5pp+edQxnbvMppDsX9bNhoCHl40
   Iitcj9cwfiRdVNOY6vdOqCNSR4tuwU9i6ptPLrJp5Pxx0q80s9ByjUsXE
   bzpV7RkJEtVt5D1eDCVjw1wimyGeJabXHpO0tHOI6gHC4S31U0OPq7eWm
   qkzsKX82Y3Qmi5StxE/nbnFEREF57Nm+4Z5T1GrcLWuKkOpD3TqiLbLNs
   7/2OVs4FEmoNN991zgsRWkVm0mIhYSI7z6FZFsszsge2VgqAZLYw01cUY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248602899"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="xz'?scan'208";a="248602899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 04:11:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="xz'?scan'208";a="586466048"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.127])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 04:11:12 -0700
Date:   Sat, 7 May 2022 19:09:46 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org, lkp@lists.01.org,
        fengwei.yin@intel.com, linux-xfs@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [LKP] Re: [xfs]  32678f1513:  aim7.jobs-per-min -5.6% regression
Message-ID: <20220507110941.GA10880@linux.intel.com>
References: <20220502082018.1076561-2-david@fromorbit.com>
 <20220506092250.GI23061@xsang-OptiPlex-9020>
 <20220506212924.GJ1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506212924.GJ1098723@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Dave,

On Sat, May 07, 2022 at 07:29:24AM +1000, Dave Chinner wrote:
> On Fri, May 06, 2022 at 05:22:50PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -5.6% regression of aim7.jobs-per-min due to commit:
> > 
> > 
> > commit: 32678f151338b9a321e9e27139a63c81f353acb7 ("[PATCH 1/4] xfs: detect self referencing btree sibling pointers")
> > url: https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/xfs-fix-random-format-verification-issues/20220502-162206
> > base: https://git.kernel.org/cgit/fs/xfs/xfs-linux.git for-next
> > patch link: https://lore.kernel.org/linux-xfs/20220502082018.1076561-2-david@fromorbit.com
> 
> Well, that answers the concern I had about the impact of 
> changing the way endian conversions were done in that patch.
> 
> > a44a027a8b2a20fe 32678f151338b9a321e9e27139a 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >     464232            -5.6%     438315        aim7.jobs-per-min
> ....
> >       0.13 ±  5%      +0.2        0.33 ±  6%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
> ....
> >       0.11 ±  4%      +0.2        0.30 ±  5%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
> 
> Because there is it, right at the bottom of the profile.
> 
> Can you try the patch below and see if that fixes the issue?

We tested below patch, it didn't fix the issue, still has -6.4% regression [1] 
comparing to a44a027a8b ("Merge tag 'large-extent-counters-v9' of 
https://github.com/chandanr/linux into xfs-5.19-for-next"). 

Dmesg file is attached.

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-11/performance/4BRD_12G/xfs/x86_64-rhel-8.3/3000/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_wrt/aim7/0x500320a

commit: 
  a44a027a8b ("Merge tag 'large-extent-counters-v9' of https://github.com/chandanr/linux into xfs-5.19-for-next")
  32678f1513 ("xfs: detect self referencing btree sibling pointers")
  92a8f471fa ("fixup-for-32678f1513")

a44a027a8b2a20fe 32678f151338b9a321e9e27139a 92a8f471fa024e1a303b0595fb9 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
    464232            -5.6%     438315            -6.4%     434563        aim7.jobs-per-min
...
      0.13 ±  5%      +0.2        0.33 ±  6%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
...
      0.11 ±  4%      +0.2        0.30 ±  5%      +0.2        0.29        perf-profile.self.cycles-pp.__xfs_btree_check_sblock

[1]

a44a027a8b2a20fe 32678f151338b9a321e9e27139a 92a8f471fa024e1a303b0595fb9 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
    464232            -5.6%     438315            -6.4%     434563        aim7.jobs-per-min
    702.64            +2.9%     723.04            +3.9%     730.36        aim7.time.system_time
     20.61            -3.7%      19.84            -2.9%      20.00        iostat.cpu.system
     10.13 ±111%     -13.0%       8.81 ± 97%      -1.0%      10.03 ± 74%  perf-stat.i.MPKI
 8.246e+09            -3.9%  7.924e+09            -4.1%  7.907e+09        perf-stat.i.branch-instructions
      1.44 ± 64%      -0.1        1.34 ± 54%      +0.1        1.52 ± 46%  perf-stat.i.branch-miss-rate%
  34854794 ±  5%      -4.2%   33387833 ±  3%      -1.9%   34209787 ±  3%  perf-stat.i.branch-misses
     23.30 ±  3%      +1.6       24.86 ±  8%      +0.1       23.36 ±  4%  perf-stat.i.cache-miss-rate%
  23053543 ±  2%      -6.0%   21668177            -4.9%   21931373 ±  3%  perf-stat.i.cache-misses
  86799897 ±  8%      -6.0%   81632955 ±  8%      -2.2%   84874629 ±  8%  perf-stat.i.cache-references
     46885            -4.6%      44714            -5.4%      44356        perf-stat.i.context-switches
      1.99 ± 24%      -2.2%       1.95 ± 17%      -0.5%       1.98 ± 18%  perf-stat.i.cpi
     88032            -0.0%      88025            -0.0%      88021        perf-stat.i.cpu-clock
 5.425e+10            -2.6%  5.285e+10            -2.1%  5.311e+10 ±  2%  perf-stat.i.cpu-cycles
      1424            -8.9%       1296            -9.1%       1294        perf-stat.i.cpu-migrations
      3054 ± 17%     -12.8%       2664 ± 12%      -5.5%       2886 ± 13%  perf-stat.i.cycles-between-cache-misses
      0.08 ±133%      +0.0        0.10 ± 83%      +0.0        0.09 ± 91%  perf-stat.i.dTLB-load-miss-rate%
   1644013 ±101%     -39.1%    1001092 ± 20%     -40.4%     979021 ± 21%  perf-stat.i.dTLB-load-misses
 1.175e+10            -4.1%  1.127e+10            -4.7%   1.12e+10        perf-stat.i.dTLB-loads
      0.02 ±119%      +0.0        0.03 ± 75%      +0.0        0.02 ± 84%  perf-stat.i.dTLB-store-miss-rate%
    120834 ± 26%      +2.8%     124168 ± 20%      +1.9%     123169 ± 21%  perf-stat.i.dTLB-store-misses
 5.701e+09            -5.3%  5.396e+09            -6.0%  5.356e+09        perf-stat.i.dTLB-stores
     72.95 ±  4%      -0.5       72.49 ±  3%      -0.2       72.71 ±  2%  perf-stat.i.iTLB-load-miss-rate%
  17300716           -12.4%   15151342           -10.8%   15425181 ±  3%  perf-stat.i.iTLB-load-misses
   4184079 ±  4%      -2.7%    4071696 ±  3%      -7.2%    3882733        perf-stat.i.iTLB-loads
 4.151e+10            -3.8%  3.994e+10            -4.0%  3.986e+10        perf-stat.i.instructions
      2341 ±  5%     +10.1%       2578            +9.7%       2567 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.68 ±  4%      +0.3%       0.68 ±  2%      -0.0%       0.68 ±  4%  perf-stat.i.ipc
     37.92 ± 40%     +21.1%      45.90 ± 29%     +25.1%      47.43 ± 43%  perf-stat.i.major-faults
      0.62            -2.6%       0.60            -2.1%       0.60 ±  2%  perf-stat.i.metric.GHz
    311.41 ± 42%      -2.6%     303.44 ± 32%      -1.7%     306.21 ± 27%  perf-stat.i.metric.K/sec
    292.90            -4.3%     280.20            -4.8%     278.81        perf-stat.i.metric.M/sec
      7947 ±  2%      -3.4%       7677 ±  2%      -2.4%       7758 ±  3%  perf-stat.i.minor-faults
     69.35 ±  3%      +0.3       69.68 ±  2%      +1.3       70.64        perf-stat.i.node-load-miss-rate%
   4245573 ±  3%      -4.9%    4035543 ±  2%      -4.7%    4043985 ±  2%  perf-stat.i.node-load-misses
   1997742 ±  2%      -6.2%    1874006            -7.5%    1847909        perf-stat.i.node-loads
     44.58 ±  4%      +0.7       45.29 ±  5%      -0.0       44.58 ±  5%  perf-stat.i.node-store-miss-rate%
   2317846 ±  3%      -4.7%    2208172 ±  2%      -5.6%    2188128 ±  3%  perf-stat.i.node-store-misses
   3534663            -5.9%    3326105            -6.3%    3312606        perf-stat.i.node-stores
      7985 ±  2%      -3.3%       7723 ±  2%      -2.2%       7806 ±  3%  perf-stat.i.page-faults
     88032            -0.0%      88025            -0.0%      88021        perf-stat.i.task-clock
      2.09 ±  7%      -2.2%       2.04 ±  8%      +1.8%       2.13 ±  8%  perf-stat.overall.MPKI
      0.42 ±  5%      -0.0        0.42 ±  3%      +0.0        0.43 ±  3%  perf-stat.overall.branch-miss-rate%
     26.70 ±  6%      +0.0       26.70 ±  7%      -0.7       26.01 ±  7%  perf-stat.overall.cache-miss-rate%
      1.31            +1.3%       1.32            +2.0%       1.33        perf-stat.overall.cpi
      2354 ±  2%      +3.6%       2440 ±  2%      +2.9%       2423 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±101%      -0.0        0.01 ± 20%      -0.0        0.01 ± 21%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 25%      +0.0        0.00 ± 20%      +0.0        0.00 ± 21%  perf-stat.overall.dTLB-store-miss-rate%
     80.54            -1.7       78.83            -0.7       79.88        perf-stat.overall.iTLB-load-miss-rate%
      2400            +9.8%       2636            +7.8%       2586 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.77            -1.3%       0.76            -1.9%       0.75        perf-stat.overall.ipc
     67.98            +0.3       68.28            +0.6       68.63        perf-stat.overall.node-load-miss-rate%
     39.59 ±  2%      +0.3       39.90            +0.2       39.76        perf-stat.overall.node-store-miss-rate%
  8.05e+09            -3.7%  7.749e+09            -4.0%  7.729e+09        perf-stat.ps.branch-instructions
  33999070 ±  5%      -4.1%   32614324 ±  3%      -1.7%   33414902 ±  3%  perf-stat.ps.branch-misses
  22503328 ±  2%      -5.9%   21186670            -4.8%   21434254 ±  2%  perf-stat.ps.cache-misses
  84713531 ±  7%      -5.8%   79798101 ±  8%      -2.1%   82935444 ±  8%  perf-stat.ps.cache-references
     45772            -4.5%      43725            -5.3%      43356        perf-stat.ps.context-switches
     85806            +0.2%      85944            +0.2%      85955        perf-stat.ps.cpu-clock
 5.296e+10            -2.4%  5.168e+10            -2.0%  5.191e+10 ±  2%  perf-stat.ps.cpu-cycles
      1390            -8.8%       1267            -9.0%       1264        perf-stat.ps.cpu-migrations
   1603543 ±101%     -39.0%     977805 ± 20%     -40.4%     956223 ± 21%  perf-stat.ps.dTLB-load-misses
 1.147e+10            -4.0%  1.102e+10            -4.6%  1.094e+10        perf-stat.ps.dTLB-loads
    117801 ± 26%      +2.9%     121212 ± 19%      +2.1%     120248 ± 21%  perf-stat.ps.dTLB-store-misses
 5.565e+09            -5.2%  5.277e+09            -5.9%  5.236e+09        perf-stat.ps.dTLB-stores
  16890063           -12.3%   14816058           -10.7%   15077842 ±  3%  perf-stat.ps.iTLB-load-misses
   4083261 ±  4%      -2.5%    3980087 ±  3%      -7.1%    3794317        perf-stat.ps.iTLB-loads
 4.053e+10            -3.6%  3.905e+10            -3.9%  3.896e+10        perf-stat.ps.instructions
     36.83 ± 40%     +21.4%      44.70 ± 29%     +25.1%      46.07 ± 42%  perf-stat.ps.major-faults
      7724 ±  2%      -3.2%       7476 ±  2%      -2.2%       7551 ±  3%  perf-stat.ps.minor-faults
   4144187 ±  3%      -4.8%    3946230 ±  2%      -4.6%    3952384 ±  2%  perf-stat.ps.node-load-misses
   1950358 ±  2%      -6.0%    1832583            -7.4%    1806333        perf-stat.ps.node-loads
   2262554 ±  3%      -4.6%    2159317 ±  2%      -5.5%    2138598 ±  3%  perf-stat.ps.node-store-misses
   3450878            -5.7%    3252498            -6.2%    3237962        perf-stat.ps.node-stores
      7761 ±  2%      -3.1%       7521 ±  2%      -2.1%       7597 ±  3%  perf-stat.ps.page-faults
     85806            +0.2%      85944            +0.2%      85955        perf-stat.ps.task-clock
 1.625e+12            +2.8%   1.67e+12            +3.0%  1.673e+12        perf-stat.total.instructions
     29.46 ±  3%      -1.1       28.33 ±  3%      -1.2       28.25 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     28.94 ±  3%      -1.1       27.84 ±  3%      -1.2       27.76 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.28 ±  3%      -1.0       26.25 ±  3%      -1.1       26.20 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.46 ±  3%      -1.0       25.46 ±  3%      -1.0       25.42 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     23.17 ±  3%      -0.8       22.36 ±  3%      -0.9       22.30 ±  2%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     18.02 ±  3%      -0.6       17.41 ±  3%      -0.6       17.37 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     22.03 ± 12%      -0.4       21.60 ± 10%      -0.6       21.46 ±  9%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     22.14 ± 12%      -0.3       21.79 ±  9%      -0.6       21.51 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.93 ±  3%      -0.3        9.61 ±  2%      -0.3        9.60 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
     23.55 ± 12%      -0.3       23.23 ±  8%      -0.6       22.94 ±  9%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     22.88 ± 12%      -0.3       22.62 ±  9%      -0.6       22.31 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     22.93 ± 12%      -0.3       22.68 ±  9%      -0.6       22.36 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     23.08 ± 12%      -0.2       22.84 ±  8%      -0.6       22.52 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
     23.21 ± 12%      -0.2       22.98 ±  8%      -0.6       22.65 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
     23.20 ± 12%      -0.2       22.98 ±  8%      -0.6       22.65 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      4.49 ±  2%      -0.2        4.31 ±  3%      -0.2        4.29 ±  3%  perf-profile.calltrace.cycles-pp.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
      5.22 ±  2%      -0.2        5.05 ±  3%      -0.2        5.01 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.17 ±141%      -0.2        0.00            -0.2        0.00        perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      3.36            -0.1        3.22 ±  3%      -0.2        3.18 ±  2%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.38            -0.1        3.24 ±  3%      -0.2        3.20 ±  2%  perf-profile.calltrace.cycles-pp.__close
      3.35 ±  2%      -0.1        3.21 ±  3%      -0.2        3.18 ±  2%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.37            -0.1        3.23 ±  3%      -0.2        3.20 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      3.37            -0.1        3.23 ±  3%      -0.2        3.20 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.34            -0.1        3.20 ±  3%      -0.2        3.16 ±  2%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      3.36            -0.1        3.22 ±  3%      -0.2        3.19 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.36            -0.1        3.22 ±  3%      -0.2        3.19 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.36            -0.1        3.22 ±  3%      -0.2        3.19 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.33 ±  2%      -0.1        3.19 ±  3%      -0.2        3.16 ±  2%  perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_loop
      3.32            -0.1        3.19 ±  3%      -0.2        3.15 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
      3.29 ±  2%      -0.1        3.16 ±  3%      -0.2        3.12 ±  2%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
      3.27 ±  2%      -0.1        3.14 ±  3%      -0.2        3.10 ±  2%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill.dput
      2.96 ±  2%      -0.1        2.84 ±  3%      -0.1        2.82 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      4.28 ±  3%      -0.1        4.16 ±  2%      -0.1        4.18 ±  2%  perf-profile.calltrace.cycles-pp.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      1.75 ±  6%      -0.1        1.64 ±  2%      -0.1        1.63        perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.08 ± 25%      -0.1        0.96 ± 21%      -0.2        0.87 ±  5%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      3.94 ±  3%      -0.1        3.84 ±  3%      -0.1        3.83 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.67 ± 12%      -0.1        0.57 ±  4%      -0.1        0.59 ±  5%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      2.63 ±  3%      -0.1        2.54 ±  3%      -0.1        2.53 ±  2%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      1.69 ±  3%      -0.1        1.62 ±  3%      -0.1        1.63 ±  2%  perf-profile.calltrace.cycles-pp.filemap_dirty_folio.iomap_write_end.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      1.33            -0.1        1.26 ±  3%      -0.1        1.24 ±  2%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      1.29            -0.1        1.22 ±  3%      -0.1        1.20 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      1.93 ±  3%      -0.1        1.86 ±  3%      -0.1        1.85 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      1.21 ±  4%      -0.1        1.15 ±  4%      -0.1        1.15        perf-profile.calltrace.cycles-pp.zero_user_segments.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      1.00 ±  2%      -0.1        0.94 ±  3%      -0.1        0.94 ±  3%  perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      1.14 ±  4%      -0.1        1.09 ±  4%      -0.0        1.10 ±  2%  perf-profile.calltrace.cycles-pp.memset_erms.zero_user_segments.__iomap_write_begin.iomap_write_begin.iomap_write_iter
      1.50 ±  3%      -0.1        1.44 ±  3%      -0.1        1.42 ±  2%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.89 ±  4%      -0.1        0.84 ±  4%      -0.1        0.83 ±  5%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.filemap_add_folio.__filemap_get_folio.iomap_write_begin
      1.03 ±  2%      -0.1        0.98 ±  4%      -0.0        0.99 ±  3%  perf-profile.calltrace.cycles-pp.__folio_mark_dirty.filemap_dirty_folio.iomap_write_end.iomap_write_iter.iomap_file_buffered_write
      1.36 ±  3%      -0.1        1.31 ±  3%      -0.1        1.30 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_iter.iomap_file_buffered_write
      0.98 ±  3%      -0.1        0.92 ±  3%      -0.1        0.92 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.iomap_write_begin.iomap_write_iter
      1.61 ±  3%      -0.0        1.57 ±  2%      -0.1        1.56        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.iomap_write_begin.iomap_write_iter
      0.83 ±  3%      -0.0        0.79 ±  4%      -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.iomap_write_begin.iomap_write_iter
      0.74 ±  2%      -0.0        0.70 ±  2%      -0.0        0.71 ±  4%  perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      0.69 ±  2%      -0.0        0.66 ±  4%      -0.0        0.66 ±  2%  perf-profile.calltrace.cycles-pp.folio_account_dirtied.__folio_mark_dirty.filemap_dirty_folio.iomap_write_end.iomap_write_iter
      0.58 ±  4%      -0.0        0.55 ±  4%      -0.1        0.46 ± 44%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add_fn.__pagevec_lru_add.folio_add_lru.filemap_add_folio.__filemap_get_folio
      0.62 ±  3%      -0.0        0.60            -0.0        0.60 ±  4%  perf-profile.calltrace.cycles-pp.__folio_cancel_dirty.truncate_cleanup_folio.truncate_inode_pages_range.evict.__dentry_kill
      0.65 ±  4%      -0.0        0.62 ±  3%      -0.0        0.63 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.iomap_write_begin
      0.80 ±  3%      -0.0        0.78 ±  4%      -0.0        0.78 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.77 ±  2%      -0.0        0.75 ±  3%      -0.0        0.74 ±  3%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      0.54 ±  5%      -0.0        0.53 ±  4%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.59 ±  3%      -0.0        0.58 ±  3%      -0.0        0.56 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio.iomap_write_begin
      0.67 ±  2%      -0.0        0.66 ±  4%      -0.0        0.65 ±  4%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_iter.iomap_file_buffered_write
      0.64 ±  4%      -0.0        0.63 ±  2%      -0.0        0.62 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      0.62 ±  5%      -0.0        0.60 ±  4%      -0.0        0.60 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ±  2%      -0.0        0.81 ±  5%      -0.0        0.81 ±  3%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.44 ± 44%      -0.0        0.43 ± 44%      -0.1        0.35 ± 70%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write
      0.68 ±  3%      -0.0        0.68 ±  6%      -0.0        0.68 ±  4%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      0.81 ±  4%      +0.0        0.82 ±  3%      -0.0        0.81 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink
      0.74 ±  4%      +0.0        0.76            +0.0        0.75 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.open_last_lookups.path_openat
      0.68 ±  2%      +0.0        0.71 ±  9%      -0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.70            +0.0        0.72 ±  9%      -0.0        0.66 ±  2%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ±  2%      +0.0        0.71 ±  9%      -0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.63 ±  5%      +0.1        0.70 ± 12%      +0.0        0.68 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.68 ±  5%      +0.1        0.76 ± 12%      +0.1        0.73 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.53 ±  3%      +0.1        0.64 ±  4%      +0.1        0.64 ±  4%  perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      0.88 ±  3%      +0.1        1.00 ±  3%      +0.1        0.99 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.95 ±  3%      +0.1        1.08 ±  3%      +0.1        1.05 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.96 ±  3%      +0.1        1.09 ±  3%      +0.1        1.06 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.98 ±  3%      +0.1        1.11 ±  3%      +0.1        1.09 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.99 ±  3%      +0.1        1.12 ±  3%      +0.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.99 ±  3%      +0.1        1.13 ±  3%      +0.1        1.10 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.99 ±  3%      +0.1        1.13 ±  3%      +0.1        1.10 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.11 ±  3%      +0.2        1.26 ±  6%      +0.1        1.19        perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.95 ±  4%      +0.2        1.10 ±  6%      +0.1        1.04        perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.lookup_open.open_last_lookups.path_openat
      0.96 ±  4%      +0.2        1.12 ±  6%      +0.1        1.05        perf-profile.calltrace.cycles-pp.xfs_generic_create.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.00            +0.3        0.26 ±100%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xfs_check_agi_freecount.xfs_dialloc_ag.xfs_dialloc.xfs_create.xfs_generic_create
      0.00            +0.3        0.32 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter
      0.00            +0.5        0.47 ± 45%      +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.xfs_dialloc_ag.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      0.08 ±223%      +0.5        0.61 ±  8%      +0.5        0.58 ±  2%  perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      0.00            +0.5        0.55 ±  4%      +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
     17.48 ±  4%      +0.6       18.12 ±  3%      +1.0       18.48 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink
     18.32 ±  4%      +0.6       18.95 ±  3%      +1.0       19.31 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64
     17.80 ±  5%      +0.7       18.46 ±  3%      +0.9       18.75 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.open_last_lookups.path_openat
     18.58 ±  4%      +0.7       19.24 ±  2%      +1.0       19.57 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.56 ±  5%      +0.7       19.24 ±  2%      +1.0       19.52 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.open_last_lookups.path_openat.do_filp_open
     19.36 ±  4%      +0.7       20.06 ±  2%      +1.0       20.32 ±  3%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     19.37 ±  4%      +0.7       20.07 ±  2%      +1.0       20.33 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     19.38 ±  4%      +0.7       20.08 ±  2%      +1.0       20.34 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
     19.38 ±  4%      +0.7       20.08 ±  2%      +1.0       20.34 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     19.40 ±  4%      +0.7       20.10 ±  2%      +1.0       20.36 ±  3%  perf-profile.calltrace.cycles-pp.unlink
     18.82 ±  5%      +0.7       19.53 ±  2%      +1.0       19.78 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
     20.10 ±  4%      +0.9       20.96 ±  3%      +1.0       21.13 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
     20.09 ±  4%      +0.9       20.95 ±  3%      +1.0       21.12 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     20.09 ±  4%      +0.9       20.95 ±  3%      +1.0       21.12 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     20.07 ±  4%      +0.9       20.93 ±  3%      +1.0       21.10 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.00 ±  4%      +0.9       20.86 ±  3%      +1.0       21.04 ±  3%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
     20.06 ±  4%      +0.9       20.92 ±  3%      +1.0       21.10 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
     20.10 ±  4%      +0.9       20.96 ±  3%      +1.0       21.13 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     20.11 ±  4%      +0.9       20.98 ±  3%      +1.0       21.15 ±  3%  perf-profile.calltrace.cycles-pp.creat64
     32.16 ±  3%      -1.2       30.92 ±  2%      -1.3       30.86 ±  2%  perf-profile.children.cycles-pp.write
     29.48 ±  3%      -1.1       28.34 ±  3%      -1.2       28.26 ±  2%  perf-profile.children.cycles-pp.ksys_write
     28.97 ±  3%      -1.1       27.86 ±  3%      -1.2       27.79 ±  2%  perf-profile.children.cycles-pp.vfs_write
     27.30 ±  3%      -1.0       26.26 ±  3%      -1.1       26.23 ±  2%  perf-profile.children.cycles-pp.new_sync_write
     26.50 ±  3%      -1.0       25.51 ±  3%      -1.0       25.46 ±  2%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     23.21 ±  3%      -0.8       22.39 ±  3%      -0.9       22.33 ±  2%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     18.05 ±  3%      -0.6       17.45 ±  3%      -0.6       17.41 ±  2%  perf-profile.children.cycles-pp.iomap_write_iter
     22.46 ± 12%      -0.4       22.03 ±  9%      -0.7       21.77 ±  9%  perf-profile.children.cycles-pp.intel_idle
     22.45 ± 12%      -0.4       22.02 ±  9%      -0.7       21.77 ±  9%  perf-profile.children.cycles-pp.mwait_idle_with_hints
     23.27 ± 12%      -0.3       22.92 ±  9%      -0.6       22.64 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
     23.27 ± 12%      -0.3       22.93 ±  9%      -0.6       22.65 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
      9.95 ±  3%      -0.3        9.63 ±  2%      -0.3        9.61 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
     23.55 ± 12%      -0.3       23.23 ±  8%      -0.6       22.94 ±  9%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     23.55 ± 12%      -0.3       23.23 ±  8%      -0.6       22.94 ±  9%  perf-profile.children.cycles-pp.cpu_startup_entry
     23.55 ± 12%      -0.3       23.23 ±  8%      -0.6       22.94 ±  9%  perf-profile.children.cycles-pp.do_idle
     23.41 ± 12%      -0.3       23.09 ±  8%      -0.6       22.81 ±  9%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.30 ±  3%      -0.2        5.11 ±  2%      -0.2        5.08 ±  2%  perf-profile.children.cycles-pp.__filemap_get_folio
      4.52 ±  2%      -0.2        4.34 ±  3%      -0.2        4.32 ±  3%  perf-profile.children.cycles-pp.iomap_iter
      3.38            -0.1        3.24 ±  3%      -0.2        3.20 ±  2%  perf-profile.children.cycles-pp.__close
      3.56            -0.1        3.42 ±  3%      -0.2        3.38 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.36            -0.1        3.22 ±  3%      -0.2        3.18 ±  2%  perf-profile.children.cycles-pp.task_work_run
      3.35 ±  2%      -0.1        3.21 ±  3%      -0.2        3.18 ±  2%  perf-profile.children.cycles-pp.__fput
      3.36            -0.1        3.22 ±  3%      -0.2        3.19 ±  2%  perf-profile.children.cycles-pp.dput
      3.33 ±  2%      -0.1        3.19 ±  3%      -0.2        3.16 ±  2%  perf-profile.children.cycles-pp.dentry_kill
      3.36            -0.1        3.22 ±  3%      -0.2        3.19 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      3.46            -0.1        3.32 ±  3%      -0.2        3.29 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.32            -0.1        3.19 ±  3%      -0.2        3.15 ±  2%  perf-profile.children.cycles-pp.__dentry_kill
      3.29 ±  2%      -0.1        3.16 ±  3%      -0.2        3.12 ±  2%  perf-profile.children.cycles-pp.evict
      3.27            -0.1        3.14 ±  3%      -0.2        3.10 ±  2%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      4.31 ±  3%      -0.1        4.18 ±  2%      -0.1        4.20 ±  2%  perf-profile.children.cycles-pp.__iomap_write_begin
      3.02 ±  2%      -0.1        2.90 ±  3%      -0.1        2.88 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      1.79 ±  6%      -0.1        1.66 ±  3%      -0.1        1.66        perf-profile.children.cycles-pp.xfs_file_write_checks
      3.96 ±  3%      -0.1        3.85 ±  3%      -0.1        3.85 ±  2%  perf-profile.children.cycles-pp.iomap_write_end
      0.68 ± 12%      -0.1        0.58 ±  4%      -0.1        0.60 ±  5%  perf-profile.children.cycles-pp.file_update_time
      2.64 ±  3%      -0.1        2.55 ±  2%      -0.1        2.53 ±  2%  perf-profile.children.cycles-pp.filemap_add_folio
      0.34 ± 23%      -0.1        0.25 ± 23%      -0.0        0.29 ± 26%  perf-profile.children.cycles-pp.start_kernel
      1.71 ±  3%      -0.1        1.63 ±  4%      -0.1        1.65 ±  2%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.39 ±  9%      -0.1        0.31 ±  5%      -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.33            -0.1        1.26 ±  3%      -0.1        1.24 ±  2%  perf-profile.children.cycles-pp.__pagevec_release
      1.94 ±  3%      -0.1        1.87 ±  3%      -0.1        1.86 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      1.38            -0.1        1.32 ±  3%      -0.1        1.30 ±  2%  perf-profile.children.cycles-pp.release_pages
      0.26 ± 31%      -0.1        0.20 ±  7%      -0.1        0.21 ± 19%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.59 ±  3%      -0.1        0.53 ±  3%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.51 ±  3%      -0.1        1.45 ±  3%      -0.1        1.44 ±  2%  perf-profile.children.cycles-pp.copyin
      1.21 ±  4%      -0.1        1.15 ±  4%      -0.1        1.16        perf-profile.children.cycles-pp.zero_user_segments
      1.16 ±  4%      -0.1        1.11 ±  4%      -0.0        1.12 ±  2%  perf-profile.children.cycles-pp.memset_erms
      1.00 ±  2%      -0.1        0.95 ±  3%      -0.1        0.94 ±  3%  perf-profile.children.cycles-pp.folio_alloc
      0.91 ±  4%      -0.1        0.86 ±  3%      -0.1        0.86 ±  5%  perf-profile.children.cycles-pp.__pagevec_lru_add
      1.04 ±  2%      -0.0        0.98 ±  4%      -0.0        1.00 ±  2%  perf-profile.children.cycles-pp.__folio_mark_dirty
      1.45 ±  3%      -0.0        1.40 ±  3%      -0.1        1.38 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.98 ±  3%      -0.0        0.93 ±  3%      -0.1        0.92 ±  4%  perf-profile.children.cycles-pp.folio_add_lru
      0.36 ±  5%      -0.0        0.31 ±  4%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.47 ±  7%      -0.0        0.43 ±  8%      -0.0        0.42 ±  7%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      1.64 ±  3%      -0.0        1.59 ±  2%      -0.1        1.58        perf-profile.children.cycles-pp.__filemap_add_folio
      0.84 ±  2%      -0.0        0.80 ±  4%      -0.1        0.79 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.82 ±  3%      -0.0        0.78 ±  2%      -0.0        0.79 ±  3%  perf-profile.children.cycles-pp.xfs_iunlock
      0.27 ± 14%      -0.0        0.23 ±  7%      -0.0        0.24 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.05 ± 45%      -0.0        0.01 ±223%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.__x64_sys_write
      1.47 ±  2%      -0.0        1.44 ±  3%      -0.0        1.43 ±  3%  perf-profile.children.cycles-pp.xfs_ilock
      0.74 ±  2%      -0.0        0.71 ±  2%      -0.0        0.71 ±  4%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.70 ±  2%      -0.0        0.67 ±  5%      -0.0        0.68 ±  2%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.46 ±  5%      -0.0        0.43 ±  4%      -0.0        0.43 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.60 ±  4%      -0.0        0.56 ±  4%      -0.0        0.57 ±  5%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.38 ±  4%      -0.0        0.36 ±  3%      -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.91 ±  4%      -0.0        0.88 ±  3%      -0.0        0.88 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.36 ±  6%      -0.0        0.33 ±  3%      -0.0        0.33 ±  5%  perf-profile.children.cycles-pp.__fdget_pos
      0.28 ±  7%      -0.0        0.25 ±  3%      -0.0        0.26 ±  7%  perf-profile.children.cycles-pp.__fget_light
      0.51 ±  3%      -0.0        0.48 ±  5%      -0.0        0.49 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.63 ±  3%      -0.0        0.60 ±  2%      -0.0        0.61 ±  4%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.59 ±  3%      -0.0        0.56 ±  3%      -0.0        0.58 ±  3%  perf-profile.children.cycles-pp.up_write
      0.02 ± 99%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__x64_sys_times
      0.03 ± 70%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.propagate_protected_usage
      1.11 ±  7%      -0.0        1.08 ±  4%      -0.1        1.04 ±  3%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.50 ±  4%      -0.0        0.48 ±  3%      -0.0        0.47 ±  4%  perf-profile.children.cycles-pp.xfs_break_layouts
      1.28 ±  2%      -0.0        1.26 ±  2%      -0.0        1.25 ±  4%  perf-profile.children.cycles-pp.down_write
      0.46 ±  3%      -0.0        0.44 ±  3%      -0.0        0.44 ±  5%  perf-profile.children.cycles-pp.folio_account_cleaned
      0.42 ±  3%      -0.0        0.40 ±  3%      -0.0        0.40 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.34 ±  3%      -0.0        0.32 ±  5%      -0.0        0.31 ±  6%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.43 ±  3%      -0.0        0.41 ±  5%      -0.0        0.40        perf-profile.children.cycles-pp.xfs_file_write_iter
      0.30 ±  4%      -0.0        0.28 ±  2%      -0.0        0.28 ±  4%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.78 ±  5%      -0.0        0.76 ±  2%      -0.0        0.76 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.65 ±  4%      -0.0        0.63 ±  3%      -0.0        0.63 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.79            -0.0        0.77 ±  4%      -0.0        0.78 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      1.08 ±  6%      -0.0        1.06 ±  4%      -0.1        1.01 ±  3%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.77 ±  2%      -0.0        0.75 ±  3%      -0.0        0.75 ±  3%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.41 ±  6%      -0.0        0.39 ±  5%      -0.0        0.40 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.60 ±  3%      -0.0        0.58 ±  4%      -0.0        0.57        perf-profile.children.cycles-pp.get_page_from_freelist
      0.09 ± 13%      -0.0        0.08 ±  9%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.61 ±  3%      -0.0        0.59 ±  2%      -0.0        0.58 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.56 ±  5%      -0.0        0.54 ±  4%      -0.0        0.54 ±  5%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.63 ±  5%      -0.0        0.61 ±  4%      -0.0        0.61 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      0.12 ±  6%      -0.0        0.11 ± 10%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.disk_wrt
      0.10 ±  7%      -0.0        0.09 ±  7%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.45 ±  2%      -0.0        0.43 ±  4%      -0.0        0.43 ±  5%  perf-profile.children.cycles-pp.charge_memcg
      0.24 ±  3%      -0.0        0.23 ±  3%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.40 ±  3%      -0.0        0.38 ±  5%      -0.0        0.37 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.30 ±  8%      -0.0        0.28 ±  6%      +0.0        0.30 ±  6%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.05 ±  8%      -0.0        0.04 ± 72%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.15 ±  7%      -0.0        0.14 ±  8%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.84 ±  3%      -0.0        0.83 ±  5%      -0.0        0.83 ±  3%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.02 ±144%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.28 ±  4%      -0.0        0.27 ±  6%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.12 ±  6%      -0.0        0.10 ±  4%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.aa_file_perm
      0.73 ±  6%      -0.0        0.72 ±  4%      -0.0        0.70 ±  3%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.34 ±  3%      -0.0        0.33 ±  4%      -0.0        0.32 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.07 ±  6%      -0.0        0.06 ± 11%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.filemap_free_folio
      0.05 ±  8%      -0.0        0.04 ± 45%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.schedule_idle
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.21 ±  4%      -0.0        0.20 ±  5%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.current_time
      0.05            -0.0        0.04 ± 44%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.12 ±  3%      -0.0        0.12 ±  4%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.xfs_buf_rele
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.xfs_trans_alloc_dir
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_inode_to_log_dinode
      0.18 ± 10%      -0.0        0.17 ± 10%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.inode_to_bdi
      0.13 ±  6%      -0.0        0.12 ±  6%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.05 ± 46%      -0.0        0.04 ± 44%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.fprintf
      0.08            -0.0        0.07 ±  5%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.PageHeadHuge
      0.10 ±  8%      -0.0        0.09 ±  7%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__list_add_valid
      0.66 ±  3%      -0.0        0.65 ±  3%      -0.0        0.64 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.30 ±  3%      -0.0        0.30 ±  6%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.uncharge_batch
      0.23 ±  5%      -0.0        0.22 ±  3%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      0.71 ±  3%      -0.0        0.70 ±  5%      -0.0        0.70 ±  4%  perf-profile.children.cycles-pp.fault_in_readable
      0.38 ±  2%      -0.0        0.37 ±  7%      -0.0        0.38 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.33 ±  3%      -0.0        0.32 ±  7%      +0.0        0.33 ±  5%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.15 ±  6%      -0.0        0.14 ±  6%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.alloc_pages
      0.20 ±  4%      -0.0        0.19 ±  8%      -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.node_dirty_ok
      0.08 ± 10%      -0.0        0.08 ± 10%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.09 ±  8%      -0.0        0.08 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.xa_get_order
      0.05 ± 50%      -0.0        0.04 ± 72%      +0.0        0.05 ± 47%  perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.26 ±  2%      -0.0        0.25 ±  4%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.try_charge_memcg
      0.10 ±  5%      -0.0        0.09 ± 10%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.07 ± 16%      -0.0        0.06 ±  7%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.94 ±  3%      -0.0        0.94 ±  2%      -0.0        0.91 ±  3%  perf-profile.children.cycles-pp.__might_resched
      0.30 ±  3%      -0.0        0.30 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.15 ±  4%      -0.0        0.15 ±  5%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__xa_set_mark
      0.08 ±  8%      -0.0        0.08 ± 12%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.iomap_adjust_read_range
      0.27 ±  4%      -0.0        0.27 ±  5%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.15 ±  3%      -0.0        0.14 ±  6%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.17 ±  9%      -0.0        0.16 ±  4%      +0.0        0.17 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.09 ± 15%      -0.0        0.09 ± 12%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.rcu_do_batch
      0.06 ± 13%      -0.0        0.05 ±  8%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xfs_mod_freecounter
      0.08 ±  4%      -0.0        0.08 ±  8%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xas_find
      0.08 ± 12%      -0.0        0.08 ± 14%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.22 ±  3%      -0.0        0.22 ±  4%      -0.0        0.22 ±  5%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.12 ±  6%      -0.0        0.11 ±  6%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      0.08 ± 12%      -0.0        0.08 ±  9%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.09 ± 12%      -0.0        0.08 ±  8%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.07 ±  7%      -0.0        0.06 ±  7%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.folio_mapping
      0.15 ±  4%      -0.0        0.15 ±  4%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.xfs_iread_extents
      0.08 ± 14%      -0.0        0.08 ± 16%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.down
      0.07 ± 10%      -0.0        0.07 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_iunlink_update_inode
      0.06 ± 14%      -0.0        0.06 ±  9%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_hole_delay
      0.06 ±  9%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.iomap_iter_done
      0.06 ± 13%      -0.0        0.06 ± 11%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.times
      0.12            -0.0        0.12 ± 11%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.08 ± 10%      -0.0        0.07 ± 12%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__down_common
      0.11 ±  8%      -0.0        0.11 ±  9%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.xas_clear_mark
      0.12 ±  4%      -0.0        0.11 ±  4%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.11 ±  9%      -0.0        0.11 ±  8%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.10 ±  3%      -0.0        0.10 ± 10%      -0.0        0.09        perf-profile.children.cycles-pp.xfs_lookup
      0.10 ±  7%      -0.0        0.10 ± 11%      -0.0        0.09        perf-profile.children.cycles-pp.xfs_dir_lookup
      0.04 ± 45%      +0.0        0.04 ± 45%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.vfprintf
      0.02 ± 99%      +0.0        0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.xas_set_mark
      0.10 ±  7%      +0.0        0.10 ± 10%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.08 ±  6%      +0.0        0.08 ± 12%      -0.0        0.07        perf-profile.children.cycles-pp.xfs_dir2_node_lookup
      0.18 ±  6%      +0.0        0.18 ±  6%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.07 ± 11%      +0.0        0.07 ± 11%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.06 ± 11%      +0.0        0.06 ± 11%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.node_page_state
      0.06 ±  6%      +0.0        0.06 ± 17%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rebalance_domains
      0.05 ± 46%      +0.0        0.05 ± 46%      +0.0        0.05 ± 53%  perf-profile.children.cycles-pp.xfs_next_bit
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.serial8250_console_write
      0.02 ± 99%      +0.0        0.02 ± 99%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.uart_console_write
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.02 ±141%      +0.0        0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.xfs_dir3_data_read
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_verify_agino
      0.08 ± 13%      +0.0        0.08 ± 11%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.kmem_cache_free
      0.02 ± 99%      +0.0        0.02 ± 99%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.xfs_iextents_copy
      0.09 ±  6%      +0.0        0.09 ± 14%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.08 ±  6%      +0.0        0.08 ± 14%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.irq_work_run
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.irq_work_single
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp._printk
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.vprintk_emit
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.console_unlock
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.call_console_drivers
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.policy_node
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.16 ±  4%      +0.0        0.16 ± 10%      -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.xfs_read_agi
      0.10 ±  4%      +0.0        0.10 ±  6%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.07 ±  6%      +0.0        0.08 ±  6%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.folio_memcg_unlock
      0.29 ±  7%      +0.0        0.30 ±  3%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.generic_write_checks
      0.10 ± 10%      +0.0        0.10 ±  7%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.09 ±  7%      +0.0        0.09 ± 14%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.rwsem_wake
      0.08 ±  4%      +0.0        0.08 ±  7%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.uncharge_folio
      0.06 ± 11%      +0.0        0.07 ± 11%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.schedule_timeout
      0.11 ±  4%      +0.0        0.12 ±  8%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.iomap_page_create
      0.07 ±  9%      +0.0        0.07 ± 15%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.wake_up_q
      0.12 ± 12%      +0.0        0.12 ± 11%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.06 ±  9%      +0.0        0.06 ±  8%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.iov_iter_init
      0.10 ±  5%      +0.0        0.10 ±  4%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.xas_create
      0.06 ±  9%      +0.0        0.06 ± 13%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xfs_imap_to_bp
      0.06 ±  6%      +0.0        0.06 ±  9%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.03 ± 70%      +0.0        0.04 ± 71%      +0.0        0.04 ± 44%  perf-profile.children.cycles-pp.rw_verify_area
      0.28 ±  5%      +0.0        0.29 ±  8%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.06 ± 13%      +0.0        0.06 ± 11%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xfs_isilocked
      0.08            +0.0        0.08 ±  8%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.14 ±  9%      +0.0        0.14 ±  8%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.05            +0.0        0.05 ±  8%      +0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xas_alloc
      0.10 ±  6%      +0.0        0.10 ±  9%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.05 ±  8%      +0.0        0.06 ± 13%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.xfs_init_new_inode
      0.06 ±  6%      +0.0        0.06 ±  7%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.11 ±  6%      +0.0        0.11 ± 12%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.xfs_iunlink
      0.12 ±  8%      +0.0        0.12 ±  9%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      0.08 ±  8%      +0.0        0.08 ±  8%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xas_find_conflict
      0.10 ±  6%      +0.0        0.10 ± 13%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.07 ± 10%      +0.0        0.08 ±  9%      +0.0        0.07 ± 17%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.09 ±  8%      +0.0        0.09 ± 15%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.06            +0.0        0.06 ±  7%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.15 ± 11%      +0.0        0.15 ±  4%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.26 ±  4%      +0.0        0.27 ±  9%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.18 ±  2%      +0.0        0.18 ±  9%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.14 ±  7%      +0.0        0.14 ±  7%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.07 ±  9%      +0.0        0.08 ±  9%      -0.0        0.07        perf-profile.children.cycles-pp.xfs_dir2_leafn_remove
      0.07 ±  7%      +0.0        0.07 ±  9%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.up
      0.13 ± 10%      +0.0        0.14 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.file_modified
      0.10 ± 10%      +0.0        0.10 ±  4%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.file_remove_privs
      0.42 ±  2%      +0.0        0.42 ±  7%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.24 ±  5%      +0.0        0.25 ±  9%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.xfs_buf_find
      0.11 ±  3%      +0.0        0.12 ±  7%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.08 ±  9%      +0.0        0.08 ± 11%      +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.06 ±  9%      +0.0        0.06 ± 11%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.xlog_prepare_iovec
      0.10 ±  6%      +0.0        0.10 ± 16%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      0.24 ±  5%      +0.0        0.24 ±  5%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.13 ±  8%      +0.0        0.14 ±  7%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.12 ± 10%      +0.0        0.12 ±  7%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.32 ±  2%      +0.0        0.33 ±  5%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.02 ± 99%      +0.0        0.03 ± 70%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.xfs_inode_item_format_data_fork
      0.07            +0.0        0.08 ±  8%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.08 ±  6%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.01 ±223%      +0.0        0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_verify_dir_ino
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.xfs_dabuf_map
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.xfs_iget
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.xfs_defer_trans_roll
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.irq_work_run_list
      0.02 ±141%      +0.0        0.02 ± 99%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.02 ±141%      +0.0        0.02 ± 99%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.10 ± 12%      +0.0        0.11 ± 11%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ± 16%      +0.0        0.11 ±  8%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.12 ±  5%      +0.0        0.13 ± 13%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.27 ±  8%      +0.0        0.28 ± 11%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.09 ±  4%      +0.0        0.10 ± 10%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.07 ±  8%      +0.0        0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.01 ±223%      +0.0        0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.tick_sched_do_timer
      0.04 ± 71%      +0.0        0.04 ± 45%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.xfs_perag_get
      0.05 ±  7%      +0.0        0.06 ± 14%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__rhashtable_lookup
      0.19 ±  8%      +0.0        0.20 ±  8%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.schedule
      0.24 ±  7%      +0.0        0.25 ±  9%      +0.0        0.24 ±  6%  perf-profile.children.cycles-pp.__schedule
      0.10 ± 13%      +0.0        0.11 ± 29%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ± 11%      +0.0        0.07 ± 34%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
      0.02 ±141%      +0.0        0.03 ±102%      +0.0        0.03 ± 70%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.04 ± 71%      +0.0        0.05 ±  7%      +0.0        0.04 ± 44%  perf-profile.children.cycles-pp.workingset_update_node
      0.22 ± 10%      +0.0        0.24 ± 11%      +0.0        0.23 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.09 ±  4%      +0.0        0.11 ± 11%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_dir3_data_check
      0.20 ±  8%      +0.0        0.22 ± 13%      -0.0        0.20 ± 12%  perf-profile.children.cycles-pp.clockevents_program_event
      0.24 ±  6%      +0.0        0.26 ± 11%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.22            +0.0        0.24 ± 11%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.30 ±  5%      +0.0        0.32 ±  4%      +0.0        0.30 ±  5%  perf-profile.children.cycles-pp.memcpy_erms
      0.09            +0.0        0.11 ± 11%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__xfs_dir3_data_check
      0.00            +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.02 ±141%      +0.0        0.03 ± 70%      +0.0        0.03 ± 70%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.0        0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.02 ±141%      +0.0        0.03 ± 70%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.memcg_check_events
      0.22            +0.0        0.24 ± 10%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.21 ±  2%      +0.0        0.23 ± 10%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.02 ±141%      +0.0        0.04 ± 71%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.02 ±144%      +0.0        0.04 ± 44%  perf-profile.children.cycles-pp.update_rq_clock
      0.03 ± 70%      +0.0        0.05 ±  8%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  6%      +0.0        0.13 ± 11%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.03 ±101%      +0.0        0.05 ± 50%      +0.0        0.05 ± 54%  perf-profile.children.cycles-pp.xfs_inobt_irec_to_allocmask
      0.10 ±  3%      +0.0        0.12 ± 10%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.xfs_difree_finobt
      0.41 ±  4%      +0.0        0.44 ±  3%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.42 ±  3%      +0.0        0.44 ±  3%      -0.0        0.41 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.14 ± 11%      +0.0        0.16 ± 40%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.task_tick_fair
      0.68 ±  2%      +0.0        0.71 ±  9%      -0.0        0.65 ±  2%  perf-profile.children.cycles-pp.xfs_remove
      0.70            +0.0        0.72 ±  9%      -0.0        0.66 ±  2%  perf-profile.children.cycles-pp.vfs_unlink
      0.68 ±  2%      +0.0        0.71 ±  9%      -0.0        0.65 ±  2%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.57 ±  3%      +0.0        0.60 ±  4%      +0.0        0.57 ±  4%  perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      0.02 ±141%      +0.0        0.06 ±  9%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.24 ±  8%      +0.0        0.28 ± 25%      +0.0        0.25 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.01 ±223%      +0.0        0.05 ±  7%      +0.0        0.04 ± 44%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.0        0.04 ± 45%      +0.0        0.04 ± 44%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.32 ±  7%      +0.0        0.37 ± 22%      +0.0        0.34 ±  8%  perf-profile.children.cycles-pp.update_process_times
      0.33 ±  7%      +0.0        0.38 ± 22%      +0.0        0.35 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
      0.38 ±  6%      +0.1        0.44 ± 21%      +0.0        0.40 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.46 ±  5%      +0.1        0.53 ± 18%      +0.0        0.48 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.90 ±  3%      +0.1        1.98 ±  4%      +0.0        1.92 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.74 ±  6%      +0.1        0.83 ± 15%      +0.0        0.76 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.73 ±  6%      +0.1        0.82 ± 15%      +0.0        0.75 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.28 ±  5%      +0.1        0.37 ±  4%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.xfs_difree_inobt
      0.19 ±  3%      +0.1        0.29 ±  7%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.44 ±  4%      +0.1        0.55 ±  4%      +0.1        0.55 ±  4%  perf-profile.children.cycles-pp.xfs_difree
      0.20 ±  9%      +0.1        0.30 ±  7%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.xfs_btree_increment
      1.10 ±  6%      +0.1        1.21 ± 12%      +0.0        1.14 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.53 ±  3%      +0.1        0.64 ±  4%      +0.1        0.64 ±  4%  perf-profile.children.cycles-pp.xfs_ifree
      0.88 ±  3%      +0.1        1.00 ±  3%      +0.1        0.99 ±  4%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.38 ±  4%      +0.1        0.50 ±  6%      +0.1        0.50 ±  6%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.95 ±  3%      +0.1        1.08 ±  3%      +0.1        1.05 ±  4%  perf-profile.children.cycles-pp.xfs_inactive
      0.96 ±  3%      +0.1        1.09 ±  3%      +0.1        1.06 ±  4%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.42 ±  3%      +0.1        0.55 ±  7%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.xfs_dialloc_ag
      0.98 ±  3%      +0.1        1.11 ±  3%      +0.1        1.09 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.48 ±  3%      +0.1        0.61 ±  8%      +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.xfs_dialloc
      0.99 ±  3%      +0.1        1.12 ±  3%      +0.1        1.09 ±  3%  perf-profile.children.cycles-pp.worker_thread
      0.99 ±  3%      +0.1        1.13 ±  3%      +0.1        1.10 ±  3%  perf-profile.children.cycles-pp.kthread
      0.99 ±  3%      +0.1        1.14 ±  3%      +0.1        1.10 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      1.11 ±  3%      +0.2        1.26 ±  6%      +0.1        1.19        perf-profile.children.cycles-pp.lookup_open
      0.95 ±  4%      +0.2        1.10 ±  6%      +0.1        1.04        perf-profile.children.cycles-pp.xfs_create
      0.96 ±  4%      +0.2        1.12 ±  6%      +0.1        1.05        perf-profile.children.cycles-pp.xfs_generic_create
      0.13 ±  5%      +0.2        0.33 ±  6%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      1.30 ±  7%      +0.2        1.51 ± 21%      -0.0        1.28 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.22 ±  6%      +0.2        0.43 ±  6%      +0.2        0.42        perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.68 ±  4%      +0.2        0.91 ±  5%      +0.2        0.90 ±  3%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
     72.85 ±  3%      +0.3       73.10 ±  2%      +0.6       73.43 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     73.11 ±  3%      +0.3       73.36 ±  2%      +0.6       73.69 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.36 ±  4%      +0.7       20.06 ±  2%      +1.0       20.32 ±  3%  perf-profile.children.cycles-pp.do_unlinkat
     19.37 ±  4%      +0.7       20.07 ±  2%      +1.0       20.33 ±  3%  perf-profile.children.cycles-pp.__x64_sys_unlink
     19.41 ±  4%      +0.7       20.11 ±  2%      +1.0       20.36 ±  3%  perf-profile.children.cycles-pp.unlink
     20.09 ±  4%      +0.9       20.95 ±  3%      +1.0       21.12 ±  3%  perf-profile.children.cycles-pp.__x64_sys_creat
     20.10 ±  4%      +0.9       20.96 ±  3%      +1.0       21.13 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
     20.12 ±  4%      +0.9       20.98 ±  3%      +1.0       21.16 ±  3%  perf-profile.children.cycles-pp.creat64
     20.00 ±  4%      +0.9       20.87 ±  3%      +1.0       21.04 ±  3%  perf-profile.children.cycles-pp.open_last_lookups
     20.07 ±  4%      +0.9       20.94 ±  3%      +1.0       21.11 ±  3%  perf-profile.children.cycles-pp.do_filp_open
     20.07 ±  4%      +0.9       20.93 ±  3%      +1.0       21.11 ±  3%  perf-profile.children.cycles-pp.path_openat
     35.30 ±  4%      +1.3       36.59 ±  3%      +1.9       37.24 ±  3%  perf-profile.children.cycles-pp.osq_lock
     36.88 ±  4%      +1.3       38.19 ±  2%      +1.9       38.83 ±  3%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     37.40 ±  4%      +1.4       38.77 ±  2%      +2.0       39.35 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     22.44 ± 12%      -0.4       22.00 ±  9%      -0.7       21.75 ±  9%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      0.39 ±  9%      -0.1        0.31 ±  4%      -0.1        0.31 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.89 ±  2%      -0.1        2.82 ±  3%      -0.0        2.85 ±  3%  perf-profile.self.cycles-pp.__iomap_write_begin
      1.15 ±  4%      -0.1        1.10 ±  4%      -0.0        1.10 ±  2%  perf-profile.self.cycles-pp.memset_erms
      0.72 ±  4%      -0.0        0.68 ±  5%      -0.1        0.65 ±  3%  perf-profile.self.cycles-pp.vfs_write
      1.43 ±  3%      -0.0        1.39 ±  3%      -0.1        1.37 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.36 ±  7%      -0.0        0.32 ±  9%      -0.0        0.32 ±  8%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      1.99 ±  5%      -0.0        1.95 ±  4%      -0.1        1.93 ±  2%  perf-profile.self.cycles-pp.iomap_write_end
      0.52 ±  5%      -0.0        0.49 ±  2%      -0.0        0.48 ±  3%  perf-profile.self.cycles-pp.iomap_write_iter
      0.66 ±  2%      -0.0        0.62 ±  2%      -0.0        0.63 ±  2%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.92 ±  4%      -0.0        0.89 ±  4%      -0.0        0.91 ±  3%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.43 ±  4%      -0.0        0.40 ±  3%      -0.0        0.41 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.03 ±  4%      -0.0        1.00 ±  4%      -0.0        0.98 ±  4%  perf-profile.self.cycles-pp.iomap_iter
      0.56 ±  3%      -0.0        0.54 ±  3%      -0.0        0.55 ±  3%  perf-profile.self.cycles-pp.up_write
      0.27 ±  8%      -0.0        0.24 ±  4%      -0.0        0.25 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.21 ±  4%      -0.0        0.19 ±  5%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.file_update_time
      0.67 ±  4%      -0.0        0.64 ±  4%      -0.0        0.63 ±  4%  perf-profile.self.cycles-pp.write
      0.47 ±  5%      -0.0        0.44 ±  4%      -0.0        0.46 ±  3%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.32 ±  3%      -0.0        0.30 ±  3%      -0.0        0.30 ±  3%  perf-profile.self.cycles-pp.__might_sleep
      0.37 ±  5%      -0.0        0.35 ±  5%      -0.0        0.34 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.30 ±  4%      -0.0        0.28            -0.0        0.27 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.42 ±  5%      -0.0        0.40 ±  4%      -0.0        0.41 ±  6%  perf-profile.self.cycles-pp.__entry_text_start
      0.77 ±  5%      -0.0        0.75 ±  2%      -0.0        0.75 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.32 ±  3%      -0.0        0.30 ±  5%      -0.0        0.30 ±  5%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.27 ±  9%      -0.0        0.25 ±  5%      -0.0        0.27 ±  5%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.28 ±  3%      -0.0        0.26 ±  4%      -0.0        0.28 ±  4%  perf-profile.self.cycles-pp.new_sync_write
      0.14 ±  6%      -0.0        0.12 ±  4%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__alloc_pages
      0.42 ±  3%      -0.0        0.40 ±  5%      -0.0        0.40 ±  2%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.30 ±  4%      -0.0        0.29 ±  2%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.25 ±  6%      -0.0        0.23 ±  3%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.xfs_iunlock
      0.21 ±  5%      -0.0        0.19 ±  6%      -0.0        0.19 ±  3%  perf-profile.self.cycles-pp.xfs_ilock
      0.02 ± 99%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.vfprintf
      0.38 ±  5%      -0.0        0.36 ±  5%      -0.0        0.36 ±  3%  perf-profile.self.cycles-pp.filemap_dirty_folio
      0.43 ±  6%      -0.0        0.41 ±  4%      -0.0        0.41 ±  3%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.21 ±  5%      -0.0        0.20 ±  8%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.04 ± 44%      -0.0        0.03 ±100%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.21 ±  7%      -0.0        0.19 ±  2%      -0.0        0.19 ±  7%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.24 ±  3%      -0.0        0.22 ±  5%      -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.27 ±  4%      -0.0        0.26 ±  4%      -0.0        0.26 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.08 ± 13%      -0.0        0.07 ± 13%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.xfs_get_extsz_hint
      0.78 ±  3%      -0.0        0.77 ±  4%      -0.0        0.76 ±  4%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.06 ±  9%      -0.0        0.04 ± 45%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.zero_user_segments
      0.30 ±  4%      -0.0        0.29 ±  3%      -0.0        0.29 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.93 ±  3%      -0.0        0.92 ±  3%      -0.0        0.90 ±  3%  perf-profile.self.cycles-pp.__might_resched
      0.09 ±  7%      -0.0        0.08 ±  5%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.10 ± 10%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.36 ±  4%      -0.0        0.35 ±  4%      -0.0        0.35 ±  4%  perf-profile.self.cycles-pp.iomap_write_begin
      0.07 ±  6%      -0.0        0.06 ± 11%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.filemap_free_folio
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.12 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.09 ±  8%      -0.0        0.08 ±  6%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.10 ±  4%      -0.0        0.09 ±  7%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.aa_file_perm
      0.15 ± 13%      -0.0        0.14 ± 11%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.inode_to_bdi
      0.12 ±  3%      -0.0        0.12 ±  4%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.02 ± 99%      -0.0        0.02 ±141%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.xfs_isilocked
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.propagate_protected_usage
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.free_pcp_prepare
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.__x64_sys_write
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_verify_agino
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xfs_btree_get_rec
      0.17 ±  5%      -0.0        0.16 ±  7%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.03 ± 70%      -0.0        0.02 ± 99%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.iomap_iter_done
      0.69 ±  3%      -0.0        0.68 ±  6%      -0.0        0.68 ±  3%  perf-profile.self.cycles-pp.fault_in_readable
      0.32 ±  4%      -0.0        0.31 ±  7%      +0.0        0.32 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.14 ±  4%      -0.0        0.14 ±  7%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.11 ±  4%      -0.0        0.10 ±  5%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ±  5%      -0.0        0.06 ±  6%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.PageHeadHuge
      0.06 ± 14%      -0.0        0.06 ± 11%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.charge_memcg
      0.13 ±  6%      -0.0        0.12 ±  7%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.folio_memcg_lock
      0.44 ±  4%      -0.0        0.44 ±  4%      -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.16 ±  8%      -0.0        0.15 ±  4%      -0.0        0.14 ±  9%  perf-profile.self.cycles-pp.ksys_write
      0.44 ±  5%      -0.0        0.44 ±  4%      -0.0        0.43 ±  6%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.15 ±  6%      -0.0        0.14 ±  5%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.current_time
      0.27 ±  3%      -0.0        0.27 ±  4%      -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.find_lock_entries
      0.25 ±  4%      -0.0        0.24 ±  6%      -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.08 ±  8%      -0.0        0.07 ± 10%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_charge_statistics
      0.12 ±  6%      -0.0        0.12 ±  6%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.08 ±  4%      -0.0        0.07 ± 10%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.08 ± 10%      -0.0        0.08 ±  6%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.disk_wrt
      0.14 ±  6%      -0.0        0.14 ±  7%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.node_dirty_ok
      0.14 ±  3%      -0.0        0.13 ±  6%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.09 ±  5%      -0.0        0.08 ±  8%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.free_unref_page_list
      0.09 ±  7%      -0.0        0.09 ±  4%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  3%      -0.0        0.12 ± 13%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.10 ±  6%      -0.0        0.09 ± 10%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.08 ± 12%      -0.0        0.07 ± 11%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.31 ±  3%      -0.0        0.31 ±  3%      -0.0        0.30 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.06 ± 11%      -0.0        0.06            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.folio_mapping
      0.11 ±  9%      -0.0        0.10 ±  7%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.xas_clear_mark
      0.11 ±  8%      -0.0        0.10 ±  4%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.try_charge_memcg
      0.13 ±  5%      -0.0        0.12 ±  6%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.06 ± 19%      -0.0        0.06 ±  9%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.06            -0.0        0.06 ± 13%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.xas_find
      0.07 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.security_file_permission
      0.19 ±  2%      -0.0        0.18 ±  6%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.16 ± 11%      -0.0        0.16 ±  5%      +0.0        0.16 ±  8%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.61 ±  3%      -0.0        0.60            -0.0        0.60 ±  2%  perf-profile.self.cycles-pp.down_write
      0.32 ±  3%      -0.0        0.31 ±  5%      -0.0        0.30 ±  7%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.27 ±  3%      -0.0        0.26 ±  4%      -0.0        0.26 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.07 ±  6%      -0.0        0.07 ± 14%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.08 ±  8%      -0.0        0.08 ±  5%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.04 ± 72%      -0.0        0.04 ± 71%      +0.0        0.05 ± 50%  perf-profile.self.cycles-pp.xfs_next_bit
      0.12 ±  6%      -0.0        0.12 ±  4%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.rmqueue
      0.08 ± 10%      -0.0        0.08 ±  8%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.iomap_adjust_read_range
      0.08            -0.0        0.08 ± 11%      +0.0        0.08        perf-profile.self.cycles-pp.__fdget_pos
      0.14 ±  6%      -0.0        0.14 ±  7%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.08 ± 14%      -0.0        0.07 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.23 ±  6%      -0.0        0.23 ±  2%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.04 ± 71%      +0.0        0.04 ± 71%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.xfs_btree_check_sblock
      0.15 ±  8%      +0.0        0.15 ±  8%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.generic_write_checks
      0.08 ±  6%      +0.0        0.08 ±  9%      -0.0        0.07        perf-profile.self.cycles-pp.uncharge_folio
      0.09 ±  5%      +0.0        0.09 ±  7%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.alloc_pages
      0.07 ±  5%      +0.0        0.07 ±  9%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.folio_memcg_unlock
      0.07 ± 10%      +0.0        0.07 ± 10%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.xfs_btree_increment
      0.14 ± 11%      +0.0        0.14 ±  3%      +0.0        0.14 ±  7%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.02 ±141%      +0.0        0.02 ±141%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.xas_set_mark
      0.07 ± 11%      +0.0        0.07 ± 11%      +0.0        0.07 ± 19%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.25 ±  4%      +0.0        0.25 ±  4%      +0.0        0.26 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.filemap_unaccount_folio
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xas_create
      0.10 ±  3%      +0.0        0.10 ±  9%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.iomap_page_create
      0.05 ±  7%      +0.0        0.05 ±  8%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp._xfs_trans_bjoin
      0.06 ±  6%      +0.0        0.06 ±  9%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.xfs_buf_item_init
      0.05 ± 46%      +0.0        0.05 ±  7%      +0.0        0.05 ±  8%  perf-profile.self.cycles-pp.copyin
      0.13 ±  6%      +0.0        0.13 ±  5%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  5%      +0.0        0.08 ± 11%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.folio_add_lru
      0.14 ±  6%      +0.0        0.15 ±  6%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.xfs_iread_extents
      0.06 ±  7%      +0.0        0.07 ± 11%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.21 ±  7%      +0.0        0.22 ±  5%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.06 ±  7%      +0.0        0.07 ± 16%      +0.0        0.06 ± 14%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.05 ± 45%      +0.0        0.05            -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.node_page_state
      0.09 ± 15%      +0.0        0.10 ± 11%      +0.0        0.10 ± 13%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.04 ± 71%      +0.0        0.04 ± 44%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.workingset_update_node
      0.05 ± 46%      +0.0        0.05 ±  8%      +0.0        0.05 ±  7%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.07 ±  5%      +0.0        0.07 ±  6%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.06 ±  9%      +0.0        0.06 ±  7%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.xas_find_conflict
      0.10 ±  4%      +0.0        0.11 ±  8%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.xfs_inobt_get_rec
      0.05            +0.0        0.06 ± 13%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.xlog_cil_insert_format_items
      0.31 ±  2%      +0.0        0.32 ±  5%      +0.0        0.32 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.05 ±  7%      +0.0        0.06 ±  9%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.xlog_prepare_iovec
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.tick_sched_do_timer
      0.02 ±141%      +0.0        0.02 ± 99%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.iov_iter_init
      0.02 ±141%      +0.0        0.02 ± 99%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.xfs_buf_find
      0.09 ± 15%      +0.0        0.10 ±  8%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.file_remove_privs
      0.05            +0.0        0.06 ± 13%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__rhashtable_lookup
      0.07 ± 10%      +0.0        0.08 ± 20%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.02 ± 99%      +0.0        0.04 ± 71%      +0.0        0.02 ± 99%  perf-profile.self.cycles-pp.rw_verify_area
      0.05 ±  7%      +0.0        0.06 ± 14%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.__xfs_dir3_data_check
      0.20 ± 10%      +0.0        0.22 ± 11%      +0.0        0.20 ± 12%  perf-profile.self.cycles-pp.ktime_get
      0.06 ± 11%      +0.0        0.07 ± 34%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      0.04 ± 44%      +0.0        0.05 ±  8%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.xfs_buf_item_format_segment
      0.07 ± 10%      +0.0        0.09 ± 10%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.30 ±  5%      +0.0        0.31 ±  3%      -0.0        0.29 ±  5%  perf-profile.self.cycles-pp.memcpy_erms
      0.06 ± 45%      +0.0        0.07 ± 37%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.0        0.02 ±141%      +0.0        0.00        perf-profile.self.cycles-pp.xfs_verify_dir_ino
      0.00            +0.0        0.02 ±141%      +0.0        0.00        perf-profile.self.cycles-pp.native_sched_clock
      0.02 ±141%      +0.0        0.03 ± 70%      +0.0        0.03 ± 70%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.01 ±223%      +0.0        0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_perag_get
      0.03 ± 70%      +0.0        0.05 ±  8%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.lapic_next_deadline
      1.89 ±  3%      +0.1        1.96 ±  4%      +0.0        1.90 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.11 ±  4%      +0.2        0.30 ±  5%      +0.2        0.29        perf-profile.self.cycles-pp.__xfs_btree_check_sblock
     35.08 ±  4%      +1.3       36.33 ±  2%      +1.9       37.01 ±  3%  perf-profile.self.cycles-pp.osq_lock
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 
> xfs: avoid unnecessary runtime sibling pointer endian conversions
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> Commit dc04db2aa7c9 has caused a small aim7 regression, showing a
> small increase in CPU usage in __xfs_btree_check_sblock() as a
> result of the extra checking.
> 
> This is likely due to the endian conversion of the sibling poitners
> being unconditional instead of relying on the compiler to endian
> convert the NULL pointer at compile time and avoiding the runtime
> conversion for this common case.
> 
> Rework the checks so that endian conversion of the sibling pointers
> is only done if they are not null as the original code did.
> 
> Fixes: dc04db2aa7c9 ("xfs: detect self referencing btree sibling pointers")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/libxfs/xfs_btree.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> index 2aa300f7461f..4d673e943317 100644
> --- a/fs/xfs/libxfs/xfs_btree.c
> +++ b/fs/xfs/libxfs/xfs_btree.c
> @@ -51,16 +51,25 @@ xfs_btree_magic(
>  	return magic;
>  }
>  
> +/*
> + * These sibling pointer checks are optimised for null sibling pointers. This
> + * happens a lot, and we don't need to byte swap at runtime if the sibling
> + * pointer is NULL.
> + */
>  static xfs_failaddr_t
>  xfs_btree_check_lblock_siblings(
>  	struct xfs_mount	*mp,
>  	struct xfs_btree_cur	*cur,
>  	int			level,
>  	xfs_fsblock_t		fsb,
> -	xfs_fsblock_t		sibling)
> +	__be64			dsibling)
>  {
> -	if (sibling == NULLFSBLOCK)
> +	xfs_fsblock_t		sibling;
> +
> +	if (dsibling == cpu_to_be64(NULLFSBLOCK))
>  		return NULL;
> +
> +	sibling = be64_to_cpu(dsibling);
>  	if (sibling == fsb)
>  		return __this_address;
>  	if (level >= 0) {
> @@ -81,10 +90,14 @@ xfs_btree_check_sblock_siblings(
>  	int			level,
>  	xfs_agnumber_t		agno,
>  	xfs_agblock_t		agbno,
> -	xfs_agblock_t		sibling)
> +	__be32			dsibling)
>  {
> -	if (sibling == NULLAGBLOCK)
> +	xfs_agblock_t		sibling;
> +
> +	if (dsibling == cpu_to_be32(NULLAGBLOCK))
>  		return NULL;
> +
> +	sibling = be32_to_cpu(dsibling);
>  	if (sibling == agbno)
>  		return __this_address;
>  	if (level >= 0) {
> @@ -136,10 +149,10 @@ __xfs_btree_check_lblock(
>  		fsb = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
>  
>  	fa = xfs_btree_check_lblock_siblings(mp, cur, level, fsb,
> -			be64_to_cpu(block->bb_u.l.bb_leftsib));
> +			block->bb_u.l.bb_leftsib);
>  	if (!fa)
>  		fa = xfs_btree_check_lblock_siblings(mp, cur, level, fsb,
> -				be64_to_cpu(block->bb_u.l.bb_rightsib));
> +				block->bb_u.l.bb_rightsib);
>  	return fa;
>  }
>  
> @@ -204,10 +217,10 @@ __xfs_btree_check_sblock(
>  	}
>  
>  	fa = xfs_btree_check_sblock_siblings(mp, cur, level, agno, agbno,
> -			be32_to_cpu(block->bb_u.s.bb_leftsib));
> +			block->bb_u.s.bb_leftsib);
>  	if (!fa)
>  		fa = xfs_btree_check_sblock_siblings(mp, cur, level, agno,
> -				 agbno, be32_to_cpu(block->bb_u.s.bb_rightsib));
> +				 agbno, block->bb_u.s.bb_rightsib);
>  	return fa;
>  }
>  
> @@ -4523,10 +4536,10 @@ xfs_btree_lblock_verify(
>  	/* sibling pointer verification */
>  	fsb = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
>  	fa = xfs_btree_check_lblock_siblings(mp, NULL, -1, fsb,
> -			be64_to_cpu(block->bb_u.l.bb_leftsib));
> +			block->bb_u.l.bb_leftsib);
>  	if (!fa)
>  		fa = xfs_btree_check_lblock_siblings(mp, NULL, -1, fsb,
> -				be64_to_cpu(block->bb_u.l.bb_rightsib));
> +				block->bb_u.l.bb_rightsib);
>  	return fa;
>  }
>  
> @@ -4580,10 +4593,10 @@ xfs_btree_sblock_verify(
>  	agno = xfs_daddr_to_agno(mp, xfs_buf_daddr(bp));
>  	agbno = xfs_daddr_to_agbno(mp, xfs_buf_daddr(bp));
>  	fa = xfs_btree_check_sblock_siblings(mp, NULL, -1, agno, agbno,
> -			be32_to_cpu(block->bb_u.s.bb_leftsib));
> +			block->bb_u.s.bb_leftsib);
>  	if (!fa)
>  		fa = xfs_btree_check_sblock_siblings(mp, NULL, -1, agno, agbno,
> -				be32_to_cpu(block->bb_u.s.bb_rightsib));
> +				block->bb_u.s.bb_rightsib);
>  	return fa;
>  }
>  
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

--KsGdsel6WgEHnImy
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--KsGdsel6WgEHnImy--
