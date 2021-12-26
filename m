Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1E47F6A0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhLZLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:30:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:21373 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhLZLar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640518247; x=1672054247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwfJgey1Y2MycPreC6NGLs3wDjD0V4knPRbCRu14jMA=;
  b=eZXe47MTyskSdR5KErcGVwZzYbp1RhgOIw33BjLAN9wTbOD+ddSJ8Ylt
   oL3IN6Ndkyvg0aqV9IrQQsr5aabJ5KZiwt7cPcTRCiHMScwU6pXYEOE0R
   r5H4BRyNGUOV5en4ALzlEkLbQfudB8IySmRYOK4M9gTO9M54vdZUByQk2
   tyKJP1zCu+Cq/hnHI2n9IvCi4Avb3BNIKu6RaEdIyA/gjDM2Z2xo9Gmbi
   kgdwnJAu31ooECMhcyV7KaUUxU4jzxt3/zjUomwP1QOZ1DKV0GuDO1GOO
   hRQLtpPiRXtM4TNwYA1VUcjXxmNGEKEgJK5xSRJKpYm/cRWzAi0afzlac
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="265322901"
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; 
   d="scan'208";a="265322901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 03:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; 
   d="scan'208";a="686019543"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2021 03:30:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1Rjd-0005Km-WC; Sun, 26 Dec 2021 11:30:41 +0000
Date:   Sun, 26 Dec 2021 19:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, tony.huang@sunplus.com,
        wells.lu@sunplus.com, Tony Huang <tonyhuang.sunplus@gmail.com>
Subject: Re: [PATCH v5 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <202112261932.8hwlDwCu-lkp@intel.com>
References: <75e44cae76b74b16c1e178d2d6bb18a332179bc9.1640332430.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e44cae76b74b16c1e178d2d6bb18a332179bc9.1640332430.git.tonyhuang.sunplus@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on robh/for-next linux/master linus/master v5.16-rc6 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tony-Huang/Add-iop-driver-for-Sunplus-SP7021/20211224-163743
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 1bb866dcb8cf5054de88f592fc0ec1f275ad9d63
config: powerpc64-randconfig-s032-20211226 (https://download.01.org/0day-ci/archive/20211226/202112261932.8hwlDwCu-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/a75af7615fe0101c6f3742afc005a39c66b00864
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tony-Huang/Add-iop-driver-for-Sunplus-SP7021/20211224-163743
        git checkout a75af7615fe0101c6f3742afc005a39c66b00864
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/misc/ drivers/pinctrl/nuvoton/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/misc/sunplus_iop.c:94:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/sunplus_iop.c:95:43: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/misc/sunplus_iop.c:100:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *[assigned] iop_kernel_base @@
   drivers/misc/sunplus_iop.c:100:16: sparse:     expected void *p
   drivers/misc/sunplus_iop.c:100:16: sparse:     got void [noderef] __iomem *[assigned] iop_kernel_base
   drivers/misc/sunplus_iop.c:101:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *[assigned] iop_kernel_base @@
   drivers/misc/sunplus_iop.c:101:16: sparse:     expected void *p
   drivers/misc/sunplus_iop.c:101:16: sparse:     got void [noderef] __iomem *[assigned] iop_kernel_base
   drivers/misc/sunplus_iop.c:103:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:103:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:103:47: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:105:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:105:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:105:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:107:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:107:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:107:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:109:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:109:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:109:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:111:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:111:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:111:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:113:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:113:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:113:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:115:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:115:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:115:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:118:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:118:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:118:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:120:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:120:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:120:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:122:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:122:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:122:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:124:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:124:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:124:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:130:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/sunplus_iop.c:131:43: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/sunplus_iop.c:136:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *[assigned] iop_kernel_base @@
   drivers/misc/sunplus_iop.c:136:16: sparse:     expected void *p
   drivers/misc/sunplus_iop.c:136:16: sparse:     got void [noderef] __iomem *[assigned] iop_kernel_base
   drivers/misc/sunplus_iop.c:137:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *[assigned] iop_kernel_base @@
   drivers/misc/sunplus_iop.c:137:16: sparse:     expected void *p
   drivers/misc/sunplus_iop.c:137:16: sparse:     got void [noderef] __iomem *[assigned] iop_kernel_base
   drivers/misc/sunplus_iop.c:139:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:139:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:139:47: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:141:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:141:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:141:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:143:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:143:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:143:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:145:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:145:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:145:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:147:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:147:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:147:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:149:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:149:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:149:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:151:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:151:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:151:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:154:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:154:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:154:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:156:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:156:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:156:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:158:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:158:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:158:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:160:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:160:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:160:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:171:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/sunplus_iop.c:172:43: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/sunplus_iop.c:173:47: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/misc/sunplus_iop.c:177:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:177:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:177:47: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:179:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:179:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:179:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:181:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:181:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:181:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:183:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:183:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:183:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:185:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:185:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:185:22: sparse:     got unsigned int *
   drivers/misc/sunplus_iop.c:188:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/misc/sunplus_iop.c:188:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/sunplus_iop.c:188:29: sparse:     got unsigned int *

vim +100 drivers/misc/sunplus_iop.c

    91	
    92	static void sp_iop_normal_mode(struct sp_iop *iop)
    93	{
    94		struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;
    95		struct regs_moon0 *p_moon0_reg = (struct regs_moon0 *)iop->moon0_regs;
    96		void __iomem *iop_kernel_base;
    97		unsigned int reg;
    98	
    99		iop_kernel_base = ioremap(iop->iop_mem_start, NORMAL_CODE_MAX_SIZE);
 > 100		memset(iop_kernel_base, 0, NORMAL_CODE_MAX_SIZE);
   101		memcpy(iop_kernel_base, iop->iop_normal_code, NORMAL_CODE_MAX_SIZE);
   102	
   103		writel(0x00100010, &p_moon0_reg->clken[0]);
   104	
   105		reg = readl(&p_iop_reg->iop_control);
   106		reg |= 0x01;
   107		writel(reg, &p_iop_reg->iop_control);
   108	
   109		reg = readl(&p_iop_reg->iop_control);
   110		reg &= ~(0x8000);
   111		writel(reg, &p_iop_reg->iop_control);
   112	
   113		reg = readl(&p_iop_reg->iop_control);
   114		reg |= 0x0200;//disable watchdog event reset IOP
   115		writel(reg, &p_iop_reg->iop_control);
   116	
   117		reg = (iop->iop_mem_start & 0xFFFF);
   118		writel(reg, &p_iop_reg->iop_base_adr_l);
   119		reg	= (iop->iop_mem_start >> 16);
   120		writel(reg, &p_iop_reg->iop_base_adr_h);
   121	
   122		reg = readl(&p_iop_reg->iop_control);
   123		reg &= ~(0x01);
   124		writel(reg, &p_iop_reg->iop_control);
   125		iop->mode = 0;
   126	}
   127	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
