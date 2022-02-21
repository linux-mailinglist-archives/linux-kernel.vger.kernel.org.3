Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADCB4BD3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbiBUCYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:24:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbiBUCXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:23:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364AE3CFE1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645410185; x=1676946185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jb8pChYpGdC3Iop/f8X7za0jBZE99xJAFjk23ByQzrc=;
  b=kUjXCXpYk3isWP6O/HNvEMLPyd0O3+sjaH4saJPYYrWUMp3h+kKf8Nce
   VOCajaO1kZqJ1yr8jQJqnrq4zr0TOE5zmDqT4/BRkzSFX0LH0YyXkbXVB
   QZ0BFsRK04H1iLTcA2xAh0g7NFsUJwfnUODOZsDK6Rt7GLBpyG/Nb+g7Z
   uHeqvwZaiakak7VZe9iad5WUEUH715b9E4U2Fr4ZfVYXI857Fa2bZIfCq
   yCENgZ2qyS5z+uine3u34CIm0WLqBVMmi59v2lU2Mz53vE38tmz0mcETN
   EA729xcgXUuPT7XZREHwwhbii+83LH2OhcHmN6xxdJorGJKhbLthMd7Ug
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251369116"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251369116"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 18:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="606239816"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2022 18:23:03 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLyLu-0001CF-Iz; Mon, 21 Feb 2022 02:23:02 +0000
Date:   Mon, 21 Feb 2022 10:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1782/2574] kernel/sched/core.c:5345:20:
 warning: no previous prototype for function 'task_sched_runtime'
Message-ID: <202202211012.Blj8znBG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: b6902652b0ca92c05ba2a78dafaa1db83f232fe4 [1782/2574] headers/deps: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220221/202202211012.Blj8znBG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b6902652b0ca92c05ba2a78dafaa1db83f232fe4
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b6902652b0ca92c05ba2a78dafaa1db83f232fe4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ arch/x86/pci/ kernel/sched/ kernel/trace/ lib/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:5345:20: warning: no previous prototype for function 'task_sched_runtime' [-Wmissing-prototypes]
   unsigned long long task_sched_runtime(struct task_struct *p)
                      ^
   kernel/sched/core.c:5345:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long long task_sched_runtime(struct task_struct *p)
   ^
   static 
>> kernel/sched/core.c:9478:13: warning: no previous prototype for function 'sched_init_smp' [-Wmissing-prototypes]
   void __init sched_init_smp(void)
               ^
   kernel/sched/core.c:9478:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sched_init_smp(void)
   ^
   static 
   kernel/sched/core.c:9508:13: warning: no previous prototype for function 'per_task_init' [-Wmissing-prototypes]
   void __init per_task_init(void)
               ^
   kernel/sched/core.c:9508:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init per_task_init(void)
   ^
   static 
>> kernel/sched/core.c:9517:13: warning: no previous prototype for function 'sched_init' [-Wmissing-prototypes]
   void __init sched_init(void)
               ^
   kernel/sched/core.c:9517:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init sched_init(void)
   ^
   static 
   kernel/sched/core.c:3701:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
   static inline bool rq_has_pinned_tasks(struct rq *rq)
                      ^
   kernel/sched/core.c:5612:20: warning: unused function 'sched_tick_start' [-Wunused-function]
   static inline void sched_tick_start(int cpu) { }
                      ^
   kernel/sched/core.c:5613:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
   static inline void sched_tick_stop(int cpu) { }
                      ^
   kernel/sched/core.c:6301:20: warning: unused function 'sched_core_cpu_starting' [-Wunused-function]
   static inline void sched_core_cpu_starting(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6302:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
   static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
                      ^
   kernel/sched/core.c:6303:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
   static inline void sched_core_cpu_dying(unsigned int cpu) {}
                      ^
   10 warnings generated.
--
   In file included from kernel/sched/build_utility.c:79:
>> kernel/sched/loadavg.c:245:6: warning: no previous prototype for function 'calc_load_nohz_start' [-Wmissing-prototypes]
   void calc_load_nohz_start(void)
        ^
   kernel/sched/loadavg.c:245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void calc_load_nohz_start(void)
   ^
   static 
>> kernel/sched/loadavg.c:258:6: warning: no previous prototype for function 'calc_load_nohz_remote' [-Wmissing-prototypes]
   void calc_load_nohz_remote(struct rq *rq)
        ^
   kernel/sched/loadavg.c:258:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void calc_load_nohz_remote(struct rq *rq)
   ^
   static 
>> kernel/sched/loadavg.c:263:6: warning: no previous prototype for function 'calc_load_nohz_stop' [-Wmissing-prototypes]
   void calc_load_nohz_stop(void)
        ^
   kernel/sched/loadavg.c:263:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void calc_load_nohz_stop(void)
   ^
   static 
   3 warnings generated.


vim +/task_sched_runtime +5345 kernel/sched/core.c

6075620b0590ea kernel/sched/core.c Giovanni Gherdovich 2016-08-05  5339  
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5340  /*
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5341   * Return accounted runtime for the task.
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5342   * In case the task is currently running, return the runtime plus current's
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5343   * pending runtime that have not been accounted yet.
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5344   */
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31 @5345  unsigned long long task_sched_runtime(struct task_struct *p)
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5346  {
eb58075149b7f0 kernel/sched/core.c Peter Zijlstra      2015-07-31  5347  	struct rq_flags rf;
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5348  	struct rq *rq;
6e998916dfe327 kernel/sched/core.c Stanislaw Gruszka   2014-11-12  5349  	u64 ns;
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5350  

:::::: The code at line 5345 was first introduced by commit
:::::: c5f8d99585d7b5b7e857fabf8aefd0174903a98c posixtimers, sched: Fix posix clock monotonicity

:::::: TO: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
