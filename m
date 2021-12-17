Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BE34783D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhLQEEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:04:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:4689 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhLQEEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639713883; x=1671249883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xPxQv63W+jGbiIuB6HX4JPG3Y5Af+vW3cSADdbekqug=;
  b=mcNVnPbVTA0xBi0M+jkP0Mj9XtERhkl+oHltOugSLt4STxP+YHpDKBw8
   YEcoOAN6wbAP8R641x4GljCmnxyC3OVrM7p9wu/TR+2mLpVg/nTFUWVFh
   DHrbSMrsohNXduH4i0vhDLWhORjO/GPB8e2L/gkk3Vcr4xNGVU2C0/iDh
   OEzVce+g0OvH9W0EJKRzdHNQHCc1UGc9mKnrT9iVuY8WQVEDnOdtAr9+m
   PE1WkuKHZv/id2DJ/UuA3mClyu4XiSBQq8fHBslE1YW/m9uAn4CNNTFC4
   5+mZ0qV+dvbJ1HIbg7rxYh3oDcLFuB2nMPwRzqcEoBZMb/yhawYFl9sqx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220354372"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="220354372"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 20:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683239886"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 20:04:37 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my4U0-0004Ct-N4; Fri, 17 Dec 2021 04:04:36 +0000
Date:   Fri, 17 Dec 2021 12:04:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] pinctrl: add one more "const" for generic function groups
Message-ID: <202112171229.i6D3onAx-lkp@intel.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on v5.16-rc5 next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/pinctrl-add-one-more-const-for-generic-function-groups/20211216-014859
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: arm64-randconfig-s031-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171229.i6D3onAx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e4338a6ad34998afb60c5ad294aafa06cd7110a7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rafa-Mi-ecki/pinctrl-add-one-more-const-for-generic-function-groups/20211216-014859
        git checkout e4338a6ad34998afb60c5ad294aafa06cd7110a7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pinctrl/pinctrl-keembay.c:1594:29: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected char const **grp @@     got char const *const *group_names @@
   drivers/pinctrl/pinctrl-keembay.c:1594:29: sparse:     expected char const **grp
   drivers/pinctrl/pinctrl-keembay.c:1594:29: sparse:     got char const *const *group_names

vim +1594 drivers/pinctrl/pinctrl-keembay.c

ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1556  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1557  static int keembay_add_functions(struct keembay_pinctrl *kpc,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1558  				 struct function_desc *function)
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1559  {
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1560  	unsigned int i;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1561  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1562  	/* Assign the groups for each function */
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1563  	for (i = 0; i < kpc->npins; i++) {
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1564  		const struct pinctrl_pin_desc *pdesc = keembay_pins + i;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1565  		struct keembay_mux_desc *mux = pdesc->drv_data;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1566  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1567  		while (mux->name) {
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1568  			struct function_desc *func;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1569  			const char **grp;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1570  			size_t grp_size;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1571  			u32 j, grp_num;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1572  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1573  			for (j = 0; j < kpc->nfuncs; j++) {
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1574  				if (!strcmp(mux->name, function[j].name))
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1575  					break;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1576  			}
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1577  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1578  			if (j == kpc->nfuncs)
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1579  				return -EINVAL;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1580  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1581  			func = function + j;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1582  			grp_num = func->num_group_names;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1583  			grp_size = sizeof(*func->group_names);
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1584  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1585  			if (!func->group_names) {
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1586  				func->group_names = devm_kcalloc(kpc->dev,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1587  								 grp_num,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1588  								 grp_size,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1589  								 GFP_KERNEL);
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1590  				if (!func->group_names)
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1591  					return -ENOMEM;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1592  			}
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1593  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06 @1594  			grp = func->group_names;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1595  			while (*grp)
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1596  				grp++;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1597  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1598  			*grp = pdesc->name;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1599  			mux++;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1600  		}
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1601  	}
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1602  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1603  	/* Add all functions */
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1604  	for (i = 0; i < kpc->nfuncs; i++) {
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1605  		pinmux_generic_add_function(kpc->pctrl,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1606  					    function[i].name,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1607  					    function[i].group_names,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1608  					    function[i].num_group_names,
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1609  					    function[i].data);
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1610  	}
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1611  
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1612  	return 0;
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1613  }
ffd4e739358be03 Lakshmi Sowjanya D 2021-08-06  1614  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
