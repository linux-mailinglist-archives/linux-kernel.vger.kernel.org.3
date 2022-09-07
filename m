Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED305B0FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIGW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIGW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:28:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C7857DA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662589715; x=1694125715;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DwnQBzVBatJ3w/wyR2QiQ+qDmaaq3NmbzGL/nxjKeho=;
  b=DauAwvwELrxNejKolA78lL74F1cn8bpwX35Uu3RkJ/dZW2BLD81UcCh6
   HEubbh7qXAAOd1nW6tLuITT2hWLGuQvj8u9R11+zPZxYjMKRO1iXDF6sg
   RSgHHL8dmeQS6BX8erhz8yyKmNJjykWlt/jNu7I7w/AhfkfVSadnK77tf
   AcyxB/vy3zQA45GWxMrzWEQo07fU4aTASt+OJUfWPyZ3Dtc53cEghfMG4
   Oa2hq0JyL+UOQhgrfEVUiFreX+jLpXI+IpsN5OxVL4Km37alSqLSQVfGe
   f9wkbCnGnyOmLBMrtrdV+NcVRLgxPXS7oRbAwKN0HJK4Yqfeq7yiw9i/2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276749546"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="276749546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="591904676"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 15:28:33 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW3X7-000713-06;
        Wed, 07 Sep 2022 22:28:33 +0000
Date:   Thu, 8 Sep 2022 06:28:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/mips/bcm47xx/prom.c:89:8: error: no matching function for call
 to 'memcmp'
Message-ID: <202209080652.sz2d68e5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0066f1b0e27556381402db3ff31f85d2a2265858
commit: 281d0c962752fb40866dd8d4cade68656f34bd1f fortify: Add Clang support
date:   7 months ago
config: mips-randconfig-r032-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080652.sz2d68e5-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=281d0c962752fb40866dd8d4cade68656f34bd1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 281d0c962752fb40866dd8d4cade68656f34bd1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/mips/bcm47xx/prom.c:89:8: error: no matching function for call to 'memcmp'
                   if (!memcmp(prom_init, prom_init + mem, 32))
                        ^~~~~~
   include/linux/string.h:156:12: note: candidate function not viable: no known conversion from 'void (void)' to 'const void *' for 1st argument
   extern int memcmp(const void *,const void *,__kernel_size_t);
              ^
   include/linux/fortify-string.h:391:5: note: candidate function not viable: no known conversion from 'void (void)' to 'const void *const' for 1st argument
   int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t size)
       ^
   1 error generated.


vim +/memcmp +89 arch/mips/bcm47xx/prom.c

