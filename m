Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD37476669
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhLOXS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:18:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:27488 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhLOXS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639610305; x=1671146305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J9CVgNUuhMP1qYMs4+idikxQqt8JvMU/Q608H6x0Bq4=;
  b=oEXhTL0hGgh6J5cBjFRi2VF3QcLtnZ5Rx01RAWt4DXKtmWBH0gJWJ77e
   NknFyXhANm+R71nTN7OsJ2BdvcYVzYGPGNqFjGj8APGDEGNahBKMVt1DC
   GT5/R1sfzrB3wEPqwA3mSOQ/prsMArC15y1A8B4bJg/DoQeE3943R3EW9
   oUVPWDAOHfuHAXhKyTS7vXFLny9E5y/kjZ9dTjktELF8yNyoCVCzUyTBs
   T8yrpTsSENBG3bRM5wcleAsSiIibv39OscuQqDENJaHiQPvVFVziZ4U6S
   y2H4PqMw8Ie990PRgm06OCmhCrVLtpZk/e0QO6UWCan/2Lozi3M+7EKk1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="325637363"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="325637363"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 15:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="464461571"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2021 15:18:23 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxdXS-0002TR-Px; Wed, 15 Dec 2021 23:18:22 +0000
Date:   Thu, 16 Dec 2021 07:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] pinctrl: add one more "const" for generic function groups
Message-ID: <202112160723.nSvHR7gk-lkp@intel.com>
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
config: arm-randconfig-c002-20211214 (https://download.01.org/0day-ci/archive/20211216/202112160723.nSvHR7gk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e4338a6ad34998afb60c5ad294aafa06cd7110a7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rafa-Mi-ecki/pinctrl-add-one-more-const-for-generic-function-groups/20211216-014859
        git checkout e4338a6ad34998afb60c5ad294aafa06cd7110a7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/freescale/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pinctrl/freescale/pinctrl-imx.c: In function 'imx_pinctrl_parse_functions':
>> drivers/pinctrl/freescale/pinctrl-imx.c:672:38: error: assignment of read-only location '*(func->group_names + (sizetype)(i * 4))'
     672 |                 func->group_names[i] = child->name;
         |                                      ^


vim +672 drivers/pinctrl/freescale/pinctrl-imx.c

ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  642  
150632b09aadf1 drivers/pinctrl/pinctrl-imx.c           Greg Kroah-Hartman 2012-12-21  643  static int imx_pinctrl_parse_functions(struct device_node *np,
e566fc11ea76ec drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  644  				       struct imx_pinctrl *ipctl,
150632b09aadf1 drivers/pinctrl/pinctrl-imx.c           Greg Kroah-Hartman 2012-12-21  645  				       u32 index)
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  646  {
e566fc11ea76ec drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  647  	struct pinctrl_dev *pctl = ipctl->pctl;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  648  	struct device_node *child;
3fd6d6ad73af90 drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  649  	struct function_desc *func;
e566fc11ea76ec drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  650  	struct group_desc *grp;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  651  	u32 i = 0;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  652  
94f4e54cecaf3e drivers/pinctrl/freescale/pinctrl-imx.c Rob Herring        2018-08-27  653  	dev_dbg(pctl->dev, "parse function(%d): %pOFn\n", index, np);
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  654  
3fd6d6ad73af90 drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  655  	func = pinmux_generic_get_function(pctl, index);
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  656  	if (!func)
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  657  		return -EINVAL;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  658  
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  659  	/* Initialise function */
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  660  	func->name = np->name;
3fd6d6ad73af90 drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  661  	func->num_group_names = of_get_child_count(np);
3fd6d6ad73af90 drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  662  	if (func->num_group_names == 0) {
f5843492ecefcf drivers/pinctrl/freescale/pinctrl-imx.c Stefan Agner       2018-01-06  663  		dev_err(ipctl->dev, "no groups defined in %pOF\n", np);
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  664  		return -EINVAL;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  665  	}
f5843492ecefcf drivers/pinctrl/freescale/pinctrl-imx.c Stefan Agner       2018-01-06  666  	func->group_names = devm_kcalloc(ipctl->dev, func->num_group_names,
3fd6d6ad73af90 drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  667  					 sizeof(char *), GFP_KERNEL);
49af64e6b52208 drivers/pinctrl/freescale/pinctrl-imx.c Christophe JAILLET 2017-05-06  668  	if (!func->group_names)
49af64e6b52208 drivers/pinctrl/freescale/pinctrl-imx.c Christophe JAILLET 2017-05-06  669  		return -ENOMEM;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  670  
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  671  	for_each_child_of_node(np, child) {
3fd6d6ad73af90 drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02 @672  		func->group_names[i] = child->name;
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  673  
f5843492ecefcf drivers/pinctrl/freescale/pinctrl-imx.c Stefan Agner       2018-01-06  674  		grp = devm_kzalloc(ipctl->dev, sizeof(struct group_desc),
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  675  				   GFP_KERNEL);
bf4b87b0d06aa3 drivers/pinctrl/freescale/pinctrl-imx.c Nishka Dasgupta    2019-08-08  676  		if (!grp) {
bf4b87b0d06aa3 drivers/pinctrl/freescale/pinctrl-imx.c Nishka Dasgupta    2019-08-08  677  			of_node_put(child);
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  678  			return -ENOMEM;
bf4b87b0d06aa3 drivers/pinctrl/freescale/pinctrl-imx.c Nishka Dasgupta    2019-08-08  679  		}
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  680  
f5843492ecefcf drivers/pinctrl/freescale/pinctrl-imx.c Stefan Agner       2018-01-06  681  		mutex_lock(&ipctl->mutex);
e566fc11ea76ec drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2017-01-02  682  		radix_tree_insert(&pctl->pin_group_tree,
f5843492ecefcf drivers/pinctrl/freescale/pinctrl-imx.c Stefan Agner       2018-01-06  683  				  ipctl->group_index++, grp);
f5843492ecefcf drivers/pinctrl/freescale/pinctrl-imx.c Stefan Agner       2018-01-06  684  		mutex_unlock(&ipctl->mutex);
a51c158bf0f7ca drivers/pinctrl/freescale/pinctrl-imx.c Gary Bisson        2016-12-02  685  
a5cadbbb081cb8 drivers/pinctrl/freescale/pinctrl-imx.c Dong Aisheng       2017-05-19  686  		imx_pinctrl_parse_groups(child, grp, ipctl, i++);
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  687  	}
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  688  
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  689  	return 0;
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  690  }
ae75ff81453840 drivers/pinctrl/pinctrl-imx.c           Dong Aisheng       2012-04-27  691  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
