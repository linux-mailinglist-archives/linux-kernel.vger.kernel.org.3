Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA9552234
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiFTQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiFTQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:26:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F27C1D317
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655742400; x=1687278400;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f7g5q36s3nBOH9s2jmYUtqMFNU2MA/u3zaucBxlEbHc=;
  b=nq505Ox3R+Fvs7phDJ6NDoYUsnVNvzG9Cc9CO/AGGekVCJi9mMHz53T2
   sDv5oq4UgNciPjM+xSnMWmd2ub0t0QbQLXYHGXvVoVxaQQk10doxkOxL0
   qEQ5AklN4GegQuHLIFaldSTN2fANvorfHAcEQZQzTeqK+x/DDuoxf2Kc4
   iyGgoOMSlh8JeBfzCpjDUte92GD1NUUWy4ci9pU9DjNzc5I8c7No5nGx7
   VG5A7r+9/N88ANVjaLnmO9cn3M93mICDNhDMsTdVYvWW7kHQI+8iJjE5s
   DcKANE9wp2SlWrppiRBjZMGF1q1EhvWGN9/6UPkwxLXxvDCeTf/yqFvly
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="366257595"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="366257595"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 09:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="591243077"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2022 09:25:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3KDG-000UBr-44;
        Mon, 20 Jun 2022 16:25:18 +0000
Date:   Tue, 21 Jun 2022 00:24:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/soc/ixp4xx/ixp4xx-npe.c:737:34: warning:
 'ixp4xx_npe_of_match' defined but not used
