Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6664CADFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiCBS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiCBS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:57:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11312C6205
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646247386; x=1677783386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tuVXfx1Tgtb2olCY+IIzIqMfIaSBzsqP7r46EEQmWvU=;
  b=QFI0GfkYCxRaYbc7woMo8orzDkAdo0NGNcnJSLaWh/ZcGI8yxz6498qM
   4n2gN4x6F+R+5uRGE+bfPyAIh73SuNHeoLAbzjgBXSp0Ai41R5nx1H/MN
   WqQrHK/+pMHUOcJ/iQcyGUeMPNOyEYKSZsWs/paMkCLh/pXQtLEfC6Ite
   ZUrFP96Ybtz3HIgTZ6INChEbDFzZvfXtXhhvrcWjYzGyCAv59LVlrPvGm
   ThR78gG6rWGCVa3E/z8Amyaubj6Z5fFofCbpKYlRq5ZTf1v2p9ilbp+e9
   D3BdbwycUj8Dz/SnB7gc9OG2mUYTL1hdkG+Ae4Q+Pb1il0AR8xFiw4pBJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234097522"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="234097522"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 10:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="576212133"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 10:56:23 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPU99-0001m8-AY; Wed, 02 Mar 2022 18:56:23 +0000
Date:   Thu, 3 Mar 2022 02:56:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angelo Dureghello <angelo@sysam.it>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@kernel.org>
Subject: arch/m68k/coldfire/device.c:511:35: error: 'MCFEDMA_BASE' undeclared
 here (not in a function); did you mean 'MCFDMA_BASE0'?
Message-ID: <202203030252.P752DK46-lkp@intel.com>
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

Hi Angelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb184c4af9b9f4563e7a126219389986a71d5b5b
commit: d7e9d01ac2920959b474c6363dba269a868f4db9 m68k: add ColdFire mcf5441x eDMA platform support
date:   3 years ago
config: m68k-buildonly-randconfig-r003-20220112 (https://download.01.org/0day-ci/archive/20220303/202203030252.P752DK46-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7e9d01ac2920959b474c6363dba269a868f4db9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d7e9d01ac2920959b474c6363dba269a868f4db9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10,
                    from arch/m68k/coldfire/device.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   arch/m68k/coldfire/device.c: At top level:
>> arch/m68k/coldfire/device.c:511:35: error: 'MCFEDMA_BASE' undeclared here (not in a function); did you mean 'MCFDMA_BASE0'?
     511 |                 .start          = MCFEDMA_BASE,
         |                                   ^~~~~~~~~~~~
         |                                   MCFDMA_BASE0
>> arch/m68k/coldfire/device.c:512:50: error: 'MCFEDMA_SIZE' undeclared here (not in a function)
     512 |                 .end            = MCFEDMA_BASE + MCFEDMA_SIZE - 1,
         |                                                  ^~~~~~~~~~~~
>> arch/m68k/coldfire/device.c:516:35: error: 'MCFEDMA_IRQ_INTR0' undeclared here (not in a function)
     516 |                 .start          = MCFEDMA_IRQ_INTR0,
         |                                   ^~~~~~~~~~~~~~~~~
>> arch/m68k/coldfire/device.c:522:35: error: 'MCFEDMA_IRQ_INTR16' undeclared here (not in a function)
     522 |                 .start          = MCFEDMA_IRQ_INTR16,
         |                                   ^~~~~~~~~~~~~~~~~~
>> arch/m68k/coldfire/device.c:528:35: error: 'MCFEDMA_IRQ_INTR56' undeclared here (not in a function)
     528 |                 .start          = MCFEDMA_IRQ_INTR56,
         |                                   ^~~~~~~~~~~~~~~~~~
>> arch/m68k/coldfire/device.c:534:35: error: 'MCFEDMA_IRQ_ERR' undeclared here (not in a function)
     534 |                 .start          = MCFEDMA_IRQ_ERR,
         |                                   ^~~~~~~~~~~~~~~


vim +511 arch/m68k/coldfire/device.c

   508	
   509	static struct resource mcf_edma_resources[] = {
   510		{
 > 511			.start		= MCFEDMA_BASE,
 > 512			.end		= MCFEDMA_BASE + MCFEDMA_SIZE - 1,
   513			.flags		= IORESOURCE_MEM,
   514		},
   515		{
 > 516			.start		= MCFEDMA_IRQ_INTR0,
   517			.end		= MCFEDMA_IRQ_INTR0 + 15,
   518			.flags		= IORESOURCE_IRQ,
   519			.name		= "edma-tx-00-15",
   520		},
   521		{
 > 522			.start		= MCFEDMA_IRQ_INTR16,
   523			.end		= MCFEDMA_IRQ_INTR16 + 39,
   524			.flags		= IORESOURCE_IRQ,
   525			.name		= "edma-tx-16-55",
   526		},
   527		{
 > 528			.start		= MCFEDMA_IRQ_INTR56,
   529			.end		= MCFEDMA_IRQ_INTR56,
   530			.flags		= IORESOURCE_IRQ,
   531			.name		= "edma-tx-56-63",
   532		},
   533		{
 > 534			.start		= MCFEDMA_IRQ_ERR,
   535			.end		= MCFEDMA_IRQ_ERR,
   536			.flags		= IORESOURCE_IRQ,
   537			.name		= "edma-err",
   538		},
   539	};
   540	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
