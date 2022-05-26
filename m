Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6742535624
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348727AbiEZWpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEZWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:45:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947ADC5D8C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653605101; x=1685141101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q/gPSv6PKYmowfPsIC3jmdBDjeNSJKaPWyddAk0wFoc=;
  b=fa83M/lnvLUJTgez89hxsLyJriOBEfPa4qr6RIPOvexXTCB6M5Lgd/SO
   K90OIuqQA0DVKjBbJM+r8YeD1nSFTHKLK8iTwdXXKx32foHKUbAJDaY0X
   2iYLzD7pbFI3dszlybqK4LmdrfDQ+fRXWRrOgZYfn4C6D3+UL/hxU37So
   Zvb+AwKA+dJx4+pFljWpZ7UDKUodGAPaU2rSsLw7PGxu4ga6AXnjqVRjR
   csIrHeWwA3bVwWylTjsDMe9sDUab6HDbRCWiD0YHu3qxI/Hp0vV9nphXy
   NttNz0UFJXOOXxnNjOXPxoyrvgeILarzZ8qaiTwtsaZDF4CRdA8ZI4JyK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360700611"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="360700611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 15:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="527663540"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2022 15:44:52 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuMDs-0004EE-5r;
        Thu, 26 May 2022 22:44:52 +0000
Date:   Fri, 27 May 2022 06:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.05.23b 64/68]
 arch/s390/include/asm/cmpxchg.h:160:17: error: cast to union type from type
 not present in union
Message-ID: <202205270626.brEm5KpN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.05.23b
head:   29fe03d9190c37a93b96078e34ddd95344ef8b0f
commit: 2b23adb3446ac4098c17dee98414df6fca07f6c9 [64/68] squash! rcu-tasks: Atomically update .b.need_qs to obviate count
config: s390-randconfig-r044-20220524 (https://download.01.org/0day-ci/archive/20220527/202205270626.brEm5KpN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2b23adb3446ac4098c17dee98414df6fca07f6c9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.05.23b
        git checkout 2b23adb3446ac4098c17dee98414df6fca07f6c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/update.c:606:
   kernel/rcu/tasks.h: In function 'rcu_trc_cmpxchg_need_qs':
   kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected
    1243 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |         ^~~
   kernel/rcu/tasks.h:1243:9: error: aggregate value used where an integer was expected
   In file included from arch/s390/include/asm/percpu.h:6,
                    from include/linux/irqflags.h:17,
                    from include/linux/spinlock.h:58,
                    from kernel/rcu/update.c:23:
>> arch/s390/include/asm/cmpxchg.h:160:17: error: cast to union type from type not present in union
     160 |         __ret = (__typeof__(*(ptr)))                                    \
         |                 ^
   include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro 'arch_cmpxchg'
    1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~
   kernel/rcu/tasks.h:1243:15: note: in expansion of macro 'cmpxchg'
    1243 |         ret = cmpxchg(&t->trc_reader_special, trs_old, trs_new);
         |               ^~~~~~~


vim +160 arch/s390/include/asm/cmpxchg.h

d2b1f6d2d35043 Heiko Carstens 2021-04-06  155  
000174233b9134 Heiko Carstens 2021-04-06  156  #define arch_cmpxchg(ptr, o, n)						\
6b894a409e8c0f Heiko Carstens 2012-05-29  157  ({									\
d2b1f6d2d35043 Heiko Carstens 2021-04-06  158  	__typeof__(*(ptr)) __ret;					\
d2b1f6d2d35043 Heiko Carstens 2021-04-06  159  									\
d2b1f6d2d35043 Heiko Carstens 2021-04-06 @160  	__ret = (__typeof__(*(ptr)))					\
13525f0a62cc25 Heiko Carstens 2021-04-13  161  		__cmpxchg((unsigned long)(ptr), (unsigned long)(o),	\
d2b1f6d2d35043 Heiko Carstens 2021-04-06  162  			  (unsigned long)(n), sizeof(*(ptr)));		\
d2b1f6d2d35043 Heiko Carstens 2021-04-06  163  	__ret;								\
54eaae3028e6b0 Heiko Carstens 2011-03-23  164  })
54eaae3028e6b0 Heiko Carstens 2011-03-23  165  

:::::: The code at line 160 was first introduced by commit
:::::: d2b1f6d2d35043d2c9d079c1595f10c93bfca7d2 s390/cmpxchg: get rid of gcc atomic builtins

:::::: TO: Heiko Carstens <hca@linux.ibm.com>
:::::: CC: Heiko Carstens <hca@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
