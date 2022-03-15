Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF34D96E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbiCOI7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiCOI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:59:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB7112A81
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647334700; x=1678870700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OamH5cCD6OY+XqvIwr2+b8PAvcl4Dd5SmNGx+vFZd1U=;
  b=DXqBI7LEa1DssPksJ69NtQ0Oe1rpxQZY7QJVvx7L4lAWFuwlnm+qSBDI
   b+8+n5J6/7K2rZ+3kTZGpGhdqAz1rG/5NO66cOOCB+WBN4wP/mdW/DGuf
   kyqiQ2kGHtFmgpcpjuLXvH7nKue3OoKV9J8a5vu2Ygf0w2v0btJBFm9fy
   9pjNTb4n3MPoiI5C7gjeSf3fWSKEr47TdlK5QWeRe5smcjlIyLKZ0R8oN
   cz0YJUFFgXhtZJFyI4K+A6v5H/LGmgi8EmTvfXqPqleGVldfOsCyKizMw
   HKnOY4aIrvJsPsDKAm2XP/0oKIm9MNF/XiyucsxtEGEjfTpg4v++W8Dii
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256440332"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="256440332"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 01:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="556832143"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 01:58:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU30U-000AlA-4A; Tue, 15 Mar 2022 08:58:18 +0000
Date:   Tue, 15 Mar 2022 16:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 166/179] fs/hostfs/hostfs_kern.c:507:17:
 error: 'filemap_dirty_folio' undeclared here (not in a function); did you
 mean 'filemap_get_folio'?
Message-ID: <202203151604.dZIG5fhk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   af564d7369d44fbbe697a5f631fe3bba5ebecd59
commit: 821405cf3ebbd9a17baf9afce08b0562fba04056 [166/179] fs: Convert trivial uses of __set_page_dirty_nobuffers to filemap_dirty_folio
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220315/202203151604.dZIG5fhk-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 821405cf3ebbd9a17baf9afce08b0562fba04056
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/hostfs/hostfs_kern.c:507:17: error: 'filemap_dirty_folio' undeclared here (not in a function); did you mean 'filemap_get_folio'?
     507 |  .dirty_folio = filemap_dirty_folio,
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 filemap_get_folio


vim +507 fs/hostfs/hostfs_kern.c

   503	
   504	static const struct address_space_operations hostfs_aops = {
   505		.writepage 	= hostfs_writepage,
   506		.readpage	= hostfs_readpage,
 > 507		.dirty_folio	= filemap_dirty_folio,
   508		.write_begin	= hostfs_write_begin,
   509		.write_end	= hostfs_write_end,
   510	};
   511	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
