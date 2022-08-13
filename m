Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FE05919B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiHMJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiHMJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:43:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CCA647E2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660383796; x=1691919796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ajoVJ+xOWkkTuv3AAjY1HB5x1d++MyD4zkAJ6N9lY7M=;
  b=Nz6GSNufkzR12gVnAomgUsBQGvhrWfzP4ANLlWVWvGEF46X9tjRtSU+Z
   8N4nMViMx+AUuPntu1DQFrmHAfpDlq6YJQZxQfaF9ASV5/Tkx2yBgnUQq
   +gwUQo3iW9R1TSicKr21qd627s+oGRQ78xLyuqVwPbcKswpgQVUqwVKEh
   9vdcHe6E9DsvfbpnWUqEEUu2m6nrm89vMZOZx2bORtCkYRNenCG31fwCQ
   TC7RXiMCpCVEX9aiIXnyvcoEU33GiZvJSWGRZE5Mknw/VRIB/KDGe5fVu
   bJVJ0NMTvzOssakoP2fLlXlHGCQno4b3dCg6zRVOYUCEs0231MO58cq1e
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278696783"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="278696783"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 02:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782194957"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2022 02:43:14 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMnfl-0001XF-2m;
        Sat, 13 Aug 2022 09:43:13 +0000
Date:   Sat, 13 Aug 2022 17:42:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: kernel/dma/coherent.c:82: undefined reference to `memunmap'
Message-ID: <202208131746.fBYALPxR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: e61c451476e61450f6771ce03bbc01210a09be16 dma-mapping: Add dma_release_coherent_memory to DMA API
date:   7 weeks ago
config: s390-randconfig-r031-20220812 (https://download.01.org/0day-ci/archive/20220813/202208131746.fBYALPxR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e61c451476e61450f6771ce03bbc01210a09be16
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e61c451476e61450f6771ce03bbc01210a09be16
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   kernel/dma/coherent.c:48: undefined reference to `memremap'
>> /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.c:82: undefined reference to `memunmap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.c:71: undefined reference to `memunmap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.o: in function `dma_release_coherent_memory':
>> kernel/dma/coherent.c:82: undefined reference to `memunmap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.o: in function `rmem_dma_device_init':
   kernel/dma/coherent.c:48: undefined reference to `memremap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.c:71: undefined reference to `memunmap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   drivers/dma/fsl-edma.c:302: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/fsl-edma.c:327: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   drivers/dma/idma64.c:644: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   drivers/dma/qcom/hidma.c:770: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/qcom/hidma.c:777: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   drivers/char/xillybus/xillybus_of.c:50: undefined reference to `devm_platform_ioremap_resource'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   drivers/clocksource/timer-of.c:159: undefined reference to `of_iomap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/clocksource/timer-of.c:151: undefined reference to `iounmap'
   /opt/cross/gcc-12.1.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   drivers/clocksource/timer-of.c:151: undefined reference to `iounmap'


vim +82 kernel/dma/coherent.c

7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  76  
e61c451476e614 kernel/dma/coherent.c       Mark-PK Tsai       2022-04-22  77  static void _dma_release_coherent_memory(struct dma_coherent_mem *mem)
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  78  {
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  79  	if (!mem)
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  80  		return;
6b03ae0d42bfec drivers/base/dma-coherent.c Brian Starkey      2016-03-22  81  
6b03ae0d42bfec drivers/base/dma-coherent.c Brian Starkey      2016-03-22 @82  	memunmap(mem->virt_base);
9fbd8dc19aa57e kernel/dma/coherent.c       Christophe JAILLET 2021-10-24  83  	bitmap_free(mem->bitmap);
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  84  	kfree(mem);
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  85  }
7bfa5ab6fa1b18 drivers/base/dma-coherent.c Marek Szyprowski   2014-10-13  86  

:::::: The code at line 82 was first introduced by commit
:::::: 6b03ae0d42bfecf2536f7967d37e471d98c0b3d2 drivers: dma-coherent: use MEMREMAP_WC for DMA_MEMORY_MAP

:::::: TO: Brian Starkey <brian.starkey@arm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
