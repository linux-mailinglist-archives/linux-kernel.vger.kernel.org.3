Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827895A3C08
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 07:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiH1Fem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 01:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH1Fei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:34:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7744569
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661664878; x=1693200878;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZBbJUQRq4xYojLnSubVBT4oYkMrO602PlhVEoBrZezY=;
  b=MnLF5SrdOoaS3HgfAbz5qQfvcvpHH0y8UIXCSNoNzY9NF2run2pwU1I/
   U71k9BxHQD+Wy7+DtpBGEj/6fk7+wRgJXrxWiBy5EwRyBwjJOb5BJ76iy
   HjmoGLuKKMOtmTj6pAzQ7LOEwQWNzpriMp4KNcys0n+5uTzm9dK7HibYm
   dBYpym35vsiLK3D+zdN3nxnWPds2zo+kj/10sYqGlntFc5hp3tD9j3SuO
   KqM88oWH/oQEbnw7qAY7wzKAA8tQbMHsJdu2lDHFMN1I8PD5VugsModPj
   P2MfThWTls756I7Xix8u8+mT08vFId6wzZB9adJo4iij2aCRIMtVmt+id
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="295985863"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="295985863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 22:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="679282374"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2022 22:34:35 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSAwM-0000om-3A;
        Sun, 28 Aug 2022 05:34:34 +0000
Date:   Sun, 28 Aug 2022 13:33:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/video/fbdev/imsttfb.c:1548:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202208281326.rCI2rkGl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
head:   10d4879f9ef01cc6190fafe4257d06f375bab92c
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   9 weeks ago
config: arm-randconfig-s031-20220828 (https://download.01.org/0day-ci/archive/20220828/202208281326.rCI2rkGl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/imsttfb.c:1513:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/imsttfb.c:1513:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char [usertype] * @@
   drivers/video/fbdev/imsttfb.c:1513:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/imsttfb.c:1513:27: sparse:     got unsigned char [usertype] *
   drivers/video/fbdev/imsttfb.c:1522:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/imsttfb.c:1548:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got unsigned char [usertype] *cmap_regs @@
   drivers/video/fbdev/imsttfb.c:1548:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/video/fbdev/imsttfb.c:1548:20: sparse:     got unsigned char [usertype] *cmap_regs
   drivers/video/fbdev/imsttfb.c:1360:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/imsttfb.c:1361:16: sparse: sparse: cast removes address space '__iomem' of expression

vim +1548 drivers/video/fbdev/imsttfb.c

^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1540  
48c68c4f1b5424 drivers/video/imsttfb.c Greg Kroah-Hartman 2012-12-21  1541  static void imsttfb_remove(struct pci_dev *pdev)
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1542  {
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1543  	struct fb_info *info = pci_get_drvdata(pdev);
94f9e09ce531d4 drivers/video/imsttfb.c Antonino A. Daplas 2006-01-09  1544  	struct imstt_par *par = info->par;
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1545  	int size = pci_resource_len(pdev, 0);
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1546  
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1547  	unregister_framebuffer(info);
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16 @1548  	iounmap(par->cmap_regs);
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1549  	iounmap(par->dc_regs);
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1550  	iounmap(info->screen_base);
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1551  	release_mem_region(info->fix.smem_start, size);
94f9e09ce531d4 drivers/video/imsttfb.c Antonino A. Daplas 2006-01-09  1552  	framebuffer_release(info);
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1553  }
^1da177e4c3f41 drivers/video/imsttfb.c Linus Torvalds     2005-04-16  1554  

:::::: The code at line 1548 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
