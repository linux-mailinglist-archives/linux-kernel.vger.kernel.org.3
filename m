Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00B479E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 00:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhLRXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 18:13:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:59896 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhLRXNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 18:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639869187; x=1671405187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GjSKeXQPTr7yF3AuFRKxxad8NgEFBrhkdB1LkhXvPw=;
  b=jPYJlKRENaQ8hPNh4JNaf0Z37cxq7ay31xSkkeNCoLySc1fkCsRJS3mL
   qHG09h3clV0u3nfLza2KjOQJOtb/OA9EvoPq6fffzpoEpS2uhZVy/OAWI
   WLxGU0hZReR6U7Rc47kqrUurbon83vpdZgBXWcFPg8W3al3+QYvH7iPtZ
   KdiKOAlftbD+JqlR1D3AwGAcjETSyt7yJqN9wMCbLnZ/+Y/59g/55wPFk
   lwQl29Cyx5DmQdgPRGjjYQCFk7lTLuNCetsm2faO18ynLLIjPhxrh/Lfd
   7fSfearoHzC682AM+jhrze7FknnI7EN/4xFhsNHCOrbeTzprGwmHCfyVF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="326250258"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="326250258"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 15:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="606252363"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Dec 2021 15:13:04 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myisy-0006UV-6e; Sat, 18 Dec 2021 23:13:04 +0000
Date:   Sun, 19 Dec 2021 07:12:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, john@phrozen.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 07/14] clk: en7523: Add clock driver for Airoha EN7523
 SoC
Message-ID: <202112190745.VhE9iVPk-lkp@intel.com>
References: <20211217112345.14029-8-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217112345.14029-8-nbd@nbd.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next v5.16-rc5 next-20211217]
[cannot apply to linusw-gpio/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Felix-Fietkau/dt-bindings-Add-vendor-prefix-for-Airoha/20211217-202345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sparc-randconfig-s031-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190745.VhE9iVPk-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/64b3a07b51d637d0df89f00d061662f8228c0b13
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Felix-Fietkau/dt-bindings-Add-vendor-prefix-for-Airoha/20211217-202345
        git checkout 64b3a07b51d637d0df89f00d061662f8228c0b13
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/clk/ drivers/clocksource/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/clk/clk-en7523.c:240:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *np_base @@     got void [noderef] __iomem *base @@
   drivers/clk/clk-en7523.c:240:27: sparse:     expected void *np_base
   drivers/clk/clk-en7523.c:240:27: sparse:     got void [noderef] __iomem *base
>> drivers/clk/clk-en7523.c:243:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/clk/clk-en7523.c:243:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clk/clk-en7523.c:243:29: sparse:     got void *
>> drivers/clk/clk-en7523.c:245:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/clk/clk-en7523.c:245:29: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/clk/clk-en7523.c:245:29: sparse:     got void *

vim +240 drivers/clk/clk-en7523.c

   236	
   237	static void en7523_pci_disable(struct clk_hw *hw)
   238	{
   239		struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
 > 240		void *np_base = cg->base;
   241		u32 val;
   242	
 > 243		val = readl(np_base + REG_PCI_CONTROL);
   244		val &= ~REG_PCI_CONTROL_REFCLK_EN1;
 > 245		writel(val, np_base + REG_PCI_CONTROL);
   246	}
   247	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
