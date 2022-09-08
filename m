Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259805B25B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiIHSZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiIHSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:25:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDE4F646
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662661529; x=1694197529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bAx+Cn0eM5ExfkOKLeqqr5eoLH4LBmI7lcxTj56V7lA=;
  b=GijBhNq017mzw1c5g4Ii2/DHAgyk9zTk4ZtGAN9ssInDMWwhyqvc4yBX
   TZpRNSwwJKK3dgqRuIHEWyrAVMEpHjpirEMPwaOTCa2WqXYqavU8Arswd
   JeyHD2NZuvbnfkK42LinyWB1ilg42QKO/8jnym86s75499zEjzaHK0Yg5
   k77p+VFu3JnvMK0Dt0cCR1j2c1cEIU2VzGrJz9Qclxgn2RupskfuqX9C9
   B1boRuzmnLNbrgEhLIDZzCwK6NLnPc+SENIjfQwX2Fkpff4l7/zd2n8kV
   G4yvJufMrhFP9jpUZ7gmeMBjhcIMMqQeuNlFiXoz8z9DOduXJmCbNk3sw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280313465"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280313465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 11:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943462127"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 11:25:23 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWMDL-0000DR-0u;
        Thu, 08 Sep 2022 18:25:23 +0000
Date:   Fri, 9 Sep 2022 02:25:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:virt-to-pfn-v6.0-rc1 10/24]
 arch/arm/include/asm/memory.h:294:43: error: 'PAGE_SHIFT' undeclared
Message-ID: <202209090251.nxU1tPcG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git virt-to-pfn-v6.0-rc1
head:   bc69ecf9b2a3d1f9699edab614580d6a6e090407
commit: dbf81f3235aaece643b3fef4b5568d79caf6db0e [10/24] ARM: mm: Make virt_to_pfn() a static inline
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220909/202209090251.nxU1tPcG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=dbf81f3235aaece643b3fef4b5568d79caf6db0e
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator virt-to-pfn-v6.0-rc1
        git checkout dbf81f3235aaece643b3fef4b5568d79caf6db0e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/io.h:26,
                    from include/linux/io.h:13,
                    from include/linux/iosys-map.h:10,
                    from include/linux/dma-buf.h:16,
                    from drivers/gpu/drm/drm_gem_cma_helper.c:12:
   arch/arm/include/asm/memory.h: In function 'virt_to_pfn':
>> arch/arm/include/asm/memory.h:294:43: error: 'PAGE_SHIFT' undeclared (first use in this function)
     294 |         return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
         |                                           ^~~~~~~~~~
   arch/arm/include/asm/memory.h:294:43: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm/include/asm/memory.h:296:1: error: control reaches end of non-void function [-Werror=return-type]
     296 | }
         | ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/include/asm/io.h:26,
                    from include/linux/io.h:13,
                    from include/linux/iosys-map.h:10,
                    from include/linux/dma-buf.h:16,
                    from drivers/gpu/drm/drm_gem_shmem_helper.c:6:
   arch/arm/include/asm/memory.h: In function 'virt_to_pfn':
>> arch/arm/include/asm/memory.h:294:43: error: 'PAGE_SHIFT' undeclared (first use in this function)
     294 |         return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
         |                                           ^~~~~~~~~~
   arch/arm/include/asm/memory.h:294:43: note: each undeclared identifier is reported only once for each function it appears in


vim +/PAGE_SHIFT +294 arch/arm/include/asm/memory.h

   290	
   291	static inline unsigned long virt_to_pfn(const void *p)
   292	{
   293		unsigned long kaddr = (unsigned long)p;
 > 294		return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
   295			PHYS_PFN_OFFSET);
   296	}
   297	#define __pa_symbol_nodebug(x)	__virt_to_phys_nodebug((x))
   298	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
