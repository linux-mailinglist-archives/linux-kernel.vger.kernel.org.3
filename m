Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41934E1A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbiCTGQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242069AbiCTGQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:16:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DDEA76B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647756899; x=1679292899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XwlpogHoehElB+P7p2BtKSQCbX6NsBxc1YsFKJzIbzQ=;
  b=RtA/vsbNcnq0Qc5UFwT72ISJCYP/jx42MNz9NmHL3EmqA70bNXwtnbxt
   IQRdUo4iNXridU5vgEW+AE5uyzCVDNbFDB4NmoKqRqMbHFbvoY2/s0rWc
   2L2PA5T6qMfFECFiaFZTy4cotPNTR5rLFZldneN6PmNrVldS8ysy5UCRE
   DSdm4x+KKOle38qgPG2FQCrExul+xUdL5Kko7DV2Xn8SRFwRlbwOhbZfQ
   +7+/grtA84FP45SG8lfWzw7BRhfkANJJiZh/b78TGsd0TbRxZYoIrLcDQ
   fzmSL9B/ILm3yyBAvJRic9qnNqI/nTXUc6KcmjJGYdccISQGrKNUwKSaD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="282177167"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="282177167"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="716073956"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2022 23:14:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVoq8-000GdZ-W2; Sun, 20 Mar 2022 06:14:57 +0000
Date:   Sun, 20 Mar 2022 14:14:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:netfs-lib 44/59] fs/netfs/objects.c:48:9: error:
 implicit declaration of function 'netfs_proc_add_writeback'; did you mean
 'netfs_proc_add_rreq'?
Message-ID: <202203201439.oyNMcOwM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-lib
head:   be5db4483c9c2527fc63622f257ffd916ac87c98
commit: 72ab86a3e8b3709b611f7a709382fad7be00df69 [44/59] netfs: Add a procfile to list in-progress requests
config: nios2-randconfig-p002-20220320 (https://download.01.org/0day-ci/archive/20220320/202203201439.oyNMcOwM-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=72ab86a3e8b3709b611f7a709382fad7be00df69
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs netfs-lib
        git checkout 72ab86a3e8b3709b611f7a709382fad7be00df69
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/netfs/objects.c: In function 'netfs_alloc_request':
>> fs/netfs/objects.c:48:9: error: implicit declaration of function 'netfs_proc_add_writeback'; did you mean 'netfs_proc_add_rreq'? [-Werror=implicit-function-declaration]
      48 |         netfs_proc_add_writeback(rreq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         netfs_proc_add_rreq
   fs/netfs/objects.c: In function 'netfs_free_request':
>> fs/netfs/objects.c:80:9: error: implicit declaration of function 'netfs_proc_del_writeback'; did you mean 'netfs_proc_del_rreq'? [-Werror=implicit-function-declaration]
      80 |         netfs_proc_del_writeback(rreq);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         netfs_proc_del_rreq
   cc1: some warnings being treated as errors


vim +48 fs/netfs/objects.c

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
