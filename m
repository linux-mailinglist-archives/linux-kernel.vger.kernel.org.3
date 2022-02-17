Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B54BAC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbiBQWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:11:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiBQWLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:11:23 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E843AC8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645135867; x=1676671867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K0lpwgYDR+DBHT94KuipQ7SjwCyTd1K7dFsU5aicrl0=;
  b=HckVgmRW4MWwQwAibRLolMMV8sylIqyLRSL/Z71wkRtsqjgz7OuETS2I
   1G12cphcbu26wB9lhoFU4FUcyFizXGZsaGTUkh/0BVKIDr2YYKqaCFetG
   BCpj6NZB4/CQsaNRAm3KHIjao2qf8BbVpsaIId0Lr1MGXyalWRSM1cDah
   IOPFAJyGJ+v7/n57Ku9PJdToGYKnV+JieWbe/75sR6d3zZ1zG5SJ6UcB9
   lAUbgW/BrCs0VCBhZXoABv9NOc3Gl/siUvwMjUt4g/eo0x31WHcisc0hZ
   XSUJwg44dZBSxz8MHQxTNID7iENpqf7pMxJNG9lZ/FE2uAcOJLcvIzkqp
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="311731472"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="311731472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 14:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="488777213"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2022 14:11:05 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKozQ-0000gf-Io; Thu, 17 Feb 2022 22:11:04 +0000
Date:   Fri, 18 Feb 2022 06:10:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test-nvme 343/393]
 drivers/platform/apple/smc_rtkit.c:73:16: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202202180627.PX4h6t7v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test-nvme
head:   c0629b5191ba9a1a5372182580dc5452072ac666
commit: 63615eb2a0f68ad3d05cf48ccf0771dd613e1f44 [343/393] platform/apple: Add new Apple Mac SMC driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202180627.PX4h6t7v-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/63615eb2a0f68ad3d05cf48ccf0771dd613e1f44
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test-nvme
        git checkout 63615eb2a0f68ad3d05cf48ccf0771dd613e1f44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_rtkit_write_key_atomic':
>> drivers/platform/apple/smc_rtkit.c:73:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      73 |         msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
         |                ^~~~~~~~~~
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
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
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
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
>> drivers/platform/apple/smc_rtkit.c:93:13: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      93 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_cmd':
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
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
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
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
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
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
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
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
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
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
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
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


vim +/FIELD_PREP +73 drivers/platform/apple/smc_rtkit.c

    57	
    58	static int apple_smc_rtkit_write_key_atomic(void *cookie, smc_key key, void *buf, size_t size)
    59	{
    60		struct apple_smc_rtkit *smc = cookie;
    61		int ret;
    62		u64 msg;
    63		u8 result;
    64	
    65		if (size > SMC_SHMEM_SIZE || size == 0)
    66			return -EINVAL;
    67	
    68		if (!smc->alive)
    69			return -EIO;
    70	
    71		memcpy_toio(smc->shmem.iomem, buf, size);
    72		smc->msg_id = (smc->msg_id + 1) & 0xf;
  > 73		msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
    74		       FIELD_PREP(SMC_SIZE, size) |
    75		       FIELD_PREP(SMC_ID, smc->msg_id) |
    76		       FIELD_PREP(SMC_DATA, key));
    77		smc->atomic_pending = true;
    78	
    79		ret = apple_rtkit_send_message_atomic(smc->rtk, SMC_ENDPOINT, msg);
    80		if (ret < 0) {
    81			dev_err(smc->dev, "Failed to send command\n");
    82			return ret;
    83		}
    84	
    85		while (smc->atomic_pending) {
    86			ret = apple_rtkit_poll(smc->rtk);
    87			if (ret < 0) {
    88				dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
    89				return ret;
    90			}
    91		}
    92		
  > 93		if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
    94			dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
    95				smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
    96			return -EIO;
    97		}
    98	
    99		result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
   100		if (result != 0)
   101			return -result;
   102	
   103		return FIELD_GET(SMC_SIZE, smc->cmd_ret);
   104	}
   105	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
