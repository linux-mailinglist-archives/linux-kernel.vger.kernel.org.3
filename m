Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA4597CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiHREMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHREMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:12:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3F8E995
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660795949; x=1692331949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nk5uM2qjK+W1ydVZdO1CwFceZ1tYR9qSGcOLVTCVOdE=;
  b=OXs4xRU+nEUQI/oaCWsbz+e61NNpGHc5jBtr0Cp4VEt/0bXLcMNB9bmh
   17m5G00/FKNRr9HPpybzt15vWMIaYhMWSdvxWerOAUsIDIP5j+shelLcc
   B3hDfmjU4LabMdzRmV2+dduStoFwoaKUN89MMI+0lWkM1UYbfZhzN0EJM
   IzRxl8RbZ0c2BlpTYAPsyG8M6T/DbGze9EpmDX0SmGfMYAwr7mPkki+Az
   DSsuLP12JQ4UBrKzsaSG0Rlxu/uzQHHy2hiUU+IllQUczmzmtubst75nc
   36OD+AaiZNO2YWBITcJjmfl8NEmKOAaUe2OmXdpRwpTahcEP4UuGFjQ+S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292659061"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="292659061"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 21:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="667920262"
Received: from lkp-server01.sh.intel.com (HELO 6cc724e23301) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 21:12:28 -0700
Received: from kbuild by 6cc724e23301 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOWtP-00001P-1z;
        Thu, 18 Aug 2022 04:12:27 +0000
Date:   Thu, 18 Aug 2022 12:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 4/17]
 drivers/platform/apple/smc_rtkit.c:74:16: error: implicit declaration of
 function 'FIELD_PREP'
Message-ID: <202208181201.TefItZ04-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   85225bbe01a2a74102db8d75e316b4e46f1cb07f
commit: 59000ffdca0f77c3f45fe7610510b17382fc8974 [4/17] platform/apple: Add new Apple Mac SMC driver
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220818/202208181201.TefItZ04-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/59000ffdca0f77c3f45fe7610510b17382fc8974
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 59000ffdca0f77c3f45fe7610510b17382fc8974
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

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
                    from ./arch/nios2/include/generated/asm/div64.h:1,
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
>> drivers/platform/apple/smc_rtkit.c:95:13: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
      95 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
         |             FOLL_GET
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
