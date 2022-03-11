Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE44D5F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiCKK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbiCKK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:29:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D42182BCA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646994528; x=1678530528;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KU8T3d1tCOYJhZF3cQC5jUqiVgCi8RwxRrN2NC0C5fA=;
  b=BTGpmemM1Muu5FXmRdHe/F4tL6qteQjl1DWtXliTyUgwwRvh+gG27Eb2
   SckSPNFqVwAblfewegPW3QdUUgfsYVYxBNrOKM5qR5j012zpzxGunQXn5
   eEhy7lBx3y+hlUDsZEvAU3ufXQHfyCdHuTr4VgeCdzEcjr+rGM2M/Hb7A
   YPuLzIzUnAnOh6axX6WRQMMhCOOWseP9Qj0o1beDQVuGhpN3bpUxvf285
   gRiK5ZPQ887AdI6XMqMAUbdiF3KkXW6S5gcwAJbvsHaaDXQb3jCpr3/cw
   OJiioykUFJSd2t1rTFG5MP80l/oBMJQ313rxwioZK6OK84dRARqUEkZoV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341975824"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="341975824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="514462473"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 02:28:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nScVo-0006FV-Tq; Fri, 11 Mar 2022 10:28:44 +0000
Date:   Fri, 11 Mar 2022 18:27:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 42/54]
 fs/netfs/objects.c:49:9: error: implicit declaration of function
 'netfs_proc_add_writeback'; did you mean 'netfs_proc_add_rreq'?
Message-ID: <202203111832.1JtRzMeS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   4a98a2518c638d046f6f9c41060f78c349c4c6de
commit: 6903280c13bfacd00ddd06fda523ecce6ee8db34 [42/54] netfs: Add a procfile to list in-progress requests
config: openrisc-buildonly-randconfig-r004-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111832.1JtRzMeS-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6903280c13bfacd00ddd06fda523ecce6ee8db34
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout 6903280c13bfacd00ddd06fda523ecce6ee8db34
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/netfs/objects.c: In function 'netfs_alloc_request':
>> fs/netfs/objects.c:49:9: error: implicit declaration of function 'netfs_proc_add_writeback'; did you mean 'netfs_proc_add_rreq'? [-Werror=implicit-function-declaration]
      49 |         netfs_proc_add_writeback(rreq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         netfs_proc_add_rreq
   fs/netfs/objects.c: In function 'netfs_free_request':
>> fs/netfs/objects.c:81:9: error: implicit declaration of function 'netfs_proc_del_writeback'; did you mean 'netfs_proc_del_rreq'? [-Werror=implicit-function-declaration]
      81 |         netfs_proc_del_writeback(rreq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         netfs_proc_del_rreq
   cc1: some warnings being treated as errors


vim +49 fs/netfs/objects.c

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
    38		INIT_WORK(&rreq->work, NULL);
    39		refcount_set(&rreq->ref, 1);
    40		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
    41		if (rreq->netfs_ops->init_request) {
    42			ret = rreq->netfs_ops->init_request(rreq, file);
    43			if (ret < 0) {
    44				kfree(rreq);
    45				return ERR_PTR(ret);
    46			}
    47		}
    48	
  > 49		netfs_proc_add_writeback(rreq);
    50		netfs_stat(&netfs_n_rh_rreq);
    51		return rreq;
    52	}
    53	
    54	void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what)
    55	{
    56		int r;
    57	
    58		__refcount_inc(&rreq->ref, &r);
    59		trace_netfs_rreq_ref(rreq->debug_id, r + 1, what);
    60	}
    61	
    62	void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
    63	{
    64		struct netfs_io_subrequest *subreq;
    65	
    66		while (!list_empty(&rreq->subrequests)) {
    67			subreq = list_first_entry(&rreq->subrequests,
    68						  struct netfs_io_subrequest, rreq_link);
    69			list_del(&subreq->rreq_link);
    70			netfs_put_subrequest(subreq, was_async,
    71					     netfs_sreq_trace_put_clear);
    72		}
    73	}
    74	
    75	static void netfs_free_request(struct work_struct *work)
    76	{
    77		struct netfs_io_request *rreq =
    78			container_of(work, struct netfs_io_request, work);
    79	
    80		trace_netfs_rreq(rreq, netfs_rreq_trace_free);
  > 81		netfs_proc_del_writeback(rreq);
    82		netfs_clear_subrequests(rreq, false);
    83		if (rreq->netfs_ops->free_request)
    84			rreq->netfs_ops->free_request(rreq);
    85		if (rreq->cache_resources.ops)
    86			rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
    87		kfree_rcu(rreq, rcu);
    88		netfs_stat_d(&netfs_n_rh_rreq);
    89	}
    90	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
