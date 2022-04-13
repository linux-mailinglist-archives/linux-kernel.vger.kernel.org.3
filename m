Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE90D4FF087
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiDMH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiDMH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:29:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116933D1FF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649834831; x=1681370831;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9+856DcjO2YNbuW7rEr3u9PhAYPs1Ie75ilf0c59pmE=;
  b=POQjT+t+Z3PeNFogwepYexD//ydowkSUWsca8zEWoruI18kqFtAiQWJ+
   sD3M+AiOGZAa2ub8GMH9tfuiQHtRKzIMlz8M/mx7NHiBh/qXOLBNnNVZD
   wjZB39zU57TRayaJkoOErV2+T7z1SHNxhUN+7nLiFyVhRXAFaXDZlRJVA
   D8W16OxmxHYZ7g8b3Vfgk8QxLCuyTQaCOyuur/eU80OvcDvjXcJyUOCbR
   tHgxcjIpVLwujXgV3+q8YSWEv21+tSOQz1xpuip+QS7fnR3lNBD6hQg/R
   LpNDLL/WQbtCZ+V/bFV/eDyBB1zu5K9gG0jkesJGk/zaWSh7hqj+jh+bF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="242533607"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="242533607"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="590656716"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Apr 2022 00:27:08 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neXPA-00006i-3N;
        Wed, 13 Apr 2022 07:27:08 +0000
Date:   Wed, 13 Apr 2022 15:26:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 2/19]
 fs/netfs/objects.c:48:2: error: implicit declaration of function
 'netfs_proc_add_writeback' is invalid in C99
Message-ID: <202204131520.EiLQsAAH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   581c77dd1ab4abe122b649ed7118b3581ff1a437
commit: 20239f3d18983c183a267ab537919bc88990b832 [2/19] netfs: Add a procfile to list in-progress requests
config: s390-buildonly-randconfig-r002-20220412 (https://download.01.org/0day-ci/archive/20220413/202204131520.EiLQsAAH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/20239f3d18983c183a267ab537919bc88990b832
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout 20239f3d18983c183a267ab537919bc88990b832
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/netfs/objects.c:48:2: error: implicit declaration of function 'netfs_proc_add_writeback' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           netfs_proc_add_writeback(rreq);
           ^
   fs/netfs/objects.c:48:2: note: did you mean 'netfs_proc_add_rreq'?
   fs/netfs/internal.h:51:20: note: 'netfs_proc_add_rreq' declared here
   static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq) {}
                      ^
>> fs/netfs/objects.c:80:2: error: implicit declaration of function 'netfs_proc_del_writeback' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           netfs_proc_del_writeback(rreq);
           ^
   fs/netfs/objects.c:80:2: note: did you mean 'netfs_proc_del_rreq'?
   fs/netfs/internal.h:52:20: note: 'netfs_proc_del_rreq' declared here
   static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
                      ^
   2 errors generated.


vim +/netfs_proc_add_writeback +48 fs/netfs/objects.c

    10	
    11	/*
    12	 * Allocate an I/O request and initialise it.
    13	 */
    14	struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
    15						     struct file *file,
    16						     loff_t start, size_t len,
    17						     enum netfs_io_origin origin)
    18	{
    19		static atomic_t debug_ids;
    20		struct inode *inode = file ? file_inode(file) : mapping->host;
    21		struct netfs_i_context *ctx = netfs_i_context(inode);
    22		struct netfs_io_request *rreq;
    23		int ret;
    24	
    25		rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
    26		if (!rreq)
    27			return ERR_PTR(-ENOMEM);
    28	
    29		rreq->start	= start;
    30		rreq->len	= len;
    31		rreq->origin	= origin;
    32		rreq->netfs_ops	= ctx->ops;
    33		rreq->mapping	= mapping;
    34		rreq->inode	= inode;
    35		rreq->i_size	= i_size_read(inode);
    36		rreq->debug_id	= atomic_inc_return(&debug_ids);
    37		INIT_LIST_HEAD(&rreq->subrequests);
    38		refcount_set(&rreq->ref, 1);
    39		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
    40		if (rreq->netfs_ops->init_request) {
    41			ret = rreq->netfs_ops->init_request(rreq, file);
    42			if (ret < 0) {
    43				kfree(rreq);
    44				return ERR_PTR(ret);
    45			}
    46		}
    47	
  > 48		netfs_proc_add_writeback(rreq);
    49		netfs_stat(&netfs_n_rh_rreq);
    50		return rreq;
    51	}
    52	
    53	void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what)
    54	{
    55		int r;
    56	
    57		__refcount_inc(&rreq->ref, &r);
    58		trace_netfs_rreq_ref(rreq->debug_id, r + 1, what);
    59	}
    60	
    61	void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
    62	{
    63		struct netfs_io_subrequest *subreq;
    64	
    65		while (!list_empty(&rreq->subrequests)) {
    66			subreq = list_first_entry(&rreq->subrequests,
    67						  struct netfs_io_subrequest, rreq_link);
    68			list_del(&subreq->rreq_link);
    69			netfs_put_subrequest(subreq, was_async,
    70					     netfs_sreq_trace_put_clear);
    71		}
    72	}
    73	
    74	static void netfs_free_request(struct work_struct *work)
    75	{
    76		struct netfs_io_request *rreq =
    77			container_of(work, struct netfs_io_request, work);
    78	
    79		trace_netfs_rreq(rreq, netfs_rreq_trace_free);
  > 80		netfs_proc_del_writeback(rreq);
    81		netfs_clear_subrequests(rreq, false);
    82		if (rreq->netfs_ops->free_request)
    83			rreq->netfs_ops->free_request(rreq);
    84		if (rreq->cache_resources.ops)
    85			rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
    86		kfree_rcu(rreq, rcu);
    87		netfs_stat_d(&netfs_n_rh_rreq);
    88	}
    89	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
