Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7376B50F084
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiDZGAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiDZGAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:00:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC637A94
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650952662; x=1682488662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7M/WA0Ma/2nZZCdHHliVnxfpGJN9ZttuykvvATujQ00=;
  b=LmuDuF/WTsKtPI4P27GDiQYV0ic8kwiJ/AolaRVGwiNhDcQxOv8U3FkL
   YuJYXwLYLBGIVzmPquHofe/PPdCwCawYFCbyXH3xengkbmAhce5h6j2j+
   Ud8vjCEnSJAs+bQxjmirKCNxHG4F4dLWSCpSzSF3uMx7IXbPXLPCfjBxC
   JihckAOlM5yni9u91b8OfXRK2VeD4+LFXRoCo0bHJyA5/NYjYNCEjfRhV
   1twtdNADljzb93i/XbHzxPEFJ0GjbX/s55Xr9qu8vaFb9iXXYYyiYyanG
   G/IkHqzQb8JwLgz1erzF16OIjbCuCAJcQQc5mNokiyzzzS8VqdB/TiJBW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264986800"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264986800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 22:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="730086778"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 22:57:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njECh-0003Gg-Uh;
        Tue, 26 Apr 2022 05:57:39 +0000
Date:   Tue, 26 Apr 2022 13:57:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     kbuild-all@lists.01.org, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [yu-chen-surf:sis 1/3] kernel/sched/debug.c:765:31: warning: format
 '%ld' expects argument of type 'long int', but argument 4 has type 'int'
Message-ID: <202204261355.SU3LEu3a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/yu-chen-surf/linux.git sis
head:   96e5c4a99150281df27ecef59d05229a609afd17
commit: 0c1952e6258a04d69b2b862a11f037f125dcfe05 [1/3] sched/fair: Track efficiency of select_idle_sibling
config: sparc-randconfig-r022-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261355.SU3LEu3a-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/yu-chen-surf/linux/commit/0c1952e6258a04d69b2b862a11f037f125dcfe05
        git remote add yu-chen-surf https://github.com/yu-chen-surf/linux.git
        git fetch --no-tags yu-chen-surf sis
        git checkout 0c1952e6258a04d69b2b862a11f037f125dcfe05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c: In function 'print_cpu':
>> kernel/sched/debug.c:765:31: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
     765 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_search", schedstat_val(rq->sis_search));
         |                               ^~~~~~~~~~~~~~~~~
   kernel/sched/debug.c:17:31: note: in definition of macro 'SEQ_printf'
      17 |                 seq_printf(m, x);               \
         |                               ^
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:765:44: note: format string is defined here
     765 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_search", schedstat_val(rq->sis_search));
         |                                          ~~^
         |                                            |
         |                                            long int
         |                                          %d
   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from kernel/sched/build_utility.c:12:
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:531:9: note: in expansion of macro 'printk'
     531 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:24:25: note: in expansion of macro 'KERN_SOH'
      24 | #define KERN_CONT       KERN_SOH "c"
         |                         ^~~~~~~~
   include/linux/printk.h:531:16: note: in expansion of macro 'KERN_CONT'
     531 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
         |                ^~~~~~~~~
   kernel/sched/debug.c:19:17: note: in expansion of macro 'pr_cont'
      19 |                 pr_cont(x);                     \
         |                 ^~~~~~~
   kernel/sched/debug.c:765:17: note: in expansion of macro 'SEQ_printf'
     765 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_search", schedstat_val(rq->sis_search));
         |                 ^~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:766:31: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
     766 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_domain_search", schedstat_val(rq->sis_domain_search));
         |                               ^~~~~~~~~~~~~~~~~
   kernel/sched/debug.c:17:31: note: in definition of macro 'SEQ_printf'
      17 |                 seq_printf(m, x);               \
         |                               ^
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:766:44: note: format string is defined here
     766 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_domain_search", schedstat_val(rq->sis_domain_search));
         |                                          ~~^
         |                                            |
         |                                            long int
         |                                          %d
   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from kernel/sched/build_utility.c:12:
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:531:9: note: in expansion of macro 'printk'
     531 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:24:25: note: in expansion of macro 'KERN_SOH'
      24 | #define KERN_CONT       KERN_SOH "c"
         |                         ^~~~~~~~
   include/linux/printk.h:531:16: note: in expansion of macro 'KERN_CONT'
     531 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
         |                ^~~~~~~~~
   kernel/sched/debug.c:19:17: note: in expansion of macro 'pr_cont'
      19 |                 pr_cont(x);                     \
         |                 ^~~~~~~
   kernel/sched/debug.c:766:17: note: in expansion of macro 'SEQ_printf'
     766 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_domain_search", schedstat_val(rq->sis_domain_search));
         |                 ^~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:767:31: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
     767 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_scanned", schedstat_val(rq->sis_scanned));
         |                               ^~~~~~~~~~~~~~~~~
   kernel/sched/debug.c:17:31: note: in definition of macro 'SEQ_printf'
      17 |                 seq_printf(m, x);               \
         |                               ^
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:767:44: note: format string is defined here
     767 |                 SEQ_printf(m, "  .%-30s: %ld\n", "sis_scanned", schedstat_val(rq->sis_scanned));
         |                                          ~~^
         |                                            |
         |                                            long int
         |                                          %d
   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from kernel/sched/build_utility.c:12:
   include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~


vim +765 kernel/sched/debug.c

   757	
   758	#define P(n) SEQ_printf(m, "  .%-30s: %d\n", #n, schedstat_val(rq->n));
   759		if (schedstat_enabled()) {
   760			P(yld_count);
   761			P(sched_count);
   762			P(sched_goidle);
   763			P(ttwu_count);
   764			P(ttwu_local);
 > 765			SEQ_printf(m, "  .%-30s: %ld\n", "sis_search", schedstat_val(rq->sis_search));
   766			SEQ_printf(m, "  .%-30s: %ld\n", "sis_domain_search", schedstat_val(rq->sis_domain_search));
   767			SEQ_printf(m, "  .%-30s: %ld\n", "sis_scanned", schedstat_val(rq->sis_scanned));
   768			SEQ_printf(m, "  .%-30s: %ld\n", "sis_failed", schedstat_val(rq->sis_failed));
   769		}
   770	#undef P
   771	
   772		print_cfs_stats(m, cpu);
   773		print_rt_stats(m, cpu);
   774		print_dl_stats(m, cpu);
   775	
   776		print_rq(m, rq, cpu);
   777		SEQ_printf(m, "\n");
   778	}
   779	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
