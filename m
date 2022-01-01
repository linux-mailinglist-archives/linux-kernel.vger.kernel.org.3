Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4767F48267C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 05:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiAAEj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 23:39:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:10342 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbiAAEj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 23:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641011967; x=1672547967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Rh6PuEjq01cj4WG5nChppUo3ymihTCTtwftOlTWuP8=;
  b=f+ZXM+BZXAmX4TyGe9o3rOutAjhi4HSifd9O10XBlhj12YSo85uVHtuI
   /wl5vLbU89rsnTeAP7sHlPsLctZQZogEpNZt5zIBMS0hVGpQdzgoAymob
   d+uLHuDuNUPnkXUVADHWwYQH0IZPrJPNNyeQXU0gpPc4CcbiCFLqeIM2N
   xRYORZRhq5nji1Nx6Xege6zqZlulGDeiIp7VlLz191d9ljqdVLXKaVIrR
   ORhhCqgc87cPqsVzZA1ZBt/OWKZTkaxQkX4+eVG/sXyyjCdFUEfhPHy31
   sf3cnlAbItPMSmszu3NmVjdJgx4MgjPtAe1zYBjVZVnbdhe2OMmqBgNH1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="221863687"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="221863687"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 20:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="511368904"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 Dec 2021 20:39:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3WAu-000C0J-SC; Sat, 01 Jan 2022 04:39:24 +0000
Date:   Sat, 1 Jan 2022 12:39:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Scull <ascull@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kvm/hyp/vhe/switch.c:217:17: warning: no previous
 prototype for 'hyp_panic'
Message-ID: <202201011207.T9q6Uy0y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8008293888188c3923f5bd8a69370dae25ed14e5
commit: f79e616f27ab6cd74deb0995a8eead3d1c9d65af KVM: arm64: Use BUG and BUG_ON in nVHE hyp
date:   9 months ago
config: arm64-randconfig-r035-20211231 (https://download.01.org/0day-ci/archive/20220101/202201011207.T9q6Uy0y-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f79e616f27ab6cd74deb0995a8eead3d1c9d65af
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f79e616f27ab6cd74deb0995a8eead3d1c9d65af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/vhe/switch.c:217:17: warning: no previous prototype for 'hyp_panic' [-Wmissing-prototypes]
     217 | void __noreturn hyp_panic(void)
         |                 ^~~~~~~~~
   arch/arm64/kvm/hyp/vhe/switch.c:227:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     227 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm64/kvm/hyp/nvhe/switch.c:264:17: warning: no previous prototype for 'hyp_panic' [-Wmissing-prototypes]
     264 | void __noreturn hyp_panic(void)
         |                 ^~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c:286:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     286 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hyp_panic +217 arch/arm64/kvm/hyp/vhe/switch.c

09cf57eba30424 David Brazdil 2020-06-25  216  
6a0259ed29bba8 Andrew Scull  2020-09-15 @217  void __noreturn hyp_panic(void)
09cf57eba30424 David Brazdil 2020-06-25  218  {
09cf57eba30424 David Brazdil 2020-06-25  219  	u64 spsr = read_sysreg_el2(SYS_SPSR);
09cf57eba30424 David Brazdil 2020-06-25  220  	u64 elr = read_sysreg_el2(SYS_ELR);
96d389ca10110d Rob Herring   2020-10-28  221  	u64 par = read_sysreg_par();
09cf57eba30424 David Brazdil 2020-06-25  222  
6a0259ed29bba8 Andrew Scull  2020-09-15  223  	__hyp_call_panic(spsr, elr, par);
09cf57eba30424 David Brazdil 2020-06-25  224  	unreachable();
09cf57eba30424 David Brazdil 2020-06-25  225  }
e9ee186bb735bf James Morse   2020-08-21  226  

:::::: The code at line 217 was first introduced by commit
:::::: 6a0259ed29bba83653a36fabcdf6b06aecd78596 KVM: arm64: Remove hyp_panic arguments

:::::: TO: Andrew Scull <ascull@google.com>
:::::: CC: Marc Zyngier <maz@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
