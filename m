Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4A50B468
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiDVJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446247AbiDVJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:51:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F80E46645
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650620926; x=1682156926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x1vQFBIsNj2j27ZbIjDt3pno+CqY/0ui3z7PekQzkHc=;
  b=FfJ+B5/zQs7MDWiNuGj5Kfg2UrOVou5bMpeqsA0XgFESrerwDHmbNsmX
   FmH4pifIleONXYwdh9WyLrDs7pwVXQy7b5V8BmxwzJ6R+16dP2Yf+LEYY
   sotkZJlywu6Yi5a6BUzgep3xQnF5it1VZnALYxiRoA77NZkYPHhKQN4/a
   rLxnLEtIO9F/tNvnJu42PdY+duEzAQonAQ17vl1Rmoxqczu3l9VWMGOyn
   LDwILCHw6zf4amGwI0Qc+2Oit2M8od3ABjJ+ugt/ejHl8WGCb0To+kr5e
   7ltoHLNfKbQDPzqtAYnN111Fu5H31Jvz0IVgfaaeXovZvUCsMFdA7DKrn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264409978"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264409978"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="728442232"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2022 02:48:42 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhpu5-0009zr-FJ;
        Fri, 22 Apr 2022 09:48:41 +0000
Date:   Fri, 22 Apr 2022 17:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 17/78]
 kernel/printk/printk.c:3182:13: warning: function 'console_emit_next_record'
 has internal linkage but is not defined
Message-ID: <202204221737.XUqb9giP-lkp@intel.com>
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
config: hexagon-randconfig-r002-20220422 (https://download.01.org/0day-ci/archive/20220422/202204221737.XUqb9giP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=72b5c1227b73b2cde1452cfc58717cff442ed473
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout 72b5c1227b73b2cde1452cfc58717cff442ed473
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/printk/printk.c:3187:7: warning: variable 'any_usable' set but not used [-Wunused-but-set-variable]
           bool any_usable = false;
                ^
>> kernel/printk/printk.c:3182:13: warning: function 'console_emit_next_record' has internal linkage but is not defined [-Wundefined-internal]
   static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
               ^
   kernel/printk/printk.c:3215:16: note: used here
                                   progress = console_emit_next_record(con,
                                              ^
   2 warnings generated.


vim +/console_emit_next_record +3182 kernel/printk/printk.c

fe3d8ad31cf51b kernel/printk.c        Feng Tang   2011-03-22  3180  
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3181  #ifdef CONFIG_HAVE_ATOMIC_CONSOLE
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04 @3182  static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3183  				     char *dropped_text, bool atomic_printing);
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3184  

:::::: The code at line 3182 was first introduced by commit
:::::: 943b66638a0519612cdc25dcb07f59af89d37407 printk: add infrastucture for atomic consoles

:::::: TO: John Ogness <john.ogness@linutronix.de>
:::::: CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
