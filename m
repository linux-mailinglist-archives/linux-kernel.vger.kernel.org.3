Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192652AF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiERAyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiERAyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:54:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01E527F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652835251; x=1684371251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c9ASCWtNl5ff1+M8qK7VVRJgCNKtny+nyyxNn1EA9+g=;
  b=ieiaJaqyYB3Rn4DQXU/sCqGYF87MZJybnXP6hntcT85E8F1etxzsdl2x
   GOrVImEl02l0WteK8QD2Q66QsPEZw+Gq/belo6dYvGH1WNVCcFJOaP6RE
   tqkPN5/bnhszerTjvop7bp9wF+xy/EV8zZ0NS0RqC+LgZ2fBfsLVCz0Fb
   x3ieF45kjzSp9H2IyGkkR5jqS9T3LT+6dXf95R0yivtD8bGPUFkTb2CgB
   DQ9hCP31mhFFlO1li9lzDdt2HhOIUh14xra32hU/5uWJS3IilPSGbZAMs
   9wj7g8B6K/aMpSMujOUc44m+CvvVd4JTBU1cDeKC5IsfRGCtQfMobNnps
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251303304"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251303304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 17:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="742045555"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2022 17:54:09 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr7x3-0001c5-6H;
        Wed, 18 May 2022 00:54:09 +0000
Date:   Wed, 18 May 2022 08:54:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_iommu_dtbind_v1 35/37]
 arch/riscv/kvm/aia_aplic.c:264:6: warning: variable 'inject' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202205180812.fxcKuXBO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_iommu_dtbind_v1
head:   13676549febfed9e7e2a3368008ed2cae53c84a7
commit: 84b7089883b326751f31f50b205663151dd10768 [35/37] RISC-V: KVM: Add in-kernel emulation of AIA APLIC
config: riscv-randconfig-r031-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180812.fxcKuXBO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/84b7089883b326751f31f50b205663151dd10768
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_iommu_dtbind_v1
        git checkout 84b7089883b326751f31f50b205663151dd10768
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/aia_aplic.c:264:6: warning: variable 'inject' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:303:6: note: uninitialized use occurs here
           if (inject)
               ^~~~~~
   arch/riscv/kvm/aia_aplic.c:264:2: note: remove the 'if' if its condition is always false
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:252:13: note: initialize the variable 'inject' to silence this warning
           bool inject, ie;
                      ^
                       = 0
   1 warning generated.


vim +264 arch/riscv/kvm/aia_aplic.c

   248	
   249	int kvm_riscv_aia_aplic_inject(struct kvm *kvm, u32 source, bool level)
   250	{
   251		u32 target;
   252		bool inject, ie;
   253		unsigned long flags;
   254		struct aplic_irq *irqd;
   255		struct aplic *aplic = kvm->arch.aia.aplic_state;
   256	
   257		if (!aplic || !source || (aplic->nr_irqs <= source))
   258			return -ENODEV;
   259		irqd = &aplic->irqs[source];
   260		ie = (aplic->domaincfg & APLIC_DOMAINCFG_IE) ? true : false;
   261	
   262		raw_spin_lock_irqsave(&irqd->lock, flags);
   263	
 > 264		if (irqd->sourcecfg & APLIC_SOURCECFG_D)
   265			goto skip_unlock;
   266	
   267		switch (irqd->sourcecfg & APLIC_SOURCECFG_SM_MASK) {
   268		case APLIC_SOURCECFG_SM_EDGE_RISE:
   269			if (level && !(irqd->state & APLIC_IRQ_STATE_INPUT) &&
   270			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   271				irqd->state |= APLIC_IRQ_STATE_PENDING;
   272			break;
   273		case APLIC_SOURCECFG_SM_EDGE_FALL:
   274			if (!level && (irqd->state & APLIC_IRQ_STATE_INPUT) &&
   275			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   276				irqd->state |= APLIC_IRQ_STATE_PENDING;
   277			break;
   278		case APLIC_SOURCECFG_SM_LEVEL_HIGH:
   279			if (level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   280				irqd->state |= APLIC_IRQ_STATE_PENDING;
   281			break;
   282		case APLIC_SOURCECFG_SM_LEVEL_LOW:
   283			if (!level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   284				irqd->state |= APLIC_IRQ_STATE_PENDING;
   285			break;
   286		}
   287	
   288		if (level)
   289			irqd->state |= APLIC_IRQ_STATE_INPUT;
   290		else
   291			irqd->state &= ~APLIC_IRQ_STATE_INPUT;
   292	
   293		inject = false;
   294		target = irqd->target;
   295		if (ie && (irqd->state & APLIC_IRQ_STATE_ENPEND)) {
   296			irqd->state &= ~APLIC_IRQ_STATE_PENDING;
   297			inject = true;
   298		}
   299	
   300	skip_unlock:
   301		raw_spin_unlock_irqrestore(&irqd->lock, flags);
   302	
   303		if (inject)
   304			aplic_inject_msi(kvm, source, target);
   305	
   306		return 0;
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
