Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1500750F180
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiDZGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbiDZGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:51:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A112C8E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650955731; x=1682491731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nqrgrw/s0vxaROpu8xZWOWGHSnX8rXEaIq3SmjGDH4c=;
  b=GbwRPkgLgSF+GsTSECcc4gzVS2P9+HGtQ+qoSAC1JG4x/ztCYLvqWt2E
   6z1eid8IPuxWTQbSJy6zKOwWly+eJaFkjM9PS2B+m5NCkXjRj3932hRB+
   fMoUdFcL4fzbNgT74qdQIOWfdURuMgYgTSMSMJLpNtLIw6I/qz9P+UtOf
   sAwisGskj9IoxCysOSI901+0+6pZP2O6PAwEJNCcIoIOJuwdPFIWnjOzD
   bucCu7zN/j1jI+3mmWwshCUwzvvFx7NIVYP2NlPgeBSm+UisMs2PmIS6r
   W9ZCq85pUc1C3TGMDJ6blifeNnjm5u+aDLSIzeWFUpcTdIOUSm9l2Wzlz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264996576"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264996576"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="628384521"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2022 23:48:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njF0B-0003Ii-Hp;
        Tue, 26 Apr 2022 06:48:47 +0000
Date:   Tue, 26 Apr 2022 14:48:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: [yu-chen-surf:sis 1/3] kernel/sched/debug.c:765:50: warning: format
 specifies type 'long' but the argument has type 'int'
Message-ID: <202204261453.3774zcNd-lkp@intel.com>
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
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261453.3774zcNd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/yu-chen-surf/linux/commit/0c1952e6258a04d69b2b862a11f037f125dcfe05
        git remote add yu-chen-surf https://github.com/yu-chen-surf/linux.git
        git fetch --no-tags yu-chen-surf sis
        git checkout 0c1952e6258a04d69b2b862a11f037f125dcfe05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:72:
>> kernel/sched/debug.c:765:50: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_search", schedstat_val(rq->sis_search));
                                            ~~~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:17:17: note: expanded from macro 'SEQ_printf'
                   seq_printf(m, x);               \
                                 ^
>> kernel/sched/debug.c:765:50: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_search", schedstat_val(rq->sis_search));
                                            ~~~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:19:11: note: expanded from macro 'SEQ_printf'
                   pr_cont(x);                     \
                           ^
   include/linux/printk.h:531:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:766:57: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_domain_search", schedstat_val(rq->sis_domain_search));
                                            ~~~                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:17:17: note: expanded from macro 'SEQ_printf'
                   seq_printf(m, x);               \
                                 ^
   kernel/sched/debug.c:766:57: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_domain_search", schedstat_val(rq->sis_domain_search));
                                            ~~~                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:19:11: note: expanded from macro 'SEQ_printf'
                   pr_cont(x);                     \
                           ^
   include/linux/printk.h:531:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:767:51: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_scanned", schedstat_val(rq->sis_scanned));
                                            ~~~                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:17:17: note: expanded from macro 'SEQ_printf'
                   seq_printf(m, x);               \
                                 ^
   kernel/sched/debug.c:767:51: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_scanned", schedstat_val(rq->sis_scanned));
                                            ~~~                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:19:11: note: expanded from macro 'SEQ_printf'
                   pr_cont(x);                     \
                           ^
   include/linux/printk.h:531:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:768:50: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_failed", schedstat_val(rq->sis_failed));
                                            ~~~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:17:17: note: expanded from macro 'SEQ_printf'
                   seq_printf(m, x);               \
                                 ^
   kernel/sched/debug.c:768:50: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
                   SEQ_printf(m, "  .%-30s: %ld\n", "sis_failed", schedstat_val(rq->sis_failed));
                                            ~~~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                            %d
   kernel/sched/stats.h:82:32: note: expanded from macro 'schedstat_val'
   # define   schedstat_val(var)           0
                                           ^
   kernel/sched/debug.c:19:11: note: expanded from macro 'SEQ_printf'
                   pr_cont(x);                     \
                           ^
   include/linux/printk.h:531:26: note: expanded from macro 'pr_cont'


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
