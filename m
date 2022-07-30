Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31C0585C96
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 01:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiG3XBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiG3XBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:01:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597114033
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659222111; x=1690758111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U6Bvegd1tq+PskN4kPjFP0sVNRYkTabIdMjaluyKOHQ=;
  b=HMrEPaLLeGuS1lzutcZmsapkZiMv16gBV3q6apOVoRS0QQFy2AXQnxi4
   8ikbPLTtA/3idNOnTFyQjdSjvKXZtjJT6BulX1I1rTWhZ/M5SGdEbjrl+
   XOgGMztvWv6jvd1aluMheKS7GIM4OJcki33rt6k5YqIqjfvC81GmTbS23
   3q0mko5jNzrnu04mCPrC84/qt0ZqsEyspb4pXv4/mLOplQY3zeYtvWLg3
   vq0EQwi7/mVeL3k3ON4FgPlraQ9DQZfjnIdDQBt2xfPWMmrfeBXdJh3SW
   C8/ZzE5OXmt5gwRtxUUPFq8ARk2/VOmmge/Kf0jtpFXVdjxTyXjKj95U4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268717670"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="268717670"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 16:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="743886967"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2022 16:01:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHvSv-000DPt-2N;
        Sat, 30 Jul 2022 23:01:49 +0000
Date:   Sun, 31 Jul 2022 07:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/smc/smc_llc.c:40:1: warning: alignment 1 of 'struct smc_llc_hdr'
 is less than 4
Message-ID: <202207310658.ERb14Td9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karsten,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   620725263f4222b3c94d4ee19846835feec0ad69
commit: b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196 net/smc: extend LLC layer for SMC-Rv2
date:   10 months ago
config: arm-randconfig-r036-20220731 (https://download.01.org/0day-ci/archive/20220731/202207310658.ERb14Td9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b4ba4652b3f8b7c9bbb5786f8acf4724bdab2196
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/smc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:19,
                    from include/linux/fs.h:15,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/tcp.h:17,
                    from include/net/tcp.h:20,
                    from net/smc/smc_llc.c:13:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1349:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1349 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1335:27: note: 'mem_section' declared here
    1335 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   net/smc/smc_llc.c: At top level:
>> net/smc/smc_llc.c:40:1: warning: alignment 1 of 'struct smc_llc_hdr' is less than 4 [-Wpacked-not-aligned]
      40 | } __packed;             /* format defined in
         | ^
   In file included from <command-line>:
   net/smc/smc_llc.c: In function 'smc_llc_add_pending_send':
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_564' declared with attribute error: must increase SMC_WR_BUF_SIZE to at least sizeof(struct smc_llc_msg)
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:409:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     409 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:322:45: error: call to '__compiletime_assert_565' declared with attribute error: must adapt SMC_WR_TX_SIZE to sizeof(struct smc_llc_msg); if not all smc_wr upper layer protocols use the same message size any more, must start to set link->wr_tx_sges[i].length on each individual smc_wr_tx_send()
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:303:25: note: in definition of macro '__compiletime_assert'
     303 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:412:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     412 |         BUILD_BUG_ON_MSG(
         |         ^~~~~~~~~~~~~~~~
   In function 'smc_llc_send_message_wait',
       inlined from 'smc_llc_send_link_delete_all' at net/smc/smc_llc.c:1635:8:
   net/smc/smc_llc.c:785:9: warning: 'memcpy' reading 60 bytes from a region of size 49 [-Wstringop-overread]
     785 |         memcpy(wr_buf, llcbuf, sizeof(union smc_llc_msg));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c: In function 'smc_llc_send_link_delete_all':
   net/smc/smc_llc.c:1622:37: note: source object 'delllc' of size 49
    1622 |         struct smc_llc_msg_del_link delllc = {};
         |                                     ^~~~~~


vim +40 net/smc/smc_llc.c

    23	
    24	struct smc_llc_hdr {
    25		struct smc_wr_rx_hdr common;
    26		union {
    27			struct {
    28				u8 length;	/* 44 */
    29		#if defined(__BIG_ENDIAN_BITFIELD)
    30				u8 reserved:4,
    31				   add_link_rej_rsn:4;
    32	#elif defined(__LITTLE_ENDIAN_BITFIELD)
    33				u8 add_link_rej_rsn:4,
    34				   reserved:4;
    35	#endif
    36			};
    37			u16 length_v2;	/* 44 - 8192*/
    38		};
    39		u8 flags;
  > 40	} __packed;		/* format defined in
    41				 * IBM Shared Memory Communications Version 2
    42				 * (https://www.ibm.com/support/pages/node/6326337)
    43				 */
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
