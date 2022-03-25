Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDB4E6D87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358319AbiCYFMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYFMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:12:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8EC3340
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648185041; x=1679721041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XDY853qZuhVljacwr/6rQGszK4wCR2ivJapIjVsEuHc=;
  b=UHTMw1jyvWmQmFO0hpZNCKhazTd/WEC9aMCPwROpXsd2Qi2tXo3oYSJ5
   iPk0fEqywikAzBIoOWawn+a7ClHeSOUO1R1iWEhQdCInOCOtxKSF5Oi0E
   oh/Iira8IisYgx6jN+3H4WSeDPeC7OfGBXMBbDQ9sOLdx8+ZHwc73Ug4Y
   54AZKgt7txjZB+MWjtYohTMNDVSYuZqUrcQgr53ITstHoso1x/HN2bgT8
   4/YYMSxRdVo3nZ7msTtm+MtBJprVlIuPhfRW4xz9/5GNOt60MeYGD7qJx
   Et16m59wAwf4CVWKknfMNcR5XPcQBB+9r/8L5oM0lT1G2HiWbCclhUBv3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283422748"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="283422748"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 22:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="501661701"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2022 22:10:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXcDe-000Lou-3X; Fri, 25 Mar 2022 05:10:38 +0000
Date:   Fri, 25 Mar 2022 13:09:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/irqchip/irq-al-fic.c:252: undefined reference to `of_iomap'
Message-ID: <202203251340.vhdRFCvH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   27 hours ago
config: s390-randconfig-r044-20220325 (https://download.01.org/0day-ci/archive/20220325/202203251340.vhdRFCvH-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9b3cd24578401e7a392974b3353277286e49cee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f9b3cd24578401e7a392974b3353277286e49cee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   kernel/dma/coherent.c:48: undefined reference to `memremap'
   s390-linux-ld: kernel/dma/coherent.c:71: undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_release_coherent_memory':
   kernel/dma/coherent.c:82: undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
>> drivers/irqchip/irq-al-fic.c:252: undefined reference to `of_iomap'
>> s390-linux-ld: drivers/irqchip/irq-al-fic.c:282: undefined reference to `iounmap'


vim +252 drivers/irqchip/irq-al-fic.c

1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  237  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  238  static int __init al_fic_init_dt(struct device_node *node,
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  239  				 struct device_node *parent)
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  240  {
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  241  	int ret;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  242  	void __iomem *base;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  243  	unsigned int parent_irq;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  244  	struct al_fic *fic;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  245  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  246  	if (!parent) {
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  247  		pr_err("%s: unsupported - device require a parent\n",
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  248  		       node->name);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  249  		return -EINVAL;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  250  	}
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  251  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10 @252  	base = of_iomap(node, 0);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  253  	if (!base) {
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  254  		pr_err("%s: fail to map memory\n", node->name);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  255  		return -ENOMEM;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  256  	}
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  257  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  258  	parent_irq = irq_of_parse_and_map(node, 0);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  259  	if (!parent_irq) {
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  260  		pr_err("%s: fail to map irq\n", node->name);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  261  		ret = -EINVAL;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  262  		goto err_unmap;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  263  	}
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  264  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  265  	fic = al_fic_wire_init(node,
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  266  			       base,
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  267  			       node->name,
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  268  			       parent_irq);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  269  	if (IS_ERR(fic)) {
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  270  		pr_err("%s: fail to initialize irqchip (%lu)\n",
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  271  		       node->name,
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  272  		       PTR_ERR(fic));
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  273  		ret = PTR_ERR(fic);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  274  		goto err_irq_dispose;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  275  	}
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  276  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  277  	return 0;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  278  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  279  err_irq_dispose:
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  280  	irq_dispose_mapping(parent_irq);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  281  err_unmap:
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10 @282  	iounmap(base);
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  283  
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  284  	return ret;
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  285  }
1eb77c3bcdb70f2 Talel Shenhar 2019-06-10  286  

:::::: The code at line 252 was first introduced by commit
:::::: 1eb77c3bcdb70f2501f419b3da45b19acaf01072 irqchip/al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt Controller Driver

:::::: TO: Talel Shenhar <talel@amazon.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
