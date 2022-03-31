Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F414ED7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiCaKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiCaKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:18:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD1511A9B6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648721824; x=1680257824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RbQW+n/+6PJw9BWCQAk1SdFbKP5uCEhi+CcdW4GzQ9s=;
  b=Y5fO/yGZ5aX3RlZa43qhgpQrYjNU98BTuZkmLDsSB1mHiC5wz3uYat7Q
   oQkBj67GyZ+ewhj/Dwhio5Pg/fUDaZ2nhIzmkRL0atuFdzsROwMEiY9F8
   jtcvmU0wCzMwo7G37MC7bWn4Vi8yv2p5VtWiFMPU0ds/wzJZk0/tyDsCJ
   fCfZ64JvlOedw5XixKTRCXhIoZySd8BPAWrPPkjY/LuVrHX03t0IGhnEl
   Sc7haS3zh2mc1zfxr+tiSoJh3H60/enCOQpmqatNkMfXO/LzQ1rRRH6pr
   B4yT84MH4pjAq66PZmTq60s5/nUiB2MFjMHMYU/TpNVxVyccKWWF7lkjy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259969468"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259969468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 03:17:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503683920"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 03:17:02 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZrrR-00009g-LK;
        Thu, 31 Mar 2022 10:17:01 +0000
Date:   Thu, 31 Mar 2022 18:16:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 1060/5872] arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for
 'check_range_driver_managed'
Message-ID: <202203311842.wFWvHrHn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudarshan,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: 1b4aca7d82ae9b40145484fa09ceab38a6a06062 [1060/5872] ANDROID: arm64/mm: implement {populate/depopulate}_range_driver_managed
config: arm64-buildonly-randconfig-r005-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311842.wFWvHrHn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1b4aca7d82ae9b40145484fa09ceab38a6a06062
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 1b4aca7d82ae9b40145484fa09ceab38a6a06062
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/ drivers/gpu/drm/hisilicon/kirin/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for 'check_range_driver_managed' [-Wmissing-prototypes]
    1499 | int check_range_driver_managed(u64 start, u64 size, const char *resource_name)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:16,
                    from arch/arm64/mm/mmu.c:11:
   arch/arm64/mm/mmu.c: In function 'check_range_driver_managed':
   include/linux/kern_levels.h:5:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:343:16: note: in expansion of macro 'KERN_ERR'
     343 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   arch/arm64/mm/mmu.c:1509:17: note: in expansion of macro 'pr_err'
    1509 |                 pr_err("%s: couldn't find memory resource for start 0x%lx\n",
         |                 ^~~~~~


vim +/check_range_driver_managed +1499 arch/arm64/mm/mmu.c

  1498	
> 1499	int check_range_driver_managed(u64 start, u64 size, const char *resource_name)
  1500	{
  1501		struct mem_section *ms;
  1502		unsigned long pfn = __phys_to_pfn(start);
  1503		unsigned long end_pfn = __phys_to_pfn(start + size);
  1504		struct resource *res;
  1505		unsigned long flags;
  1506	
  1507		res = lookup_resource(&iomem_resource, start);
  1508		if (!res) {
  1509			pr_err("%s: couldn't find memory resource for start 0x%lx\n",
  1510				   __func__, start);
  1511			return -EINVAL;
  1512		}
  1513	
  1514		flags = res->flags;
  1515	
  1516		if (!(flags & IORESOURCE_SYSRAM_DRIVER_MANAGED) ||
  1517		    strstr(resource_name, "System RAM (") != resource_name)
  1518			return -EINVAL;
  1519	
  1520		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
  1521			ms = __pfn_to_section(pfn);
  1522			if (early_section(ms))
  1523				return -EINVAL;
  1524		}
  1525	
  1526		return 0;
  1527	}
  1528	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
