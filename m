Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0E4A3CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 04:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357513AbiAaDpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 22:45:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:57758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbiAaDpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 22:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643600707; x=1675136707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kxqSaxQ7Gb04Bz5NI2oVNABfZy4bSZKSXQz6fiilRDA=;
  b=IywJ94Ct7QYhpkuKD/BQ13a5Sx00q6/+2xL1fnphyKCXjcUXoGSnv1UB
   87icgkENEJcScKeaZqddqpw0A7T6TwVBknTNDIrFfRkJ6F37sxKpYsmZj
   5vJ7BaVO7EpYVwOQ6F/Nrq7a+JYlEhRX8FFNfel8jRRy9o25ldlNHNMYA
   rQm8qdwvSFPelwErhWXlE4bsCRbthNrtYhR48gT+TDhQHKjzXoC1H0h91
   m2Csfe4O/F9tQ/3voeI7k492Fbic2ySwf6+UYmrIAYS59UGeboK+HGyvp
   eDFWVelq2QfIPi10+5K+2usFpdD1EqnUbKn0mAoTAfAKWHgCbvIxP/EIq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="228059215"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="228059215"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 19:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="481549194"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2022 19:45:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nENcl-000RLP-Sw; Mon, 31 Jan 2022 03:45:03 +0000
Date:   Mon, 31 Jan 2022 11:44:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/5] clk: mux: Declare u32 *table parameter as const
Message-ID: <202201311102.kgy44sMD-lkp@intel.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Neusch-fer/clk-Declare-mux-tables-as-const-u32/20220129-175243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-buildonly-randconfig-r002-20220131 (https://download.01.org/0day-ci/archive/20220131/202201311102.kgy44sMD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b97ffeed127cccf9159b9de1e9a1527b963460c4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonathan-Neusch-fer/clk-Declare-mux-tables-as-const-u32/20220129-175243
        git checkout b97ffeed127cccf9159b9de1e9a1527b963460c4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/nxp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/nxp/clk-lpc18xx-cgu.c: In function 'lpc18xx_pll1_recalc_rate':
   drivers/clk/nxp/clk-lpc18xx-cgu.c:460:13: warning: variable 'stat' set but not used [-Wunused-but-set-variable]
     460 |         u32 stat, ctrl;
         |             ^~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c: In function 'lpc18xx_cgu_register_div':
>> drivers/clk/nxp/clk-lpc18xx-cgu.c:545:52: warning: passing argument 2 of 'lpc18xx_fill_parent_names' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     545 |         lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
         |                                            ~~~~~~~~^~~~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c:526:65: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'const u32 *' {aka 'const unsigned int *'}
     526 | static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int size)
         |                                                            ~~~~~^~
   drivers/clk/nxp/clk-lpc18xx-cgu.c: In function 'lpc18xx_register_base_clk':
   drivers/clk/nxp/clk-lpc18xx-cgu.c:567:52: warning: passing argument 2 of 'lpc18xx_fill_parent_names' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     567 |         lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
         |                                            ~~~~~~~~^~~~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c:526:65: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'const u32 *' {aka 'const unsigned int *'}
     526 | static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int size)
         |                                                            ~~~~~^~
   drivers/clk/nxp/clk-lpc18xx-cgu.c: In function 'lpc18xx_cgu_register_pll':
   drivers/clk/nxp/clk-lpc18xx-cgu.c:592:52: warning: passing argument 2 of 'lpc18xx_fill_parent_names' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     592 |         lpc18xx_fill_parent_names(parents, clk->mux.table, clk->n_parents);
         |                                            ~~~~~~~~^~~~~~
   drivers/clk/nxp/clk-lpc18xx-cgu.c:526:65: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'const u32 *' {aka 'const unsigned int *'}
     526 | static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int size)
         |                                                            ~~~~~^~


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
