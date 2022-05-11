Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE352311D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiEKLGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbiEKLGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:06:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA126AC7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652267205; x=1683803205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4aOCkWbkKoLGrbHScRid0Q+aMXfM/6Np0GvPa+B1Dbw=;
  b=lwFg3i1MRlylNDN7IiuuW+UmPshUIYFW6LmX+QSmU8iJse45eerG1RHF
   A7Sc1ISG3ess0lo6Bl2HM1pCXSILNSg3pO3h0Ta3PjYNuAVAb9H1iNAqA
   KQG1a8o9ZDAS2FIcj54unZ9ne0BoV179PAaToyO6/R5VfMCp7Wm/zlnde
   AVBJUVx+P6GNjilgkHHTp/NpQpboLKvLltj681nOF9i7KLh4MnP0DAti+
   dMKwmLjZTnHb05GdmsSpvywJQSZRJrynLf0FRJigRaZHvHl76R7OxR+pg
   8wAc1MhOveFwn2rgC/DeVsr/XGSXa4ygL9kkF1zyhzBlhMpmysZ3jBjir
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249562170"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="249562170"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 04:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="739174040"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2022 04:06:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nokAz-000J1a-De;
        Wed, 11 May 2022 11:06:41 +0000
Date:   Wed, 11 May 2022 19:06:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     kbuild-all@lists.01.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org
Subject: [uclinux-h8:h8300-next 10/15]
 drivers/irqchip/irq-renesas-h8s.c:104:18: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202205111817.XjODrOki-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.sourceforge.jp/gitroot/uclinux-h8/linux h8300-next
head:   096e0fe4084eb9c2c12c272688d1703921811cd7
commit: f45fdb7acce2a2cac49541b914b88f1e5a869052 [10/15] irq-renesas-h8s: fix interrupt handling.
config: h8300-randconfig-s032-20220509 (https://download.01.org/0day-ci/archive/20220511/202205111817.XjODrOki-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add uclinux-h8 git://git.sourceforge.jp/gitroot/uclinux-h8/linux
        git fetch --no-tags uclinux-h8 h8300-next
        git checkout f45fdb7acce2a2cac49541b914b88f1e5a869052
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/irqchip/irq-renesas-h8s.c:42:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:42:14: sparse:     expected void [noderef] __iomem *addr
   drivers/irqchip/irq-renesas-h8s.c:42:14: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:56:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:56:14: sparse:     expected void [noderef] __iomem *addr
   drivers/irqchip/irq-renesas-h8s.c:56:14: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:66:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *isr_addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:66:43: sparse:     expected void [noderef] __iomem *isr_addr
   drivers/irqchip/irq-renesas-h8s.c:66:43: sparse:     got void *
>> drivers/irqchip/irq-renesas-h8s.c:104:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [toplevel] ipr_base @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-renesas-h8s.c:104:18: sparse:     expected void *static [toplevel] ipr_base
   drivers/irqchip/irq-renesas-h8s.c:104:18: sparse:     got void [noderef] __iomem *
>> drivers/irqchip/irq-renesas-h8s.c:105:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [toplevel] icr_base @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-renesas-h8s.c:105:18: sparse:     expected void *static [toplevel] icr_base
   drivers/irqchip/irq-renesas-h8s.c:105:18: sparse:     got void [noderef] __iomem *
>> drivers/irqchip/irq-renesas-h8s.c:111:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:111:43: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/irqchip/irq-renesas-h8s.c:111:43: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:113:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:113:39: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/irqchip/irq-renesas-h8s.c:113:39: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c: note: in included file (through include/linux/io.h, include/linux/irq.h):
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:20:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:38:11: sparse: sparse: cast removes address space '__iomem' of expression

vim +104 drivers/irqchip/irq-renesas-h8s.c

    34	
    35	static void h8s_disable_irq(struct irq_data *data)
    36	{
    37		int pos;
    38		void __iomem *addr;
    39		unsigned short pri;
    40		int irq = data->irq;
    41	
  > 42		addr = IPRA + ((ipr_table[irq - 16] & 0xf0) >> 3);
    43		pos = (ipr_table[irq - 16] & 0x0f) * 4;
    44		pri = ~(0x000f << pos);
    45		pri &= __raw_readw(addr);
    46		__raw_writew(pri, addr);
    47	}
    48	
    49	static void h8s_enable_irq(struct irq_data *data)
    50	{
    51		int pos;
    52		void __iomem *addr;
    53		unsigned short pri;
    54		int irq = data->irq;
    55	
  > 56		addr = IPRA + ((ipr_table[irq - 16] & 0xf0) >> 3);
    57		pos = (ipr_table[irq - 16] & 0x0f) * 4;
    58		pri = ~(0x000f << pos);
    59		pri &= __raw_readw(addr);
    60		pri |= 1 << pos;
    61		__raw_writew(pri, addr);
    62	}
    63	
    64	static void h8s_ack_irq(struct irq_data *data)
    65	{
  > 66		void __iomem *isr_addr = icr_base + 4;
    67		int irq = data->irq;
    68		uint16_t isr;
    69	
    70		if (irq >= 16 && irq < 32) {
    71			irq -= 16;
    72			isr = __raw_readw(isr_addr);
    73			isr &= ~(1 << irq);
    74			__raw_writew(isr, isr_addr);
    75		}
    76	}
    77	
    78	struct irq_chip h8s_irq_chip = {
    79		.name		= "H8S-INTC",
    80		.irq_enable	= h8s_enable_irq,
    81		.irq_disable	= h8s_disable_irq,
    82		.irq_ack	= h8s_ack_irq,
    83	};
    84	
    85	static __init int irq_map(struct irq_domain *h, unsigned int virq,
    86				  irq_hw_number_t hw_irq_num)
    87	{
    88	       irq_set_chip_and_handler(virq, &h8s_irq_chip, handle_simple_irq);
    89	
    90	       return 0;
    91	}
    92	
    93	static const struct irq_domain_ops irq_ops = {
    94	       .map    = irq_map,
    95	       .xlate  = irq_domain_xlate_onecell,
    96	};
    97	
    98	static int __init h8s_intc_of_init(struct device_node *intc,
    99					   struct device_node *parent)
   100	{
   101		struct irq_domain *domain;
   102		int n;
   103	
 > 104		ipr_base = of_iomap(intc, 0);
 > 105		icr_base = of_iomap(intc, 1);
   106		BUG_ON(!ipr_base || !icr_base);
   107	
   108		/* All interrupt priority is 0 (disable) */
   109		/* IPRA to IPRK */
   110		for (n = 0; n <= 'k' - 'a'; n++)
 > 111			__raw_writew(0x0000, IPRA + (n * 2));
   112	
   113		__raw_writew(0xffff, icr_base + 2);
   114		domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, NULL);
   115		BUG_ON(!domain);
   116		irq_set_default_host(domain);
   117		return 0;
   118	}
   119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
