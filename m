Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2E49D473
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiAZV0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:26:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:24601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbiAZV0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643232379; x=1674768379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UdJvBisU+9yOZRdMDlJTLDdoLRql/qKmBXw8lYNqUCM=;
  b=j0ewN/dmO2aBpH5fiE8ndflbi6Q+g77tYN/EEt1RHrCdhznlZ/Gl6rNy
   fKVxGEJnjEVvwg1K4aU3Ykru0wdMF+aAJGcCeX0rwLZmVvV4fjB0++8Hy
   0EyWPNP0nhMSEU0oxxfSFKmrzThqns+nV0ogl2ZAEopBJTj2Oap31YSYV
   ycTQc5A5jwToCVi3ZEc7G9xUUgV8kZRYRBJxq2poIWYVqzdAId5TQy4Fu
   iI362vdiNJhGjl0NKd3HXdpE5uqe3xKIbPyE40lVjFYh6IuEQmFdKuig2
   ByvUCmh7g/K2n2Yfdeq6J4qYPNEmWbB7PoKiD0q3MjGDyE+LCT7GdQCBi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230228594"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="230228594"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 13:26:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="628437237"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 13:26:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCpo1-000Lg1-Bd; Wed, 26 Jan 2022 21:26:17 +0000
Date:   Thu, 27 Jan 2022 05:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 70/137]
 include/linux/irqchip/arm-vgic-info.h:13: Error: bad instruction `enum
 gic_type {'
Message-ID: <202201270538.QiKLpMYv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: faf6ce00f9b35ca0a0389a2d66d90214d3c62f34 [70/137] irqchip/gic: Collect GIC_IRQ_TYPE definitions into one place
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201270538.QiKLpMYv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=faf6ce00f9b35ca0a0389a2d66d90214d3c62f34
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout faf6ce00f9b35ca0a0389a2d66d90214d3c62f34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/irqchip/arm-vgic-info.h: Assembler messages:
>> include/linux/irqchip/arm-vgic-info.h:13: Error: bad instruction `enum gic_type {'
>> include/linux/irqchip/arm-vgic-info.h:15: Error: bad instruction `gic_v2,'
>> include/linux/irqchip/arm-vgic-info.h:17: Error: bad instruction `gic_v3,'
>> include/linux/irqchip/arm-vgic-info.h:18: Error: junk at end of line, first unrecognized character is `}'
>> include/linux/irqchip/arm-vgic-info.h:20: Error: bad instruction `struct gic_kvm_info {'
>> include/linux/irqchip/arm-vgic-info.h:22: Error: bad instruction `enum gic_type type'
>> include/linux/irqchip/arm-vgic-info.h:24: Error: bad instruction `struct resource vcpu'
>> include/linux/irqchip/arm-vgic-info.h:26: Error: bad instruction `unsigned int maint_irq'
>> include/linux/irqchip/arm-vgic-info.h:28: Error: bad instruction `bool no_maint_irq_mask'
>> include/linux/irqchip/arm-vgic-info.h:30: Error: bad instruction `struct resource vctrl'
>> include/linux/irqchip/arm-vgic-info.h:32: Error: bad instruction `bool has_v4'
>> include/linux/irqchip/arm-vgic-info.h:34: Error: bad instruction `bool has_v4_1'
>> include/linux/irqchip/arm-vgic-info.h:36: Error: bad instruction `bool no_hw_deactivation'
   include/linux/irqchip/arm-vgic-info.h:37: Error: junk at end of line, first unrecognized character is `}'
>> include/linux/irqchip/arm-vgic-info.h:42: Error: bad instruction `static inline void vgic_set_kvm_info(const struct gic_kvm_info*info){}'
>> include/linux/irqchip/arm-gic-common.h:25: Error: bad instruction `struct irq_domain'
>> include/linux/irqchip/arm-gic-common.h:26: Error: bad instruction `struct fwnode_handle'
>> include/linux/irqchip/arm-gic-common.h:27: Error: bad instruction `int gicv2m_init(struct fwnode_handle*parent_handle,'
>> include/linux/irqchip/arm-gic-common.h:28: Error: bad instruction `struct irq_domain*parent)'


vim +13 include/linux/irqchip/arm-vgic-info.h

0e5cb7770684b4 Marc Zyngier 2021-02-27  12  
0e5cb7770684b4 Marc Zyngier 2021-02-27 @13  enum gic_type {
0e5cb7770684b4 Marc Zyngier 2021-02-27  14  	/* Full GICv2 */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @15  	GIC_V2,
0e5cb7770684b4 Marc Zyngier 2021-02-27  16  	/* Full GICv3, optionally with v2 compat */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @17  	GIC_V3,
0e5cb7770684b4 Marc Zyngier 2021-02-27 @18  };
0e5cb7770684b4 Marc Zyngier 2021-02-27  19  
0e5cb7770684b4 Marc Zyngier 2021-02-27 @20  struct gic_kvm_info {
0e5cb7770684b4 Marc Zyngier 2021-02-27  21  	/* GIC type */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @22  	enum gic_type	type;
0e5cb7770684b4 Marc Zyngier 2021-02-27  23  	/* Virtual CPU interface */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @24  	struct resource vcpu;
0e5cb7770684b4 Marc Zyngier 2021-02-27  25  	/* Interrupt number */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @26  	unsigned int	maint_irq;
669062d2a1aa36 Marc Zyngier 2021-02-28  27  	/* No interrupt mask, no need to use the above field */
669062d2a1aa36 Marc Zyngier 2021-02-28 @28  	bool		no_maint_irq_mask;
0e5cb7770684b4 Marc Zyngier 2021-02-27  29  	/* Virtual control interface */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @30  	struct resource vctrl;
0e5cb7770684b4 Marc Zyngier 2021-02-27  31  	/* vlpi support */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @32  	bool		has_v4;
0e5cb7770684b4 Marc Zyngier 2021-02-27  33  	/* rvpeid support */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @34  	bool		has_v4_1;
f6c3e24fb721dd Marc Zyngier 2021-03-15  35  	/* Deactivation impared, subpar stuff */
f6c3e24fb721dd Marc Zyngier 2021-03-15 @36  	bool		no_hw_deactivation;
0e5cb7770684b4 Marc Zyngier 2021-02-27  37  };
0e5cb7770684b4 Marc Zyngier 2021-02-27  38  
0e5cb7770684b4 Marc Zyngier 2021-02-27  39  #ifdef CONFIG_KVM
0e5cb7770684b4 Marc Zyngier 2021-02-27  40  void vgic_set_kvm_info(const struct gic_kvm_info *info);
0e5cb7770684b4 Marc Zyngier 2021-02-27  41  #else
0e5cb7770684b4 Marc Zyngier 2021-02-27 @42  static inline void vgic_set_kvm_info(const struct gic_kvm_info *info) {}
0e5cb7770684b4 Marc Zyngier 2021-02-27  43  #endif
0e5cb7770684b4 Marc Zyngier 2021-02-27  44  

:::::: The code at line 13 was first introduced by commit
:::::: 0e5cb7770684b4c81bcc63f4675e488f9a0e31eb irqchip/gic: Split vGIC probing information from the GIC code

:::::: TO: Marc Zyngier <maz@kernel.org>
:::::: CC: Marc Zyngier <maz@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
