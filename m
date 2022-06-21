Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56963553E74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349272AbiFUW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFUW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:27:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93E313B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655850438; x=1687386438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S9M+nxiGTqy+iOORAChUsI1bobjs+TvgVDkGk0n+jYU=;
  b=nXoEudtReI5UEUBTl9vJGmUtFSLQKDWlOCPSvrvkYpr1O0if8PFsQmL+
   tNdFlh9Y2ZbAJswixQ9TxNuDNFHEEWqxSo7NAHvqZSOsZUY10xqEpnSFk
   XXcLGYvgW4hWjLiIyK9zuIGRyB+9eRVb3Tv+D992axrcDY9vF+RQBuF19
   osEzXtsg9Ix6pDO/TjjTK5Os8yybBd7HKHWzCWDTKhOs7/YAHoWEDnLnv
   2+VEd2FR2BuRIaoO4QSaSlxGM20kAsbGJtwx4Z17CUSJjm143rw/EC5Gf
   F6PN24QMSjxxKbJg4O1NpupTqwUZ1gfrzEOVIaO8eKj/Oc8bH60zKiNNq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305703132"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="305703132"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="586365078"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2022 15:27:17 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3mL6-0000V7-JX;
        Tue, 21 Jun 2022 22:27:16 +0000
Date:   Wed, 22 Jun 2022 06:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jamie Iles <jamie@jamieiles.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld:
 irq-xilinx-intc.c:undefined reference to `iounmap'
Message-ID: <202206220648.Ovoh9xpK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d
commit: b84dc7f0e3646d480b6972c5f25586215c5f33e2 irqchip/xilinx: Remove microblaze+zynq dependency
date:   12 days ago
config: s390-randconfig-r021-20220622 (https://download.01.org/0day-ci/archive/20220622/202206220648.Ovoh9xpK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b84dc7f0e3646d480b6972c5f25586215c5f33e2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b84dc7f0e3646d480b6972c5f25586215c5f33e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x13a): undefined reference to `memunmap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x1e8): undefined reference to `memremap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: coherent.c:(.text+0x36c): undefined reference to `memunmap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x3a): undefined reference to `of_iomap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: irq-al-fic.c:(.init.text+0x4c0): undefined reference to `iounmap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/irqchip/irq-xilinx-intc.o: in function `xilinx_intc_of_init':
   irq-xilinx-intc.c:(.init.text+0xa6): undefined reference to `of_iomap'
>> /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: irq-xilinx-intc.c:(.init.text+0x1fc): undefined reference to `iounmap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/misc/open-dice.o: in function `open_dice_write':
   open-dice.c:(.text+0x170): undefined reference to `devm_memremap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: open-dice.c:(.text+0x21e): undefined reference to `devm_memunmap'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
