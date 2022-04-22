Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C950C111
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiDVVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiDVVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:25:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71C3AA842
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650658832; x=1682194832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XE7JHwu805drzlQf1mQ23fDrBkMXNUptX1mERviOLCY=;
  b=noGtA4AbPNRO/Cq+MQBA1esojWENYu0kUu4bykAZQDdf/nrCHu2uM1C6
   5JpuzmXaTYtxYE00xLTTOYsKdjxmeftBXAe21fi9IhETYLjYCDH8xPqil
   FgqpEM6p/OsvbJblbm8PopCYSvbkfFqrAYD3ym/FdM5+AlRBrMlXxzV5S
   BJjuNRvcKskXFT07KZCjaQyKFfm1x05moEEdZt35lsPzuPgceDR9vETir
   MsgWXgrfCpXrkP+BL3vkJNCuxdY6Epznlli4mp+ciB66QhxTk8w1my37b
   7Vkxka+7BiBgpE/0NiXwhpf2udyOVNpkKtGLgOs65sPDf/BJzNaKVEf5p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264268111"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264268111"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="672639715"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2022 13:19:11 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhzkE-000AYI-Ve;
        Fri, 22 Apr 2022 20:19:10 +0000
Date:   Sat, 23 Apr 2022 04:18:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 17/78]
 kernel/printk/printk.c:3187:14: warning: variable 'any_usable' set but not
 used
Message-ID: <202204230430.85I2TCOI-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.18.y-rt-rebase
head:   03e7725ddbfb0ffd7f3d7b257bfa504c6f795f6b
commit: 72b5c1227b73b2cde1452cfc58717cff442ed473 [17/78] serial: 8250: implement write_atomic
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204230430.85I2TCOI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=72b5c1227b73b2cde1452cfc58717cff442ed473
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout 72b5c1227b73b2cde1452cfc58717cff442ed473
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/printk/printk.c: In function 'atomic_console_flush_all':
>> kernel/printk/printk.c:3187:14: warning: variable 'any_usable' set but not used [-Wunused-but-set-variable]
    3187 |         bool any_usable = false;
         |              ^~~~~~~~~~


vim +/any_usable +3187 kernel/printk/printk.c

fe3d8ad31cf51b kernel/printk.c        Feng Tang   2011-03-22  3180  
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3181  #ifdef CONFIG_HAVE_ATOMIC_CONSOLE
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3182  static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3183  				     char *dropped_text, bool atomic_printing);
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3184  
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3185  static void atomic_console_flush_all(void)
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3186  {
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04 @3187  	bool any_usable = false;
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3188  	unsigned long flags;
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3189  	struct console *con;
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3190  	bool any_progress;
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3191  	int index = 0;
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3192  
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3193  	if (console_suspended)
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3194  		return;
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3195  

:::::: The code at line 3187 was first introduced by commit
:::::: 943b66638a0519612cdc25dcb07f59af89d37407 printk: add infrastucture for atomic consoles

:::::: TO: John Ogness <john.ogness@linutronix.de>
:::::: CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
