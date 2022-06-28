Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8C55EDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiF1T2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiF1T1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:27:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C0FD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656444332; x=1687980332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vA8AUe3SseTOUfL/Kcn/DK0nH5CwMA0z/lVwts4sJYU=;
  b=L32RYIfZFbnmWVcDJVEStGCMY+ayIGcdUhFi+wIxGx5s/3lSY2qe/Zyd
   vwmLaAIj8VJchuSB1sx198Odd3bF9LcsbbvpN88D0rgi+TpUUIXU550Zu
   wTlMSKTbL6YF16/oH32odrLYoLA+cL7P/w6XCGLWQkYtdmBMd7JBhjpwG
   0sqgIvEtfbuGu9DPTTa5qocq+/yNPmUWEPwVw9NeMlfglBFnqleL0aDrV
   P20/bp1XCm9xPdW20/HonV5WOzNQv9ijLXZk0E7b6Ex5Dtd6B6hK1Xh8t
   RFqCQSdAmRqnBzNUb8F+OTgwy1bpoZL2M/c0FvkP3Wdn6KITa2cRlEYI7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282924069"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="282924069"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="658251282"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 12:25:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6Gq1-000AYE-Bu;
        Tue, 28 Jun 2022 19:25:29 +0000
Date:   Wed, 29 Jun 2022 03:25:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:netfs-linked-list 32/54] fs/netfs/output.c:274:25: warning:
 unused variable 'cookie'
Message-ID: <202206290345.wPdhFKn5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git netfs-linked-list
head:   d35a2461e039c9131e97bb125eac59a0f04e9161
commit: feb78625e48b167397af0355efac9bcf3b545d42 [32/54] netfs: Dispatch write requests to process a writeback slice
config: x86_64-randconfig-a004-20220627 (https://download.01.org/0day-ci/archive/20220629/202206290345.wPdhFKn5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=feb78625e48b167397af0355efac9bcf3b545d42
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton netfs-linked-list
        git checkout feb78625e48b167397af0355efac9bcf3b545d42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/netfs/output.c:274:49: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct netfs_inode *' [-Werror,-Wincompatible-pointer-types]
           struct fscache_cookie *cookie = netfs_i_cookie(wreq->inode);
                                                          ^~~~~~~~~~~
   include/linux/netfs.h:413:73: note: passing argument to parameter 'ctx' here
   static inline struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx)
                                                                           ^
>> fs/netfs/output.c:274:25: warning: unused variable 'cookie' [-Wunused-variable]
           struct fscache_cookie *cookie = netfs_i_cookie(wreq->inode);
                                  ^
   1 warning and 1 error generated.


vim +/cookie +274 fs/netfs/output.c

   266	
   267	/*
   268	 * Set up a op for writing to the cache.
   269	 */
   270	static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
   271	{
   272		struct netfs_cache_resources *cres;
   273		struct netfs_io_subrequest *subreq;
 > 274		struct fscache_cookie *cookie = netfs_i_cookie(wreq->inode);
   275		loff_t start = wreq->first * PAGE_SIZE;
   276		size_t len = (wreq->last - wreq->first + 1) * PAGE_SIZE;
   277		int ret;
   278	
   279		if (!fscache_cookie_enabled(cookie)) {
   280			clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags);
   281			return;
   282		}
   283	
   284		_debug("write to cache");
   285		subreq = netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start, len,
   286						    netfs_write_to_cache_op_worker);
   287		if (!subreq)
   288			return;
   289	
   290		cres = &wreq->cache_resources;
   291		ret = -ENOBUFS;
   292		if (wreq->netfs_ops->begin_cache_operation)
   293			ret = wreq->netfs_ops->begin_cache_operation(wreq);
   294		if (ret < 0) {
   295			netfs_write_subrequest_terminated(subreq, ret, false);
   296			return;
   297		}
   298	
   299		ret = cres->ops->prepare_write(cres, &start, &len, i_size_read(wreq->inode),
   300					       true);
   301		if (ret < 0) {
   302			netfs_write_subrequest_terminated(subreq, ret, false);
   303			return;
   304		}
   305	
   306		netfs_queue_write_request(subreq);
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
