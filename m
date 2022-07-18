Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C597577B01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiGRGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGRGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:31:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD916585
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658125891; x=1689661891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=okrjatJa1D0kwkWfKcg6m75U5AxWNXcokwAOov2aqRo=;
  b=Kh9GNpeW7E8pKEI+2v6Gs92QEwOP8/x/mRHOCoTGPIXtOA5XD9XpmXYt
   QrshsMOtABQpEup8z5ktAIqiaYkyD0BbPjGj5OuSiYL59Xr41DOuX9g/H
   3JETCiRpDeKvLijBGMMwV5q3iYhFPkPOIzoK1YR28EIrURc+Vx1eYmWx4
   8Q55+PB6d8tuzOd3TpJPOQOh4xbaVjV0hKh5RSwQHNu+Sbz/QKSqbltwZ
   tfppeZAwu+NmX74vtUOgHb8xzRZveO5L3F448i3psU/EgSh0vOHEt3flL
   v84bFH1CMVhQ5DTHYrESclTkTBvwmOj3fxFrJg0c2utiqZO9yB82ap7IL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="311825864"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="311825864"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="572277405"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2022 23:31:27 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDKHu-00046A-Ui;
        Mon, 18 Jul 2022 06:31:26 +0000
Date:   Mon, 18 Jul 2022 14:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:f2fs 4/4] fs/f2fs/segment.h:417:21: warning: comparison
 of distinct pointer types ('typeof (start + (4096 / sizeof(struct
 f2fs_sit_entry))) *' (aka 'unsigned int *') and 'typeof ((unsigned
 long)(SM_I(sbi)->main_segments)) *' (aka 'unsigned long *'))
Message-ID: <202207181452.urqB2dj0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux f2fs
head:   787811ac4178b6f0a77923aa25c58b4041a52f05
commit: 787811ac4178b6f0a77923aa25c58b4041a52f05 [4/4] f
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220718/202207181452.urqB2dj0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74b88c69dc2644bd0dc5d64e2d7413a0d4040e5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/787811ac4178b6f0a77923aa25c58b4041a52f05
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche f2fs
        git checkout 787811ac4178b6f0a77923aa25c58b4041a52f05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/f2fs/file.c:31:
>> fs/f2fs/segment.h:417:21: warning: comparison of distinct pointer types ('typeof (start + (4096 / sizeof(struct f2fs_sit_entry))) *' (aka 'unsigned int *') and 'typeof ((unsigned long)(SM_I(sbi)->main_segments)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.
--
   In file included from fs/f2fs/segment.c:22:
>> fs/f2fs/segment.h:417:21: warning: comparison of distinct pointer types ('typeof (start + (4096 / sizeof(struct f2fs_sit_entry))) *' (aka 'unsigned int *') and 'typeof ((unsigned long)(SM_I(sbi)->main_segments)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
           unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/f2fs/segment.c:4070:22: warning: comparison of distinct pointer types ('typeof (start_segno + (4096 / sizeof(struct f2fs_sit_entry))) *' (aka 'unsigned int *') and 'typeof ((unsigned long)(SM_I(sbi)->main_segments)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   2 warnings generated.


vim +417 fs/f2fs/segment.h

068c3cd8586678 Yunlei He 2018-01-25  410  
068c3cd8586678 Yunlei He 2018-01-25  411  static inline void seg_info_to_sit_page(struct f2fs_sb_info *sbi,
068c3cd8586678 Yunlei He 2018-01-25  412  				struct page *page, unsigned int start)
068c3cd8586678 Yunlei He 2018-01-25  413  {
068c3cd8586678 Yunlei He 2018-01-25  414  	struct f2fs_sit_block *raw_sit;
068c3cd8586678 Yunlei He 2018-01-25  415  	struct seg_entry *se;
068c3cd8586678 Yunlei He 2018-01-25  416  	struct f2fs_sit_entry *rs;
068c3cd8586678 Yunlei He 2018-01-25 @417  	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
068c3cd8586678 Yunlei He 2018-01-25  418  					(unsigned long)MAIN_SEGS(sbi));
068c3cd8586678 Yunlei He 2018-01-25  419  	int i;
068c3cd8586678 Yunlei He 2018-01-25  420  
068c3cd8586678 Yunlei He 2018-01-25  421  	raw_sit = (struct f2fs_sit_block *)page_address(page);
81114baa835b59 Chao Yu   2018-04-09  422  	memset(raw_sit, 0, PAGE_SIZE);
068c3cd8586678 Yunlei He 2018-01-25  423  	for (i = 0; i < end - start; i++) {
068c3cd8586678 Yunlei He 2018-01-25  424  		rs = &raw_sit->entries[i];
068c3cd8586678 Yunlei He 2018-01-25  425  		se = get_seg_entry(sbi, start + i);
068c3cd8586678 Yunlei He 2018-01-25  426  		__seg_info_to_raw_sit(se, rs);
068c3cd8586678 Yunlei He 2018-01-25  427  	}
068c3cd8586678 Yunlei He 2018-01-25  428  }
068c3cd8586678 Yunlei He 2018-01-25  429  

:::::: The code at line 417 was first introduced by commit
:::::: 068c3cd85866785303f18960a4c00a182515b963 f2fs: rebuild sit page from sit info in mem

:::::: TO: Yunlei He <heyunlei@huawei.com>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
