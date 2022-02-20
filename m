Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554FA4BCE59
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbiBTMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:00:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBTMAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:00:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75684F46D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 03:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645358379; x=1676894379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gkh/Fm/JdPiXSYvQ/h8G+gEBnhiqCo/G2YHhv5hjl04=;
  b=TRp0zlP9hJQV+VHM2YOrUerlfk1y/1sykx83Rh47FXKFyPUvdnpAPizA
   GBHT7Vxnu24AcJFERslRASAV6qJDq3MhHcdzTH+nMzP5BvD9G5RHR8zTE
   4Lc99JkvVQBsmXOQJByKXlQ/RDDZjI7V0Idm3a7i1lJ+QXPHhY387IAsM
   Ae3cOkCE7C/+XR56n3N+6J70xht98FbGPrpFRwvr9AgPL38CFxyRSI3B3
   a5aRNJPy+4StWavsJQOjHCQ/m4JyPFMg2U9Aaa0jHAJfjTPo54cmfRMUv
   46dRCEcqSHQEaiS5f+nVA1KRB42UtmJoM8TvQVjWGWMR/c5dqLJWazfeB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="250186707"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="250186707"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 03:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="682933606"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2022 03:59:38 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLksL-0000JO-Gq; Sun, 20 Feb 2022 11:59:37 +0000
Date:   Sun, 20 Feb 2022 19:58:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/alchemy/board-gpr.c:78:13: warning: no previous prototype
 for function 'board_setup'
Message-ID: <202202201926.pBXsd3i7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   1 year, 5 months ago
config: mips-randconfig-r016-20220220 (https://download.01.org/0day-ci/archive/20220220/202202201926.pBXsd3i7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/alchemy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/alchemy/board-gpr.c:78:13: warning: no previous prototype for function 'board_setup' [-Wmissing-prototypes]
   void __init board_setup(void)
               ^
   arch/mips/alchemy/board-gpr.c:78:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init board_setup(void)
   ^
   static 
   1 warning generated.


vim +/board_setup +78 arch/mips/alchemy/board-gpr.c

8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  77  
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10 @78  void __init board_setup(void)
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  79  {
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  80  	printk(KERN_INFO "Trapeze ITS GPR board\n");
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  81  
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  82  	pm_power_off = gpr_power_off;
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  83  	_machine_halt = gpr_power_off;
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  84  	_machine_restart = gpr_reset;
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  85  
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  86  	/* Enable UART1/3 */
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  87  	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  88  	alchemy_uart_enable(AU1000_UART1_PHYS_ADDR);
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  89  
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  90  	/* Take away Reset of UMTS-card */
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  91  	alchemy_gpio_direction_output(215, 1);
8e026910fcd46c3 arch/mips/alchemy/board-gpr.c    Manuel Lauss        2011-11-10  92  }
cb8f55b9207df96 arch/mips/alchemy/gpr/platform.c Wolfgang Grandegger 2010-07-15  93  

:::::: The code at line 78 was first introduced by commit
:::::: 8e026910fcd46c3cfcdf5cff7ebba013bb8ec85c MIPS: Alchemy: merge GPR/MTX-1/XXS1500 board code into single files

:::::: TO: Manuel Lauss <manuel.lauss@googlemail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
