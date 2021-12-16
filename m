Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5547672E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhLPBAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:00:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:22823 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhLPBA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639616429; x=1671152429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gN4+d66eBI/gXay2wWeA6BkAs5oa3s8HM8occSuZ8po=;
  b=ZXxJAlcZr+wr6+qafdLnQzH63QN0mSeQt5bcUcIO92A+sZ8d/jFfBzPT
   Vj4u2/6BCrrCtKfbzUlXHwy3dN5sIOZcEmJ32doCVHGRRaFOj7pkyHkHn
   YKs4TKl+5ZI9owj+AdXluAgNIajTHNoxADvCNST4zykn4W1NN0Ka6GDib
   J41NXZU2khWwTyOtKwHXPHpiA7TB8qLjGCQISimPwv/NzCs76k9gsGByA
   LLsFdI6RbOhLDCT4M+3c6NaCtqs7vmM/5p3+WsRvEWiXV2I3J8IYCd+qG
   TJb7z3jGrMTTki6CCIkl64YskwsBPccef1sjjE+9lED83tpQoipzcrVcp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239594361"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="239594361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 17:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="545784568"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Dec 2021 17:00:25 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxf8D-0002Xr-5A; Thu, 16 Dec 2021 01:00:25 +0000
Date:   Thu, 16 Dec 2021 09:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] pinctrl: add one more "const" for generic function groups
Message-ID: <202112160816.btxt2IyR-lkp@intel.com>
References: <20211215174821.21668-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215174821.21668-1-zajec5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Rafał,

I love your patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/pinctrl-add-one-more-const-for-generic-function-groups/20211216-014859
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm64-randconfig-r031-20211215 (https://download.01.org/0day-ci/archive/20211216/202112160816.btxt2IyR-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/e4338a6ad34998afb60c5ad294aafa06cd7110a7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rafa-Mi-ecki/pinctrl-add-one-more-const-for-generic-function-groups/20211216-014859
        git checkout e4338a6ad34998afb60c5ad294aafa06cd7110a7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-keembay.c:1594:8: error: assigning to 'const char **' from 'const char *const *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                           grp = func->group_names;
                               ^ ~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/pinctrl/freescale/pinctrl-imx.c:672:24: error: read-only variable is not assignable
                   func->group_names[i] = child->name;
                   ~~~~~~~~~~~~~~~~~~~~ ^
   1 error generated.


vim +1594 drivers/pinctrl/pinctrl-keembay.c

ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1556  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1557  static int keembay_add_functions(struct keembay_pinctrl *kpc,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1558  				 struct function_desc *function)
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1559  {
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1560  	unsigned int i;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1561  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1562  	/* Assign the groups for each function */
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1563  	for (i = 0; i < kpc->npins; i++) {
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1564  		const struct pinctrl_pin_desc *pdesc = keembay_pins + i;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1565  		struct keembay_mux_desc *mux = pdesc->drv_data;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1566  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1567  		while (mux->name) {
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1568  			struct function_desc *func;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1569  			const char **grp;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1570  			size_t grp_size;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1571  			u32 j, grp_num;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1572  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1573  			for (j = 0; j < kpc->nfuncs; j++) {
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1574  				if (!strcmp(mux->name, function[j].name))
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1575  					break;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1576  			}
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1577  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1578  			if (j == kpc->nfuncs)
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1579  				return -EINVAL;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1580  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1581  			func = function + j;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1582  			grp_num = func->num_group_names;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1583  			grp_size = sizeof(*func->group_names);
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1584  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1585  			if (!func->group_names) {
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1586  				func->group_names = devm_kcalloc(kpc->dev,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1587  								 grp_num,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1588  								 grp_size,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1589  								 GFP_KERNEL);
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1590  				if (!func->group_names)
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1591  					return -ENOMEM;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1592  			}
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1593  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06 @1594  			grp = func->group_names;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1595  			while (*grp)
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1596  				grp++;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1597  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1598  			*grp = pdesc->name;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1599  			mux++;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1600  		}
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1601  	}
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1602  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1603  	/* Add all functions */
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1604  	for (i = 0; i < kpc->nfuncs; i++) {
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1605  		pinmux_generic_add_function(kpc->pctrl,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1606  					    function[i].name,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1607  					    function[i].group_names,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1608  					    function[i].num_group_names,
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1609  					    function[i].data);
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1610  	}
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1611  
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1612  	return 0;
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1613  }
ffd4e739358be0 Lakshmi Sowjanya D 2021-08-06  1614  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
