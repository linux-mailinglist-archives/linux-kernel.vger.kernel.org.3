Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CFD4B9A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiBQII1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:08:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiBQIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:08:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C731427DF3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645085287; x=1676621287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BaxvtiLXacnxCrgDjRqJ72VHJT4+//agaSkLkp8qmz8=;
  b=jCQdsOesmvQ/hpdAjw8kvqkQRZ1NUfT4HfjFjYoSOv++GrqYfFEyj9wg
   OFSjlBvbA0VPy/cfd9zUzrnIlfUPtMMaylDajZm1qV893f8gnK8PiHukA
   M2MzM0imbMo8rUCaCgL0LwwuGk5QRpzyJmNoO2bkdRzAeqw3EqrSX9qMH
   8B7epXgYTkqDXBkp3F0mSG+Yx2nI4jd2gKaQuEjdh+n3D6eMAiFWN+0c8
   56HcU3Vnh4+sH3TV9spFtVxctoQuz6m9jJXb1FXRvCUtAcYJfNlKLM8js
   9YSTWY5dbdrNijhJPd16R/Dd5+m82xf/yxOmzrOOU6gpoS/lUPRSZu1S/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250763949"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250763949"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="540820272"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Feb 2022 00:08:05 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKbpc-000BbP-I0; Thu, 17 Feb 2022 08:08:04 +0000
Date:   Thu, 17 Feb 2022 16:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 343/385]
 drivers/platform/apple/smc_rtkit.c:73:9: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202202171656.Usxovuzb-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test
head:   e226b395bc2d49a6a1411765875e0864c9a0e0da
commit: 63615eb2a0f68ad3d05cf48ccf0771dd613e1f44 [343/385] platform/apple: Add new Apple Mac SMC driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220217/202202171656.Usxovuzb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0bad7cb56526f2572c74449fcf97c1fcda42b41d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/63615eb2a0f68ad3d05cf48ccf0771dd613e1f44
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout 63615eb2a0f68ad3d05cf48ccf0771dd613e1f44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/platform/apple/smc_rtkit.c:73:9: error: implicit declaration of function 'FIELD_PREP' [-Werror,-Wimplicit-function-declaration]
           msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
                  ^
>> drivers/platform/apple/smc_rtkit.c:93:6: error: implicit declaration of function 'FIELD_GET' [-Werror,-Wimplicit-function-declaration]
           if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
               ^
   drivers/platform/apple/smc_rtkit.c:93:6: note: did you mean 'FIELD_PREP'?
   drivers/platform/apple/smc_rtkit.c:73:9: note: 'FIELD_PREP' declared here
           msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
                  ^
>> drivers/platform/apple/smc_rtkit.c:76:20: warning: shift count >= width of type [-Wshift-count-overflow]
                  FIELD_PREP(SMC_DATA, key));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
>> drivers/platform/apple/smc_rtkit.c:76:20: warning: shift count is negative [-Wshift-count-negative]
                  FIELD_PREP(SMC_DATA, key));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:119:9: error: implicit declaration of function 'FIELD_PREP' [-Werror,-Wimplicit-function-declaration]
           msg = (FIELD_PREP(SMC_MSG, cmd) |
                  ^
   drivers/platform/apple/smc_rtkit.c:136:7: error: implicit declaration of function 'FIELD_GET' [-Werror,-Wimplicit-function-declaration]
                   if (FIELD_GET(SMC_ID, smc->cmd_ret) == smc->msg_id)
                       ^
   drivers/platform/apple/smc_rtkit.c:142:11: error: implicit declaration of function 'FIELD_GET' [-Werror,-Wimplicit-function-declaration]
           result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
                    ^
   drivers/platform/apple/smc_rtkit.c:123:20: warning: shift count >= width of type [-Wshift-count-overflow]
                  FIELD_PREP(SMC_DATA, arg));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
   drivers/platform/apple/smc_rtkit.c:123:20: warning: shift count is negative [-Wshift-count-negative]
                  FIELD_PREP(SMC_DATA, arg));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:147:25: warning: shift count >= width of type [-Wshift-count-overflow]
                   *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
   drivers/platform/apple/smc_rtkit.c:147:25: warning: shift count is negative [-Wshift-count-negative]
                   *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:298:13: error: implicit declaration of function 'FIELD_GET' [-Werror,-Wimplicit-function-declaration]
           } else if (FIELD_GET(SMC_MSG, message) == SMC_MSG_NOTIFICATION) {
                      ^
   drivers/platform/apple/smc_rtkit.c:322:6: error: implicit declaration of function 'FIELD_GET' [-Werror,-Wimplicit-function-declaration]
           if (FIELD_GET(SMC_MSG, message) != SMC_MSG_NOTIFICATION) {
               ^
   drivers/platform/apple/smc_rtkit.c:327:48: warning: shift count >= width of type [-Wshift-count-overflow]
           apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
                                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
   drivers/platform/apple/smc_rtkit.c:327:48: warning: shift count is negative [-Wshift-count-negative]
           apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
                                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:381:12: error: implicit declaration of function 'FIELD_PREP' [-Werror,-Wimplicit-function-declaration]
                                          FIELD_PREP(SMC_MSG, SMC_MSG_INITIALIZE));
                                          ^
>> drivers/platform/apple/smc_rtkit.c:429:25: error: use of undeclared identifier 'apple_smc_of_match'; did you mean 'apple_smc_rtkit_of_match'?
   MODULE_DEVICE_TABLE(of, apple_smc_of_match);
                           ^~~~~~~~~~~~~~~~~~
                           apple_smc_rtkit_of_match
   include/linux/module.h:244:15: note: expanded from macro 'MODULE_DEVICE_TABLE'
   extern typeof(name) __mod_##type##__##name##_device_table               \
                 ^
   drivers/platform/apple/smc_rtkit.c:425:34: note: 'apple_smc_rtkit_of_match' declared here
   static const struct of_device_id apple_smc_rtkit_of_match[] = {
                                    ^
   8 warnings and 9 errors generated.


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
  > 76		       FIELD_PREP(SMC_DATA, key));
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
