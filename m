Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B205577967
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGRBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGRBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:45:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DB13F22
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658108710; x=1689644710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3ZBTCN554S4wyXZeUS8sJhqy6fYcV1h0evtpe655gg=;
  b=f8zDx8LyaStX/BIkNaiH33tD88y8Dt4KVxLRfpIr1+iTVctjb98S/YCa
   /OlE2Nzw9s+VMkBqOYLUKj5VqsSwSYai3k5pYnctairqsj2XE4G17HEIZ
   x4DUBdm4WwO+SS5zgXFQq5T+vGt3pdid1gth3B2H9EEyXNsCHWdGDI+ss
   QuixuJqb0u6slPQID0upaFsskVC73oAXVs6mPY2fFKHBhynAxgjrc1K7/
   QEqKUD4Un82PcfUYfnuJbiLtYunetyilq7hUaZ65C6eJ3sHE0zKjQcLXw
   G+mGI3PYCF7xgp+R2cRbbYarchoB9Bq6XHHpFIgykJf8D+YfbnUGvOFJC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="284864883"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="284864883"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="629746039"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2022 18:45:08 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDFop-0003sQ-JK;
        Mon, 18 Jul 2022 01:45:07 +0000
Date:   Mon, 18 Jul 2022 09:44:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:f2fs 2/3] include/linux/f2fs_fs.h:364:1: error:
 static_assert failed due to requirement 'sizeof(struct f2fs_nat_block) ==
 4095':
Message-ID: <202207180909.eQsJ5h8G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux f2fs
head:   93e015b268055bcd2dc2f03bcb2c1311dff33c5e
commit: c8670ac5d2e3a0351cefc7ca9722cf532c3fa823 [2/3] Verify structure sizes at compile time
config: hexagon-randconfig-r041-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180909.eQsJ5h8G-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/c8670ac5d2e3a0351cefc7ca9722cf532c3fa823
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche f2fs
        git checkout c8670ac5d2e3a0351cefc7ca9722cf532c3fa823
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:10:
>> include/linux/f2fs_fs.h:364:1: error: static_assert failed due to requirement 'sizeof(struct f2fs_nat_block) == 4095': 
   static_assert(sizeof(struct f2fs_nat_block) == 4095, "");
   ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ^               ~~~~
   include/linux/build_bug.h:78:41: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                           ^              ~~~~
   In file included from fs/f2fs/dir.c:10:
>> include/linux/f2fs_fs.h:407:1: error: static_assert failed due to requirement 'sizeof(struct f2fs_sit_block) == 4070': 
   static_assert(sizeof(struct f2fs_sit_block) == 4070, "");
   ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ^               ~~~~
   include/linux/build_bug.h:78:41: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                           ^              ~~~~
   2 errors generated.


vim +364 include/linux/f2fs_fs.h

   363	
 > 364	static_assert(sizeof(struct f2fs_nat_block) == 4095, "");
   365	
   366	/*
   367	 * For SIT entries
   368	 *
   369	 * Each segment is 2MB in size by default so that a bitmap for validity of
   370	 * there-in blocks should occupy 64 bytes, 512 bits.
   371	 * Not allow to change this.
   372	 */
   373	#define SIT_VBLOCK_MAP_SIZE 64
   374	#define SIT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_sit_entry))
   375	
   376	/*
   377	 * F2FS uses 4 bytes to represent block address. As a result, supported size of
   378	 * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
   379	 */
   380	#define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
   381	
   382	/*
   383	 * Note that f2fs_sit_entry->vblocks has the following bit-field information.
   384	 * [15:10] : allocation type such as CURSEG_XXXX_TYPE
   385	 * [9:0] : valid block count
   386	 */
   387	#define SIT_VBLOCKS_SHIFT	10
   388	#define SIT_VBLOCKS_MASK	((1 << SIT_VBLOCKS_SHIFT) - 1)
   389	#define GET_SIT_VBLOCKS(raw_sit)				\
   390		(le16_to_cpu((raw_sit)->vblocks) & SIT_VBLOCKS_MASK)
   391	#define GET_SIT_TYPE(raw_sit)					\
   392		((le16_to_cpu((raw_sit)->vblocks) & ~SIT_VBLOCKS_MASK)	\
   393		 >> SIT_VBLOCKS_SHIFT)
   394	
   395	struct f2fs_sit_entry {
   396		__le16 vblocks;				/* reference above */
   397		__u8 valid_map[SIT_VBLOCK_MAP_SIZE];	/* bitmap for valid blocks */
   398		__le64 mtime;				/* segment age for cleaning */
   399	} __packed;
   400	
   401	static_assert(sizeof(struct f2fs_sit_entry) == 74, "");
   402	
   403	struct f2fs_sit_block {
   404		struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
   405	} __packed;
   406	
 > 407	static_assert(sizeof(struct f2fs_sit_block) == 4070, "");
   408	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
