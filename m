Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8B479EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 02:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhLSBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 20:25:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:37465 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhLSBZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 20:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639877110; x=1671413110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0M9MC4Ak8GfscacBHhzDCXtNrQbm72iDPkzmNwlSN0M=;
  b=ZKlPfKBV3PxR9SS56z54p+diXQr6i/mUsxEsMvjq/kql25kn+eo+Et+H
   7v1mooxbEuMJFq9Dq0m2ws3IArTntLrBDoVqLBL6NZqcTF8wejZbch/+D
   SVSERycliIc6pUBICKQ3s8UInlUX/wY7lICKdeqxAhdSeOfcP1gVvUL4n
   4UHSraccZuxgOOENlfFpaLvRowIU4mY31w/tyiP1fqvgTuH6XIx11BOfX
   HnUKVZzIwBtE+B8SxIm2d+TtT11LJgZMgb5pgZ2Spy+YEwbTwmYGJJNuZ
   K46ztukHovReD+KrgOH8jpq4OTF+hTEf6i7F5bbXQxwj+qmh/QEkpLheA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="238710105"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="238710105"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 17:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="466945944"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 17:25:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mykwk-0006bS-NV; Sun, 19 Dec 2021 01:25:06 +0000
Date:   Sun, 19 Dec 2021 09:24:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clocksource: Ingenic: Add SMP/SMT support for
 sysost driver.
Message-ID: <202112190917.6yxHlgI2-lkp@intel.com>
References: <1639756624-46435-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1639756624-46435-4-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "周琰杰,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on robh/for-next v5.16-rc5 next-20211217]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Zhou-Yanjie/Add-SMP-SMT-support-for-Ingenic-sysost-driver/20211217-235813
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a8da61cee95e627ed3d4274861428013aa9604ea
config: sparc-randconfig-s031-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190917.6yxHlgI2-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/3cd1f50718078825e6411751f137406442bb84c0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zhou-Yanjie/Add-SMP-SMT-support-for-Ingenic-sysost-driver/20211217-235813
        git checkout 3cd1f50718078825e6411751f137406442bb84c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/clocksource/ingenic-sysost.c:702:65: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *dev @@     got struct ingenic_ost_timer [noderef] __percpu *timers @@
   drivers/clocksource/ingenic-sysost.c:702:65: sparse:     expected void *dev
   drivers/clocksource/ingenic-sysost.c:702:65: sparse:     got struct ingenic_ost_timer [noderef] __percpu *timers

vim +702 drivers/clocksource/ingenic-sysost.c

   677	
   678	static int __init ingenic_ost_init(struct device_node *np)
   679	{
   680		struct ingenic_ost *ost;
   681		unsigned long rate;
   682		int ret;
   683	
   684		ret = ingenic_ost_probe(np);
   685		if (ret) {
   686			pr_crit("%s: Failed to initialize OST clocks: %d\n", __func__, ret);
   687			return ret;
   688		}
   689	
   690		of_node_clear_flag(np, OF_POPULATED);
   691	
   692		ost = ingenic_ost;
   693		if (IS_ERR(ost))
   694			return PTR_ERR(ost);
   695	
   696		if (ost->soc_info->has_event_timer) {
   697			if (ost->soc_info->version >= ID_X2000)
   698				ret = request_percpu_irq(ost->irq, ingenic_ost_cevt_cb,
   699						  "OST event timer", ost->timers);
   700			else
   701				ret = request_irq(ost->irq, ingenic_ost_cevt_cb, IRQF_TIMER,
 > 702						  "OST event timer", ost->timers);
   703	
   704			if (ret) {
   705				pr_crit("%s: Unable to request IRQ: %d\n", __func__, ret);
   706				goto err_free_ingenic_ost;
   707			}
   708	
   709			/* Setup clock events on each CPU core */
   710			ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "Ingenic XBurst: online",
   711						ingenic_ost_setup_cevt, NULL);
   712			if (ret < 0) {
   713				pr_crit("%s: Unable to init event timers: %d\n", __func__, ret);
   714				goto err_free_ingenic_ost;
   715			}
   716		}
   717	
   718		if (ost->soc_info->has_global_timer) {
   719			ret = ingenic_ost_global_timer_init(np, ost);
   720			if (ret) {
   721				pr_crit("%s: Unable to init global timer: %d\n", __func__, ret);
   722	
   723				if (!ost->soc_info->has_event_timer)
   724					goto err_free_ingenic_ost;
   725			}
   726	
   727			/* Register the sched_clock at the end as there's no way to undo it */
   728			rate = clk_get_rate(ost->global_timer_clk);
   729			sched_clock_register(ingenic_ost_global_timer_read_cntl, 32, rate);
   730		}
   731	
   732		return 0;
   733	
   734	err_free_ingenic_ost:
   735		kfree(ost);
   736		return ret;
   737	}
   738	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
