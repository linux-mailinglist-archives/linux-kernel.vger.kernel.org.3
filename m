Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAF4A344D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 06:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiA3FdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 00:33:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:20891 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235695AbiA3FdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 00:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643520802; x=1675056802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nFtjbMYQUJKLsc2kTCy7pstMArinbqOSpq480PNgxbY=;
  b=ckbscICaCsw4x0QaodJgMDstkRRvD0awq3LaZ87DTNLXbVc/KADeNG9K
   h0czZaVTFFsaeRDE/8ZmX7a8ob2+pzY8bcG7rzjXs4nGc6I4trb2BXcTG
   AMSNCHfLaARse/7nMhjFByrcsfavVEGFh6i8biO9xkMKUUZDDDcmjQ5+D
   gHBMZyNHdI8X5HUEbrfQrKKD1A3YtHqQWWuFAtiFEpmtOnLpnufo7qmYA
   z9U+KfHFcv1Z3Xml65NqeW+Xr/oqxkVGvic778ORmKSyvYLfXke6wG847
   vzdpOIWaYZxvIIVhPkrlORM0Az3QvETUSDgi5qMnRXc/UMVZ/COvJg96a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="244916661"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="244916661"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 21:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="478693980"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2022 21:33:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE2pz-000Q5o-R4; Sun, 30 Jan 2022 05:33:19 +0000
Date:   Sun, 30 Jan 2022 13:33:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 28/29] arch/riscv/kvm/aia_aplic.c:264:6:
 warning: variable 'inject' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202201301340.5ZMPdDsQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   2aca1bad96b476d6e8043db556d43de866e527ff
commit: 1c3226c0cd04a531ee9141bffa933f844c717191 [28/29] RISC-V: KVM: Add in-kernel emulation of AIA APLIC
config: riscv-randconfig-r036-20220130 (https://download.01.org/0day-ci/archive/20220130/202201301340.5ZMPdDsQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/1c3226c0cd04a531ee9141bffa933f844c717191
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 1c3226c0cd04a531ee9141bffa933f844c717191
        # save the config file to linux build tree
        mkdir build_dir
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
