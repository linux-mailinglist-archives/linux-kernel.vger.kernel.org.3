Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE53A490302
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbiAQHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:38:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:61042 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237596AbiAQHin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642405123; x=1673941123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fMSUlL6VTDJ09rj4Ax0FCoS+F/i5R5IUB6nWBoPCOns=;
  b=Q/h7Joq5lZEo7mmtSlSjaMy7aQ0UFJpjSCuc5OeX0fu83OutYEm8O775
   PR+o58Lim38Xqjs6REo55UU2p6S0Eu/9eP9JuhIXwRCW0UXuzlb/7tXQf
   IT6Inx7CMKeyZUn542bIwAZqnyx4q4cqsd6hY53Mz5zHf/6U2jMj0evds
   KUawtSG8p7QZb/+wzfPJW9bIQLunOms0wr+QPOhMsQOzbEwCtWX2QemkS
   LdMLg9lVssmIKdqw+hFjehLBxUZqGtQWIHakszLCkI+eWSF/d7jd+cZIc
   /Ou9EFvWX7zwHh6Gixn2qOwZ72/9GQio0+etRY8PzDiuKcdXeOryY0RwC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244528625"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="244528625"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 23:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="614969277"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2022 23:38:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Maw-000BM4-9T; Mon, 17 Jan 2022 07:38:26 +0000
Date:   Mon, 17 Jan 2022 15:38:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sander Vanheule <sander@svanheule.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: Re: [PATCH 2/2] clocksource/drivers: Add Realtek Otto timer driver
Message-ID: <202201171557.EmiIHtdJ-lkp@intel.com>
References: <2fb4aa29e8c581f5c7e97ab7678ccb34e99e5c6e.1642369117.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb4aa29e8c581f5c7e97ab7678ccb34e99e5c6e.1642369117.git.sander@svanheule.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sander,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220116]
[cannot apply to tip/timers/core linux/master linus/master daniel-lezcano/clockevents/next v5.16 v5.16-rc8 v5.16-rc7 v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sander-Vanheule/Realtek-Otto-timer-counter-support/20220117-054003
base:    70e6f1b39929bf6755a9c55b79fe720f7c8b9436
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220117/202201171557.EmiIHtdJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1c346209c6655c06ab28df22f821ffa06a792a14
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sander-Vanheule/Realtek-Otto-timer-counter-support/20220117-054003
        git checkout 1c346209c6655c06ab28df22f821ffa06a792a14
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-realtek-otto.c: In function 'otto_tc_init':
>> drivers/clocksource/timer-realtek-otto.c:182:16: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
     182 |         ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
         |                ^~~~~~~
         |                d_alloc
   drivers/clocksource/timer-realtek-otto.c:182:14: warning: assignment to 'struct otto_tc_ctrl *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     182 |         ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
         |              ^
>> drivers/clocksource/timer-realtek-otto.c:212:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
     212 |         kfree(ctrl);
         |         ^~~~~
   cc1: some warnings being treated as errors


vim +182 drivers/clocksource/timer-realtek-otto.c

   176	
   177	static int __init otto_tc_init(struct device_node *node)
   178	{
   179		struct otto_tc_ctrl *ctrl;
   180		int err;
   181	
 > 182		ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
   183		if (!ctrl)
   184			return -ENOMEM;
   185	
   186		spin_lock_init(&ctrl->lock);
   187	
   188		ctrl->to.flags = TIMER_OF_BASE | TIMER_OF_IRQ | TIMER_OF_CLOCK;
   189		ctrl->to.of_clk.name = "bus";
   190		ctrl->to.of_irq.flags = IRQF_TIMER;
   191		ctrl->to.of_irq.handler = otto_tc_handler;
   192	
   193		err = timer_of_init(node, &ctrl->to);
   194		if (err)
   195			goto err_out;
   196	
   197		/* Reset timer state */
   198		writel(0, OTTO_TC_REG_CTL(&ctrl->to));
   199		writel(0, OTTO_TC_REG_DATA(&ctrl->to));
   200	
   201		/* TODO Replace by a real derived clock */
   202		otto_tc_set_divisor(ctrl, OTTO_TC_MIN_DIVISOR);
   203		ctrl->to.of_clk.rate /= OTTO_TC_MIN_DIVISOR;
   204		ctrl->to.of_clk.period /= OTTO_TC_MIN_DIVISOR;
   205	
   206		otto_tc_irq_enable_clear(&ctrl->to);
   207		otto_tc_init_clkevt(&ctrl->to);
   208	
   209		return 0;
   210	
   211	err_out:
 > 212		kfree(ctrl);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
