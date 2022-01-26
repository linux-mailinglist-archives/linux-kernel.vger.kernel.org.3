Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AFB49C352
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiAZFhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:37:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:50917 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbiAZFhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643175456; x=1674711456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K1Ia3evHQmhGL125iZLbYE8s2eqmLUKbbbZVVzu9Ptg=;
  b=Iwh6QFI/mA1zWKDlhyvK2cabjQkqN1exntXA9CbCDGLKsMywTFEwfh4F
   U5pRHMMLt4jF+iCqIbMaQ3r2Z8uICtpbL1wZr1BrwFUVtWablJorVPG1a
   54csn7I3VCFZLSrpvwNfOL2lQTOImoRAhtqsCSrwPf7NGLNw5qCKGGyUT
   HUklu0fqCAwiLK4mxO5MSKUn5PtuW6DlCZ58W0sui1PTA591NiiCYFWyr
   XQugdVHUxCKJhGbVWdd+UhdJA/lgGzSzYcUj6OBQR+GbBSS6FupWMzQJ5
   iyVN9cnn5PbkZyESp50KMe4dzMwTPedwQN3YHAVxz9TpOT1cNcGNzljap
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230058823"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="230058823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="477375590"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 21:37:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCazu-000KpY-2U; Wed, 26 Jan 2022 05:37:34 +0000
Date:   Wed, 26 Jan 2022 13:37:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 70/137]
 include/linux/irqchip/arm-vgic-info.h:13:15: error: unexpected token in
 argument list
Message-ID: <202201261305.sZ3Y7MUD-lkp@intel.com>
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
config: arm-omap1_defconfig (https://download.01.org/0day-ci/archive/20220126/202201261305.sZ3Y7MUD-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=faf6ce00f9b35ca0a0389a2d66d90214d3c62f34
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout faf6ce00f9b35ca0a0389a2d66d90214d3c62f34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> include/linux/irqchip/arm-vgic-info.h:13:15: error: unexpected token in argument list
   enum gic_type {
                 ^
>> include/linux/irqchip/arm-vgic-info.h:15:8: error: unexpected token in operand
    GIC_V2,
          ^
   include/linux/irqchip/arm-vgic-info.h:17:8: error: unexpected token in operand
    GIC_V3,
          ^
>> include/linux/irqchip/arm-vgic-info.h:18:1: error: invalid instruction, did you mean: b?
   };
   ^
   include/linux/irqchip/arm-vgic-info.h:20:21: error: unexpected token in argument list
   struct gic_kvm_info {
                       ^
   include/linux/irqchip/arm-vgic-info.h:22:16: error: unexpected token in argument list
    enum gic_type type;
                  ^
   include/linux/irqchip/arm-vgic-info.h:24:18: error: unexpected token in argument list
    struct resource vcpu;
                    ^
   include/linux/irqchip/arm-vgic-info.h:26:15: error: unexpected token in argument list
    unsigned int maint_irq;
                 ^
>> include/linux/irqchip/arm-vgic-info.h:28:2: error: invalid instruction, did you mean: bl?
    bool no_maint_irq_mask;
    ^
   include/linux/irqchip/arm-vgic-info.h:30:18: error: unexpected token in argument list
    struct resource vctrl;
                    ^
   include/linux/irqchip/arm-vgic-info.h:32:2: error: invalid instruction, did you mean: bl?
    bool has_v4;
    ^
   include/linux/irqchip/arm-vgic-info.h:34:2: error: invalid instruction, did you mean: bl?
    bool has_v4_1;
    ^
   include/linux/irqchip/arm-vgic-info.h:36:2: error: invalid instruction, did you mean: bl?
    bool no_hw_deactivation;
    ^
   include/linux/irqchip/arm-vgic-info.h:37:1: error: invalid instruction, did you mean: b?
   };
   ^
   include/linux/irqchip/arm-vgic-info.h:42:15: error: unexpected token in argument list
   static inline void vgic_set_kvm_info(const struct gic_kvm_info *info) {}
                 ^
>> include/linux/irqchip/arm-gic-common.h:25:1: error: invalid instruction, did you mean: strt?
   struct irq_domain;
   ^
   include/linux/irqchip/arm-gic-common.h:26:1: error: invalid instruction, did you mean: strt?
   struct fwnode_handle;
   ^
>> include/linux/irqchip/arm-gic-common.h:27:24: error: unexpected token in variant, expected ')'
   int gicv2m_init(struct fwnode_handle *parent_handle,
                          ^
>> include/linux/irqchip/arm-gic-common.h:28:28: error: unexpected token in argument list
     struct irq_domain *parent);
                              ^


vim +13 include/linux/irqchip/arm-vgic-info.h

0e5cb7770684b4 Marc Zyngier 2021-02-27  12  
0e5cb7770684b4 Marc Zyngier 2021-02-27 @13  enum gic_type {
0e5cb7770684b4 Marc Zyngier 2021-02-27  14  	/* Full GICv2 */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @15  	GIC_V2,
0e5cb7770684b4 Marc Zyngier 2021-02-27  16  	/* Full GICv3, optionally with v2 compat */
0e5cb7770684b4 Marc Zyngier 2021-02-27  17  	GIC_V3,
0e5cb7770684b4 Marc Zyngier 2021-02-27 @18  };
0e5cb7770684b4 Marc Zyngier 2021-02-27  19  
0e5cb7770684b4 Marc Zyngier 2021-02-27  20  struct gic_kvm_info {
0e5cb7770684b4 Marc Zyngier 2021-02-27  21  	/* GIC type */
0e5cb7770684b4 Marc Zyngier 2021-02-27 @22  	enum gic_type	type;
0e5cb7770684b4 Marc Zyngier 2021-02-27  23  	/* Virtual CPU interface */
0e5cb7770684b4 Marc Zyngier 2021-02-27  24  	struct resource vcpu;
0e5cb7770684b4 Marc Zyngier 2021-02-27  25  	/* Interrupt number */
0e5cb7770684b4 Marc Zyngier 2021-02-27  26  	unsigned int	maint_irq;
669062d2a1aa36 Marc Zyngier 2021-02-28  27  	/* No interrupt mask, no need to use the above field */
669062d2a1aa36 Marc Zyngier 2021-02-28 @28  	bool		no_maint_irq_mask;
0e5cb7770684b4 Marc Zyngier 2021-02-27  29  	/* Virtual control interface */
0e5cb7770684b4 Marc Zyngier 2021-02-27  30  	struct resource vctrl;
0e5cb7770684b4 Marc Zyngier 2021-02-27  31  	/* vlpi support */
0e5cb7770684b4 Marc Zyngier 2021-02-27  32  	bool		has_v4;
0e5cb7770684b4 Marc Zyngier 2021-02-27  33  	/* rvpeid support */
0e5cb7770684b4 Marc Zyngier 2021-02-27  34  	bool		has_v4_1;
f6c3e24fb721dd Marc Zyngier 2021-03-15  35  	/* Deactivation impared, subpar stuff */
f6c3e24fb721dd Marc Zyngier 2021-03-15  36  	bool		no_hw_deactivation;
0e5cb7770684b4 Marc Zyngier 2021-02-27  37  };
0e5cb7770684b4 Marc Zyngier 2021-02-27  38  

:::::: The code at line 13 was first introduced by commit
:::::: 0e5cb7770684b4c81bcc63f4675e488f9a0e31eb irqchip/gic: Split vGIC probing information from the GIC code

:::::: TO: Marc Zyngier <maz@kernel.org>
:::::: CC: Marc Zyngier <maz@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
