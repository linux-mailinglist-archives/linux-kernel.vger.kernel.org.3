Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CDC4820DB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 00:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbhL3Xal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 18:30:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:16468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240325AbhL3Xak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640907040; x=1672443040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9mWJhtnYDv9wzR8iH+0I7VO7AYuo6/tNvy1hPcmjmck=;
  b=Jbb37O9p1hXXMyOWqjZN3jOP8DWANHjkMhV9615iAWhQiQLW0+wC/bxn
   FwelD3MzGHjTOxXVC0fTBdYzJlDeuGHAiMJyPTGYzd8lHE0TuRi1RF4Nd
   EtQGPifmdiiWVuTtF4Ty8CJ3FoSfTwrHTzGt0RQeeWew8Wu8thGxJGT1k
   n1RYYE2KfpeQnUC5ZBEWxrYfaWJVreCW2sl5UMK/dDkW+zLbBRMT4bkCD
   3xREIQeOLDO5AEFW8G4RsEq41sdNJkPqmSvPKSk2UM7Pyf4HEKWxMP3Nx
   NsCO7JHSXb6Oir6vemm4sA+k3xfTUZfUkWI/IRhblRB9OsJz3lwOd7Fe/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="228569601"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="228569601"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 15:30:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="524550333"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Dec 2021 15:30:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n34sW-000Ako-5c; Thu, 30 Dec 2021 23:30:36 +0000
Date:   Fri, 31 Dec 2021 07:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 41/42] arch/riscv/kvm/aia_aplic.c:254:6:
 warning: variable 'inject' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202112310702.5K1jsmj4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   39b04982423339e2b116ac84de98458b8cb7c4d4
commit: ac2d0396c236254b8f364b738d983d754ba1bbe5 [41/42] RISC-V: KVM: Add in-kernel emulation of AIA APLIC
config: riscv-randconfig-r035-20211230 (https://download.01.org/0day-ci/archive/20211231/202112310702.5K1jsmj4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/ac2d0396c236254b8f364b738d983d754ba1bbe5
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout ac2d0396c236254b8f364b738d983d754ba1bbe5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/aia_aplic.c:254:6: warning: variable 'inject' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:293:6: note: uninitialized use occurs here
           if (inject)
               ^~~~~~
   arch/riscv/kvm/aia_aplic.c:254:2: note: remove the 'if' if its condition is always false
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:242:13: note: initialize the variable 'inject' to silence this warning
           bool inject, ie;
                      ^
                       = 0
   1 warning generated.


vim +254 arch/riscv/kvm/aia_aplic.c

   238	
   239	int kvm_riscv_aia_aplic_inject(struct kvm *kvm, u32 source, bool level)
   240	{
   241		u32 target;
   242		bool inject, ie;
   243		unsigned long flags;
   244		struct aplic_irq *irqd;
   245		struct aplic *aplic = kvm->arch.aia.aplic_state;
   246	
   247		if (!aplic || !source || (aplic->nr_irqs <= source))
   248			return -ENODEV;
   249		irqd = &aplic->irqs[source];
   250		ie = (aplic->domaincfg & APLIC_DOMAINCFG_IE) ? true : false;
   251	
   252		raw_spin_lock_irqsave(&irqd->lock, flags);
   253	
 > 254		if (irqd->sourcecfg & APLIC_SOURCECFG_D)
   255			goto skip_unlock;
   256	
   257		switch (irqd->sourcecfg & APLIC_SOURCECFG_SM_MASK) {
   258		case APLIC_SOURCECFG_SM_EDGE_RISE:
   259			if (level && !(irqd->state & APLIC_IRQ_STATE_INPUT) &&
   260			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   261				irqd->state |= APLIC_IRQ_STATE_PENDING;
   262			break;
   263		case APLIC_SOURCECFG_SM_EDGE_FALL:
   264			if (!level && (irqd->state & APLIC_IRQ_STATE_INPUT) &&
   265			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   266				irqd->state |= APLIC_IRQ_STATE_PENDING;
   267			break;
   268		case APLIC_SOURCECFG_SM_LEVEL_HIGH:
   269			if (level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   270				irqd->state |= APLIC_IRQ_STATE_PENDING;
   271			break;
   272		case APLIC_SOURCECFG_SM_LEVEL_LOW:
   273			if (!level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   274				irqd->state |= APLIC_IRQ_STATE_PENDING;
   275			break;
   276		}
   277	
   278		if (level)
   279			irqd->state |= APLIC_IRQ_STATE_INPUT;
   280		else
   281			irqd->state &= ~APLIC_IRQ_STATE_INPUT;
   282	
   283		inject = false;
   284		target = irqd->target;
   285		if (ie && (irqd->state & APLIC_IRQ_STATE_ENPEND)) {
   286			irqd->state &= ~APLIC_IRQ_STATE_PENDING;
   287			inject = true;
   288		}
   289	
   290	skip_unlock:
   291		raw_spin_unlock_irqrestore(&irqd->lock, flags);
   292	
   293		if (inject)
   294			aplic_inject_msi(kvm, source, target);
   295	
   296		return 0;
   297	}
   298	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
