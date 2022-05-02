Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE6517AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiEBXi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiEBXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:37:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B031DDA;
        Mon,  2 May 2022 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651534446; x=1683070446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nUwdA0ziW/oAngkHF65MDeVXJ9fwpPSasMNceDCwLpk=;
  b=nvluUV7UHa8M8j5h0sQ0phvSRZJG8/xQCD9H4fOntnT/JRmjYBUe3DU8
   Fr+hlzOslEauAbltSbSxn/y3Bn7fIfxdnYS8xD2ZIH9vzjotbT7iam9x5
   YW3Vyv68AJ3riQl184eOHoIak2e5/UQ26TVOuB7pAUmTJ3RN24uw6cx66
   QgSMe73x94X4TCQySBZbHwLWMf1o+a+2UL4AghnQlIkTMFvd53+cc0qa0
   EFWxdyfQvdrEt0wFR/4Fm7QhMduMn+HUGk7MxFc90PuQtGO8Zh2YOCJOu
   cMkQOVZOgjb4IXaNcYSVAIgWkYSb9Tyd4DWYvVS3EmoP1Q/VCeFtUz8Jn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247265525"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247265525"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 16:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="887442966"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 May 2022 16:34:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlfYJ-0009zA-3Z;
        Mon, 02 May 2022 23:34:03 +0000
Date:   Tue, 3 May 2022 07:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v4] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <202205030715.YJrfVKUa-lkp@intel.com>
References: <20220502151222.10681-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502151222.10681-1-max@enpas.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on linus/master v5.18-rc5 next-20220502]
[cannot apply to mkl-can-next/testing linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Staudt/can-tty-elmcan-CAN-ldisc-driver-for-ELM327-based-OBD-II-adapters/20220502-232340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205030715.YJrfVKUa-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/abb85fc1dc50ffca72049df7c5714a83d081d6f6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Max-Staudt/can-tty-elmcan-CAN-ldisc-driver-for-ELM327-based-OBD-II-adapters/20220502-232340
        git checkout abb85fc1dc50ffca72049df7c5714a83d081d6f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/net/can/elmcan.c:16:
   drivers/net/can/elmcan.c: In function 'elm327_send':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:130:9: note: in expansion of macro 'lockdep_assert_held'
     130 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_kick_into_cmd_mode':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:160:9: note: in expansion of macro 'lockdep_assert_held'
     160 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_send_frame':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:173:9: note: in expansion of macro 'lockdep_assert_held'
     173 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_init':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:235:9: note: in expansion of macro 'lockdep_assert_held'
     235 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_feed_frame_to_netdev':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:265:9: note: in expansion of macro 'lockdep_assert_held'
     265 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_uart_side_failure':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:286:9: note: in expansion of macro 'lockdep_assert_held'
     286 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_parse_error':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:327:9: note: in expansion of macro 'lockdep_assert_held'
     327 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_parse_frame':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:394:9: note: in expansion of macro 'lockdep_assert_held'
     394 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_parse_line':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:516:9: note: in expansion of macro 'lockdep_assert_held'
     516 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_handle_prompt':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:550:9: note: in expansion of macro 'lockdep_assert_held'
     550 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_drop_bytes':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:655:9: note: in expansion of macro 'lockdep_assert_held'
     655 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c: In function 'elm327_parse_rxbuf':
>> include/linux/lockdep.h:286:61: error: invalid type argument of '->' (have 'spinlock_t' {aka 'struct spinlock'})
     286 | #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
         |                                                             ^~
   include/asm-generic/bug.h:122:32: note: in definition of macro 'WARN_ON'
     122 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   include/linux/lockdep.h:316:9: note: in expansion of macro 'lockdep_assert'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |         ^~~~~~~~~~~~~~
   include/linux/lockdep.h:316:24: note: in expansion of macro 'lockdep_is_held'
     316 |         lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
         |                        ^~~~~~~~~~~~~~~
   drivers/net/can/elmcan.c:666:9: note: in expansion of macro 'lockdep_assert_held'
     666 |         lockdep_assert_held(elm->lock);
         |         ^~~~~~~~~~~~~~~~~~~


vim +286 include/linux/lockdep.h

f607c668577481 Peter Zijlstra 2009-07-20  285  
f8319483f57f1c Peter Zijlstra 2016-11-30 @286  #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)
f8319483f57f1c Peter Zijlstra 2016-11-30  287  #define lockdep_is_held_type(lock, r)	lock_is_held_type(&(lock)->dep_map, (r))
f607c668577481 Peter Zijlstra 2009-07-20  288  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
