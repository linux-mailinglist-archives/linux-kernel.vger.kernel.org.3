Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4D4A3CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 05:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357551AbiAaEQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 23:16:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:38346 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237404AbiAaEQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643602567; x=1675138567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OTqClx0disot17Z7bgrGwFoqxoKf1jV+IMsH5OQF4tE=;
  b=Tm4W97EfsTVZecUa5RT9M4avxXdx8REDzDLb9nBflM+rYxMepIH6QLst
   Xpb/pEwWKO4MnV5aR+p0ABIfAYnkq6Lg5MbIElCw7Az6Q4aYPYb8ieRx5
   Jo7tjJswO0iYVHX4JpkrrdbtpZY7s28KfYbTQmXZ6D0lv13Vr/V+c5n4p
   0cvkNVs9tlG1N0W9plSM++4at52FpZzpDck8OtgrVaqeAGvEytPb/exPK
   RnctyVCtKTixhJwBLhszKKOpUw2R9mcwhs7m68lcHhK+qE9vL5hRSyVYh
   FgwBMFWCoAXisLf+muNQmOTtO23etnXnidRvzJ4scgYPIAdApTCHxvUtI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308127937"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="308127937"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 20:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="582509531"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2022 20:16:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEO6m-000RML-BL; Mon, 31 Jan 2022 04:16:04 +0000
Date:   Mon, 31 Jan 2022 12:15:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/5] clk: mux: Declare u32 *table parameter as const
Message-ID: <202201311204.ggE2FHa7-lkp@intel.com>
References: <20220129095159.2202366-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129095159.2202366-2-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Jonathan,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linux/master linus/master v5.17-rc2 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Neusch-fer/clk-Declare-mux-tables-as-const-u32/20220129-175243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-randconfig-r004-20220131 (https://download.01.org/0day-ci/archive/20220131/202201311204.ggE2FHa7-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f1c18acb07aa40f42b87b70462a6d1ab77a4825c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/b97ffeed127cccf9159b9de1e9a1527b963460c4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonathan-Neusch-fer/clk-Declare-mux-tables-as-const-u32/20220129-175243
        git checkout b97ffeed127cccf9159b9de1e9a1527b963460c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/nxp/clk-lpc18xx-cgu.c:460:6: warning: variable 'stat' set but not used [-Wunused-but-set-variable]
           u32 stat, ctrl;
               ^
>> drivers/clk/nxp/clk-lpc18xx-cgu.c:545:37: error: passing 'const u32 *' (aka 'const unsigned int *') to parameter of type 'u32 *' (aka 'unsigned int *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
                                              ^~~~~~~~~~~~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c:526:65: note: passing argument to parameter 'id' here
   static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int size)
                                                                   ^
   drivers/clk/nxp/clk-lpc18xx-cgu.c:567:37: error: passing 'const u32 *' (aka 'const unsigned int *') to parameter of type 'u32 *' (aka 'unsigned int *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
                                              ^~~~~~~~~~~~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c:526:65: note: passing argument to parameter 'id' here
   static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int size)
                                                                   ^
   drivers/clk/nxp/clk-lpc18xx-cgu.c:592:37: error: passing 'const u32 *' (aka 'const unsigned int *') to parameter of type 'u32 *' (aka 'unsigned int *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
                                              ^~~~~~~~~~~~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c:526:65: note: passing argument to parameter 'id' here
   static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int size)
                                                                   ^
   1 warning and 3 errors generated.


vim +545 drivers/clk/nxp/clk-lpc18xx-cgu.c

b04e0b8fd5443b Joachim Eastwood 2015-05-28  533  
b04e0b8fd5443b Joachim Eastwood 2015-05-28  534  static struct clk *lpc18xx_cgu_register_div(struct lpc18xx_cgu_src_clk_div *clk,
b04e0b8fd5443b Joachim Eastwood 2015-05-28  535  					    void __iomem *base, int n)
b04e0b8fd5443b Joachim Eastwood 2015-05-28  536  {
b04e0b8fd5443b Joachim Eastwood 2015-05-28  537  	void __iomem *reg = base + LPC18XX_CGU_IDIV_CTRL(n);
b04e0b8fd5443b Joachim Eastwood 2015-05-28  538  	const char *name = clk_src_names[clk->clk_id];
b04e0b8fd5443b Joachim Eastwood 2015-05-28  539  	const char *parents[CLK_SRC_MAX];
b04e0b8fd5443b Joachim Eastwood 2015-05-28  540  
b04e0b8fd5443b Joachim Eastwood 2015-05-28  541  	clk->div.reg = reg;
b04e0b8fd5443b Joachim Eastwood 2015-05-28  542  	clk->mux.reg = reg;
b04e0b8fd5443b Joachim Eastwood 2015-05-28  543  	clk->gate.reg = reg;
b04e0b8fd5443b Joachim Eastwood 2015-05-28  544  
b04e0b8fd5443b Joachim Eastwood 2015-05-28 @545  	lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
b04e0b8fd5443b Joachim Eastwood 2015-05-28  546  
b04e0b8fd5443b Joachim Eastwood 2015-05-28  547  	return clk_register_composite(NULL, name, parents, clk->n_parents,
b04e0b8fd5443b Joachim Eastwood 2015-05-28  548  				      &clk->mux.hw, &clk_mux_ops,
b04e0b8fd5443b Joachim Eastwood 2015-05-28  549  				      &clk->div.hw, &clk_divider_ops,
c23a5847695dbd Joachim Eastwood 2015-10-24  550  				      &clk->gate.hw, &lpc18xx_gate_ops, 0);
b04e0b8fd5443b Joachim Eastwood 2015-05-28  551  }
b04e0b8fd5443b Joachim Eastwood 2015-05-28  552  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
