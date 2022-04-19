Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C750620A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbiDSC06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiDSC04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:26:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4F2C120
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650335055; x=1681871055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sg0GUnHw6JWHcaByo8mJxsaDyhurBYJrDE+tM61ItNU=;
  b=QPu1aqeB78zOxGz1+Nc9Fa73JEkwyAlpsMWdVMFpXBuPB67NTDSLR09d
   i/MsvfwQ1LaRpJOt4ZyYHw6K7Nv9xEOeeeH9p7rqv6ojE4K8y44FOb66u
   hkOQ0FEsGzLk3GXV6FYMoLbooOQx7AWnQQkODrMwBZh2TGPKyfunRfO+m
   hcMUM8g0DbcjI0RgvVIPIkAP6tbx5agyQEy4+xYXvUUnMNSmu0lMDAe7O
   JL/7pI08rOyLktRyMhY91XsLczuidivqaEQL9mPnBGiWdeu74pt30sFXL
   npsVWWWvJ8lb+KpFPiDlA9Yr5FTQ64T1fNe7PyO/ON5ucWBqgCInfPzNi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350105245"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350105245"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="625496035"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Apr 2022 19:24:14 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngdXJ-0005D4-E8;
        Tue, 19 Apr 2022 02:24:13 +0000
Date:   Tue, 19 Apr 2022 10:23:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2061/2356]
 drivers/pinctrl/pinctrl-microchip-sgpio.c:656:39: warning: variable 'flags'
 is uninitialized when used here
Message-ID: <202204191041.XKFMSrNr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: abac2ae0fd81750ce0835c0637b6b7fff7c2316a [2061/2356] headers/deps: irq: Optimize <linux/irq.h> dependencies
config: i386-randconfig-a012-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191041.XKFMSrNr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=abac2ae0fd81750ce0835c0637b6b7fff7c2316a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout abac2ae0fd81750ce0835c0637b6b7fff7c2316a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/panel/ drivers/hwmon/ drivers/iio/afe/ drivers/iio/proximity/ drivers/input/touchscreen/ drivers/mtd/nand/ drivers/phy/cadence/ drivers/pinctrl/ drivers/platform/chrome/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-microchip-sgpio.c:656:2: error: implicit declaration of function 'spin_lock_irqsave' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           spin_lock_irqsave(&bank->priv->lock, flags);
           ^
   drivers/pinctrl/pinctrl-microchip-sgpio.c:675:2: error: implicit declaration of function 'spin_unlock_irqrestore' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           spin_unlock_irqrestore(&bank->priv->lock, flags);
           ^
   drivers/pinctrl/pinctrl-microchip-sgpio.c:675:2: note: did you mean 'spin_lock_irqsave'?
   drivers/pinctrl/pinctrl-microchip-sgpio.c:656:2: note: 'spin_lock_irqsave' declared here
           spin_lock_irqsave(&bank->priv->lock, flags);
           ^
>> drivers/pinctrl/pinctrl-microchip-sgpio.c:656:39: warning: variable 'flags' is uninitialized when used here [-Wuninitialized]
           spin_lock_irqsave(&bank->priv->lock, flags);
                                                ^~~~~
   drivers/pinctrl/pinctrl-microchip-sgpio.c:651:21: note: initialize the variable 'flags' to silence this warning
           unsigned long flags;
                              ^
                               = 0
   1 warning and 2 errors generated.


vim +/flags +656 drivers/pinctrl/pinctrl-microchip-sgpio.c

