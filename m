Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA93C4886CB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 23:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiAHWnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 17:43:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:39006 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbiAHWnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641681795; x=1673217795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HzcCcK63x9PRjBExA2zKYKDGXMPx/PlaWy1El3NB8aI=;
  b=MJ9B8x6Tu2+2qmFHsTVIehgjTNfI358dWNuW1+3XDSY+8d3xvjfu3HB2
   JiaMaE1uMGvLpqKxxrAQxUn3zdwlKeW/mQWsAINbEDhulXgcsnPYXomfn
   JeENeC8bk+XxYR4rP9zXJ6NauWCBGBxkUSxTYQpo+uIm+H8BQqWlrhu/M
   ccVpNzUa4NHWkQxCm7VWDkLxkkob6iJeT6xeCUipO07j1K51TC1C8oPkT
   PCAUPTw5PUHyXMGdK18I9ENPVJLhsHBws53jXcqLFPM2c5y6k0/9nzxUf
   iKf363nmo6tuPB4u/nLxLdG1Y7eUqZdxcZTMHPF89fC4kRUSYzagg98OI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="306403619"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="306403619"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 14:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="690172808"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 14:43:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6KQZ-00017z-Qu; Sat, 08 Jan 2022 22:43:11 +0000
Date:   Sun, 9 Jan 2022 06:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-m2107
 1060/8698] arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for
 function 'check_range_driver_managed'
Message-ID: <202201090602.3hmcOZA2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudarshan,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-m2107
head:   6b5101a5720784d91a53168bfbc90c940ee6817f
commit: 1b4aca7d82ae9b40145484fa09ceab38a6a06062 [1060/8698] ANDROID: arm64/mm: implement {populate/depopulate}_range_driver_managed
config: arm64-randconfig-r024-20220107 (https://download.01.org/0day-ci/archive/20220109/202201090602.3hmcOZA2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/1b4aca7d82ae9b40145484fa09ceab38a6a06062
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-m2107
        git checkout 1b4aca7d82ae9b40145484fa09ceab38a6a06062
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/mm/mmu.c:689:10: warning: variable 'bm_pudp' set but not used [-Wunused-but-set-variable]
                   pud_t *bm_pudp;
                          ^
   arch/arm64/mm/mmu.c:1510:17: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
                              __func__, start);
                                        ^~~~~
   include/linux/printk.h:343:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
>> arch/arm64/mm/mmu.c:1499:5: warning: no previous prototype for function 'check_range_driver_managed' [-Wmissing-prototypes]
   int check_range_driver_managed(u64 start, u64 size, const char *resource_name)
       ^
   arch/arm64/mm/mmu.c:1499:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int check_range_driver_managed(u64 start, u64 size, const char *resource_name)
   ^
   static 
   3 warnings generated.


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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
