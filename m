Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD44C1CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiBWUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiBWUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:17 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B684C798
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645646868; x=1677182868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8tswYs6UqTqV07hXWyr2WDqNw6u3gvmz6vbZeddXumg=;
  b=TOQwdm5z6VpWMEQAab5oLMfEoSosvdc4vojHCrGeHbFJqGXVIh557n/M
   N9uc2bGU4j0Gaao1S6Im0lLAQKKbjOnPa2uDtsBxVgr8i4QCGJPxHylio
   c7NoMkKOPD0f1sCmGIoJU8LAHK8HePwWf0nX/LJX2ohsYcUZk+2clXriE
   zjmFEH21ugTgmUYpS8PBHSP4DGv7jpmYYMZao0C98WLlRfc/1yAOLCbAR
   wOhKhha6w+L66YtxPAgVwbmCkYbpMKAzLhk9hC8PvFgETkOST/cTt3s5o
   Te9hna+d2Bbmjk/jcPcL7aBjwMrs9uelZkhFRnAteMVW+EdThWaq4T3zQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312786614"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="312786614"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 12:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491339448"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 12:07:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMxvN-0001me-ST; Wed, 23 Feb 2022 20:07:45 +0000
Date:   Thu, 24 Feb 2022 04:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2052/2340]
 arch/mips/loongson32/common/irq.c:152:20: error: expected '=', ',', ';',
 'asm' or '__attribute__' before 'ls1x_irq_init'
Message-ID: <202202240428.syHmLs8u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 3ba69a256b88ff6b71ad4ee8ac69a0457f991b9a [2052/2340] headers/deps: irq: Optimize <linux/irq.h> dependencies, remove <linux/slab.h>
config: mips-randconfig-r011-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240428.syHmLs8u-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3ba69a256b88ff6b71ad4ee8ac69a0457f991b9a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3ba69a256b88ff6b71ad4ee8ac69a0457f991b9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/loongson32/common/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/interrupt.h:23,
                    from arch/mips/loongson32/common/irq.c:6:
   arch/mips/include/asm/irq.h:23:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'init_IRQ'
      23 | extern void __init init_IRQ(void);
         |                    ^~~~~~~~
>> arch/mips/loongson32/common/irq.c:152:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ls1x_irq_init'
     152 | static void __init ls1x_irq_init(int base)
         |                    ^~~~~~~~~~~~~
