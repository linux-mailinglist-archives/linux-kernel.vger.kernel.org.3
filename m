Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD74CAF05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiCBTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbiCBTsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:48:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EEB11158
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646250455; x=1677786455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TXrrJddB4SOQCFhrejLi5KP1GkQ56qVMjaTRt8qYBPc=;
  b=NvE0iGCPtYqDtG5rsnJPyFVcBh8tA2waSsdpkCJG2/bh84GfiVF8auPM
   FuyLoPttG0U3QunMKNaItcfQCD1SbjjUPOSGReA3l7s2C4+v2L2ur6B8q
   Y/o2OiQ+GgVCGYGmZjdK9k+pX2mpQGwXOCT7Jjg6DSQS2NkHJa75+pl6f
   pMjnEtp45zS0ybt1eX6wQhfkRCzmH+mp/ojT+Cvk5S7XUU6p+oRkS70qA
   FgkaEkmY+wemgYBfw94/sUtaeUx24YrhU/76lawEo/YRino5pDl0s+aFQ
   8+zO+grI0hPywRiECEB3kN88W5MrKZ6al8oS+TCv454/xE6YEFfT816Ra
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252321161"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="252321161"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 11:47:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="511130508"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 11:47:33 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPUwf-0001qn-6Y; Wed, 02 Mar 2022 19:47:33 +0000
Date:   Thu, 3 Mar 2022 03:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: com90xx.c:undefined reference to `iounmap'
Message-ID: <202203030347.uFXSRjNB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb184c4af9b9f4563e7a126219389986a71d5b5b
commit: 71ba41c9b1d91042960e9d92a5c8f52dc8531eda s390/pci: provide support for MIO instructions
date:   2 years, 10 months ago
config: s390-randconfig-r044-20220109 (https://download.01.org/0day-ci/archive/20220303/202203030347.uFXSRjNB-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x128a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x12bc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x1472): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x52): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x23a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o:meson-rng.c:(.text+0x7c): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
>> com90xx.c:(.exit.text+0x5a): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
>> com90xx.c:(.init.text+0x4c): undefined reference to `ioremap'
>> s390-linux-ld: com90xx.c:(.init.text+0x6e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_found':
>> com90xx.c:(.init.text+0xe6): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x1ba): undefined reference to `iounmap'
>> s390-linux-ld: com90xx.c:(.init.text+0x2d4): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x3a2): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0x652): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x6ae): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x8d4): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
>> arc-rimi.c:(.exit.text+0x2e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
>> arc-rimi.c:(.init.text+0xb6): undefined reference to `ioremap'
>> s390-linux-ld: arc-rimi.c:(.init.text+0x136): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x29e): undefined reference to `iounmap'
>> s390-linux-ld: arc-rimi.c:(.init.text+0x326): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x3e4): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
>> arc-rimi.c:(.text.unlikely+0x4c): undefined reference to `ioremap'
>> s390-linux-ld: arc-rimi.c:(.text.unlikely+0x6e): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x220): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x232): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x288): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x29e): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xce4): undefined reference to `iounmap'
   s390-linux-ld: drivers/watchdog/sirfsoc_wdt.o: in function `sirfsoc_wdt_probe':
   sirfsoc_wdt.c:(.text+0x116): undefined reference to `devm_ioremap_resource'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
