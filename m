Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFD4BECC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiBUVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:50:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBUVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:50:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752822BCE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645480184; x=1677016184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VCvs9jrXrWJpDXNnlFdocpwVMPZv9QzgW9JVcM75Pvc=;
  b=kAwP8RUus7ffZgri04XzOhWee0ZR+o+BRxhauVVkw2G2QGRSJEAsSMVb
   rk0IWDxZgqCdHjogG9+CBnNa3Pvtyxx3zwNzyf5qWHhjgok7+Qoi8dyRN
   J7Thpu/jIa2zQFPlm7cgTxW/PwuRXatP7SEbpTT7Kv3hsVimZs6/GCaMn
   7ElHVmB6i4Tb0Bkwe9JPrZPEcxMtLVcqEx3Lox1DugJZZo0v2OWehtiDK
   2UHzFoIGOZgWzf3o06+Skx38Lbgt2E5ug3RcP/+g2eahMhhLxMMiNsoxr
   M5ZxfCWuIG1I5Me6O8UFlWnGNshEUIOlaxPXqHQzpyH8NN/aR/7HzvI/G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338003992"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="338003992"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 13:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="507753211"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2022 13:49:42 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMGYw-00020O-7A; Mon, 21 Feb 2022 21:49:42 +0000
Date:   Tue, 22 Feb 2022 05:48:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 543/552]
 include/linux/bits.h:35:29: warning: left shift count >= width of type
Message-ID: <202202220539.UAUVgANe-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 501bccfe4c2d4d9524d8cafcdd4e84b7c58e976a [543/552] Merge branches 'refs/heads/bits/000-devicetree', 'refs/heads/bits/010-mailbox', 'refs/heads/bits/020-t6000-bringup', 'refs/heads/bits/030-misc', 'refs/heads/bits/050-nvme', 'refs/heads/bits/060-spi', 'refs/heads/bits/070-audio', 'refs/heads/bits/080-wifi', 'refs/heads/bits/090-spi-hid', 'refs/heads/bits/100-shutdown-notifier', 'refs/heads/bits/110-smc', 'refs/heads/bits/120-spmi', 'refs/heads/bits/130-cpufreq' and 'refs/heads/bits/140-pci-pwren' into asahi
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202220539.UAUVgANe-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/501bccfe4c2d4d9524d8cafcdd4e84b7c58e976a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 501bccfe4c2d4d9524d8cafcdd4e84b7c58e976a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_write_key_atomic':
   drivers/platform/apple/smc_rtkit.c:73:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      73 |         msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
         |                ^~~~~~~~~~
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:76:27: note: in expansion of macro 'SMC_DATA'
      76 |                FIELD_PREP(SMC_DATA, key));
         |                           ^~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:76:27: note: in expansion of macro 'SMC_DATA'
      76 |                FIELD_PREP(SMC_DATA, key));
         |                           ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:93:13: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      93 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_cmd':
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:123:27: note: in expansion of macro 'SMC_DATA'
     123 |                FIELD_PREP(SMC_DATA, arg));
         |                           ^~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:123:27: note: in expansion of macro 'SMC_DATA'
     123 |                FIELD_PREP(SMC_DATA, arg));
         |                           ^~~~~~~~
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:147:39: note: in expansion of macro 'SMC_DATA'
     147 |                 *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
         |                                       ^~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:147:39: note: in expansion of macro 'SMC_DATA'
     147 |                 *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
         |                                       ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_recv':
>> include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
>> include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   cc1: some warnings being treated as errors


vim +35 include/linux/bits.h

295bcca84916cb Rikard Falkeborn 2020-04-06  33  
295bcca84916cb Rikard Falkeborn 2020-04-06  34  #define __GENMASK(h, l) \
95b980d62d52c4 Masahiro Yamada  2019-07-16 @35  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
95b980d62d52c4 Masahiro Yamada  2019-07-16 @36  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
295bcca84916cb Rikard Falkeborn 2020-04-06  37  #define GENMASK(h, l) \
295bcca84916cb Rikard Falkeborn 2020-04-06  38  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
8bd9cb51daac89 Will Deacon      2018-06-19  39  

:::::: The code at line 35 was first introduced by commit
:::::: 95b980d62d52c4c1768ee719e8db3efe27ef52b2 linux/bits.h: make BIT(), GENMASK(), and friends available in assembly

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
