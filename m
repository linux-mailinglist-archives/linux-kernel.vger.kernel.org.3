Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEABA49672A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiAUVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:14:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:47885 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbiAUVOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642799648; x=1674335648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6H2UckBLCuDWmdCe+Xs89o2UseA1Ut2QW+oJkT+t3Y=;
  b=PhFAWM9dQMnpk9ZTxS9HoZy5XxhXkk+lGPkOz4Im+k7zGCjUOBAMpPk5
   hebTfsdE8qiG2t8nEAdb/XvDzvjRUiUWLSxFYogJ0/bzxQh1wQSq37BP/
   ac/cHprgfYjWECQJWLyIMJb+6GbQV6CHw9YErUsh4k1tohi0aZJvSU2tJ
   7pP4zmz9EwyuhWmowJ9ElU5OAOZgw5rCcueCuL15K/xdIzi/HlVjGa9pk
   esEnDBzTrseVshZ53BtVn0bfbAFs5du+IwQI95bU3XqMMRqpdHLi1om70
   pApBOZfJKEkWyPrNmWXCD+n8gHx5rBQ0rfd6tpdclD3N5LnjBmc/hRZPA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="245965779"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="245965779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 13:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="626862833"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2022 13:14:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB1ER-000Ffd-Sb; Fri, 21 Jan 2022 21:14:03 +0000
Date:   Sat, 22 Jan 2022 05:13:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 04/16] clk: samsung: fsd: Add initial clock support
Message-ID: <202201220550.FSQ6N02X-lkp@intel.com>
References: <20220121172840.12121-5-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121172840.12121-5-alim.akhtar@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220121]
[also build test WARNING on v5.16]
[cannot apply to clk/clk-next robh/for-next pinctrl-samsung/for-next v5.16 v5.16-rc8 v5.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alim-Akhtar/dt-bindings-add-vendor-prefix-for-Tesla/20220122-022924
base:    c94951012a748a0f8ed77cd8fc25640c6fe198f9
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220122/202201220550.FSQ6N02X-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/69b6b21ebabb149c1c07d83376e9c08a582c6423
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alim-Akhtar/dt-bindings-add-vendor-prefix-for-Tesla/20220122-022924
        git checkout 69b6b21ebabb149c1c07d83376e9c08a582c6423
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/clk/samsung/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/samsung/clk-fsd.c:150:9: warning: this decimal constant is unsigned only in ISO C90
     150 |         PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
         |         ^~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/of.h:15,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/samsung/clk-fsd.c:11:
>> include/linux/build_bug.h:16:51: warning: this decimal constant is unsigned only in ISO C90
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   drivers/clk/samsung/clk-pll.h:48:9: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      48 |         BUILD_BUG_ON_ZERO(PLL_RATE(_fin, _m, _p, _s, _k, _ks) != (_fout)))
         |         ^~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk-pll.h:52:33: note: in expansion of macro 'PLL_VALID_RATE'
      52 |                 .rate   =       PLL_VALID_RATE(_fin, _rate,     \
         |                                 ^~~~~~~~~~~~~~
   drivers/clk/samsung/clk-fsd.c:150:9: note: in expansion of macro 'PLL_35XX_RATE'
     150 |         PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
         |         ^~~~~~~~~~~~~
   drivers/clk/samsung/clk-fsd.c:154:9: warning: this decimal constant is unsigned only in ISO C90
     154 |         PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
         |         ^~~~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/of.h:15,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/samsung/clk-fsd.c:11:
>> include/linux/build_bug.h:16:51: warning: this decimal constant is unsigned only in ISO C90
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   drivers/clk/samsung/clk-pll.h:48:9: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      48 |         BUILD_BUG_ON_ZERO(PLL_RATE(_fin, _m, _p, _s, _k, _ks) != (_fout)))
         |         ^~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk-pll.h:52:33: note: in expansion of macro 'PLL_VALID_RATE'
      52 |                 .rate   =       PLL_VALID_RATE(_fin, _rate,     \
         |                                 ^~~~~~~~~~~~~~
   drivers/clk/samsung/clk-fsd.c:154:9: note: in expansion of macro 'PLL_35XX_RATE'
     154 |         PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
         |         ^~~~~~~~~~~~~


vim +150 drivers/clk/samsung/clk-fsd.c

   148	
   149	static const struct samsung_pll_rate_table pll_shared1_rate_table[] __initconst = {
 > 150		PLL_35XX_RATE(24 * MHZ, 2400000000, 200, 2, 0),
   151	};
   152	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
