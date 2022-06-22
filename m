Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68845554157
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356760AbiFVEOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356940AbiFVENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:13:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41034656
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655871213; x=1687407213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1RiThxF9TNnXpu2eQhDXAZ3DFZHpMqoRm88NT/v3n3A=;
  b=ky7EuMsPBN3Yd3+334clSbE/4bnIc45X7cyL9sh/qRR36a7hM7bC2bkj
   K5uZ99FjizvPt/+GLJdAafiDqdfQRqy/OSUX+QoZb2bxImsXce3HUbG9Y
   X5EQBxK+iYa2sp/4MYPU5Mo/Nkw5+5Pg5A3NBYCN5wVwgd6WlDK2UoEMO
   ycN58RcOqHh+Mn8sSixaR5pXDL5vjieWmg7nenGXCH1XaBEO7M7AU21Ne
   arjIcBbwukbPA2NJwwCjceB1SDM8tDVXk708x6WTS/3uRpgNHkg1mVrhA
   SVQ/8RAC/pl+iOKv9OITQZXFL1RQXN+IC1a3ClGePRCYIkaAdT/cSk/gP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305757288"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="305757288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 21:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="730131927"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2022 21:13:30 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3rkA-0000ov-8d;
        Wed, 22 Jun 2022 04:13:30 +0000
Date:   Wed, 22 Jun 2022 12:13:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: kernel/sched/fair.c:9246:53: error: use of undeclared identifier
 'select_idle_mask'
Message-ID: <202206221253.ZVyGQvPX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
head:   2059fff7a5a2b6016ef5843c673845283a00a646
commit: a4a1ec79913664ac49b72cda8c3756c4da7c16b4 sched/fair: Rename select_idle_mask to select_rq_mask
date:   19 hours ago
config: s390-randconfig-r044-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221253.ZVyGQvPX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8b8d126598ce7bd5243da7f94f69fa1104288bee)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a4a1ec79913664ac49b72cda8c3756c4da7c16b4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Donnefort/feec-energy-margin-removal/20220621-170631
        git checkout a4a1ec79913664ac49b72cda8c3756c4da7c16b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:38:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/sched/fair.c:38:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/sched/fair.c:38:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   kernel/sched/fair.c:5614:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:5614:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
>> kernel/sched/fair.c:9246:53: error: use of undeclared identifier 'select_idle_mask'
                                   struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
                                                                                   ^
>> kernel/sched/fair.c:9246:53: error: use of undeclared identifier 'select_idle_mask'
>> kernel/sched/fair.c:9246:53: error: use of undeclared identifier 'select_idle_mask'
>> kernel/sched/fair.c:9246:21: error: initializing 'struct cpumask *' with an expression of incompatible type 'void'
                                   struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
                                                   ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11151:6: warning: no previous prototype for function 'task_vruntime_update' [-Wmissing-prototypes]
   void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
        ^
   kernel/sched/fair.c:11151:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
   ^
   static 
   kernel/sched/fair.c:11771:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11771:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11773:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:11773:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:11778:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11778:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:11780:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:11780:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   18 warnings and 4 errors generated.


vim +/select_idle_mask +9246 kernel/sched/fair.c

