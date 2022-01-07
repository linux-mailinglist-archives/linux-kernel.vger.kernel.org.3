Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518B48734D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiAGHJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:09:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:11492 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbiAGHJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641539385; x=1673075385;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PyHCT8ZFTZQ143GrjnW0x82nS8khVUS+/ejprLVyYrY=;
  b=YgMsU02+ELS1PC9kaxCPRftS6ySRuF2sWX353jwFnL/YJP/79fOOBbCO
   ytg404nSvm10LhV/em3TzWJEeMtD6sZi2nn6Hgj8wCHtrJT70EglGCQGE
   F/lJ/04anZE3mDb4f0dcXzUZ2PximLXfPbk10XA6DSCvi+Q+qlE1Uk/93
   dY3IguIDl8BhXZjnWi0qsbGRFxI4fOCggqSTeHp4jDCeIxN4/OQSa6SWx
   Nyh7q6U26rTfbfnt9zpG04Irsr9+gPiZQY1Ic/gTrOpFy9h5P2rekeg6y
   ihrKXrs9HfSMOzAOFWB5SwonlN+M0+xt/bOuLaeJr0+hIaBeDwHNNDhfS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="230163332"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="230163332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="618611333"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2022 23:09:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5jNf-000IOA-72; Fri, 07 Jan 2022 07:09:43 +0000
Date:   Fri, 7 Jan 2022 15:08:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 51/53]
 kernel/time/tick-sched.c:1455:6: warning: no previous prototype for function
 'tick_setup_sched_timer_dump'
Message-ID: <202201071538.1zOsvPzw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   56b8a9dc5e8aa4d625a09ce87015016ae339d44d
commit: feba9f855e1f9231392df9e7c2ba94e2fe1bc822 [51/53] EXP timers: Debugging for last-resort jiffies update
config: i386-randconfig-r014-20220107 (https://download.01.org/0day-ci/archive/20220107/202201071538.1zOsvPzw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/feba9f855e1f9231392df9e7c2ba94e2fe1bc822
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout feba9f855e1f9231392df9e7c2ba94e2fe1bc822
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ kernel/time/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/time/tick-sched.c:1455:6: warning: no previous prototype for function 'tick_setup_sched_timer_dump' [-Wmissing-prototypes]
   void tick_setup_sched_timer_dump(void)
        ^
   kernel/time/tick-sched.c:1455:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tick_setup_sched_timer_dump(void)
   ^
   static 
   1 warning generated.


vim +/tick_setup_sched_timer_dump +1455 kernel/time/tick-sched.c

  1454	
> 1455	void tick_setup_sched_timer_dump(void)
  1456	{
  1457		int cpu;
  1458		int j = jiffies;
  1459	
  1460		pr_alert("%s state", __func__);
  1461		for_each_possible_cpu(cpu)
  1462			pr_cont(" j/c %x/%d %c",
  1463				(int)(j - per_cpu(tick_setup_sched_timer_jiffies, cpu)) & 0xfff,
  1464				per_cpu(tick_setup_sched_timer_jiffies_count, cpu),
  1465				".H"[per_cpu(tick_setup_sched_timer_help_needed, cpu)]);
  1466		pr_cont("\n");
  1467	}
  1468	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
