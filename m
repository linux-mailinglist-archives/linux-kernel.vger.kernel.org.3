Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E68596522
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbiHPWIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbiHPWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:08:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D12C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660687685; x=1692223685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=krwPLkmK5xsZuiXXP2wFQW4ErvMLaDEDNhLvoCnv1R4=;
  b=Cn5lvphnTi6C2WyykwI0r34vC1aXdigVF0Ht/5Xa0Ajfc+YoVSC7WGyX
   tE8S6qQByOYGuUvva6Mt8hb1jjw5SIwtuUQYfFPQQNnYdIZyka3G4QBui
   lf8wqvjw747U0DDpG8ewiqyXNQcreT3K+EN7dju6tvwP9YyVL1JNaaRBJ
   nF3pIVYLKGDL4dD2yK2MNMZC2sJ4qNdcBJMFMfYzr236ocX7C2WUJVEW/
   45yHpp61PbQA6HnD1XJE7rR3M22nFztqJ07Rd1JCYJrVzsYKxxFjLYQv0
   rc/4GSNbCu/uOPku3gx25sX7o2p1oCtMdALL2NSGMxgtpz6TE2XEjttmI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293614653"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293614653"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 15:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="610419855"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2022 15:08:02 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO4jC-0000Gn-0m;
        Tue, 16 Aug 2022 22:08:02 +0000
Date:   Wed, 17 Aug 2022 06:07:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 4/17]
 drivers/platform/apple/smc_rtkit.c:74:9: error: call to undeclared function
 'FIELD_PREP'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202208170620.ruISFGG4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   85225bbe01a2a74102db8d75e316b4e46f1cb07f
commit: 59000ffdca0f77c3f45fe7610510b17382fc8974 [4/17] platform/apple: Add new Apple Mac SMC driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220817/202208170620.ruISFGG4-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/59000ffdca0f77c3f45fe7610510b17382fc8974
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout 59000ffdca0f77c3f45fe7610510b17382fc8974
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/platform/apple/smc_rtkit.c:74:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
                  ^
>> drivers/platform/apple/smc_rtkit.c:95:6: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
               ^
>> drivers/platform/apple/smc_rtkit.c:77:20: warning: shift count >= width of type [-Wshift-count-overflow]
                  FIELD_PREP(SMC_DATA, key));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
>> drivers/platform/apple/smc_rtkit.c:77:20: warning: shift count is negative [-Wshift-count-negative]
                  FIELD_PREP(SMC_DATA, key));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:121:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           msg = (FIELD_PREP(SMC_MSG, cmd) |
                  ^
   drivers/platform/apple/smc_rtkit.c:139:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (FIELD_GET(SMC_ID, smc->cmd_ret) == smc->msg_id)
                       ^
   drivers/platform/apple/smc_rtkit.c:145:11: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
                    ^
   drivers/platform/apple/smc_rtkit.c:125:20: warning: shift count >= width of type [-Wshift-count-overflow]
                  FIELD_PREP(SMC_DATA, arg));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
   drivers/platform/apple/smc_rtkit.c:125:20: warning: shift count is negative [-Wshift-count-negative]
                  FIELD_PREP(SMC_DATA, arg));
                             ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:150:25: warning: shift count >= width of type [-Wshift-count-overflow]
                   *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
   drivers/platform/apple/smc_rtkit.c:150:25: warning: shift count is negative [-Wshift-count-negative]
                   *ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:303:13: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           } else if (FIELD_GET(SMC_MSG, message) == SMC_MSG_NOTIFICATION) {
                      ^
   drivers/platform/apple/smc_rtkit.c:327:6: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (FIELD_GET(SMC_MSG, message) != SMC_MSG_NOTIFICATION) {
               ^
   drivers/platform/apple/smc_rtkit.c:332:48: warning: shift count >= width of type [-Wshift-count-overflow]
           apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
                                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
   drivers/platform/apple/smc_rtkit.c:332:48: warning: shift count is negative [-Wshift-count-negative]
           apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
                                                         ^~~~~~~~
   drivers/platform/apple/smc_rtkit.c:30:20: note: expanded from macro 'SMC_DATA'
   #define SMC_DATA                        GENMASK(63, 32)
                                           ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:386:12: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                          FIELD_PREP(SMC_MSG, SMC_MSG_INITIALIZE), NULL, false);


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
  > 77		       FIELD_PREP(SMC_DATA, key));
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
