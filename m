Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B916C5427F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiFHHL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353663AbiFHGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:17:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB09FE6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654668183; x=1686204183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9i4mMx/iK/L9JFNyh7Qsw9oNlDYVHXglo3wBtNN8FfE=;
  b=BpY2W6N51cIQx1J02+LTpsMjqIGv+5Gl9wSqcDIb0S66tva6e8M0kE1y
   OaZdMUH4fAf/0ncBW7jbcN2g/PslnqXQHvev4wxFWntUBq3xIo0KJorEx
   A7hWPOk4wgjSG3w4RFNhi8SbHX0SUV29wKDpzPPP4UDiVKaJBro71aboC
   aUiEImRY9kJkLdVqE7PQonU5Yfc7KHCuUuoTanmqUbNtoZZr9Xn3knO+g
   8WlbT9cYXnHrcyQqrPqBbh0RBXyS6A7SeD4K+8kVcnhkjvQ38+nxuKq81
   FgK3vlMJJLXKRuJe9Fx+LIfJ5cOCB9N0f6/Shurl4sVCF/WNsh42RXQ5K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277936556"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="277936556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="648419441"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2022 23:02:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyolp-000ELd-FV;
        Wed, 08 Jun 2022 06:02:21 +0000
Date:   Wed, 8 Jun 2022 14:01:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 23/33]
 arch/microblaze/include/asm/page.h:115:25: error: implicit declaration of
 function '__virt_to_phys'; did you mean 'virt_to_pfn'?
Message-ID: <202206081328.suY733VF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   512fc95a58c7b2e91e267db91a4ec5a54afedd01
commit: 25049d91eb99805aaf82c2829b63b52ee8591776 [23/33] microblaze: Make virt_to_pfn() a static inline
config: microblaze-buildonly-randconfig-r012-20220607 (https://download.01.org/0day-ci/archive/20220608/202206081328.suY733VF-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=25049d91eb99805aaf82c2829b63b52ee8591776
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.19-rc1
        git checkout 25049d91eb99805aaf82c2829b63b52ee8591776
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/microblaze/include/asm/page.h:15,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from arch/microblaze/kernel/asm-offsets.c:13:
   arch/microblaze/include/asm/page.h: In function 'virt_to_pfn':
>> arch/microblaze/include/asm/page.h:115:25: error: implicit declaration of function '__virt_to_phys'; did you mean 'virt_to_pfn'? [-Werror=implicit-function-declaration]
     115 | # define __pa(x)        __virt_to_phys((unsigned long)(x))
         |                         ^~~~~~~~~~~~~~
   include/linux/pfn.h:20:27: note: in definition of macro 'PFN_DOWN'
      20 | #define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
         |                           ^
   arch/microblaze/include/asm/page.h:120:16: note: in expansion of macro 'phys_to_pfn'
     120 |         return phys_to_pfn(__pa(vaddr));
         |                ^~~~~~~~~~~
   arch/microblaze/include/asm/page.h:120:28: note: in expansion of macro '__pa'
     120 |         return phys_to_pfn(__pa(vaddr));
         |                            ^~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/microblaze/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +115 arch/microblaze/include/asm/page.h

4b87d7a4f91d31 Michal Simek 2009-03-27  114  
1f84e1ea0e87ad Michal Simek 2009-05-26 @115  # define __pa(x)	__virt_to_phys((unsigned long)(x))
1f84e1ea0e87ad Michal Simek 2009-05-26  116  # define __va(x)	((void *)__phys_to_virt((unsigned long)(x)))
1f84e1ea0e87ad Michal Simek 2009-05-26  117  

:::::: The code at line 115 was first introduced by commit
:::::: 1f84e1ea0e87ad659cd6f6a6285d50c73a8d1a24 microblaze_mmu_v2: pgalloc.h and page.h

:::::: TO: Michal Simek <monstr@monstr.eu>
:::::: CC: Michal Simek <monstr@monstr.eu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
