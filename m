Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F064C1E24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbiBWWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiBWWBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:01:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B772506D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645653652; x=1677189652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5NP3Zk0qdgMT44f+QCg3Z62Jt2Hmo7b4FF+OgcXji1Y=;
  b=AjisKO2Nvgej8BbN+76j1sAP3tYhf7dvephIvPRfxpI1GJTdAV0weMXB
   ENq8C3Q/oHTfWsnaczzBrcblMfuQbLf+FllwD1cpw2E3aGqArdfcFcsPl
   6KRUr41OVZJjz4+w7Skmg2kjuy+zmmi0K4R4LOAbuMFmLBxfEmcRx3uxr
   SmC4hQaqPM7iVoibL+0BRCx6eFUFIOLpDPi+Y7/3VgRuGGN/tnWoKpJmJ
   B87+vHm25OVlwCPJINTRFZaRlZCXAz9MurbjYrlsyPcpB2Nb+u7iH7GEp
   pmZ58BQYHt2Wl4Gme29I+nYuIImY88yxies+qM56paqDZf+D1gelfvVZt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276710618"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="276710618"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="491366500"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 14:00:50 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMzgn-0001rp-A8; Wed, 23 Feb 2022 22:00:49 +0000
Date:   Thu, 24 Feb 2022 05:59:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2200/2340]
 arch/mips/loongson32/common/irq.c:28:9: error: implicit declaration of
 function '__raw_writel'
Message-ID: <202202240535.jwayYeB6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 3828a1a70a61b6a815d092a41ce8bc2af2eb3d92 [2200/2340] headers/deps: irq: Optimize <linux/interrupt.h> dependencies
config: mips-randconfig-r011-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240535.jwayYeB6-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3828a1a70a61b6a815d092a41ce8bc2af2eb3d92
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3828a1a70a61b6a815d092a41ce8bc2af2eb3d92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/loongson32/common/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/loongson32/common/irq.c: In function 'ls1x_irq_ack':
>> arch/mips/loongson32/common/irq.c:28:9: error: implicit declaration of function '__raw_writel' [-Werror=implicit-function-declaration]
      28 |         __raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
         |         ^~~~~~~~~~~~
>> arch/mips/loongson32/common/irq.c:28:22: error: implicit declaration of function '__raw_readl'; did you mean '__raw_emt'? [-Werror=implicit-function-declaration]
      28 |         __raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
         |                      ^~~~~~~~~~~
         |                      __raw_emt
   arch/mips/loongson32/common/irq.c: At top level:
   arch/mips/loongson32/common/irq.c:152:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'ls1x_irq_init'
     152 | static void __init ls1x_irq_init(int base)
         |                    ^~~~~~~~~~~~~
   arch/mips/loongson32/common/irq.c:187:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'arch_init_irq'
     187 | void __init arch_init_irq(void)
         |             ^~~~~~~~~~~~~
   arch/mips/loongson32/common/irq.c:106:24: warning: 'ls1x_irq_chip' defined but not used [-Wunused-variable]
     106 | static struct irq_chip ls1x_irq_chip = {
         |                        ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__raw_writel +28 arch/mips/loongson32/common/irq.c

ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  22  
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  23  static void ls1x_irq_ack(struct irq_data *d)
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  24  {
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  25  	unsigned int bit = (d->irq - LS1X_IRQ_BASE) & 0x1f;
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  26  	unsigned int n = (d->irq - LS1X_IRQ_BASE) >> 5;
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  27  
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25 @28  	__raw_writel(__raw_readl(LS1X_INTC_INTCLR(n))
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  29  			| (1 << bit), LS1X_INTC_INTCLR(n));
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  30  }
ca585cf9fb818b arch/mips/loongson1/common/irq.c Kelvin Cheung 2012-07-25  31  

:::::: The code at line 28 was first introduced by commit
:::::: ca585cf9fb818bfcfcac6968c2b242dcd0693b08 MIPS: Loongson 1B: Add board support

:::::: TO: Kelvin Cheung <keguang.zhang@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
