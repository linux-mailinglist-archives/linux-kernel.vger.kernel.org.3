Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20703530B93
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiEWInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiEWInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:43:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54515A1B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653295432; x=1684831432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yrIx6pomST4Cy/AfAiPlIJCC/mgu8cCMhucs9oiKghY=;
  b=B3fqS+rxrwJWmOelmOfzwQZfp6FENtLujSdWLlpW9grUHowSnxiqWQfT
   3RIR4EDB1EHj+upfvb4zPThBbFF6BMC6fPnztsSIlJzisi5amkuVqJj8s
   xE3utru2khIsOzqg/VLdeiv9+9WBo1lsMb9CdyxmVEBATEXm3J3ZDgHyo
   Ma6fP7zb4Gv7QM7qjl2huyPWb9skgl7pF5Qj4nNO7Chv/Xp9iQWM09LgX
   8lPu9XTjBxcuLGHs+8xwhb7pVPmrF21ehzBt61bOWu2kGvl0/P9D6BmVf
   O3y9WcTQAgU70OZGhLeqQvfbzxaA7z7Zb6n5HcU9uxmbDYRIbdAQC56BR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="336210679"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="336210679"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 01:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="525817497"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 May 2022 01:43:50 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nt3fJ-00010A-92;
        Mon, 23 May 2022 08:43:49 +0000
Date:   Mon, 23 May 2022 16:43:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/soc/ixp4xx/ixp4xx-qmgr.c:451:34: warning:
 'ixp4xx_qmgr_of_match' defined but not used
Message-ID: <202205231601.bE28TyYb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   4b0986a3613c92f4ec1bdc7f60ec66fea135991f
commit: 7f94b69ece515ac82defa60ef7cba2cf26180216 ARM: ixp4xx: fix compile-testing soc drivers
date:   10 months ago
config: i386-buildonly-randconfig-r002-20220523 (https://download.01.org/0day-ci/archive/20220523/202205231601.bE28TyYb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f94b69ece515ac82defa60ef7cba2cf26180216
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7f94b69ece515ac82defa60ef7cba2cf26180216
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/clk/imx/ drivers/irqchip/ drivers/media/platform/ drivers/soc/ixp4xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/ixp4xx/ixp4xx-qmgr.c:451:34: warning: 'ixp4xx_qmgr_of_match' defined but not used [-Wunused-const-variable=]
     451 | static const struct of_device_id ixp4xx_qmgr_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~
--
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


vim +/ixp4xx_qmgr_of_match +451 drivers/soc/ixp4xx/ixp4xx-qmgr.c

82a96f5790ac93 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c Krzysztof Halasa 2008-01-01  450  
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10 @451  static const struct of_device_id ixp4xx_qmgr_of_match[] = {
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10  452  	{
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10  453  		.compatible = "intel,ixp4xx-ahb-queue-manager",
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10  454          },
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10  455  	{},
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10  456  };
9e01a00958405f drivers/soc/ixp4xx/ixp4xx-qmgr.c   Linus Walleij    2019-02-10  457  

:::::: The code at line 451 was first introduced by commit
:::::: 9e01a00958405f59e0a85fd16eb4e879e983ea74 soc: ixp4xx: qmgr: Add DT probe code

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
