Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7064B5083
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353445AbiBNMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:45:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBNMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:45:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBD749279
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644842705; x=1676378705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Q+R5lSrawrz8gsh2/e/9Tsn7XcjNwgASAJ7r3luafs=;
  b=X9cyVVhheNSiLoCABco335KxWOi2tTnGeAa7hLujJ0T9pNVxyK8W8GNZ
   WuErPUzH3y2WbOwwzSmFqcyxF/Pdk//SyY7M3hnns6ORCXCh3j1GOM/Tz
   nfsS/Bl9mG5+ZWNXdoAhs3IicMVSS1KEfRlCiqDPbtVS3cbenXDiOvDew
   +/AGSNlNhWA6RZ1GnLvVan27PGQ9YA8u97A4VtjcRcV0gMmjxEIVH4PcU
   2801rcF4OlihIRHalYG13/509iOi7+WccD+yZYGWTbWGjWJig3piuJ7QM
   bQuGVp5Xm8C/0wy0dcl3l07bIaCm7w0UAeOpqmh+Xy1hOEr1Zts14BkS9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250286444"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250286444"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="775136765"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2022 04:45:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJaj0-0008XZ-Q1; Mon, 14 Feb 2022 12:45:02 +0000
Date:   Mon, 14 Feb 2022 20:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 57/85] mm/folio-compat.c:173:6: error:
 redefinition of 'mlock_vma_page'
Message-ID: <202202142042.ZrGvsx6C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   c267b33d0001488f1d9dad12d6a87655e174d914
commit: 9f6308afc86e0291310d03238e80557983af6e40 [57/85] mm/mlock: Turn mlock_vma_page() into mlock_vma_folio()
config: h8300-alldefconfig (https://download.01.org/0day-ci/archive/20220214/202202142042.ZrGvsx6C-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 9f6308afc86e0291310d03238e80557983af6e40
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/folio-compat.c:168:6: warning: no previous prototype for 'clear_page_mlock' [-Wmissing-prototypes]
     168 | void clear_page_mlock(struct page *page)
         |      ^~~~~~~~~~~~~~~~
>> mm/folio-compat.c:173:6: error: redefinition of 'mlock_vma_page'
     173 | void mlock_vma_page(struct page *page)
         |      ^~~~~~~~~~~~~~
   In file included from mm/folio-compat.c:10:
   mm/internal.h:503:20: note: previous definition of 'mlock_vma_page' with type 'void(struct page *)'
     503 | static inline void mlock_vma_page(struct page *page) { }
         |                    ^~~~~~~~~~~~~~
   mm/folio-compat.c: In function 'mlock_vma_page':
>> mm/folio-compat.c:175:9: error: implicit declaration of function 'mlock_vma_folio'; did you mean 'mlock_vma_page'? [-Werror=implicit-function-declaration]
     175 |         mlock_vma_folio(page_folio(page));
         |         ^~~~~~~~~~~~~~~
         |         mlock_vma_page
   cc1: some warnings being treated as errors


vim +/mlock_vma_page +173 mm/folio-compat.c

   172	
 > 173	void mlock_vma_page(struct page *page)
   174	{
 > 175		mlock_vma_folio(page_folio(page));

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