7e5ea974e61c8d Lars Povlsen  2020-11-13  642  
be2dc859abd4d7 Lars Povlsen  2020-12-09  643  static void microchip_sgpio_irq_settype(struct irq_data *data,
be2dc859abd4d7 Lars Povlsen  2020-12-09  644  					int type,
be2dc859abd4d7 Lars Povlsen  2020-12-09  645  					int polarity)
be2dc859abd4d7 Lars Povlsen  2020-12-09  646  {
be2dc859abd4d7 Lars Povlsen  2020-12-09  647  	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
be2dc859abd4d7 Lars Povlsen  2020-12-09  648  	struct sgpio_bank *bank = gpiochip_get_data(chip);
be2dc859abd4d7 Lars Povlsen  2020-12-09  649  	unsigned int gpio = irqd_to_hwirq(data);
be2dc859abd4d7 Lars Povlsen  2020-12-09  650  	struct sgpio_port_addr addr;
7996c5f5ec7a20 Michael Walle 2022-02-26  651  	unsigned long flags;
be2dc859abd4d7 Lars Povlsen  2020-12-09  652  	u32 ena;
be2dc859abd4d7 Lars Povlsen  2020-12-09  653  
be2dc859abd4d7 Lars Povlsen  2020-12-09  654  	sgpio_pin_to_addr(bank->priv, gpio, &addr);
be2dc859abd4d7 Lars Povlsen  2020-12-09  655  
7996c5f5ec7a20 Michael Walle 2022-02-26 @656  	spin_lock_irqsave(&bank->priv->lock, flags);
7996c5f5ec7a20 Michael Walle 2022-02-26  657  
be2dc859abd4d7 Lars Povlsen  2020-12-09  658  	/* Disable interrupt while changing type */
be2dc859abd4d7 Lars Povlsen  2020-12-09  659  	ena = sgpio_readl(bank->priv, REG_INT_ENABLE, addr.bit);
be2dc859abd4d7 Lars Povlsen  2020-12-09  660  	sgpio_writel(bank->priv, ena & ~BIT(addr.port), REG_INT_ENABLE, addr.bit);
be2dc859abd4d7 Lars Povlsen  2020-12-09  661  
be2dc859abd4d7 Lars Povlsen  2020-12-09  662  	/* Type value spread over 2 registers sets: low, high bit */
be2dc859abd4d7 Lars Povlsen  2020-12-09  663  	sgpio_clrsetbits(bank->priv, REG_INT_TRIGGER, addr.bit,
be2dc859abd4d7 Lars Povlsen  2020-12-09  664  			 BIT(addr.port), (!!(type & 0x1)) << addr.port);
5d5f2919273d10 Lars Povlsen  2021-02-03  665  	sgpio_clrsetbits(bank->priv, REG_INT_TRIGGER, SGPIO_MAX_BITS + addr.bit,
be2dc859abd4d7 Lars Povlsen  2020-12-09  666  			 BIT(addr.port), (!!(type & 0x2)) << addr.port);
be2dc859abd4d7 Lars Povlsen  2020-12-09  667  
be2dc859abd4d7 Lars Povlsen  2020-12-09  668  	if (type == SGPIO_INT_TRG_LEVEL)
be2dc859abd4d7 Lars Povlsen  2020-12-09  669  		sgpio_clrsetbits(bank->priv, REG_INT_POLARITY, addr.bit,
be2dc859abd4d7 Lars Povlsen  2020-12-09  670  				 BIT(addr.port), polarity << addr.port);
be2dc859abd4d7 Lars Povlsen  2020-12-09  671  
be2dc859abd4d7 Lars Povlsen  2020-12-09  672  	/* Possibly re-enable interrupts */
be2dc859abd4d7 Lars Povlsen  2020-12-09  673  	sgpio_writel(bank->priv, ena, REG_INT_ENABLE, addr.bit);
7996c5f5ec7a20 Michael Walle 2022-02-26  674  
7996c5f5ec7a20 Michael Walle 2022-02-26 @675  	spin_unlock_irqrestore(&bank->priv->lock, flags);
be2dc859abd4d7 Lars Povlsen  2020-12-09  676  }
be2dc859abd4d7 Lars Povlsen  2020-12-09  677  

:::::: The code at line 656 was first introduced by commit
:::::: 7996c5f5ec7a20b3f6b8fae93fcf3cb8f1c01743 pinctrl: microchip-sgpio: lock RMW access

:::::: TO: Michael Walle <michael@walle.cc>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
