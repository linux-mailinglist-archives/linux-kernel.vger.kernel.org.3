Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B125B2B25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIIAmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIIAml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:42:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756497512
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662684160; x=1694220160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DjvKuJEMOfKUtTh1+ADXQCMoCXIYt3rwrCGshVxb2Zs=;
  b=bvFNy8KkP3iAMU/TpJKyNzbY9TppqCqQCzrMKslm4OqU6dIjDS+u3nmI
   OkmUkiffP/ElIL5u/nns4k32Jd+yNe4U+lxBoJIInJCZEMP4Hz8PKcoR9
   DFBn5+hjjlu49Q7iRZ8kT1ome/N2CubM7uSQnn5WgxLyOd6Q1beEOMngX
   +Exh90V46+0yd9GNRCcvaDHrsTEVt9tb0w95/5Sq/YW8hERkn0qUSAdyf
   fYtM7t6RnONX5NKK9my1TVg/qv9ON2QYxkJPmk0DHvmx1EUXE7GAAGQeq
   8hN0HQtExWgHPmksPlntrk/wuzq8TfaXbPyMZikOmNjh3Lt6Hw6X4PR01
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="361319906"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="361319906"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 17:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="566171242"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2022 17:42:38 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWS6P-0000V9-32;
        Fri, 09 Sep 2022 00:42:37 +0000
Date:   Fri, 9 Sep 2022 08:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:virt-to-pfn-v6.0-rc1 20/24]
 arch/openrisc/include/asm/page.h:82:26: error: invalid operands to binary <<
 (have 'void *' and 'int')
Message-ID: <202209090813.hAnwc80U-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git virt-to-pfn-v6.0-rc1
head:   bc69ecf9b2a3d1f9699edab614580d6a6e090407
commit: 50c0db6d3425ce9310be32638e83e7e8d6a0530c [20/24] openrisc: Make pfn accessors statics inlines
config: openrisc-randconfig-r023-20220909 (https://download.01.org/0day-ci/archive/20220909/202209090813.hAnwc80U-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=50c0db6d3425ce9310be32638e83e7e8d6a0530c
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator virt-to-pfn-v6.0-rc1
        git checkout 50c0db6d3425ce9310be32638e83e7e8d6a0530c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/processor.h:19,
                    from arch/openrisc/include/asm/thread_info.h:22,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/openrisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/openrisc/kernel/asm-offsets.c:23:
   arch/openrisc/include/asm/page.h: In function 'pfn_to_virt':
>> arch/openrisc/include/asm/page.h:82:26: error: invalid operands to binary << (have 'void *' and 'int')
      82 |         return __va(pfn) << PAGE_SHIFT;
         |                          ^~
   make[2]: *** [scripts/Makefile.build:117: arch/openrisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1207: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +82 arch/openrisc/include/asm/page.h

    79	
    80	static inline void * pfn_to_virt(unsigned long pfn)
    81	{
  > 82		return __va(pfn) << PAGE_SHIFT;
    83	}
    84	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
