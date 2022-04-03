Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967224F0903
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiDCLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDCLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:36:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E402737005
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648985671; x=1680521671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w3+dJSG41YiOYCe9pq5tbHjd700xrUaUy6TiG5GC9sw=;
  b=g3tMmrAnI4ta7BD+bmAX0xRXs737odcDmHbF1BkdZWZzGxXM9CoN+tqM
   5GruWfqZkt4267PM3tCPqg9s4oJGlGXqUVIyNKp3c72Y/7TqdNOL9lFte
   nTxjJBt91x3mTs9oOe0beOcG554OoAyOAJ/sMC2zgqjS/pVJTI4IZ98CC
   c0gjzw/CYxtPUjKKSziX7j5hYAYydCc2ruum5ix7pnhuWsC4sLdXDxU7t
   oLERc85a2YqJONpJif73u6+5GUyXr7K/sNQqLpGstVfyFCWp8NniqRmWD
   KFkbFz8nkxzdjcTPDu+GlPow3AGdTYeUamFduT5ICIL/mwZOnkCaBhCKL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="242519817"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="242519817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 04:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="523282238"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Apr 2022 04:34:28 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nayV1-0000v7-G1;
        Sun, 03 Apr 2022 11:34:27 +0000
Date:   Sun, 3 Apr 2022 19:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [linux-stable-rc:queue/5.10 3948/9999]
 arch/powerpc/platforms/4xx/pci.c:47:19: error: unused function
 'ppc440spe_revA'
Message-ID: <202204031917.yHHLo75R-lkp@intel.com>
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

Hi Nathan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   852e92a491fd83515d5683537bfdb2d90d483344
commit: a024e88f8ab79a7b7e15337096d4f5f77edc6a49 [3948/9999] powerpc/barrier: Avoid collision with clang's __lwsync macro
config: powerpc-randconfig-c003-20220403 (https://download.01.org/0day-ci/archive/20220403/202204031917.yHHLo75R-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=a024e88f8ab79a7b7e15337096d4f5f77edc6a49
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout a024e88f8ab79a7b7e15337096d4f5f77edc6a49
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/4xx/pci.c:47:19: error: unused function 'ppc440spe_revA' [-Werror,-Wunused-function]
   static inline int ppc440spe_revA(void)
                     ^
   1 error generated.


vim +/ppc440spe_revA +47 arch/powerpc/platforms/4xx/pci.c

a2d2e1ec07a809 arch/powerpc/sysdev/ppc4xx_pci.c Benjamin Herrenschmidt 2007-12-21  41  
8308c54d7e312f arch/powerpc/sysdev/ppc4xx_pci.c Jeremy Fitzhardinge    2008-09-11  42  #define RES_TO_U32_LOW(val)	\
8308c54d7e312f arch/powerpc/sysdev/ppc4xx_pci.c Jeremy Fitzhardinge    2008-09-11  43  	((sizeof(resource_size_t) > sizeof(u32)) ? U64_TO_U32_LOW(val) : (val))
8308c54d7e312f arch/powerpc/sysdev/ppc4xx_pci.c Jeremy Fitzhardinge    2008-09-11  44  #define RES_TO_U32_HIGH(val)	\
8308c54d7e312f arch/powerpc/sysdev/ppc4xx_pci.c Jeremy Fitzhardinge    2008-09-11  45  	((sizeof(resource_size_t) > sizeof(u32)) ? U64_TO_U32_HIGH(val) : (0))
a2d2e1ec07a809 arch/powerpc/sysdev/ppc4xx_pci.c Benjamin Herrenschmidt 2007-12-21  46  
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21 @47  static inline int ppc440spe_revA(void)
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  48  {
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  49  	/* Catch both 440SPe variants, with and without RAID6 support */
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  50          if ((mfspr(SPRN_PVR) & 0xffefffff) == 0x53421890)
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  51                  return 1;
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  52          else
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  53                  return 0;
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  54  }
accf5ef254b9dd arch/powerpc/sysdev/ppc4xx_pci.c Stefan Roese           2007-12-21  55  

:::::: The code at line 47 was first introduced by commit
:::::: accf5ef254b9dd4d3b53040dd73d80875c2cd39b [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe

:::::: TO: Stefan Roese <sr@denx.de>
:::::: CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
