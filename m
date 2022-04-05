Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96264F4892
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353765AbiDEVmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353411AbiDEKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:06:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B34A90D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649152499; x=1680688499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YOugtdoOdlagxEKDXNaCJAubcGndk2KYqmkeY9Xukp4=;
  b=ZSoWCx6svSDNaqAtlnFKucCZlguzCjndAFkOMbEICE1U0gWcOh+8ro5R
   X5OI4JZQhSXPmZCgxySZL+yU9YhbKH0hRJAFVbqR5uJ8M8nYX08DfZbyF
   A3DtrDBi+WTQEeJcZ1Z7oDOJeejsFWIZ3JzezKFBKHeBCKVEXs+KKK4FK
   UArWZWGvw2CwxFrlvuHvGvTMAdYeaTFUkT1ndjdg8X7IHdx1ilIC3zFg+
   bMYRaNBJzZyTrEyc0yhtEjEey/Ciqx1GXcKPWE8cGqQJ9wc2GHOJfI+qQ
   GoGrcwfXAutxRtl4hsv1w4MRDvk6E3IDCPsMmZi95FZrz5ZqEhsTxY184
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="321404652"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="321404652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523932389"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 02:54:57 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbftp-00031H-23;
        Tue, 05 Apr 2022 09:54:57 +0000
Date:   Tue, 5 Apr 2022 17:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 2/40]
 fs/netfs/objects.c:48:2: error: implicit declaration of function
 'netfs_proc_add_writeback' is invalid in C99
Message-ID: <202204051743.54BHZ3ZH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 9bff5b05142d47cc6a64f5e023fd01d9bf8bee9e [2/40] netfs: Add a procfile to list in-progress requests
config: hexagon-randconfig-r021-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051743.54BHZ3ZH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9bff5b05142d47cc6a64f5e023fd01d9bf8bee9e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 9bff5b05142d47cc6a64f5e023fd01d9bf8bee9e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

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