>> arch/mips/loongson32/common/irq.c:187:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'arch_init_irq'
     187 | void __init arch_init_irq(void)
         |             ^~~~~~~~~~~~~
   arch/mips/loongson32/common/irq.c:106:24: warning: 'ls1x_irq_chip' defined but not used [-Wunused-variable]
     106 | static struct irq_chip ls1x_irq_chip = {
         |                        ^~~~~~~~~~~~~


vim +152 arch/mips/loongson32/common/irq.c

ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   @6  #include <linux/interrupt.h>
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25    7  #include <linux/irq.h>
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25    8  #include <asm/irq_cpu.h>
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25    9  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   10  #include <loongson1.h>
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   11  #include <irq.h>
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   12  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   13  #define LS1X_INTC_REG(n, x) \
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   14  		((void __iomem *)KSEG1ADDR(LS1X_INTC_BASE + (n * 0x18) + (x)))
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   15  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   16  #define LS1X_INTC_INTISR(n)		LS1X_INTC_REG(n, 0x0)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   17  #define LS1X_INTC_INTIEN(n)		LS1X_INTC_REG(n, 0x4)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   18  #define LS1X_INTC_INTSET(n)		LS1X_INTC_REG(n, 0x8)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   19  #define LS1X_INTC_INTCLR(n)		LS1X_INTC_REG(n, 0xc)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   20  #define LS1X_INTC_INTPOL(n)		LS1X_INTC_REG(n, 0x10)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   21  #define LS1X_INTC_INTEDGE(n)		LS1X_INTC_REG(n, 0x14)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   22  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   23  static void ls1x_irq_ack(struct irq_data *d)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   24  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   25  	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   26  	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   27  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   28  	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   29  			| (1 << bit), LS1X_INTC_INTCLR(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   30  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   31  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   32  static void ls1x_irq_mask(struct irq_data *d)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   33  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   34  	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   35  	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   36  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   37  	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   38  			& ~(1 << bit), LS1X_INTC_INTIEN(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   39  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   40  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   41  static void ls1x_irq_mask_ack(struct irq_data *d)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   42  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   43  	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   44  	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   45  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   46  	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   47  			& ~(1 << bit), LS1X_INTC_INTIEN(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   48  	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   49  			| (1 << bit), LS1X_INTC_INTCLR(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   50  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   51  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   52  static void ls1x_irq_unmask(struct irq_data *d)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   53  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   54  	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   55  	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   56  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   57  	__raw_writel(__raw_readl(LS1X_INTC_INTIEN(n))
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   58  			| (1 << bit), LS1X_INTC_INTIEN(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   59  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25   60  
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   61  static int ls1x_irq_settype(struct irq_data *d, unsigned int type)
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   62  {
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   63  	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   64  	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   65  
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   66  	switch (type) {
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   67  	case IRQ_TYPE_LEVEL_HIGH:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   68  		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   69  			| (1 << bit), LS1X_INTC_INTPOL(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   70  		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   71  			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   72  		break;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   73  	case IRQ_TYPE_LEVEL_LOW:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   74  		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   75  			& ~(1 << bit), LS1X_INTC_INTPOL(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   76  		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   77  			& ~(1 << bit), LS1X_INTC_INTEDGE(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   78  		break;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   79  	case IRQ_TYPE_EDGE_RISING:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   80  		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   81  			| (1 << bit), LS1X_INTC_INTPOL(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   82  		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   83  			| (1 << bit), LS1X_INTC_INTEDGE(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   84  		break;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   85  	case IRQ_TYPE_EDGE_FALLING:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   86  		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   87  			& ~(1 << bit), LS1X_INTC_INTPOL(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   88  		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   89  			| (1 << bit), LS1X_INTC_INTEDGE(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   90  		break;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   91  	case IRQ_TYPE_EDGE_BOTH:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   92  		__raw_writel(__raw_readl(LS1X_INTC_INTPOL(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   93  			& ~(1 << bit), LS1X_INTC_INTPOL(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   94  		__raw_writel(__raw_readl(LS1X_INTC_INTEDGE(n))
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   95  			| (1 << bit), LS1X_INTC_INTEDGE(n));
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   96  		break;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   97  	case IRQ_TYPE_NONE:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   98  		break;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19   99  	default:
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  100  		return -EINVAL;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  101  	}
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  102  
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  103  	return 0;
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  104  }
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  105  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  106  static struct irq_chip ls1x_irq_chip = {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  107  	.name		= "LS1X-INTC",
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  108  	.irq_ack	= ls1x_irq_ack,
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  109  	.irq_mask	= ls1x_irq_mask,
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  110  	.irq_mask_ack	= ls1x_irq_mask_ack,
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  111  	.irq_unmask	= ls1x_irq_unmask,
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  112  	.irq_set_type   = ls1x_irq_settype,
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  113  };
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  114  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  115  static void ls1x_irq_dispatch(int n)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  116  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  117  	u32 int_status, irq;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  118  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  119  	/* Get pending sources, masked by current enables */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  120  	int_status = __raw_readl(LS1X_INTC_INTISR(n)) &
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  121  			__raw_readl(LS1X_INTC_INTIEN(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  122  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  123  	if (int_status) {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  124  		irq = LS1X_IRQ(n, __ffs(int_status));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  125  		do_IRQ(irq);
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  126  	}
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  127  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  128  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  129  asmlinkage void plat_irq_dispatch(void)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  130  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  131  	unsigned int pending;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  132  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  133  	pending = read_c0_cause() & read_c0_status() & ST0_IM;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  134  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  135  	if (pending & CAUSEF_IP7)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  136  		do_IRQ(TIMER_IRQ);
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  137  	else if (pending & CAUSEF_IP2)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  138  		ls1x_irq_dispatch(0); /* INT0 */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  139  	else if (pending & CAUSEF_IP3)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  140  		ls1x_irq_dispatch(1); /* INT1 */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  141  	else if (pending & CAUSEF_IP4)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  142  		ls1x_irq_dispatch(2); /* INT2 */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  143  	else if (pending & CAUSEF_IP5)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  144  		ls1x_irq_dispatch(3); /* INT3 */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  145  	else if (pending & CAUSEF_IP6)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  146  		ls1x_irq_dispatch(4); /* INT4 */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  147  	else
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  148  		spurious_interrupt();
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  149  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  150  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  151  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25 @152  static void __init ls1x_irq_init(int base)
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  153  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  154  	int n;
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  155  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  156  	/* Disable interrupts and clear pending,
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  157  	 * setup all IRQs as high level triggered
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  158  	 */
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  159  	for (n = 0; n < INTN; n++) {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  160  		__raw_writel(0x0, LS1X_INTC_INTIEN(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  161  		__raw_writel(0xffffffff, LS1X_INTC_INTCLR(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  162  		__raw_writel(0xffffffff, LS1X_INTC_INTPOL(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  163  		/* set DMA0, DMA1 and DMA2 to edge trigger */
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  164  		__raw_writel(n ? 0x0 : 0xe000, LS1X_INTC_INTEDGE(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  165  	}
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  166  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  167  
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  168  	for (n = base; n < NR_IRQS; n++) {
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  169  		irq_set_chip_and_handler(n, &ls1x_irq_chip,
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  170  					 handle_level_irq);
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  171  	}
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  172  
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  173  	if (request_irq(INT0_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  174  		pr_err("Failed to request irq %d (cascade)\n", INT0_IRQ);
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  175  	if (request_irq(INT1_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  176  		pr_err("Failed to request irq %d (cascade)\n", INT1_IRQ);
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  177  	if (request_irq(INT2_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  178  		pr_err("Failed to request irq %d (cascade)\n", INT2_IRQ);
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  179  	if (request_irq(INT3_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  180  		pr_err("Failed to request irq %d (cascade)\n", INT3_IRQ);
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  181  #if defined(CONFIG_LOONGSON1_LS1C)
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  182  	if (request_irq(INT4_IRQ, no_action, IRQF_NO_THREAD, "cascade", NULL))
ac8fd122e070ce arch/mips/loongson32/common/irq.c afzal mohammed 2020-03-05  183  		pr_err("Failed to request irq %d (cascade)\n", INT4_IRQ);
12e3280b33fe1a arch/mips/loongson32/common/irq.c Yang Ling      2016-05-19  184  #endif
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  185  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25  186  
ca585cf9fb818b arch/mips/loongson1/common/irq.c  Kelvin Cheung  2012-07-25 @187  void __init arch_init_irq(void)

:::::: The code at line 152 was first introduced by commit
:::::: ca585cf9fb818bfcfcac6968c2b242dcd0693b08 MIPS: Loongson 1B: Add board support

:::::: TO: Kelvin Cheung <keguang.zhang@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
