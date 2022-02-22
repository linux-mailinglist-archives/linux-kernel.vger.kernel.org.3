Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD2F4BFDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiBVPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiBVPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:53:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0538A60052
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645545174; x=1677081174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t/qfFz32BdYKVsvLBwRDu6VqlMdiM6Wq5ScXbuYdHPQ=;
  b=T6KlBCRYJsH/3bT380AHiRKQgGA3hFGE1rvkO6HNrFrOwDH9TCbZSy7S
   5tjXZDgg+2ccNBcU/wbUhOt9kyKirUDHaafvJ7B281pmhO8C9bJAZk1f/
   W0rVXuFVvNgJ7Kar8lyMr6fq46K1lyTwZamPOgpM3VhzPK2QQyaGjwn95
   7ns3iA+xGWsZ1dvsWWrKzjccYxMhnFxvi3w0PUD4v+TozK9mi+O3DDLUU
   ypzMLcbFkxY99MrnGCDPEHtZ9ab6Y2Ff9oJOgBTil5tYkL+mdXFJXOGuv
   JhrHPY4zW6FevrtzIXzaoWynnb6w8HxCjLHSa6dSoiyNdJ3gkhZl3kn+U
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251926734"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251926734"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 07:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532279011"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 07:52:45 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMXT2-0000My-Dy; Tue, 22 Feb 2022 15:52:44 +0000
Date:   Tue, 22 Feb 2022 23:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 543/552]
 drivers/platform/apple/smc_rtkit.c:73:16: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202202222301.GNqTX5KL-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 501bccfe4c2d4d9524d8cafcdd4e84b7c58e976a [543/552] Merge branches 'refs/heads/bits/000-devicetree', 'refs/heads/bits/010-mailbox', 'refs/heads/bits/020-t6000-bringup', 'refs/heads/bits/030-misc', 'refs/heads/bits/050-nvme', 'refs/heads/bits/060-spi', 'refs/heads/bits/070-audio', 'refs/heads/bits/080-wifi', 'refs/heads/bits/090-spi-hid', 'refs/heads/bits/100-shutdown-notifier', 'refs/heads/bits/110-smc', 'refs/heads/bits/120-spmi', 'refs/heads/bits/130-cpufreq' and 'refs/heads/bits/140-pci-pwren' into asahi
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220222/202202222301.GNqTX5KL-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

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

e4ac9bebeb083a Hector Martin 2022-02-04   57  
e4ac9bebeb083a Hector Martin 2022-02-04   58  static int apple_smc_rtkit_write_key_atomic(void *cookie, smc_key key, void *buf, size_t size)
e4ac9bebeb083a Hector Martin 2022-02-04   59  {
e4ac9bebeb083a Hector Martin 2022-02-04   60  	struct apple_smc_rtkit *smc = cookie;
e4ac9bebeb083a Hector Martin 2022-02-04   61  	int ret;
e4ac9bebeb083a Hector Martin 2022-02-04   62  	u64 msg;
e4ac9bebeb083a Hector Martin 2022-02-04   63  	u8 result;
e4ac9bebeb083a Hector Martin 2022-02-04   64  
e4ac9bebeb083a Hector Martin 2022-02-04   65  	if (size > SMC_SHMEM_SIZE || size == 0)
e4ac9bebeb083a Hector Martin 2022-02-04   66  		return -EINVAL;
e4ac9bebeb083a Hector Martin 2022-02-04   67  
e4ac9bebeb083a Hector Martin 2022-02-04   68  	if (!smc->alive)
e4ac9bebeb083a Hector Martin 2022-02-04   69  		return -EIO;
e4ac9bebeb083a Hector Martin 2022-02-04   70  
e4ac9bebeb083a Hector Martin 2022-02-04   71  	memcpy_toio(smc->shmem.iomem, buf, size);
e4ac9bebeb083a Hector Martin 2022-02-04   72  	smc->msg_id = (smc->msg_id + 1) & 0xf;
e4ac9bebeb083a Hector Martin 2022-02-04  @73  	msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
e4ac9bebeb083a Hector Martin 2022-02-04   74  	       FIELD_PREP(SMC_SIZE, size) |
e4ac9bebeb083a Hector Martin 2022-02-04   75  	       FIELD_PREP(SMC_ID, smc->msg_id) |
e4ac9bebeb083a Hector Martin 2022-02-04   76  	       FIELD_PREP(SMC_DATA, key));
e4ac9bebeb083a Hector Martin 2022-02-04   77  	smc->atomic_pending = true;
e4ac9bebeb083a Hector Martin 2022-02-04   78  
e4ac9bebeb083a Hector Martin 2022-02-04   79  	ret = apple_rtkit_send_message_atomic(smc->rtk, SMC_ENDPOINT, msg);
e4ac9bebeb083a Hector Martin 2022-02-04   80  	if (ret < 0) {
e4ac9bebeb083a Hector Martin 2022-02-04   81  		dev_err(smc->dev, "Failed to send command\n");
e4ac9bebeb083a Hector Martin 2022-02-04   82  		return ret;
e4ac9bebeb083a Hector Martin 2022-02-04   83  	}
e4ac9bebeb083a Hector Martin 2022-02-04   84  
e4ac9bebeb083a Hector Martin 2022-02-04   85  	while (smc->atomic_pending) {
e4ac9bebeb083a Hector Martin 2022-02-04   86  		ret = apple_rtkit_poll(smc->rtk);
e4ac9bebeb083a Hector Martin 2022-02-04   87  		if (ret < 0) {
e4ac9bebeb083a Hector Martin 2022-02-04   88  			dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
e4ac9bebeb083a Hector Martin 2022-02-04   89  			return ret;
e4ac9bebeb083a Hector Martin 2022-02-04   90  		}
e4ac9bebeb083a Hector Martin 2022-02-04   91  	}
e4ac9bebeb083a Hector Martin 2022-02-04   92  	
e4ac9bebeb083a Hector Martin 2022-02-04  @93  	if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
e4ac9bebeb083a Hector Martin 2022-02-04   94  		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
e4ac9bebeb083a Hector Martin 2022-02-04   95  			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
e4ac9bebeb083a Hector Martin 2022-02-04   96  		return -EIO;
e4ac9bebeb083a Hector Martin 2022-02-04   97  	}
e4ac9bebeb083a Hector Martin 2022-02-04   98  
e4ac9bebeb083a Hector Martin 2022-02-04   99  	result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
e4ac9bebeb083a Hector Martin 2022-02-04  100  	if (result != 0)
e4ac9bebeb083a Hector Martin 2022-02-04  101  		return -result;
e4ac9bebeb083a Hector Martin 2022-02-04  102  
e4ac9bebeb083a Hector Martin 2022-02-04  103  	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
e4ac9bebeb083a Hector Martin 2022-02-04  104  }
e4ac9bebeb083a Hector Martin 2022-02-04  105  

:::::: The code at line 73 was first introduced by commit
:::::: e4ac9bebeb083a52e6d9874bab74c32380a53594 platform/apple: Add new Apple Mac SMC driver

:::::: TO: Hector Martin <marcan@marcan.st>
:::::: CC: Hector Martin <marcan@marcan.st>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
