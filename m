Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010F44B7A12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiBOV5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiBOV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:57:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EB8FCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644962232; x=1676498232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m6XSI0G98RPdQqcOvLzHw4i5erJFqqKLtNysZ8EGoWc=;
  b=XQ7meixloG3rOG95L78NTeSgUfrd7G/GpogCc1SPnb0oWTAEMLKX6RFj
   au9BikTHDI5I6ElIXlFZFUdANk3WnF5PazBEUn6l8kB26ylRdQPY2Nk5e
   F+l5gcy0+vVSlb544Mkw5yJlFxA5teIKZEWre9vZSgyDijdvDuviLkQxq
   Bo0Gu7S2L6EXBsu7/HD9mt1zYbku/YSPxbpo7gwOaDOutFVRveGFVq33J
   J/fb9TL20T5Gbyev7gYzIZB2g4MUEqhBUUOxcBFdvwTIAA1O6MR+PLQEB
   12mzVkBvwTdSpWD+Nm5xIO7nB7fq/jk66BOEQtrZ2bf79C4OYoayfQ1oq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230426533"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230426533"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 13:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="497587232"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 13:57:08 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK5oq-000A4q-6W; Tue, 15 Feb 2022 21:57:08 +0000
Date:   Wed, 16 Feb 2022 05:56:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 9/43]
 fs/9p/vfs_inode.c:258:7: error: no member named 'wsize' in 'struct
 netfs_i_context'
Message-ID: <202202160504.GlQpVHFc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   d40df0841e9f8de3713a19dd3f0ba283c860cb93
commit: 90870fcbed9794a03bee7aba8195e8c43e46e1dd [9/43] netfs: Add a netfs inode context
config: hexagon-randconfig-r034-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160504.GlQpVHFc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/90870fcbed9794a03bee7aba8195e8c43e46e1dd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 90870fcbed9794a03bee7aba8195e8c43e46e1dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/9p/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/dhowells/linux-fs/netfs-maple HEAD d40df0841e9f8de3713a19dd3f0ba283c860cb93 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> fs/9p/vfs_inode.c:258:7: error: no member named 'wsize' in 'struct netfs_i_context'
           ctx->wsize = 1024 * 1024;
           ~~~  ^
   1 error generated.


vim +258 fs/9p/vfs_inode.c

   249	
   250	/*
   251	 * Set parameters for the netfs library
   252	 */
   253	static void v9fs_set_netfs_context(struct inode *inode)
   254	{
   255		struct netfs_i_context *ctx = netfs_i_context(inode);
   256	
   257		netfs_i_context_init(inode, &v9fs_req_ops);
 > 258		ctx->wsize = 1024 * 1024;
   259	}
   260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
