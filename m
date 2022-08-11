Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488AC58F555
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiHKArV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiHKArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:47:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C5844DE
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660178835; x=1691714835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HtnCSZBUVPQUrbSirLmN2r26EpormcJ4svgZ8nxcA7E=;
  b=mfCGitBFfBwtFpegg91FpCFuLqZclOFo/uUV6eiwf43t7anGaMN0gYFx
   PEbWN6BawVhDJh79b5v8GTAdHk1hNolNHQ2Cg4vCgqDz87zoeIlfcjG8h
   5uERFPHvQak1s1VmrhXOtYt2DWouaLUxGI9s564VdKya/eeTGDe0J1of8
   cP43vlVce//AWSXCR90DlaR0jGbunKKRFnT92d27xTTShOx5q1s2WPizT
   Snn4ifPIM8UNNrO+Wy7hTDZ+WB6qn1eTEsSv68qUbB7jE6geBzT3JiRHI
   0enGQ3VVH6cYzbaj/7z6/ICQEUijdFw8rA2k71kkF9+UHdXOaPAQaSSn9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271003200"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271003200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 17:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="665144608"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2022 17:47:13 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLwLw-0000v1-2k;
        Thu, 11 Aug 2022 00:47:12 +0000
Date:   Thu, 11 Aug 2022 08:46:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-const-host-template 12/88]
 drivers/ata/pata_platform.c:221:20: error: passing 'const struct
 scsi_host_template *' to parameter of type 'struct scsi_host_template *'
 discards qualifiers
Message-ID: <202208110827.RxTOue3F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-const-host-template
head:   13249cc58dd0478af230234f124ec75b5331c348
commit: 21962245b3c73a5e7c9b7b3c129a83f5c1c31608 [12/88] ata
config: powerpc-randconfig-r032-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110827.RxTOue3F-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/bvanassche/linux/commit/21962245b3c73a5e7c9b7b3c129a83f5c1c31608
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-const-host-template
        git checkout 21962245b3c73a5e7c9b7b3c129a83f5c1c31608
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:220:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_platform.c:16:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:222:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_platform.c:16:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:224:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_platform.c:16:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:226:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_platform.c:16:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:228:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/ata/pata_platform.c:221:20: error: passing 'const struct scsi_host_template *' to parameter of type 'struct scsi_host_template *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                                        pio_mask, &pata_platform_sht, false);
                                                  ^~~~~~~~~~~~~~~~~~
   drivers/ata/pata_platform.c:183:19: note: passing argument to parameter here
   EXPORT_SYMBOL_GPL(__pata_platform_probe);
                     ^
   6 warnings and 1 error generated.
--
   In file included from drivers/ata/pata_of_platform.c:11:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:141:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:577:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_of_platform.c:11:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:143:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_of_platform.c:11:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:145:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_of_platform.c:11:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:147:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_of_platform.c:11:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:149:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/ata/pata_of_platform.c:11:
   In file included from include/linux/of_address.h:7:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:151:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/ata/pata_of_platform.c:76:31: error: passing 'const struct scsi_host_template *' to parameter of type 'struct scsi_host_template *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                                        reg_shift, pio_mask, &pata_platform_sht,
                                                             ^~~~~~~~~~~~~~~~~~
   include/linux/ata_platform.h:22:33: note: passing argument to parameter 'sht' here
                                    struct scsi_host_template *sht,
                                                               ^
   6 warnings and 1 error generated.


vim +221 drivers/ata/pata_platform.c

a20c9e820864e1 Paul Mundt         2006-10-27  184  
0ec24914675c48 Greg Kroah-Hartman 2012-12-21  185  static int pata_platform_probe(struct platform_device *pdev)
cf03613e9662c2 Anton Vorontsov    2008-01-09  186  {
cf03613e9662c2 Anton Vorontsov    2008-01-09  187  	struct resource *io_res;
cf03613e9662c2 Anton Vorontsov    2008-01-09  188  	struct resource *ctl_res;
cf03613e9662c2 Anton Vorontsov    2008-01-09  189  	struct resource *irq_res;
61b8c345aa8c50 Jingoo Han         2013-07-30  190  	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
cf03613e9662c2 Anton Vorontsov    2008-01-09  191  
cf03613e9662c2 Anton Vorontsov    2008-01-09  192  	/*
cf03613e9662c2 Anton Vorontsov    2008-01-09  193  	 * Simple resource validation ..
cf03613e9662c2 Anton Vorontsov    2008-01-09  194  	 */
cf03613e9662c2 Anton Vorontsov    2008-01-09  195  	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
cf03613e9662c2 Anton Vorontsov    2008-01-09  196  		dev_err(&pdev->dev, "invalid number of resources\n");
cf03613e9662c2 Anton Vorontsov    2008-01-09  197  		return -EINVAL;
cf03613e9662c2 Anton Vorontsov    2008-01-09  198  	}
cf03613e9662c2 Anton Vorontsov    2008-01-09  199  
cf03613e9662c2 Anton Vorontsov    2008-01-09  200  	/*
cf03613e9662c2 Anton Vorontsov    2008-01-09  201  	 * Get the I/O base first
cf03613e9662c2 Anton Vorontsov    2008-01-09  202  	 */
8818a5342cb499 Lad Prabhakar      2022-01-17  203  	io_res = platform_get_mem_or_io(pdev, 0);
8818a5342cb499 Lad Prabhakar      2022-01-17  204  	if (!io_res)
cf03613e9662c2 Anton Vorontsov    2008-01-09  205  		return -EINVAL;
cf03613e9662c2 Anton Vorontsov    2008-01-09  206  
cf03613e9662c2 Anton Vorontsov    2008-01-09  207  	/*
cf03613e9662c2 Anton Vorontsov    2008-01-09  208  	 * Then the CTL base
cf03613e9662c2 Anton Vorontsov    2008-01-09  209  	 */
8818a5342cb499 Lad Prabhakar      2022-01-17  210  	ctl_res = platform_get_mem_or_io(pdev, 1);
8818a5342cb499 Lad Prabhakar      2022-01-17  211  	if (!ctl_res)
cf03613e9662c2 Anton Vorontsov    2008-01-09  212  		return -EINVAL;
cf03613e9662c2 Anton Vorontsov    2008-01-09  213  
cf03613e9662c2 Anton Vorontsov    2008-01-09  214  	/*
cf03613e9662c2 Anton Vorontsov    2008-01-09  215  	 * And the IRQ
cf03613e9662c2 Anton Vorontsov    2008-01-09  216  	 */
cf03613e9662c2 Anton Vorontsov    2008-01-09  217  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
cf03613e9662c2 Anton Vorontsov    2008-01-09  218  
cf03613e9662c2 Anton Vorontsov    2008-01-09  219  	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
cf03613e9662c2 Anton Vorontsov    2008-01-09  220  				     pp_info ? pp_info->ioport_shift : 0,
f3d5e4f18dba18 Alexander Shiyan   2019-01-19 @221  				     pio_mask, &pata_platform_sht, false);
cf03613e9662c2 Anton Vorontsov    2008-01-09  222  }
cf03613e9662c2 Anton Vorontsov    2008-01-09  223  

:::::: The code at line 221 was first introduced by commit
:::::: f3d5e4f18dba18d7c2303dda68b9dbcf5ccc05cd ata: pata_of_platform: Allow to use 16-bit wide data transfer

:::::: TO: Alexander Shiyan <shc_work@mail.ru>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