57abff067a08488 Vincent Guittot    2019-10-18  9103  
57abff067a08488 Vincent Guittot    2019-10-18  9104  /*
57abff067a08488 Vincent Guittot    2019-10-18  9105   * find_idlest_group() finds and returns the least busy CPU group within the
57abff067a08488 Vincent Guittot    2019-10-18  9106   * domain.
57abff067a08488 Vincent Guittot    2019-10-18  9107   *
57abff067a08488 Vincent Guittot    2019-10-18  9108   * Assumes p is allowed on at least one CPU in sd.
57abff067a08488 Vincent Guittot    2019-10-18  9109   */
57abff067a08488 Vincent Guittot    2019-10-18  9110  static struct sched_group *
45da27732b0b9b7 Valentin Schneider 2020-04-15  9111  find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
57abff067a08488 Vincent Guittot    2019-10-18  9112  {
57abff067a08488 Vincent Guittot    2019-10-18  9113  	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
57abff067a08488 Vincent Guittot    2019-10-18  9114  	struct sg_lb_stats local_sgs, tmp_sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9115  	struct sg_lb_stats *sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9116  	unsigned long imbalance;
57abff067a08488 Vincent Guittot    2019-10-18  9117  	struct sg_lb_stats idlest_sgs = {
57abff067a08488 Vincent Guittot    2019-10-18  9118  			.avg_load = UINT_MAX,
57abff067a08488 Vincent Guittot    2019-10-18  9119  			.group_type = group_overloaded,
57abff067a08488 Vincent Guittot    2019-10-18  9120  	};
57abff067a08488 Vincent Guittot    2019-10-18  9121  
57abff067a08488 Vincent Guittot    2019-10-18  9122  	do {
57abff067a08488 Vincent Guittot    2019-10-18  9123  		int local_group;
57abff067a08488 Vincent Guittot    2019-10-18  9124  
57abff067a08488 Vincent Guittot    2019-10-18  9125  		/* Skip over this group if it has no CPUs allowed */
57abff067a08488 Vincent Guittot    2019-10-18  9126  		if (!cpumask_intersects(sched_group_span(group),
57abff067a08488 Vincent Guittot    2019-10-18  9127  					p->cpus_ptr))
57abff067a08488 Vincent Guittot    2019-10-18  9128  			continue;
57abff067a08488 Vincent Guittot    2019-10-18  9129  
97886d9dcd86820 Aubrey Li          2021-03-24  9130  		/* Skip over this group if no cookie matched */
97886d9dcd86820 Aubrey Li          2021-03-24  9131  		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
97886d9dcd86820 Aubrey Li          2021-03-24  9132  			continue;
97886d9dcd86820 Aubrey Li          2021-03-24  9133  
57abff067a08488 Vincent Guittot    2019-10-18  9134  		local_group = cpumask_test_cpu(this_cpu,
57abff067a08488 Vincent Guittot    2019-10-18  9135  					       sched_group_span(group));
57abff067a08488 Vincent Guittot    2019-10-18  9136  
57abff067a08488 Vincent Guittot    2019-10-18  9137  		if (local_group) {
57abff067a08488 Vincent Guittot    2019-10-18  9138  			sgs = &local_sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9139  			local = group;
57abff067a08488 Vincent Guittot    2019-10-18  9140  		} else {
57abff067a08488 Vincent Guittot    2019-10-18  9141  			sgs = &tmp_sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9142  		}
57abff067a08488 Vincent Guittot    2019-10-18  9143  
57abff067a08488 Vincent Guittot    2019-10-18  9144  		update_sg_wakeup_stats(sd, group, sgs, p);
57abff067a08488 Vincent Guittot    2019-10-18  9145  
57abff067a08488 Vincent Guittot    2019-10-18  9146  		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
57abff067a08488 Vincent Guittot    2019-10-18  9147  			idlest = group;
57abff067a08488 Vincent Guittot    2019-10-18  9148  			idlest_sgs = *sgs;
57abff067a08488 Vincent Guittot    2019-10-18  9149  		}
57abff067a08488 Vincent Guittot    2019-10-18  9150  
57abff067a08488 Vincent Guittot    2019-10-18  9151  	} while (group = group->next, group != sd->groups);
57abff067a08488 Vincent Guittot    2019-10-18  9152  
57abff067a08488 Vincent Guittot    2019-10-18  9153  
57abff067a08488 Vincent Guittot    2019-10-18  9154  	/* There is no idlest group to push tasks to */
57abff067a08488 Vincent Guittot    2019-10-18  9155  	if (!idlest)
57abff067a08488 Vincent Guittot    2019-10-18  9156  		return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9157  
7ed735c33104f3c Vincent Guittot    2019-12-04  9158  	/* The local group has been skipped because of CPU affinity */
7ed735c33104f3c Vincent Guittot    2019-12-04  9159  	if (!local)
7ed735c33104f3c Vincent Guittot    2019-12-04  9160  		return idlest;
7ed735c33104f3c Vincent Guittot    2019-12-04  9161  
57abff067a08488 Vincent Guittot    2019-10-18  9162  	/*
57abff067a08488 Vincent Guittot    2019-10-18  9163  	 * If the local group is idler than the selected idlest group
57abff067a08488 Vincent Guittot    2019-10-18  9164  	 * don't try and push the task.
57abff067a08488 Vincent Guittot    2019-10-18  9165  	 */
57abff067a08488 Vincent Guittot    2019-10-18  9166  	if (local_sgs.group_type < idlest_sgs.group_type)
57abff067a08488 Vincent Guittot    2019-10-18  9167  		return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9168  
57abff067a08488 Vincent Guittot    2019-10-18  9169  	/*
57abff067a08488 Vincent Guittot    2019-10-18  9170  	 * If the local group is busier than the selected idlest group
57abff067a08488 Vincent Guittot    2019-10-18  9171  	 * try and push the task.
57abff067a08488 Vincent Guittot    2019-10-18  9172  	 */
57abff067a08488 Vincent Guittot    2019-10-18  9173  	if (local_sgs.group_type > idlest_sgs.group_type)
57abff067a08488 Vincent Guittot    2019-10-18  9174  		return idlest;
57abff067a08488 Vincent Guittot    2019-10-18  9175  
57abff067a08488 Vincent Guittot    2019-10-18  9176  	switch (local_sgs.group_type) {
57abff067a08488 Vincent Guittot    2019-10-18  9177  	case group_overloaded:
57abff067a08488 Vincent Guittot    2019-10-18  9178  	case group_fully_busy:
5c339005f854fa7 Mel Gorman         2020-11-20  9179  
5c339005f854fa7 Mel Gorman         2020-11-20  9180  		/* Calculate allowed imbalance based on load */
5c339005f854fa7 Mel Gorman         2020-11-20  9181  		imbalance = scale_load_down(NICE_0_LOAD) *
5c339005f854fa7 Mel Gorman         2020-11-20  9182  				(sd->imbalance_pct-100) / 100;
5c339005f854fa7 Mel Gorman         2020-11-20  9183  
57abff067a08488 Vincent Guittot    2019-10-18  9184  		/*
57abff067a08488 Vincent Guittot    2019-10-18  9185  		 * When comparing groups across NUMA domains, it's possible for
57abff067a08488 Vincent Guittot    2019-10-18  9186  		 * the local domain to be very lightly loaded relative to the
57abff067a08488 Vincent Guittot    2019-10-18  9187  		 * remote domains but "imbalance" skews the comparison making
57abff067a08488 Vincent Guittot    2019-10-18  9188  		 * remote CPUs look much more favourable. When considering
57abff067a08488 Vincent Guittot    2019-10-18  9189  		 * cross-domain, add imbalance to the load on the remote node
57abff067a08488 Vincent Guittot    2019-10-18  9190  		 * and consider staying local.
57abff067a08488 Vincent Guittot    2019-10-18  9191  		 */
57abff067a08488 Vincent Guittot    2019-10-18  9192  
57abff067a08488 Vincent Guittot    2019-10-18  9193  		if ((sd->flags & SD_NUMA) &&
57abff067a08488 Vincent Guittot    2019-10-18  9194  		    ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
57abff067a08488 Vincent Guittot    2019-10-18  9195  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9196  
57abff067a08488 Vincent Guittot    2019-10-18  9197  		/*
57abff067a08488 Vincent Guittot    2019-10-18  9198  		 * If the local group is less loaded than the selected
57abff067a08488 Vincent Guittot    2019-10-18  9199  		 * idlest group don't try and push any tasks.
57abff067a08488 Vincent Guittot    2019-10-18  9200  		 */
57abff067a08488 Vincent Guittot    2019-10-18  9201  		if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
57abff067a08488 Vincent Guittot    2019-10-18  9202  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9203  
57abff067a08488 Vincent Guittot    2019-10-18  9204  		if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
57abff067a08488 Vincent Guittot    2019-10-18  9205  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9206  		break;
57abff067a08488 Vincent Guittot    2019-10-18  9207  
57abff067a08488 Vincent Guittot    2019-10-18  9208  	case group_imbalanced:
57abff067a08488 Vincent Guittot    2019-10-18  9209  	case group_asym_packing:
57abff067a08488 Vincent Guittot    2019-10-18  9210  		/* Those type are not used in the slow wakeup path */
57abff067a08488 Vincent Guittot    2019-10-18  9211  		return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9212  
57abff067a08488 Vincent Guittot    2019-10-18  9213  	case group_misfit_task:
57abff067a08488 Vincent Guittot    2019-10-18  9214  		/* Select group with the highest max capacity */
57abff067a08488 Vincent Guittot    2019-10-18  9215  		if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
57abff067a08488 Vincent Guittot    2019-10-18  9216  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9217  		break;
57abff067a08488 Vincent Guittot    2019-10-18  9218  
57abff067a08488 Vincent Guittot    2019-10-18  9219  	case group_has_spare:
cb29a5c19d2d68a Mel Gorman         2022-05-20  9220  #ifdef CONFIG_NUMA
57abff067a08488 Vincent Guittot    2019-10-18  9221  		if (sd->flags & SD_NUMA) {
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9222  			int imb_numa_nr = sd->imb_numa_nr;
57abff067a08488 Vincent Guittot    2019-10-18  9223  #ifdef CONFIG_NUMA_BALANCING
57abff067a08488 Vincent Guittot    2019-10-18  9224  			int idlest_cpu;
57abff067a08488 Vincent Guittot    2019-10-18  9225  			/*
57abff067a08488 Vincent Guittot    2019-10-18  9226  			 * If there is spare capacity at NUMA, try to select
57abff067a08488 Vincent Guittot    2019-10-18  9227  			 * the preferred node
57abff067a08488 Vincent Guittot    2019-10-18  9228  			 */
57abff067a08488 Vincent Guittot    2019-10-18  9229  			if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
57abff067a08488 Vincent Guittot    2019-10-18  9230  				return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9231  
57abff067a08488 Vincent Guittot    2019-10-18  9232  			idlest_cpu = cpumask_first(sched_group_span(idlest));
57abff067a08488 Vincent Guittot    2019-10-18  9233  			if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
57abff067a08488 Vincent Guittot    2019-10-18  9234  				return idlest;
cb29a5c19d2d68a Mel Gorman         2022-05-20  9235  #endif /* CONFIG_NUMA_BALANCING */
57abff067a08488 Vincent Guittot    2019-10-18  9236  			/*
2cfb7a1b031b0e8 Mel Gorman         2022-02-08  9237  			 * Otherwise, keep the task close to the wakeup source
2cfb7a1b031b0e8 Mel Gorman         2022-02-08  9238  			 * and improve locality if the number of running tasks
2cfb7a1b031b0e8 Mel Gorman         2022-02-08  9239  			 * would remain below threshold where an imbalance is
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9240  			 * allowed while accounting for the possibility the
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9241  			 * task is pinned to a subset of CPUs. If there is a
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9242  			 * real need of migration, periodic load balance will
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9243  			 * take care of it.
57abff067a08488 Vincent Guittot    2019-10-18  9244  			 */
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9245  			if (p->nr_cpus_allowed != NR_CPUS) {
f5b2eeb49991047 K Prateek Nayak    2022-04-07 @9246  				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9247  
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9248  				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9249  				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9250  			}
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9251  
cb29a5c19d2d68a Mel Gorman         2022-05-20  9252  			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
cb29a5c19d2d68a Mel Gorman         2022-05-20  9253  			if (!adjust_numa_imbalance(imbalance,
cb29a5c19d2d68a Mel Gorman         2022-05-20  9254  						   local_sgs.sum_nr_running + 1,
f5b2eeb49991047 K Prateek Nayak    2022-04-07  9255  						   imb_numa_nr)) {
57abff067a08488 Vincent Guittot    2019-10-18  9256  				return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9257  			}
cb29a5c19d2d68a Mel Gorman         2022-05-20  9258  		}
cb29a5c19d2d68a Mel Gorman         2022-05-20  9259  #endif /* CONFIG_NUMA */
57abff067a08488 Vincent Guittot    2019-10-18  9260  
57abff067a08488 Vincent Guittot    2019-10-18  9261  		/*
57abff067a08488 Vincent Guittot    2019-10-18  9262  		 * Select group with highest number of idle CPUs. We could also
57abff067a08488 Vincent Guittot    2019-10-18  9263  		 * compare the utilization which is more stable but it can end
57abff067a08488 Vincent Guittot    2019-10-18  9264  		 * up that the group has less spare capacity but finally more
57abff067a08488 Vincent Guittot    2019-10-18  9265  		 * idle CPUs which means more opportunity to run task.
57abff067a08488 Vincent Guittot    2019-10-18  9266  		 */
57abff067a08488 Vincent Guittot    2019-10-18  9267  		if (local_sgs.idle_cpus >= idlest_sgs.idle_cpus)
57abff067a08488 Vincent Guittot    2019-10-18  9268  			return NULL;
57abff067a08488 Vincent Guittot    2019-10-18  9269  		break;
57abff067a08488 Vincent Guittot    2019-10-18  9270  	}
57abff067a08488 Vincent Guittot    2019-10-18  9271  
57abff067a08488 Vincent Guittot    2019-10-18  9272  	return idlest;
57abff067a08488 Vincent Guittot    2019-10-18  9273  }
57abff067a08488 Vincent Guittot    2019-10-18  9274  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
