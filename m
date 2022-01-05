Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19030484D2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiAEEr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:47:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:51447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237365AbiAEEr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641358046; x=1672894046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ET9Y4rAZp8RGHPOdgSlDZDjUb0Q2+X3cJR3TKlSabs=;
  b=jdeu82cmdytOYYvcEbDNmgKMUOJQlzmQwLCts6wcljV7vne3lIvk94sZ
   5Cv2I1MuXTZLtIWz4rGUCKDbfXNn/ivXvIbjQUiFdvkrPQs5GCFPtmKJ1
   aE8C7Z3acuPWBkukBScRXAp7MOW319Id1d/iFNf43BZ/Fa3RLSECKTTQC
   h/1jlx9JcCDumQosPNkMHZMdLuK6bf8gUJpOCxg8aoYGARg3wo9y6KdD4
   zmq9eQD5bmOhQJVs4tEtLi7qJUNxh5Lx4qB1UJO0ZrAPuAo4UYU75FjqD
   R8cUkSENnLirQo1tVJV8CmCo4rG+6H0OFj4VBoTEjrIVN9z5cNjsMrYRx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242574354"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242574354"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 20:47:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="512793161"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2022 20:47:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4yCq-000GEO-Ha; Wed, 05 Jan 2022 04:47:24 +0000
Date:   Wed, 5 Jan 2022 12:46:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 50/50] softirq.c:undefined
 reference to `tick_setup_sched_timer_help_needed'
Message-ID: <202201051240.Gr2DTU3J-lkp@intel.com>
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
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20220105/202201051240.Gr2DTU3J-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3cda34a0004e965b08daf04fb0f2cee935654e9f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 3cda34a0004e965b08daf04fb0f2cee935654e9f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: kernel/softirq.o: in function `irq_enter_rcu':
>> softirq.c:(.text+0x39a): undefined reference to `tick_setup_sched_timer_help_needed'
>> nds32le-linux-ld: softirq.c:(.text+0x39e): undefined reference to `tick_setup_sched_timer_help_needed'
   nds32le-linux-ld: kernel/softirq.o: in function `irq_enter':
   softirq.c:(.text+0x3ca): undefined reference to `tick_setup_sched_timer_help_needed'
   nds32le-linux-ld: softirq.c:(.text+0x3ce): undefined reference to `tick_setup_sched_timer_help_needed'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
