Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD0496909
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiAVBDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:03:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:24982 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbiAVBDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642813392; x=1674349392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p6CtIuYmB9Knh+YaUvh8oW7TYmjlpEYCbWhZuupQWhI=;
  b=GWlzAl3tKgjOyHQoWURqW+003bFHIDmt7ptlcuQwOl5ZWk5FZtiWZhHg
   0ANxtJMP4Va7PfGenAPj9uTWukOY3mmpfcvNyuvAQFy0ljDDefNl7/tzr
   vClZ2bbZz1+ppfcFHvP4F/jknYJESLfN14Q4XZHyLE5vju9iCPBx9CpRe
   k3/rHyWYSjVTG2CE0lHdeYN8N9MscZHBYaB9HmjJ/h77oWPpBCrUdeUb+
   HWiBJp4LFUuXmUcTFSoYGGf5hQQ04V+G/oM/m6lh83N5kezNV4wOAen7u
   Y7Xk55VXug/kSxBBdtid4haxpIV6f4IEchJj71cmr5TjUPwFzTzGDhHoT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244597661"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="244597661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 17:03:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="562059812"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2022 17:03:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB4oA-000Fpz-3V; Sat, 22 Jan 2022 01:03:10 +0000
Date:   Sat, 22 Jan 2022 09:03:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.16.y-rt-rebase 16/132]
 kernel/printk/printk.c:2979:7: warning: variable 'any_usable' set but not
 used
Message-ID: <202201220837.EAj9Nrqa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt-rebase
head:   1722f531f5244c70dcd9687c40729860bb254e8d
commit: e1fd5438186d729df636919574f08231f7ecdd1d [16/132] serial: 8250: implement write_atomic
config: arm-randconfig-r016-20220121 (https://download.01.org/0day-ci/archive/20220122/202201220837.EAj9Nrqa-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=e1fd5438186d729df636919574f08231f7ecdd1d
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.16.y-rt-rebase
        git checkout e1fd5438186d729df636919574f08231f7ecdd1d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/printk/printk.c:2979:7: warning: variable 'any_usable' set but not used [-Wunused-but-set-variable]
           bool any_usable = false;
                ^
   1 warning generated.


vim +/any_usable +2979 kernel/printk/printk.c

fe3d8ad31cf51b kernel/printk.c        Feng Tang   2011-03-22  2975  
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2976  #ifdef CONFIG_HAVE_ATOMIC_CONSOLE
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2977  static void atomic_console_flush_all(void)
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2978  {
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22 @2979  	bool any_usable = false;
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2980  	unsigned long flags;
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2981  	struct console *con;
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2982  	bool any_progress;
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2983  	int index = 0;
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2984  
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2985  	if (console_suspended)
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2986  		return;
02489ebe320634 kernel/printk/printk.c John Ogness 2021-12-22  2987  

:::::: The code at line 2979 was first introduced by commit
:::::: 02489ebe320634155c5ddb3110d7d456fa68d304 printk: add infrastucture for atomic consoles

:::::: TO: John Ogness <john.ogness@linutronix.de>
:::::: CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
