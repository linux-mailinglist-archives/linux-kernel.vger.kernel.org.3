Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2C58B8D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 02:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiHGA4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 20:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiHGA4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:56:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685BC63E0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659833777; x=1691369777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qoNIVlwfT3Jm4cqYFZI9bHmMnff+Dnp7gqhv9viZRfM=;
  b=PfYLu07yzirJjYKldQU9zsB1gyy1g5tCIcQL9s4lgumoBf555UqM/dSq
   c8IaBu1l9LVSbPEftpazKq0GYJoDwRkvG4rX8bRe0gKQ4wFSGFAzRydWb
   aQ4PDCmXLktxTkQWnQdK/Wd/9wEadNdcfNlZ54l9jkZrpIUY8uA1YITSC
   yHRgYZcGbf9CwTOphx2fuGajo5cAbp0d+ryQlhI4zTFn0XuWmESMf7oYy
   BLKz0DcKph6C5vWlAoA/LQeHmgfEcYYILlsU8DsPbJmI0+8rP1PgtzZs4
   SlCPXEWksupE5ZwQq253UQaLNvpQo0T1wkNYlYQo7ZS5dFIE+VkoT5mZt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270786990"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="270786990"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 17:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="579910433"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2022 17:56:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKUaU-000Kp5-27;
        Sun, 07 Aug 2022 00:56:14 +0000
Date:   Sun, 7 Aug 2022 08:55:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 9/59]
 arch/x86/include/asm/linkage.h:20:3: error: #error Unsupported function
 alignment
Message-ID: <202208070826.3lDtoagS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   b518e558c49324fa002255761d2a7324ba31f7b5
commit: 63ca4d9b1d429d6cc9c1a99c81f73eaf88eadbb3 [9/59] x86/asm: Ensure proper function alignment
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220807/202208070826.3lDtoagS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/63ca4d9b1d429d6cc9c1a99c81f73eaf88eadbb3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 63ca4d9b1d429d6cc9c1a99c81f73eaf88eadbb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      17 | void foo(void)
         |      ^~~
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/x86/include/asm/linkage.h:15:5: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      15 | #if CONFIG_FUNCTION_ALIGNMENT == 8
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/linkage.h:17:7: warning: "CONFIG_FUNCTION_ALIGNMENT" is not defined, evaluates to 0 [-Wundef]
      17 | #elif CONFIG_FUNCTION_ALIGNMENT == 16
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/linkage.h:20:3: error: #error Unsupported function alignment
      20 | # error Unsupported function alignment
         |   ^~~~~
   In file included from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/linkage.h:73: warning: "__ALIGN_STR" redefined
      73 | #define __ALIGN_STR     ".align 4,0x90"
         | 
   In file included from include/linux/linkage.h:8,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/x86/include/asm/linkage.h:23: note: this is the location of the previous definition
      23 | #define __ALIGN_STR             __stringify(__ALIGN)
         | 
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1200: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +20 arch/x86/include/asm/linkage.h

    14	
    15	#if CONFIG_FUNCTION_ALIGNMENT == 8
    16	#define __ALIGN			.p2align 3, 0x90;
    17	#elif CONFIG_FUNCTION_ALIGNMENT == 16
    18	#define __ALIGN			.p2align 4, 0x90;
    19	#else
  > 20	# error Unsupported function alignment
    21	#endif
    22	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
