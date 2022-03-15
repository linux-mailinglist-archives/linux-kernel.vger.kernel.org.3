Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D508C4DA4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiCOV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiCOV63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:58:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62D5C343
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647381436; x=1678917436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CoR2irF5hj3EpTP3LGkuGrU7+xfPocs9SVr/gslfAGE=;
  b=L/gZJUUkgF9Xiu82H0eHzgHoVGlcdb77X1biDbd5Q4tqZKmPi47Pn3VK
   LMoD/g4a+hIchcEkLr7/320yfBEgH+wDzz/cYTsUn+obFEz9IV2zw1+HE
   d8i2a0NxPnefKLeLZXxxTclY4Ye2pJm7+iv3EOyCEJJqk/8zPB8lJzLb9
   byuKmxGR53479HY0cNp7G5Pn/rPviGbKD5oiu8S8wIBWLUqGK+UqiX4KN
   p8hwU8uUBnhaPGsZKgkhs35oCHYcZhfSYrXdsx3X3XxrbFrOEB/Qeo/Rx
   tA5aaNIaG79ocb+QeywwdVXDu5CtcyJ38oB/C7vQyuzgkpYAUgqbzjBFp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243882376"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="243882376"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:57:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="516055548"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 14:57:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUFAG-000BXA-Vf; Tue, 15 Mar 2022 21:57:12 +0000
Date:   Wed, 16 Mar 2022 05:56:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [broonie-misc:arm64-sysreg-gen 6/9]
 arch/arm64/include/asm/sysreg.h:125:10: fatal error:
 'generated/asm/sysreg.h' file not found
Message-ID: <202203160508.k7vz4ZxC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-sysreg-gen
head:   72b2ee21681c0c515c6a8bb62bd289766ce324a1
commit: caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff [6/9] arm64/sysreg: Enable automatic generation of system register definitions
config: arm64-randconfig-r006-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160508.k7vz4ZxC-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc arm64-sysreg-gen
        git checkout caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:10:
   In file included from include/linux/page-flags.h:10:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm64/include/asm/bug.h:26:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/cache.h:6:
   In file included from arch/arm64/include/asm/cache.h:8:
   In file included from arch/arm64/include/asm/cputype.h:173:
>> arch/arm64/include/asm/sysreg.h:125:10: fatal error: 'generated/asm/sysreg.h' file not found
   #include "generated/asm/sysreg.h"
            ^~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +125 arch/arm64/include/asm/sysreg.h

   118	
   119	/*
   120	 * Automatically generated definitions for system registers, the
   121	 * manual encodings below are in the process of being converted to
   122	 * come from here. The header relies on the definition of sys_reg()
   123	 * earlier in this file.
   124	 */
 > 125	#include "generated/asm/sysreg.h"
   126	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