Message-ID: <202206210010.piIa6O1b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: 7f94b69ece515ac82defa60ef7cba2cf26180216 ARM: ixp4xx: fix compile-testing soc drivers
date:   11 months ago
config: x86_64-buildonly-randconfig-r003-20220620 (https://download.01.org/0day-ci/archive/20220621/202206210010.piIa6O1b-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f94b69ece515ac82defa60ef7cba2cf26180216
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7f94b69ece515ac82defa60ef7cba2cf26180216
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/rockchip/ drivers/irqchip/ drivers/soc/ixp4xx/ kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/ixp4xx/ixp4xx-npe.c:696:25: note: in expansion of macro 'dev_info'
     696 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
         |                         ^~~~~~~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:696:54: note: format string is defined here
     696 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      unsigned int
         |                                                   %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
   drivers/soc/ixp4xx/ixp4xx-npe.c:696:39: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     696 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:696:25: note: in expansion of macro 'dev_info'
     696 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
         |                         ^~~~~~~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:696:61: note: format string is defined here
     696 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
         |                                                          ~~~^
         |                                                             |
         |                                                             unsigned int
         |                                                          %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
   drivers/soc/ixp4xx/ixp4xx-npe.c:705:39: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     705 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:705:25: note: in expansion of macro 'dev_info'
     705 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
         |                         ^~~~~~~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:705:54: note: format string is defined here
     705 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
         |                                                   ~~~^
         |                                                      |
         |                                                      unsigned int
         |                                                   %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
   drivers/soc/ixp4xx/ixp4xx-npe.c:705:39: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     705 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:705:25: note: in expansion of macro 'dev_info'
     705 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
         |                         ^~~~~~~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:705:61: note: format string is defined here
     705 |                         dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
         |                                                          ~~~^
         |                                                             |
         |                                                             unsigned int
         |                                                          %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
   drivers/soc/ixp4xx/ixp4xx-npe.c:710:31: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     710 |                 dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:710:17: note: in expansion of macro 'dev_info'
     710 |                 dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
         |                 ^~~~~~~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:710:46: note: format string is defined here
     710 |                 dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
         |                                           ~~~^
         |                                              |
         |                                              unsigned int
         |                                           %08llx
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
   drivers/soc/ixp4xx/ixp4xx-npe.c:710:31: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     710 |                 dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:710:17: note: in expansion of macro 'dev_info'
     710 |                 dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
         |                 ^~~~~~~~
   drivers/soc/ixp4xx/ixp4xx-npe.c:710:53: note: format string is defined here
     710 |                 dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
         |                                                  ~~~^
         |                                                     |
         |                                                     unsigned int
         |                                                  %08llx
   At top level:
>> drivers/soc/ixp4xx/ixp4xx-npe.c:737:34: warning: 'ixp4xx_npe_of_match' defined but not used [-Wunused-const-variable=]
     737 | static const struct of_device_id ixp4xx_npe_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/ixp4xx_npe_of_match +737 drivers/soc/ixp4xx/ixp4xx-npe.c

82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  679  
bc4d7eafb7ad59 drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  680  static int ixp4xx_npe_probe(struct platform_device *pdev)
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  681  {
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  682  	int i, found = 0;
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  683  	struct device *dev = &pdev->dev;
76f24b4f46b8ca drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2021-05-25  684  	struct device_node *np = dev->of_node;
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  685  	struct resource *res;
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  686  
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  687  	for (i = 0; i < NPE_COUNT; i++) {
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  688  		struct npe *npe = &npe_tab[i];
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  689  
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  690  		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  691  		if (!res)
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  692  			return -ENODEV;
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  693  
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  694  		if (!(ixp4xx_read_feature_bits() &
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  695  		      (IXP4XX_FEATURE_RESET_NPEA << i))) {
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  696  			dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  697  				 i, res->start, res->end);
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  698  			continue; /* NPE already disabled or not present */
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  699  		}
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  700  		npe->regs = devm_ioremap_resource(dev, res);
cd3967bee004bc drivers/soc/ixp4xx/ixp4xx-npe.c   Dan Carpenter    2019-06-18  701  		if (IS_ERR(npe->regs))
cd3967bee004bc drivers/soc/ixp4xx/ixp4xx-npe.c   Dan Carpenter    2019-06-18  702  			return PTR_ERR(npe->regs);
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  703  
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  704  		if (npe_reset(npe)) {
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  705  			dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  706  				 i, res->start, res->end);
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  707  			continue;
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  708  		}
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  709  		npe->valid = 1;
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10 @710  		dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  711  			 i, res->start, res->end);
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  712  		found++;
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  713  	}
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  714  
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  715  	if (!found)
3ba8c792055286 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Hałasa 2009-04-28  716  		return -ENODEV;
76f24b4f46b8ca drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2021-05-25  717  
76f24b4f46b8ca drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2021-05-25  718  	/* Spawn crypto subdevice if using device tree */
76f24b4f46b8ca drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2021-05-25  719  	if (IS_ENABLED(CONFIG_OF) && np)
76f24b4f46b8ca drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2021-05-25  720  		devm_of_platform_populate(dev);
76f24b4f46b8ca drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2021-05-25  721  
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  722  	return 0;
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  723  }
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  724  
bc4d7eafb7ad59 drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  725  static int ixp4xx_npe_remove(struct platform_device *pdev)
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  726  {
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  727  	int i;
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  728  
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  729  	for (i = 0; i < NPE_COUNT; i++)
0b458d7b10f83e drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  730  		if (npe_tab[i].regs) {
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  731  			npe_reset(&npe_tab[i]);
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  732  		}
bc4d7eafb7ad59 drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  733  
bc4d7eafb7ad59 drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  734  	return 0;
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  735  }
82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_npe.c Krzysztof Halasa 2008-01-01  736  
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10 @737  static const struct of_device_id ixp4xx_npe_of_match[] = {
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  738  	{
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  739  		.compatible = "intel,ixp4xx-network-processing-engine",
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  740          },
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  741  	{},
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  742  };
e00797f2e05b7f drivers/soc/ixp4xx/ixp4xx-npe.c   Linus Walleij    2019-02-10  743  

:::::: The code at line 737 was first introduced by commit
:::::: e00797f2e05b7f3758bb96e6248aff8d95999cec soc: ixp4xx: npe: Add DT probe code

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
