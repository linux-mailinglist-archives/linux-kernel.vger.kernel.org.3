Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528874DEAF9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 22:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiCSVhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 17:37:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A7C39693
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647725743; x=1679261743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/CYwDMy+oybOohIhRSbKiHUiRVArqo0RM764uz7Bx3s=;
  b=LUUxkjmp/PylquwK6KHet2CPvWER8e8cYQr6BEZjytwejZqyYWbfFR0Q
   Lw+qj9S2GlrsGDsGC6AVBqTVjbXJgDBcqe7aaLa4ur9gr+0b9ll3OxBj/
   kSVaknVAyEKTwP8HhR27hd63BIpF0VZ3CR6DxBmpQzdO9q/Utj01o7MyD
   kaOdNz8LhEnL9pOU0NJgjmR0YZpF5DBv07QqTDPswD084W+tSdQgIR7Qy
   VcVNBHiLkirQ9zTeFFNvcgzKqkmNqXy6/v+K+wo6QyB5o9etq1f1l52vY
   FkDvThzxGyJNDfZvTaETOLJhNxnMK7+LHbvA1Oeu/PLGmo6uouw778oe7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="257522063"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="257522063"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 14:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="517910576"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2022 14:35:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVgjc-000GJW-Os; Sat, 19 Mar 2022 21:35:40 +0000
Date:   Sun, 20 Mar 2022 05:35:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:506:5:
 warning: no previous prototype for 'LZ4_decompress_safe_forceExtDict'
Message-ID: <202203200545.zUPhx82w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34e047aa16c0123bbae8e2f6df33e5ecc1f56601
commit: baec970aa5ba11099ad7a91773350c91fb2113f0 mips: Add N64 machine type
date:   1 year, 2 months ago
config: mips-randconfig-r001-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200545.zUPhx82w-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=baec970aa5ba11099ad7a91773350c91fb2113f0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout baec970aa5ba11099ad7a91773350c91fb2113f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/boot/compressed/decompress.c:38:6: warning: no previous prototype for 'error' [-Wmissing-prototypes]
      38 | void error(char *x)
         |      ^~~~~
   In file included from arch/mips/boot/compressed/../../../../lib/decompress_unlz4.c:10,
                    from arch/mips/boot/compressed/decompress.c:60:
   arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:484:5: warning: no previous prototype for 'LZ4_decompress_safe_withPrefix64k' [-Wmissing-prototypes]
     484 | int LZ4_decompress_safe_withPrefix64k(const char *source, char *dest,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c:506:5: warning: no previous prototype for 'LZ4_decompress_safe_forceExtDict' [-Wmissing-prototypes]
     506 | int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/boot/compressed/decompress.c:81:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
      81 | void __stack_chk_fail(void)
         |      ^~~~~~~~~~~~~~~~
   arch/mips/boot/compressed/decompress.c:86:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
      86 | void decompress_kernel(unsigned long boot_heap_start)
         |      ^~~~~~~~~~~~~~~~~


vim +/LZ4_decompress_safe_forceExtDict +506 arch/mips/boot/compressed/../../../../lib/lz4/lz4_decompress.c

cffb78b0e0b3a3 Kyungsik Lee 2013-07-08  505  
2209fda323e2fd Gao Xiang    2018-10-30 @506  int LZ4_decompress_safe_forceExtDict(const char *source, char *dest,
2209fda323e2fd Gao Xiang    2018-10-30  507  				     int compressedSize, int maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  508  				     const void *dictStart, size_t dictSize)
2209fda323e2fd Gao Xiang    2018-10-30  509  {
2209fda323e2fd Gao Xiang    2018-10-30  510  	return LZ4_decompress_generic(source, dest,
2209fda323e2fd Gao Xiang    2018-10-30  511  				      compressedSize, maxOutputSize,
2209fda323e2fd Gao Xiang    2018-10-30  512  				      endOnInputSize, decode_full_block,
2209fda323e2fd Gao Xiang    2018-10-30  513  				      usingExtDict, (BYTE *)dest,
2209fda323e2fd Gao Xiang    2018-10-30  514  				      (const BYTE *)dictStart, dictSize);
2209fda323e2fd Gao Xiang    2018-10-30  515  }
2209fda323e2fd Gao Xiang    2018-10-30  516  

:::::: The code at line 506 was first introduced by commit
:::::: 2209fda323e2fd2a2d0885595fd5097717f8d2aa lib/lz4: update LZ4 decompressor module

:::::: TO: Gao Xiang <gaoxiang25@huawei.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