6ee1d93455384c Rafał Miłecki       2014-07-17   55  
25e5fb97419f73 Aurelien Jarno      2007-09-25   56  static __init void prom_init_mem(void)
1c0c13eb935c95 Aurelien Jarno      2007-09-25   57  {
1c0c13eb935c95 Aurelien Jarno      2007-09-25   58  	unsigned long mem;
aec92225513538 Hauke Mehrtens      2010-07-27   59  	unsigned long max;
c47cc20ca53e79 Hauke Mehrtens      2012-10-03   60  	unsigned long off;
d3dce3d676373b Hauke Mehrtens      2012-10-03   61  	struct cpuinfo_mips *c = &current_cpu_data;
1c0c13eb935c95 Aurelien Jarno      2007-09-25   62  
25e5fb97419f73 Aurelien Jarno      2007-09-25   63  	/* Figure out memory size by finding aliases.
25e5fb97419f73 Aurelien Jarno      2007-09-25   64  	 *
25e5fb97419f73 Aurelien Jarno      2007-09-25   65  	 * We should theoretically use the mapping from CFE using cfe_enummem().
25e5fb97419f73 Aurelien Jarno      2007-09-25   66  	 * However as the BCM47XX is mostly used on low-memory systems, we
25e5fb97419f73 Aurelien Jarno      2007-09-25   67  	 * want to reuse the memory used by CFE (around 4MB). That means cfe_*
25e5fb97419f73 Aurelien Jarno      2007-09-25   68  	 * functions stop to work at some point during the boot, we should only
25e5fb97419f73 Aurelien Jarno      2007-09-25   69  	 * call them at the beginning of the boot.
aec92225513538 Hauke Mehrtens      2010-07-27   70  	 *
aec92225513538 Hauke Mehrtens      2010-07-27   71  	 * BCM47XX uses 128MB for addressing the ram, if the system contains
aec92225513538 Hauke Mehrtens      2010-07-27   72  	 * less that that amount of ram it remaps the ram more often into the
aec92225513538 Hauke Mehrtens      2010-07-27   73  	 * available space.
25e5fb97419f73 Aurelien Jarno      2007-09-25   74  	 */
96a8123e5f9658 Rafał Miłecki       2014-04-19   75  
96a8123e5f9658 Rafał Miłecki       2014-04-19   76  	/* Physical address, without mapping to any kernel segment */
96a8123e5f9658 Rafał Miłecki       2014-04-19   77  	off = CPHYSADDR((unsigned long)prom_init);
96a8123e5f9658 Rafał Miłecki       2014-04-19   78  
96a8123e5f9658 Rafał Miłecki       2014-04-19   79  	/* Accessing memory after 128 MiB will cause an exception */
96a8123e5f9658 Rafał Miłecki       2014-04-19   80  	max = 128 << 20;
96a8123e5f9658 Rafał Miłecki       2014-04-19   81  
96a8123e5f9658 Rafał Miłecki       2014-04-19   82  	for (mem = 1 << 20; mem < max; mem += 1 << 20) {
96a8123e5f9658 Rafał Miłecki       2014-04-19   83  		/* Loop condition may be not enough, off may be over 1 MiB */
96a8123e5f9658 Rafał Miłecki       2014-04-19   84  		if (off + mem >= max) {
96a8123e5f9658 Rafał Miłecki       2014-04-19   85  			mem = max;
d548ca6b0784a9 Rafał Miłecki       2014-12-10   86  			pr_debug("Assume 128MB RAM\n");
aec92225513538 Hauke Mehrtens      2010-07-27   87  			break;
aec92225513538 Hauke Mehrtens      2010-07-27   88  		}
c47cc20ca53e79 Hauke Mehrtens      2012-10-03  @89  		if (!memcmp(prom_init, prom_init + mem, 32))
1c0c13eb935c95 Aurelien Jarno      2007-09-25   90  			break;
1c0c13eb935c95 Aurelien Jarno      2007-09-25   91  	}
6ee1d93455384c Rafał Miłecki       2014-07-17   92  	lowmem = mem;
1c0c13eb935c95 Aurelien Jarno      2007-09-25   93  
d3dce3d676373b Hauke Mehrtens      2012-10-03   94  	/* Ignoring the last page when ddr size is 128M. Cached
d3dce3d676373b Hauke Mehrtens      2012-10-03   95  	 * accesses to last page is causing the processor to prefetch
d3dce3d676373b Hauke Mehrtens      2012-10-03   96  	 * using address above 128M stepping out of the ddr address
d3dce3d676373b Hauke Mehrtens      2012-10-03   97  	 * space.
d3dce3d676373b Hauke Mehrtens      2012-10-03   98  	 */
d3dce3d676373b Hauke Mehrtens      2012-10-03   99  	if (c->cputype == CPU_74K && (mem == (128  << 20)))
d3dce3d676373b Hauke Mehrtens      2012-10-03  100  		mem -= 0x1000;
e7ae8d174eec0b Thomas Bogendoerfer 2020-10-09  101  	memblock_add(0, mem);
1c0c13eb935c95 Aurelien Jarno      2007-09-25  102  }
1c0c13eb935c95 Aurelien Jarno      2007-09-25  103  

:::::: The code at line 89 was first introduced by commit
:::::: c47cc20ca53e792938556aa29103fa889ce0d858 MIPS: BCM47XX: improve memory size detection

:::::: TO: Hauke Mehrtens <hauke@hauke-m.de>
:::::: CC: John Crispin <blogic@openwrt.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
