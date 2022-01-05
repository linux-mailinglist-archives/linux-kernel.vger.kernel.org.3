Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD7484D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiAEE52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:57:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:40527 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236939AbiAEE50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641358646; x=1672894646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6jfPgM03On/Llo66WQJouDAry39E9tkUJeM3sYlFzuc=;
  b=L8TnhJxTL++iFSnedcApVVOokvaY9EDNx2D2k1ywjN9uAFxqAYqZP3Vd
   ZqgVQFr3XI/0a3r17Kks9nwbX6Jc1dnMkcq4hgE7Nq+LUQqtrdI7leGP5
   8MIOewnuyw4VmN8eekWgIGL+6ypO6LLYWhtByiljC39rV6uZYTT21FCW9
   mOqRDPHw+NIo6/8hDBQfFaiLwJNimz8yOnQLmfElC8PxACwNcpJdHyq6b
   l3MN3ORiogmF3wks+XILrpC/zxuYi7BTLhgqWMOAGd7Z4HFHuE3h2YhvH
   ZRrGJUQnQDMZfEzi5nkQPjPk+hIK4h5rs1qEpXtFcMvczm4PzRjQNgqYl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242326295"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242326295"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 20:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="470405625"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 20:57:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4yMW-000GFD-Rt; Wed, 05 Jan 2022 04:57:24 +0000
Date:   Wed, 5 Jan 2022 12:56:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 50/50] nios2-linux-ld:
 softirq.c:undefined reference to `tick_setup_sched_timer_help_needed'
Message-ID: <202201051211.feDzoCuX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   3cda34a0004e965b08daf04fb0f2cee935654e9f
commit: 3cda34a0004e965b08daf04fb0f2cee935654e9f [50/50] EXP timers: Non-nohz_full last-resort jiffies update on IRQ entry
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220105/202201051211.feDzoCuX-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3cda34a0004e965b08daf04fb0f2cee935654e9f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 3cda34a0004e965b08daf04fb0f2cee935654e9f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: kernel/softirq.o: in function `irq_enter_rcu':
   softirq.c:(.text+0x6f8): undefined reference to `tick_setup_sched_timer_help_needed'
>> nios2-linux-ld: softirq.c:(.text+0x700): undefined reference to `tick_setup_sched_timer_help_needed'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
