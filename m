Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD25487EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiAGWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:01:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:42372 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbiAGWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641592879; x=1673128879;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rey12u7fnJ+uJjG8ZmBzF4KLt/Qem/xYpN4VrQwiSG4=;
  b=FlJytJAGJ7OXACQzb7I71u+mGuJ/zEKHU+1ATKVz/zcw29jvXdKajbFu
   XncTn58YHDO5ZKuXLAGVfbE9yWP4ofp2Bj8aJXgzYnBJzib56MgFMhrJV
   ItG2yOzTDA++KR8XjiGicnH6nndjDty1OYunR2ezNNEVmU5fo2hOAawMi
   DNi2DTAmfUpFK5zS1oZrzbUxAmDxVenBJg96iKaPA2bsM8HGqiTOUQ0kl
   dkK3R1kPHYx6xfDx786+G7zT7A3Piicxz8eYJHGm9huE8RTTnkmfhSG91
   dT0/fh/O/xxdGl5tPVQlEBwbtNhwkaG0Z9CuAuHxT31XWnqZj0jkXwafy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230292079"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="230292079"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:01:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="763963881"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jan 2022 14:01:17 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5xIS-000J53-Oz; Fri, 07 Jan 2022 22:01:16 +0000
Date:   Sat, 8 Jan 2022 06:01:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 41/42] arch/riscv/kvm/aia_aplic.c:254:6:
 warning: variable 'inject' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202201080525.48tKYY5o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   26244433d095c00973559ed0b2b02885997ad4bc
commit: b85cffe2c77bcdbc607e9ac2ba1392c89ded9b51 [41/42] RISC-V: KVM: Add in-kernel emulation of AIA APLIC
config: riscv-randconfig-r033-20220106 (https://download.01.org/0day-ci/archive/20220108/202201080525.48tKYY5o-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ca7ffe09dc6e525109e3cd570cc5182ce568be13)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/b85cffe2c77bcdbc607e9ac2ba1392c89ded9b51
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout b85cffe2c77bcdbc607e9ac2ba1392c89ded9b51
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
