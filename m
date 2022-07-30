Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14B6585C08
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiG3UTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiG3UT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:19:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294213F9D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659212368; x=1690748368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tkNWNs279ekjDQ81ZWGm5RP83pVV5DOBgUe3EmBUhXk=;
  b=EYDIpXVD4yM2qBqqiI1w/Q1612TE/y5oUTnwl1xsBiKrzAaNK+H69i/y
   21olD3iKs00D/yujDF4Jxd0IJ319XyxhaVProtpqoKtDRYTDW2OZgfRqF
   93sbRzZz22xSXw95JYkNCnm/opJm9WxkjLnUQZFBmFfxuB5WCU6VE2WSd
   CgfRGGRtas6iVaemMeuR8eM7FoIXhHr3Uax51Aesawhhzut586G7p5YR9
   bD8DOkLDR8DkpihfhLyot2p/Is6ky1PhW+aQSOkP1/IPbySR2b4hhy0CF
   P9mIt37cN1vX8QRk/4EoglLATj8kkHupji4AnBLjFyO8r/kuFQPM0nNv9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="271986684"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="271986684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 13:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="743865373"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2022 13:19:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHsvm-000DHX-0G;
        Sat, 30 Jul 2022 20:19:26 +0000
Date:   Sun, 31 Jul 2022 04:18:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 4/17]
 drivers/platform/apple/smc_rtkit.c:74:16: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202207310431.oMcYjPWN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   b1ba46a24716bd39ca22059fc93705a727c39890
commit: 58a839ca536e6de7bf1b2dff7441509c3ac9c8e7 [4/17] platform/apple: Add new Apple Mac SMC driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220731/202207310431.oMcYjPWN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/58a839ca536e6de7bf1b2dff7441509c3ac9c8e7
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 58a839ca536e6de7bf1b2dff7441509c3ac9c8e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_write_key_atomic':
>> drivers/platform/apple/smc_rtkit.c:74:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      74 |         msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
         |                ^~~~~~~~~~
   In file included from include/linux/bitops.h:6,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:22,
                    from drivers/platform/apple/smc_rtkit.c:8:
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:77:27: note: in expansion of macro 'SMC_DATA'
      77 |                FIELD_PREP(SMC_DATA, key));
         |                           ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:77:27: note: in expansion of macro 'SMC_DATA'
      77 |                FIELD_PREP(SMC_DATA, key));
         |                           ^~~~~~~~
>> drivers/platform/apple/smc_rtkit.c:95:13: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      95 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_cmd':
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:125:27: note: in expansion of macro 'SMC_DATA'
     125 |                FIELD_PREP(SMC_DATA, arg));
         |                           ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:125:27: note: in expansion of macro 'SMC_DATA'
     125 |                FIELD_PREP(SMC_DATA, arg));
         |                           ^~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:150:39: note: in expansion of macro 'SMC_DATA'
     150 |                 *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
         |                                       ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:150:39: note: in expansion of macro 'SMC_DATA'
     150 |                 *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
         |                                       ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_recv':
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:41: note: in expansion of macro 'GENMASK'
      30 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:332:55: note: in expansion of macro 'SMC_DATA'
     332 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +74 drivers/platform/apple/smc_rtkit.c

    58	
    59	static int apple_smc_rtkit_write_key_atomic(void *cookie, smc_key key, void *buf, size_t size)
    60	{
    61		struct apple_smc_rtkit *smc = cookie;
    62		int ret;
    63		u64 msg;
    64		u8 result;
    65	
    66		if (size > SMC_SHMEM_SIZE || size == 0)
    67			return -EINVAL;
    68	
    69		if (!smc->alive)
    70			return -EIO;
    71	
    72		memcpy_toio(smc->shmem.iomem, buf, size);
    73		smc->msg_id = (smc->msg_id + 1) & 0xf;
  > 74		msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
    75		       FIELD_PREP(SMC_SIZE, size) |
    76		       FIELD_PREP(SMC_ID, smc->msg_id) |
    77		       FIELD_PREP(SMC_DATA, key));
    78		smc->atomic_pending = true;
    79	
    80		ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL, true);
    81		if (ret < 0) {
    82			dev_err(smc->dev, "Failed to send command (%d)\n", ret);
    83			return ret;
    84		}
    85	
    86		while (smc->atomic_pending) {
    87			ret = apple_rtkit_poll(smc->rtk);
    88			if (ret < 0) {
    89				dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
    90				return ret;
    91			}
    92			udelay(100);
    93		}
    94	
  > 95		if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
    96			dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
    97				smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
    98			return -EIO;
    99		}
   100	
   101		result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
   102		if (result != 0)
   103			return -result;
   104	
   105		return FIELD_GET(SMC_SIZE, smc->cmd_ret);
   106	}
   107	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
