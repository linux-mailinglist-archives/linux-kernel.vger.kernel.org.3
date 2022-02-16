Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5C4B8D29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiBPQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:03:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiBPQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:03:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AAA1ED1F4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645027369; x=1676563369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Go6SPGW0Dhq+tJy23R6dUPUDSfYPivomuuhjvNdQh5c=;
  b=Uv0vmORc0YDRObansTT5UgQI0WqFZFHPGQvE1vsjX8hCZK+G05knt8r/
   Xr8FYoUnIXrQOq/LR0U+9QtxxKWwbbWChuQYVOiEVj5z9H7euwBB5Y79O
   2KLRWM6K9/uNrRy4qaa4NV9B0e7j/963YIL+IrD8qvKLpDV+uFqlgb/yg
   goHETzqV8xJqk8Celh88qgMiDSzAyKpuj15cABHeac3JlGa61dUlF6zJl
   G3WadJMAHKba8yLvbhFvP+9dmQJqak2qPHfVe+qbmrPCwoH2P7hODq0WB
   seGBZIqFMbLvpR88+zZ0Ln7iAcqSI263VMJf0tuwpBsqSV61lkbIMzIvB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249483777"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249483777"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 08:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="503088259"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2022 08:00:42 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKMjR-000Av6-HK; Wed, 16 Feb 2022 16:00:41 +0000
Date:   Thu, 17 Feb 2022 00:00:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: coreboot_table.c:undefined reference to `memremap'
Message-ID: <202202162338.iHngg0KZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5d9ae265b105d9a67575fb67bd4650a6fc08e25
commit: 951cd3a0866d29cb9c01ebc1d9c17590e598226e firmware: include drivers/firmware/Kconfig unconditionally
date:   4 months ago
config: s390-randconfig-r023-20220216 (https://download.01.org/0day-ci/archive/20220216/202202162338.iHngg0KZ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=951cd3a0866d29cb9c01ebc1d9c17590e598226e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 951cd3a0866d29cb9c01ebc1d9c17590e598226e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x96): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0x118): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0x10ee): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0x181c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x38bc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x28ec): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x2934): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   xillybus_of.c:(.text+0x2c0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x1b98): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
>> coreboot_table.c:(.text+0x596): undefined reference to `memremap'
>> s390-linux-ld: coreboot_table.c:(.text+0x646): undefined reference to `memunmap'
>> s390-linux-ld: coreboot_table.c:(.text+0x692): undefined reference to `memremap'
   s390-linux-ld: coreboot_table.c:(.text+0x6dc): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
>> memconsole-coreboot.c:(.text+0x2f6): undefined reference to `memremap'
>> s390-linux-ld: memconsole-coreboot.c:(.text+0x3ca): undefined reference to `devm_memremap'
>> s390-linux-ld: memconsole-coreboot.c:(.text+0x3da): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
   vpd.c:(.text+0x812): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
   vpd.c:(.text+0x986): undefined reference to `memremap'
   s390-linux-ld: vpd.c:(.text+0xc04): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
   vpd.c:(.text+0xe0c): undefined reference to `memremap'
   s390-linux-ld: vpd.c:(.text+0xe32): undefined reference to `memunmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
