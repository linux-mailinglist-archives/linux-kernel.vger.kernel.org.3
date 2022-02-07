Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB64AB2F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 01:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiBGAd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 19:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGAd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 19:33:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBDC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 16:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644194036; x=1675730036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N5D3gdsp9fOTSJqo4Q71cI5JW2LLnij+TGffNaxrnFo=;
  b=Kmy5HtK0hCyheh6Wn9CkXyEzoonHTab4pYWX842qkxDAV42lz2qAF8+8
   wcs5w42VvgJOSGtV+DE4pfbPsQQZlmPJFdoRBO/+Q09TXvX5XMlUH/2MW
   58KWO66RjeoiRuHQv1WBSzajIETSPjKNExuQTi6m3dyBt5/rW2GvM8EDW
   sXiiTvsCP28qe+Bj8ZU7aXHIId5io6TvxjiVvAe8gjbggZ3JGpj9HOTuF
   6iC+VAQJmhARVAbUVv14ZxQf7KUzsmAP4k0IHDonhhSG3BLmiTpxoV7np
   jqas6Es4PhQTkUWOsQZfNiSZ1DuxkbMDuai1mJ4cP/uezRAj5Bl4ezsuB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="232182997"
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="232182997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 16:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="524944399"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 16:33:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGryZ-000auP-D6; Mon, 07 Feb 2022 00:33:51 +0000
Date:   Mon, 7 Feb 2022 08:32:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: litex_liteeth.c:undefined reference to
 `devm_platform_ioremap_resource_byname'
Message-ID: <202202070822.w4rpU462-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
commit: 464a57281f29afc202905b456b0cb8bc729b383a net/mlxbf_gige: Make use of devm_platform_ioremap_resourcexxx()
date:   5 months ago
config: s390-randconfig-r012-20220207 (https://download.01.org/0day-ci/archive/20220207/202202070822.w4rpU462-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=464a57281f29afc202905b456b0cb8bc729b383a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 464a57281f29afc202905b456b0cb8bc729b383a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x2456): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/litex/litex_liteeth.o: in function `liteeth_probe':
>> litex_liteeth.c:(.text+0x1b0): undefined reference to `devm_platform_ioremap_resource_byname'
>> s390-linux-ld: litex_liteeth.c:(.text+0x1ee): undefined reference to `devm_platform_ioremap_resource_byname'
   s390-linux-ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
   samsung-keypad.c:(.text+0x1702): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `init_cc_resources':
   cc_driver.c:(.text+0xe40): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   cc_debugfs.c:(.text+0x188): undefined reference to `debugfs_create_regset32'
   s390-linux-ld: cc_debugfs.c:(.text+0x2d0): undefined reference to `debugfs_create_regset32'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x182): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x8b4): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0xa42): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-microchip-pit64b.o: in function `mchp_pit64b_dt_init_timer':
   timer-microchip-pit64b.c:(.init.text+0x578): undefined reference to `of_iomap'
   s390-linux-ld: timer-microchip-pit64b.c:(.init.text+0xdf8): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
