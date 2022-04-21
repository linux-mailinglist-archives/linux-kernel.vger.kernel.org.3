Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BE50A7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391149AbiDUSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391202AbiDUSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:06:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5794B84D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650564216; x=1682100216;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bQ+rneEE1x3jrND7Y9Wv3LGa2VxvPuk/c+WG8SdyEzQ=;
  b=VI0lCMtpgyRWIR2MVpdVS39pWila2FnjFkisYts7EclQbKaB2jEBi7PF
   DHJjqy5f6BRgFjWhIW+GVywioknnL7DP6I+GjVRMWm3UBJKL1rKcskKm0
   yh5LO9oZKbJWyctYZGBrm+GDB5e6KrbSwvI2PrZTQqhPdSlTU5XKMuGAY
   XAfayIuKjRn42OdC5cxY9+FY6lK3RAaNNoWnWGvv/P6kJ9dYCf50VJmgM
   E/f9eS3pRE20w2wxxNk5zfxkrflLir118fJ2du6Ng6fbJQo69qmjbW71f
   018e0FYAElEzV0dgOhnHuTNdgyuZ+chlUowoddJgzzkD5Azo/q1TkAwzb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246335278"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="246335278"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="728116051"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2022 11:03:30 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhb9N-0008e7-O6;
        Thu, 21 Apr 2022 18:03:29 +0000
Date:   Fri, 22 Apr 2022 02:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:netfs-lib 2/18] fs/netfs/objects.c:48:2: error: call to
 undeclared function 'netfs_proc_add_writeback'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202204220100.5rFjj0Qv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-lib
head:   5b166ee5742c8a13e2958bad90e4b3a5d9bb0426
commit: d2183d7d55ccea0042532727e540a4835aa0a266 [2/18] netfs: Add a procfile to list in-progress requests
config: hexagon-randconfig-r045-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220100.5rFjj0Qv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=d2183d7d55ccea0042532727e540a4835aa0a266
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs netfs-lib
        git checkout d2183d7d55ccea0042532727e540a4835aa0a266
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/netfs/objects.c:48:2: error: call to undeclared function 'netfs_proc_add_writeback'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           netfs_proc_add_writeback(rreq);
           ^
   fs/netfs/objects.c:48:2: note: did you mean 'netfs_proc_add_rreq'?
   fs/netfs/internal.h:51:20: note: 'netfs_proc_add_rreq' declared here
   static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq) {}
                      ^
>> fs/netfs/objects.c:80:2: error: call to undeclared function 'netfs_proc_del_writeback'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
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
