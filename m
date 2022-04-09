Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CB4FA60C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiDIIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiDIIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:38:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD97326C4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649493369; x=1681029369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cXZ+57K9X37iBLo1CEy7c3wy6+UDR+MRQQCbT05aUbs=;
  b=HQTgdrj2K9uFYhNLZg4G3LVHoNWvr3+S9TcOvb+OgEKFJCEfqx0W893N
   X0ouKYyvz1X2lZNbT0N1XVbnSzQBvfjzPfg+kJg10ysSJGCMBaupjbvWu
   O8H7GFT6feoxARfZZekNfdBmKNsxKkiAMsP5NQvDldMI8YWTDKlNtCGVE
   nRSkRPCPhU66BakadpO0peGKhLHs2cf+WSuDcgsrgUawRQJNYVKBv9T8e
   jbEtb2W/ZG9Ny8alKRiPROyhsJLHbmxZgSY7lPwSuCwW5EoJNIrBsneQE
   eKkJsW73IwUv3tju2e+9kMGPBAt5hJHE2syTVfFmLOZUua4DjyDw5Azb1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242371881"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="242371881"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 01:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="698563982"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2022 01:36:00 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd6Zb-00011U-Gb;
        Sat, 09 Apr 2022 08:35:59 +0000
Date:   Sat, 9 Apr 2022 16:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/not-zero-entropy 7/11]
 arch/arm/include/asm/timex.h:15:40: error: implicit declaration of function
 'read_current_timer'
Message-ID: <202204091618.rkNKCgBL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/not-zero-entropy
head:   ac7d8411f0216fe77e48592ed0ff2ccbd599d0de
commit: 5cde0b2eaaf94891163f14984697361fe51849e6 [7/11] arm: use sched_clock() for random_get_entropy() instead of zero
config: arm-randconfig-m031-20220408 (https://download.01.org/0day-ci/archive/20220409/202204091618.rkNKCgBL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/5cde0b2eaaf94891163f14984697361fe51849e6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/not-zero-entropy
        git checkout 5cde0b2eaaf94891163f14984697361fe51849e6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/timex.h:66,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/rhashtable-types.h:15,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/sched.h:15,
                    from arch/arm/kernel/asm-offsets.c:11:
   arch/arm/include/asm/timex.h: In function 'random_get_entropy':
>> arch/arm/include/asm/timex.h:15:40: error: implicit declaration of function 'read_current_timer' [-Werror=implicit-function-declaration]
      15 | #define get_cycles()    ({ cycles_t c; read_current_timer(&c) ? 0 : c; })
         |                                        ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/timex.h:19:29: note: in expansion of macro 'get_cycles'
      19 |         unsigned long ret = get_cycles();
         |                             ^~~~~~~~~~
   In file included from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/rhashtable-types.h:15,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/sched.h:15,
                    from arch/arm/kernel/asm-offsets.c:11:
   include/linux/timex.h: At top level:
   include/linux/timex.h:53: error: unterminated #ifndef
      53 | #ifndef _LINUX_TIMEX_H
         | 
   In file included from include/linux/jiffies.h:11,
                    from include/linux/ktime.h:25,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/rhashtable-types.h:15,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/sched.h:15,
                    from arch/arm/kernel/asm-offsets.c:11:
   include/linux/timex.h:53: error: unterminated #ifndef
      53 | #ifndef _LINUX_TIMEX_H
         | 
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/read_current_timer +15 arch/arm/include/asm/timex.h

5cde0b2eaaf948 arch/arm/include/asm/timex.h Jason A. Donenfeld 2022-04-08  13  
^1da177e4c3f41 include/asm-arm/timex.h      Linus Torvalds     2005-04-16  14  typedef unsigned long cycles_t;
923df96b9f31b7 arch/arm/include/asm/timex.h Will Deacon        2012-07-06 @15  #define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
^1da177e4c3f41 include/asm-arm/timex.h      Linus Torvalds     2005-04-16  16  

:::::: The code at line 15 was first introduced by commit
:::::: 923df96b9f31b7d08d8438ff9677326d9537accf ARM: 7451/1: arch timer: implement read_current_timer and get_cycles

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
