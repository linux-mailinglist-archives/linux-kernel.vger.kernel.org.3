Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E612497C68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiAXJsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:48:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:35193 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236813AbiAXJsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643017716; x=1674553716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/oYxsirf7P0gkPABCnVKKwxr+/GwhGW+BNMVMkHlfgg=;
  b=mf+yXu/DVWKH+XtUlwsrmRBZInn0aVLy3uqTUkc4PrGKOxP0fC8bw1V8
   TY/URvg/nhs6qmPmokYNzMWq95ATZHUkT30VemCHUbV/pPT7yk1AKLkCH
   ohNW0w2ZQncK0fV5oQ3a5D/DOi9fbnVHRmnbMl6bfi8BYniNsh3QCHqoR
   ecNONuO6fcUhUjd80zXZodF2ZgAK+fPoSab8itS+4zSkrZ0a1FUnkZd7N
   SHEs0XUmjrEYCFZCu467OuFcaSajsIH8fXuRnkzO2YjIkc2XRZTJFIA+L
   ItA8nVoNTriRyB903tIgyIPA/R2I4lEuOUDGMXCSbUXg6UuZbDV+x/iMc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270443480"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270443480"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 01:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596740940"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 01:48:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBvxc-000I82-7u; Mon, 24 Jan 2022 09:48:28 +0000
Date:   Mon, 24 Jan 2022 17:48:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] drivers: irqchip: add irq-type-changer
Message-ID: <202201241716.mt2XBMZQ-lkp@intel.com>
References: <20220119201741.717770-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119201741.717770-1-nikita.yoush@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nikita-Yushchenko/drivers-irqchip-add-irq-type-changer/20220120-041926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 67d50b5f9114ae55d45e08e1fd1d6ae152622bf3
config: microblaze-randconfig-s032-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241716.mt2XBMZQ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/08692091f6fa9d1ee51baef78ce2adf983b2248a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nikita-Yushchenko/drivers-irqchip-add-irq-type-changer/20220120-041926
        git checkout 08692091f6fa9d1ee51baef78ce2adf983b2248a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-type-changer.c:111:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] size @@     got restricted gfp_t @@
   drivers/irqchip/irq-type-changer.c:111:22: sparse:     expected unsigned int [usertype] size
   drivers/irqchip/irq-type-changer.c:111:22: sparse:     got restricted gfp_t
>> drivers/irqchip/irq-type-changer.c:111:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted gfp_t [usertype] flags @@     got unsigned int @@
   drivers/irqchip/irq-type-changer.c:111:46: sparse:     expected restricted gfp_t [usertype] flags
   drivers/irqchip/irq-type-changer.c:111:46: sparse:     got unsigned int

vim +111 drivers/irqchip/irq-type-changer.c

    81	
    82	static int __init changer_of_init(struct device_node *node,
    83					  struct device_node *parent)
    84	{
    85		struct irq_domain *domain, *parent_domain;
    86		int count, i, ret;
    87		struct changer *ch;
    88		struct of_phandle_args pargs;
    89		irq_hw_number_t unused;
    90	
    91		if (!parent) {
    92			pr_err("%pOF: no parent node\n", node);
    93			return -EINVAL;
    94		}
    95	
    96		parent_domain = irq_find_host(parent);
    97		if (!parent_domain) {
    98			pr_err("%pOF: no parent domain\n", node);
    99			return -EINVAL;
   100		}
   101	
   102		if (WARN_ON(!parent_domain->ops->translate))
   103			return -EINVAL;
   104	
   105		count = of_irq_count(node);
   106		if (count < 1) {
   107			pr_err("%pOF: no interrupts defined\n", node);
   108			return -EINVAL;
   109		}
   110	
 > 111		ch = kzalloc(GFP_KERNEL, sizeof(*ch) + count * sizeof(ch->out[0]));
   112		if (!ch)
   113			return -ENOMEM;
   114		ch->count = count;
   115	
   116		for (i = 0; i < count; i++) {
   117			ret = of_irq_parse_one(node, i, &pargs);
   118			if (ret) {
   119				pr_err("%pOF: interrupt %d: error %d parsing\n",
   120				       node, i, ret);
   121				goto out_free;
   122			}
   123			of_phandle_args_to_fwspec(pargs.np, pargs.args,
   124						  pargs.args_count,
   125						  &ch->out[i].fwspec);
   126			ret = parent_domain->ops->translate(parent_domain,
   127							    &ch->out[i].fwspec,
   128							    &unused,
   129							    &ch->out[i].type);
   130			if (ret) {
   131				pr_err("%pOF: interrupt %d: error %d extracting type\n",
   132				       node, i, ret);
   133				goto out_free;
   134			}
   135			if (ch->out[i].type == IRQ_TYPE_NONE) {
   136				pr_err("%pOF: interrupt %d: no type\n", node, i);
   137				ret = -ENXIO;
   138				goto out_free;
   139			}
   140		}
   141	
   142		domain = irq_domain_create_hierarchy(parent_domain, 0, count,
   143						     of_node_to_fwnode(node),
   144						     &changer_domain_ops, ch);
   145		if (!domain) {
   146			ret = -ENOMEM;
   147			goto out_free;
   148		}
   149	
   150		return 0;
   151	
   152	out_free:
   153		kfree(ch);
   154		return ret;
   155	}
   156	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
