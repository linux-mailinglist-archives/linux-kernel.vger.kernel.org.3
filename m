Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2348FFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiAQB3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:29:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:56421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbiAQB3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642382962; x=1673918962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dX2c9IoRnDpnBIwBy5qcsqKPfKwk8mV/7Bz72MXQzI0=;
  b=BIReFoHwFwUCasbnj1uq7uBJ9w2vLrtR/TbWCkq2a2nPtbXcppw6h/dB
   O6Sywr/f8/amR2oTVue8SkzQmXxG+oUAehzMQX7HUovaEY8TSWz39E82y
   jHSSQoY0R4FGYna1N9+5zuITt81GtxtOpWmdjH/TwJEcKR4OK9/URzopL
   9EsO0thEnnWkzLZl5D1NVuQWiK7nCPGoXj4N6v0J7vODwDtTvHzkMKmxt
   MU1NMDaWanKVreeGn5RqXrXpnDgGJ5PSALHPT0zEcXQKxRGx4i+t4XeT5
   IsxIzQdiUB08XOMt5GBSxAEzDQ1UFseWZ4SZgw+0deiA/Hf5TEaZx8zBk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="307871930"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="307871930"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 17:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="692899832"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 17:29:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Gpj-000B88-5l; Mon, 17 Jan 2022 01:29:19 +0000
Date:   Mon, 17 Jan 2022 09:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sander Vanheule <sander@svanheule.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: Re: [PATCH 2/2] clocksource/drivers: Add Realtek Otto timer driver
Message-ID: <202201170911.q3u7GptA-lkp@intel.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220116]
[cannot apply to tip/timers/core linux/master linus/master daniel-lezcano/clockevents/next v5.16 v5.16-rc8 v5.16-rc7 v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sander-Vanheule/Realtek-Otto-timer-counter-support/20220117-054003
base:    70e6f1b39929bf6755a9c55b79fe720f7c8b9436
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220117/202201170911.q3u7GptA-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-realtek-otto.c: In function 'otto_tc_init':
   drivers/clocksource/timer-realtek-otto.c:182:16: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
     182 |         ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
         |                ^~~~~~~
         |                d_alloc
>> drivers/clocksource/timer-realtek-otto.c:182:14: warning: assignment to 'struct otto_tc_ctrl *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     182 |         ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
         |              ^
   drivers/clocksource/timer-realtek-otto.c:212:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
