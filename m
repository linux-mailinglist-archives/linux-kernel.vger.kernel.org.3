Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809AD53DACF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbiFEIHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiFEIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:07:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B415818
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654416460; x=1685952460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f18CPNDfDygZosDJvgalcJdmhvSWvAvJ/c4Wl7hdE7s=;
  b=C1Uns1Ud4CPSUIXKpB0PpEUcH9s0KpqGV3QHR/WX+uIRXnv7tb4e1Kbu
   2fqpNjNjzcoBNqiLNmG0bH1nkeUIizoThm1l7PR+A/HtMrxgrX5gCUNmi
   6Z+F3mYjIMY+gsi/hOKWGMFodj8cfp2fhDiqzFW+mVZs8C+eajt15jv/h
   QlZzWJ3K3SgOEuTW2PYdY5gy+vEUZaDFuC/e5bBCLLdFVvUmGZiWFLWGt
   j7hUy7NHcrBFOZxFkhodMzuVDkhV5na1WdnsU+4sdTlalP1nSfaJ8FjzO
   /+OureDNegucrP42fsfiwKgwnr5OFBaXDpyKLG3t9C73h2rNX/WnbIlgz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="275337224"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="275337224"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 01:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="553943043"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2022 01:07:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxlIP-000Bjt-Bg;
        Sun, 05 Jun 2022 08:07:37 +0000
Date:   Sun, 5 Jun 2022 16:06:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 18/34]
 mm/filemap.c:1071:25: sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202206051647.vDYWTWQF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   1aafd4ba7b78b4ac0013a48a35252654852cb7ab
commit: 2516f41917ea4e10dce7e308dd9d1b2e31b65ad5 [18/34] ARM: mm: Make virt_to_pfn() a static inline
config: arm-randconfig-s031-20220605 (https://download.01.org/0day-ci/archive/20220605/202206051647.vDYWTWQF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=2516f41917ea4e10dce7e308dd9d1b2e31b65ad5
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 2516f41917ea4e10dce7e308dd9d1b2e31b65ad5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/filemap.c:1071:25: sparse: sparse: Using plain integer as NULL pointer
--
>> fs/crypto/bio.c:69:41: sparse: sparse: Using plain integer as NULL pointer
   fs/crypto/bio.c:161:51: sparse: sparse: Using plain integer as NULL pointer
--
>> fs/iomap/direct-io.c:184:29: sparse: sparse: Using plain integer as NULL pointer
--
>> security/keys/encrypted-keys/encrypted.c:475:32: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/md/dm-crypt.c:758:27: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/md/dm-kcopyd.c:396:31: sparse: sparse: Using plain integer as NULL pointer
--
>> block/blk-lib.c:203:53: sparse: sparse: Using plain integer as NULL pointer

vim +1071 mm/filemap.c

^1da177e4c3f415 Linus Torvalds          2005-04-16  1057  
62906027091f1d0 Nicholas Piggin         2016-12-25  1058  void __init pagecache_init(void)
^1da177e4c3f415 Linus Torvalds          2005-04-16  1059  {
62906027091f1d0 Nicholas Piggin         2016-12-25  1060  	int i;
62906027091f1d0 Nicholas Piggin         2016-12-25  1061  
62906027091f1d0 Nicholas Piggin         2016-12-25  1062  	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
df4d4f127394953 Matthew Wilcox (Oracle  2021-01-16  1063) 		init_waitqueue_head(&folio_wait_table[i]);
^1da177e4c3f415 Linus Torvalds          2005-04-16  1064  
62906027091f1d0 Nicholas Piggin         2016-12-25  1065  	page_writeback_init();
56a8c8eb1eaf212 Hugh Dickins            2022-03-22  1066  
56a8c8eb1eaf212 Hugh Dickins            2022-03-22  1067  	/*
56a8c8eb1eaf212 Hugh Dickins            2022-03-22  1068  	 * tmpfs uses the ZERO_PAGE for reading holes: it is up-to-date,
56a8c8eb1eaf212 Hugh Dickins            2022-03-22  1069  	 * and splice's page_cache_pipe_buf_confirm() needs to see that.
56a8c8eb1eaf212 Hugh Dickins            2022-03-22  1070  	 */
56a8c8eb1eaf212 Hugh Dickins            2022-03-22 @1071  	SetPageUptodate(ZERO_PAGE(0));
^1da177e4c3f415 Linus Torvalds          2005-04-16  1072  }
^1da177e4c3f415 Linus Torvalds          2005-04-16  1073  

:::::: The code at line 1071 was first introduced by commit
:::::: 56a8c8eb1eaf21261be8cdc4e3715239ac087342 tmpfs: do not allocate pages on read

:::::: TO: Hugh Dickins <hughd@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
