Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10364EFF6E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiDBHon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiDBHok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:44:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9915758D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648885368; x=1680421368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qAsRMYduxtz6+UWvcPPYWMnxh3lHi7QCAPYZhZyMkR0=;
  b=JMVVIdN/TZ9LRSPpSY9hy7sr7PGiz5o5IC/DDEVFuYXK5tNMs3JZy2n7
   i+LX2TpN2IMPgd75PLzJ+NvmVXmsY8bERvcpNK2nrbdmKBJspOdOGm6KP
   olcmH/P1aFLYy9RBXxl42qBshqhhMh+hqSqgjBKZH/CUUNW1fFr8YjV/O
   wlxdykD6InEHYd81FR7gg9CJR6VBk0hvdOGDqJ1zspJ0VvLWUK5Cm4610
   rgHq/dCv2kSs8D/ALNCgIHSRaLbJidTUzHe4fXTmSslxxzSHLI6nJZn2V
   9hliOH4vJI2QAjHpBhviCWLnwviUpHKxygth7dAUCCSU45V5l2ilW0egj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346724026"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="346724026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 00:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504412636"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 00:42:45 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naYPE-000228-L2;
        Sat, 02 Apr 2022 07:42:44 +0000
Date:   Sat, 2 Apr 2022 15:42:04 +0800
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
Message-ID: <202204021517.GCfe74Py-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
date:   9 days ago
config: s390-randconfig-r012-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021517.GCfe74Py-lkp@intel.com/config)
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

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
>> drivers/irqchip/irq-al-fic.c:252: undefined reference to `of_iomap'
>> s390-linux-ld: drivers/irqchip/irq-al-fic.c:282: undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   drivers/clk/clk-fixed-mmio.c:26: undefined reference to `of_iomap'
   s390-linux-ld: drivers/clk/clk-fixed-mmio.c:33: undefined reference to `iounmap'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   drivers/char/xillybus/xillybus_of.c:50: undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `init_cc_resources':
   drivers/crypto/ccree/cc_driver.c:355: undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   drivers/crypto/ccree/cc_debugfs.c:80: undefined reference to `debugfs_create_regset32'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.c:100: undefined reference to `debugfs_create_regset32'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_init':
   drivers/clocksource/timer-of.c:159: undefined reference to `of_iomap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_exit':
   drivers/clocksource/timer-of.c:151: undefined reference to `iounmap'
>> s390-linux-ld: drivers/clocksource/timer-of.c:151: undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   drivers/clocksource/timer-microchip-pit64b.c:436: undefined reference to `of_iomap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.c:486: undefined reference to `iounmap'


vim +252 drivers/irqchip/irq-al-fic.c

1eb77c3bcdb70f Talel Shenhar 2019-06-10  237  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  238  static int __init al_fic_init_dt(struct device_node *node,
1eb77c3bcdb70f Talel Shenhar 2019-06-10  239  				 struct device_node *parent)
1eb77c3bcdb70f Talel Shenhar 2019-06-10  240  {
1eb77c3bcdb70f Talel Shenhar 2019-06-10  241  	int ret;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  242  	void __iomem *base;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  243  	unsigned int parent_irq;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  244  	struct al_fic *fic;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  245  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  246  	if (!parent) {
1eb77c3bcdb70f Talel Shenhar 2019-06-10  247  		pr_err("%s: unsupported - device require a parent\n",
1eb77c3bcdb70f Talel Shenhar 2019-06-10  248  		       node->name);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  249  		return -EINVAL;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  250  	}
1eb77c3bcdb70f Talel Shenhar 2019-06-10  251  
1eb77c3bcdb70f Talel Shenhar 2019-06-10 @252  	base = of_iomap(node, 0);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  253  	if (!base) {
1eb77c3bcdb70f Talel Shenhar 2019-06-10  254  		pr_err("%s: fail to map memory\n", node->name);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  255  		return -ENOMEM;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  256  	}
1eb77c3bcdb70f Talel Shenhar 2019-06-10  257  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  258  	parent_irq = irq_of_parse_and_map(node, 0);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  259  	if (!parent_irq) {
1eb77c3bcdb70f Talel Shenhar 2019-06-10  260  		pr_err("%s: fail to map irq\n", node->name);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  261  		ret = -EINVAL;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  262  		goto err_unmap;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  263  	}
1eb77c3bcdb70f Talel Shenhar 2019-06-10  264  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  265  	fic = al_fic_wire_init(node,
1eb77c3bcdb70f Talel Shenhar 2019-06-10  266  			       base,
1eb77c3bcdb70f Talel Shenhar 2019-06-10  267  			       node->name,
1eb77c3bcdb70f Talel Shenhar 2019-06-10  268  			       parent_irq);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  269  	if (IS_ERR(fic)) {
1eb77c3bcdb70f Talel Shenhar 2019-06-10  270  		pr_err("%s: fail to initialize irqchip (%lu)\n",
1eb77c3bcdb70f Talel Shenhar 2019-06-10  271  		       node->name,
1eb77c3bcdb70f Talel Shenhar 2019-06-10  272  		       PTR_ERR(fic));
1eb77c3bcdb70f Talel Shenhar 2019-06-10  273  		ret = PTR_ERR(fic);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  274  		goto err_irq_dispose;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  275  	}
1eb77c3bcdb70f Talel Shenhar 2019-06-10  276  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  277  	return 0;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  278  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  279  err_irq_dispose:
1eb77c3bcdb70f Talel Shenhar 2019-06-10  280  	irq_dispose_mapping(parent_irq);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  281  err_unmap:
1eb77c3bcdb70f Talel Shenhar 2019-06-10 @282  	iounmap(base);
1eb77c3bcdb70f Talel Shenhar 2019-06-10  283  
1eb77c3bcdb70f Talel Shenhar 2019-06-10  284  	return ret;
1eb77c3bcdb70f Talel Shenhar 2019-06-10  285  }
1eb77c3bcdb70f Talel Shenhar 2019-06-10  286  

:::::: The code at line 252 was first introduced by commit
:::::: 1eb77c3bcdb70f2501f419b3da45b19acaf01072 irqchip/al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt Controller Driver

:::::: TO: Talel Shenhar <talel@amazon.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
