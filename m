Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0194B6AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiBOLYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:24:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiBOLX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:23:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600E1081AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644924228; x=1676460228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VTrj4oy56BaFz0aV2jHKrSd8VafIir/s/Q9b3EX1XZQ=;
  b=PLTamBsItqM6gcoLBmP4fFng+BwGfwqUv6/lm/T9uKSjyOJA5mNKQirO
   bs8pCwpp3VV58x9MiGhnTYRZom1OChVV6rV4JuhcDzyykMtosGwV3nE73
   giii0pc0a1zEYKVmdw5yKWWIT/b2oDLKfK4GlrdT2rBgGPXIJK1KU51BY
   g8Qtx9Xy6t+IvCeeqYO5s2Va+zQtP+FT+RbGLUQITvKvFCcBFsbY0jdSG
   q6AyXCAkaUB93+kanLqGRPWwl4HhKkcIrN+vteYyuO23llN0We+RpInmY
   TK6NB8RnkLSedxKtX0Wwu1Hd4r34dkwdGW87bZwWdvMyLI+EdKecXb/Bo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250072374"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250072374"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 03:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635815139"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 03:23:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJvvt-0009aq-Tr; Tue, 15 Feb 2022 11:23:45 +0000
Date:   Tue, 15 Feb 2022 19:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: s390-linux-ld: clk-lan966x.c:undefined reference to
 `devm_ioremap_resource'
Message-ID: <202202151735.xsCmIbXH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d567f5db412ed52de0b3b3efca4a451263de6108
commit: 5ad5915dea0047a6376d8f809ea3470ef68b1f92 clk: lan966x: Extend lan966x clock driver for clock gating support
date:   10 weeks ago
config: s390-randconfig-r044-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151735.xsCmIbXH-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ad5915dea0047a6376d8f809ea3470ef68b1f92
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5ad5915dea0047a6376d8f809ea3470ef68b1f92
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x72): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x786): undefined reference to `iounmap'
   s390-linux-ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
   clk-lan966x.c:(.text+0x950): undefined reference to `devm_platform_ioremap_resource'
>> s390-linux-ld: clk-lan966x.c:(.text+0xb1c): undefined reference to `devm_ioremap_resource'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
