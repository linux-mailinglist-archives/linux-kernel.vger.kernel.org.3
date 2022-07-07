Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3256AA50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiGGSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiGGSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:17:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421792A963
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657217819; x=1688753819;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TmlbkCbQTy7/XjAJEoM00FVskphBJaFTjB+AyigPYp8=;
  b=FAhFiqD7B6QDui7+OsBTql9XrR5y1zNl6WpaBcqsNLO29RoNBaR6B+f6
   rqGUcF2j5hs+G0URiF9CV8Hf0K3vFwYcWznNs1OI4HCk+7OVP+ALviODa
   LSdaRlEB/fk23vr2hKUM/WZIMfOVD39leyiExu0q8CFnwJ1PDQtPFKkgb
   8cvorVaWL5E10jDuo/MMjdQ2amyKuRPZOj4JM6i2W3rwnwzReZaE25Loq
   AWOxEVw/kOZ3zv9c6vyi27Lqo0AbTiEA+3k9L6EQzvjNsAOvWJeFUsMQk
   klTELyL+UfcDZsmwgSv1u+ETW7Enzo+dYNkYgji/K0xMtmOiYdn3iag2u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="345779488"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="345779488"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 11:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="683395001"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2022 11:16:56 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9W3b-000MIQ-KX;
        Thu, 07 Jul 2022 18:16:55 +0000
Date:   Fri, 8 Jul 2022 02:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/powerpc/platforms/52xx/mpc52xx_gpt.c:97: warning: expecting
 prototype for struct mpc52xx_gpt. Prototype was for struct mpc52xx_gpt_priv
 instead
Message-ID: <202207080223.SK41EJ5h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: 015d98149b326e0f1f02e44413112ca8b4330543 powerpc/barrier: Avoid collision with clang's __lwsync macro
date:   1 year, 1 month ago
config: powerpc-randconfig-r001-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080223.SK41EJ5h-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=015d98149b326e0f1f02e44413112ca8b4330543
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 015d98149b326e0f1f02e44413112ca8b4330543
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/52xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:97: warning: expecting prototype for struct mpc52xx_gpt. Prototype was for struct mpc52xx_gpt_priv instead


vim +97 arch/powerpc/platforms/52xx/mpc52xx_gpt.c

5496eab2434f2a2 Grant Likely     2009-02-04  73  
5496eab2434f2a2 Grant Likely     2009-02-04  74  /**
5496eab2434f2a2 Grant Likely     2009-02-04  75   * struct mpc52xx_gpt - Private data structure for MPC52xx GPT driver
5496eab2434f2a2 Grant Likely     2009-02-04  76   * @dev: pointer to device structure
5496eab2434f2a2 Grant Likely     2009-02-04  77   * @regs: virtual address of GPT registers
5496eab2434f2a2 Grant Likely     2009-02-04  78   * @lock: spinlock to coordinate between different functions.
a19e3da5bc5fc6c Anton Vorontsov  2010-06-08  79   * @gc: gpio_chip instance structure; used when GPIO is enabled
bae1d8f19983fbf Grant Likely     2012-02-14  80   * @irqhost: Pointer to irq_domain instance; used when IRQ mode is supported
eda43d16ef3d0bd Albrecht Dreﬂ    2009-11-13  81   * @wdt_mode: only relevant for gpt0: bit 0 (MPC52xx_GPT_CAN_WDT) indicates
eda43d16ef3d0bd Albrecht Dreﬂ    2009-11-13  82   *   if the gpt may be used as wdt, bit 1 (MPC52xx_GPT_IS_WDT) indicates
eda43d16ef3d0bd Albrecht Dreﬂ    2009-11-13  83   *   if the timer is actively used as wdt which blocks gpt functions
5496eab2434f2a2 Grant Likely     2009-02-04  84   */
5496eab2434f2a2 Grant Likely     2009-02-04  85  struct mpc52xx_gpt_priv {
4f59ecfa9b87da0 Grant Likely     2009-11-04  86  	struct list_head list;		/* List of all GPT devices */
5496eab2434f2a2 Grant Likely     2009-02-04  87  	struct device *dev;
5496eab2434f2a2 Grant Likely     2009-02-04  88  	struct mpc52xx_gpt __iomem *regs;
77720c82915a8b7 Julia Cartwright 2017-03-21  89  	raw_spinlock_t lock;
bae1d8f19983fbf Grant Likely     2012-02-14  90  	struct irq_domain *irqhost;
4f59ecfa9b87da0 Grant Likely     2009-11-04  91  	u32 ipb_freq;
eda43d16ef3d0bd Albrecht Dreﬂ    2009-11-13  92  	u8 wdt_mode;
5496eab2434f2a2 Grant Likely     2009-02-04  93  
5496eab2434f2a2 Grant Likely     2009-02-04  94  #if defined(CONFIG_GPIOLIB)
a19e3da5bc5fc6c Anton Vorontsov  2010-06-08  95  	struct gpio_chip gc;
5496eab2434f2a2 Grant Likely     2009-02-04  96  #endif
5496eab2434f2a2 Grant Likely     2009-02-04 @97  };
5496eab2434f2a2 Grant Likely     2009-02-04  98  

:::::: The code at line 97 was first introduced by commit
:::::: 5496eab2434f2a2dfe0d35496fd9605d548b7fbc powerpc/5200: Rework GPT driver to also be an IRQ controller

:::::: TO: Grant Likely <grant.likely@secretlab.ca>
:::::: CC: Grant Likely <grant.likely@secretlab.ca>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
