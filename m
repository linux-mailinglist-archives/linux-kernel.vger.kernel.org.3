Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9F50B46B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446276AbiDVJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446258AbiDVJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:51:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158853E1A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650620931; x=1682156931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o/2Iy1HevOL4Of1oBhrvO0nmVvIOhZ31l8blZr26R6U=;
  b=TNdP9J7/iKyYPMo0i5Kb7HjTb1jm4T/uwjk25y7n2WvK4wFskK7Xrr7r
   NrGj5LTMf2cSUivwUXi23EjbeCceWNXSXEcQQEahMTwLMg//5iNy7hFBA
   YBiDt+prWiGyF0TIRpPxvLBb3mtUWARqJmiJw2k0TcJr1utDGXt5Ny0lW
   WA+NuQISFYN/0v4//zho+hn2sTNtKAauHPwdAFBswxn4zLJiP7knZV+v8
   oLHUhWeddGbVzchLBqcbgpdLDjgGpYZG5OXayHjVBafPyahz5c8Qvjppz
   X8qF0qkD4ZPMLuGzqfOQJUiljGmKvbhpJEdK7fhrBBYDJs546Vj5MeL/m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263484131"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="263484131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="615342767"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2022 02:48:42 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhpu5-0009zi-AS;
        Fri, 22 Apr 2022 09:48:41 +0000
Date:   Fri, 22 Apr 2022 17:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 17/78] kernel/printk/printk.c:3221:
 undefined reference to `console_emit_next_record'
Message-ID: <202204221737.z626xFJ9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.18.y-rt-rebase
head:   03e7725ddbfb0ffd7f3d7b257bfa504c6f795f6b
commit: 72b5c1227b73b2cde1452cfc58717cff442ed473 [17/78] serial: 8250: implement write_atomic
config: parisc-randconfig-r033-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221737.z626xFJ9-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=72b5c1227b73b2cde1452cfc58717cff442ed473
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout 72b5c1227b73b2cde1452cfc58717cff442ed473
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: kernel/printk/printk.o: in function `atomic_console_flush_all':
>> kernel/printk/printk.c:3221: undefined reference to `console_emit_next_record'


vim +3221 kernel/printk/printk.c

943b66638a0519 John Ogness 2022-02-04  3200  
943b66638a0519 John Ogness 2022-02-04  3201  	printk_cpu_sync_get_irqsave(flags);
943b66638a0519 John Ogness 2022-02-04  3202  
943b66638a0519 John Ogness 2022-02-04  3203  	do {
943b66638a0519 John Ogness 2022-02-04  3204  		any_progress = false;
943b66638a0519 John Ogness 2022-02-04  3205  
943b66638a0519 John Ogness 2022-02-04  3206  		for_each_console(con) {
943b66638a0519 John Ogness 2022-02-04  3207  			bool progress;
943b66638a0519 John Ogness 2022-02-04  3208  
943b66638a0519 John Ogness 2022-02-04  3209  			if (!console_is_usable(con, true))
943b66638a0519 John Ogness 2022-02-04  3210  				continue;
943b66638a0519 John Ogness 2022-02-04  3211  			any_usable = true;
943b66638a0519 John Ogness 2022-02-04  3212  
943b66638a0519 John Ogness 2022-02-04  3213  			if (con->flags & CON_EXTENDED) {
943b66638a0519 John Ogness 2022-02-04  3214  				/* Extended consoles do not print "dropped messages". */
943b66638a0519 John Ogness 2022-02-04  3215  				progress = console_emit_next_record(con,
943b66638a0519 John Ogness 2022-02-04  3216  							&con->atomic_data->text[index],
943b66638a0519 John Ogness 2022-02-04  3217  							&con->atomic_data->ext_text[index],
943b66638a0519 John Ogness 2022-02-04  3218  							NULL,
943b66638a0519 John Ogness 2022-02-04  3219  							true);
943b66638a0519 John Ogness 2022-02-04  3220  			} else {
943b66638a0519 John Ogness 2022-02-04 @3221  				progress = console_emit_next_record(con,
943b66638a0519 John Ogness 2022-02-04  3222  							&con->atomic_data->text[index],
943b66638a0519 John Ogness 2022-02-04  3223  							NULL,
943b66638a0519 John Ogness 2022-02-04  3224  							&con->atomic_data->dropped_text[index],
943b66638a0519 John Ogness 2022-02-04  3225  							true);
943b66638a0519 John Ogness 2022-02-04  3226  			}
943b66638a0519 John Ogness 2022-02-04  3227  
943b66638a0519 John Ogness 2022-02-04  3228  			if (!progress)
943b66638a0519 John Ogness 2022-02-04  3229  				continue;
943b66638a0519 John Ogness 2022-02-04  3230  			any_progress = true;
943b66638a0519 John Ogness 2022-02-04  3231  
943b66638a0519 John Ogness 2022-02-04  3232  			touch_softlockup_watchdog_sync();
943b66638a0519 John Ogness 2022-02-04  3233  			clocksource_touch_watchdog();
943b66638a0519 John Ogness 2022-02-04  3234  			rcu_cpu_stall_reset();
943b66638a0519 John Ogness 2022-02-04  3235  			touch_nmi_watchdog();
943b66638a0519 John Ogness 2022-02-04  3236  		}
943b66638a0519 John Ogness 2022-02-04  3237  	} while (any_progress);
943b66638a0519 John Ogness 2022-02-04  3238  
943b66638a0519 John Ogness 2022-02-04  3239  	printk_cpu_sync_put_irqrestore(flags);
943b66638a0519 John Ogness 2022-02-04  3240  }
943b66638a0519 John Ogness 2022-02-04  3241  #else /* CONFIG_HAVE_ATOMIC_CONSOLE */
943b66638a0519 John Ogness 2022-02-04  3242  #define atomic_console_flush_all()
943b66638a0519 John Ogness 2022-02-04  3243  #endif
943b66638a0519 John Ogness 2022-02-04  3244  

:::::: The code at line 3221 was first introduced by commit
:::::: 943b66638a0519612cdc25dcb07f59af89d37407 printk: add infrastucture for atomic consoles

:::::: TO: John Ogness <john.ogness@linutronix.de>
:::::: CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
