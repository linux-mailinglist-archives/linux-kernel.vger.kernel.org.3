Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82150AF79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386384AbiDVFUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358641AbiDVFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:20:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016B4F445
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650604667; x=1682140667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X8Cdv3WtSi33le9lETQYCDGkrJO0HOI1XJAdU4PFZM4=;
  b=EavuGvzVDWUb7zZwsbsikSZ2BFUt2pTStfx+HQI4PruELMRKkL7fbQIG
   aOjCq6oGrHujYLDJ+ERlaFohjFU/1AF5luQdDv020BiXOGqsuK1qOOR9j
   p1sFR3zhG6mB2qrM4VtnHupNDGP2oz+5s+oBcWbW72JtrxkbDz+Px7jlC
   a+PIPh65LOcfdwjeTOgCCP2xdaxJe0/SbvVOUXJ+qR2oJhkpTOybNzbd4
   D07+f+J8D9WSvm+1guHOwX7j0RV1+HUTRPx7qPOzxItxxrDmyC7CYV4j8
   FZc/IXoEIrnWLE3s+H2iMywwvtaoOZdnm2Si8urM/l8GlS9Oz6zSZPXXj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289694319"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="289694319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 22:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="671769418"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 22:17:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhlfs-0009GM-Hi;
        Fri, 22 Apr 2022 05:17:44 +0000
Date:   Fri, 22 Apr 2022 13:17:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.18.y-rt-rebase 17/78]
 kernel/printk/printk.c:3182:13: warning: 'console_emit_next_record' used but
 never defined
Message-ID: <202204221324.lemh8k10-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: m68k-randconfig-r021-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221324.lemh8k10-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=72b5c1227b73b2cde1452cfc58717cff442ed473
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.18.y-rt-rebase
        git checkout 72b5c1227b73b2cde1452cfc58717cff442ed473
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/printk/printk.c: In function 'atomic_console_flush_all':
   kernel/printk/printk.c:3187:14: warning: variable 'any_usable' set but not used [-Wunused-but-set-variable]
    3187 |         bool any_usable = false;
         |              ^~~~~~~~~~
   kernel/printk/printk.c: At top level:
>> kernel/printk/printk.c:3182:13: warning: 'console_emit_next_record' used but never defined
    3182 | static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/console_emit_next_record +3182 kernel/printk/printk.c

fe3d8ad31cf51b kernel/printk.c        Feng Tang   2011-03-22  3180  
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04  3181  #ifdef CONFIG_HAVE_ATOMIC_CONSOLE
943b66638a0519 kernel/printk/printk.c John Ogness 2022-02-04 @3182  static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
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

:::::: The code at line 3182 was first introduced by commit
:::::: 943b66638a0519612cdc25dcb07f59af89d37407 printk: add infrastucture for atomic consoles

:::::: TO: John Ogness <john.ogness@linutronix.de>
:::::: CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
