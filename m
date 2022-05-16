Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85D528960
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiEPQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiEPQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:01:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C432BEA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652716899; x=1684252899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=63WCdB2DQ3Doklu93IUR3aVcFFfBy0AGKdfYuQi2ZD4=;
  b=Sqke/p0TpjKqRm9PkJsQjQRTMr1vnTzNaGqrcsVztawjyyaweFLNczDr
   oi/W41WNW4Cq2sRDC/rvRtLutnX/sSw0qQ8m5Q4AJUnFN4lEYtVXIUvBr
   0Pe12acaN3GQtFLt6BYDOYKkomu9J+uWJepq5j/4xUUCsqQ0rl/EwEpM8
   Xn/E8/AklW95wB+D3WthhofnmPXRITwuH3Rs/SA21ENMBCCvY8Cas2w4/
   Rju9xNJxz7VmMo/8FqQYeubgKExXR6lQE64MI+A+6ku79Ygg0QMrZI5dM
   qVrB60+7D07gMap2LKEwjsh8Jy3iymH9u+TXgwITh9SShegv05shgUc+6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="252936985"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="252936985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 09:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="568390575"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 May 2022 09:01:37 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqdA8-0000Aj-Q6;
        Mon, 16 May 2022 16:01:36 +0000
Date:   Tue, 17 May 2022 00:01:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     kbuild-all@lists.01.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org
Subject: [uclinux-h8:h8300-next 12/15]
 drivers/irqchip/irq-renesas-h8s.c:54:35: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202205162326.G70XUnDW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.sourceforge.jp/gitroot/uclinux-h8/linux h8300-next
head:   096e0fe4084eb9c2c12c272688d1703921811cd7
commit: 1bf38534b95dfd447964ed1fbdb6fe8401449ec9 [12/15] irq-renesas-h8s: Fix external interrupt control.
config: mips-randconfig-s032-20220516 (https://download.01.org/0day-ci/archive/20220516/202205162326.G70XUnDW-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        git remote add uclinux-h8 git://git.sourceforge.jp/gitroot/uclinux-h8/linux
        git fetch --no-tags uclinux-h8 h8300-next
        git checkout 1bf38534b95dfd447964ed1fbdb6fe8401449ec9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/irqchip/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/irqchip/irq-renesas-h8s.c:48:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:48:14: sparse:     expected void [noderef] __iomem *addr
   drivers/irqchip/irq-renesas-h8s.c:48:14: sparse:     got void *
>> drivers/irqchip/irq-renesas-h8s.c:54:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:54:35: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:54:35: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:56:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:56:35: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:56:35: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:71:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:71:14: sparse:     expected void [noderef] __iomem *addr
   drivers/irqchip/irq-renesas-h8s.c:71:14: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:78:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:78:35: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:78:35: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:80:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:80:35: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:80:35: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:91:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:91:35: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:91:35: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:93:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:93:35: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:93:35: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:123:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [toplevel] ipr_base @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-renesas-h8s.c:123:18: sparse:     expected void *static [toplevel] ipr_base
   drivers/irqchip/irq-renesas-h8s.c:123:18: sparse:     got void [noderef] __iomem *
   drivers/irqchip/irq-renesas-h8s.c:124:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [toplevel] icr_base @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-renesas-h8s.c:124:18: sparse:     expected void *static [toplevel] icr_base
   drivers/irqchip/irq-renesas-h8s.c:124:18: sparse:     got void [noderef] __iomem *
   drivers/irqchip/irq-renesas-h8s.c:130:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:130:43: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:130:43: sparse:     got void *
   drivers/irqchip/irq-renesas-h8s.c:132:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/irqchip/irq-renesas-h8s.c:132:30: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/irqchip/irq-renesas-h8s.c:132:30: sparse:     got void *

vim +54 drivers/irqchip/irq-renesas-h8s.c

    36	
    37	static void h8s_disable_irq(struct irq_data *data)
    38	{
    39		int pos;
    40		void __iomem *addr;
    41		unsigned short pri;
    42		int irq = data->irq - 16;
    43		unsigned short ier;
    44	
    45		if (irq < 0)
    46			return;
    47	
    48		addr = IPRA + ((ipr_table[irq] & 0xf0) >> 3);
    49		pos = (ipr_table[irq] & 0x0f) * 4;
    50		pri = ~(0x000f << pos);
    51		pri &= __raw_readw(addr);
    52		__raw_writew(pri, addr);
    53		if (irq < 16) {
  > 54			ier = __raw_readw(IER);
    55			ier &= ~(1 << irq);
    56			__raw_writew(ier, IER);
    57		}
    58	}
    59	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
