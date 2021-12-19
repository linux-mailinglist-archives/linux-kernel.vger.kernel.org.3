Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8490947A116
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhLSPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:02:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:45380 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233146AbhLSPCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639926156; x=1671462156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+XoqNGfgG9ZuaZa7jYM0wyWMe39EH0hVd3lU+dN1eHk=;
  b=G8xN6hZZHMg0XecABLB9YfgwL5a8FD5e/IiVop4gZCn86CHXeN+Y31xo
   pFcSMsa0K6sLUhyObb7Je720mzXbDi1b9zfbVPT15MhpQgmE45Q0UNBTE
   jIGhmJv/L4TDG5BeTNawul5D6/gUnGI+/Gh27aD+HAeidamsO1gCqmavI
   gEr6uXRcM6GoARAQOBEdgL5Ko2tgviDOd7sgwVdC1o/1SmZoRlIeYpzTl
   7H+hbHcBQ25IExXwvXcvM3tdHZ0/CeM09bAqRYra5slOri+LefEwBGpgO
   +zAOJwfebCbWGIg7b6FT7qMewDHbD0uEiVs3ER/RThkZ8iUdmTJQypJJ3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="239837560"
X-IronPort-AV: E=Sophos;i="5.88,218,1635231600"; 
   d="scan'208";a="239837560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 07:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,218,1635231600"; 
   d="scan'208";a="507379186"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2021 07:02:34 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myxhp-00073T-Qa; Sun, 19 Dec 2021 15:02:33 +0000
Date:   Sun, 19 Dec 2021 23:01:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 94/94] fs/nfs/nfs42proc.c:72:9: error:
 implicit declaration of function 'nfs4_bitmask_set'
Message-ID: <202112192225.W4qpFO6L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   357b7dbe0ee9811ba054d636d4ad55af1c698c6e
commit: 357b7dbe0ee9811ba054d636d4ad55af1c698c6e [94/94] NFSv42: Fallocate and clone should also request 'blocks used'
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211219/202112192225.W4qpFO6L-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout 357b7dbe0ee9811ba054d636d4ad55af1c698c6e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfs/nfs42proc.c: In function '_nfs42_proc_fallocate':
>> fs/nfs/nfs42proc.c:72:9: error: implicit declaration of function 'nfs4_bitmask_set' [-Werror=implicit-function-declaration]
      72 |         nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
         |         ^~~~~~~~~~~~~~~~
   fs/nfs/nfs42proc.c: In function '_nfs42_proc_clone':
>> fs/nfs/nfs42proc.c:1046:27: error: 'NFS4_BITMASK_SZ' undeclared (first use in this function); did you mean 'NFS_BITMASK_SZ'?
    1046 |         __u32 dst_bitmask[NFS4_BITMASK_SZ];
         |                           ^~~~~~~~~~~~~~~
         |                           NFS_BITMASK_SZ
   fs/nfs/nfs42proc.c:1046:27: note: each undeclared identifier is reported only once for each function it appears in
   fs/nfs/nfs42proc.c:1046:15: warning: unused variable 'dst_bitmask' [-Wunused-variable]
    1046 |         __u32 dst_bitmask[NFS4_BITMASK_SZ];
         |               ^~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_CORE
   Depends on HAS_IOMEM
   Selected by
   - HI6421V600_IRQ && OF && SPMI


vim +/nfs4_bitmask_set +72 fs/nfs/nfs42proc.c

    43	
    44	static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
    45			struct nfs_lock_context *lock, loff_t offset, loff_t len)
    46	{
    47		struct inode *inode = file_inode(filep);
    48		struct nfs_server *server = NFS_SERVER(inode);
    49		u32 bitmask[3];
    50		struct nfs42_falloc_args args = {
    51			.falloc_fh	= NFS_FH(inode),
    52			.falloc_offset	= offset,
    53			.falloc_length	= len,
    54			.falloc_bitmask	= bitmask,
    55		};
    56		struct nfs42_falloc_res res = {
    57			.falloc_server	= server,
    58		};
    59		int status;
    60	
    61		msg->rpc_argp = &args;
    62		msg->rpc_resp = &res;
    63	
    64		status = nfs4_set_rw_stateid(&args.falloc_stateid, lock->open_context,
    65				lock, FMODE_WRITE);
    66		if (status) {
    67			if (status == -EAGAIN)
    68				status = -NFS4ERR_BAD_STATEID;
    69			return status;
    70		}
    71	
  > 72		nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
    73				 NFS_INO_INVALID_BLOCKS);
    74	
    75		res.falloc_fattr = nfs_alloc_fattr();
    76		if (!res.falloc_fattr)
    77			return -ENOMEM;
    78	
    79		status = nfs4_call_sync(server->client, server, msg,
    80					&args.seq_args, &res.seq_res, 0);
    81		if (status == 0)
    82			status = nfs_post_op_update_inode_force_wcc(inode,
    83								    res.falloc_fattr);
    84	
    85		if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE])
    86			trace_nfs4_fallocate(inode, &args, status);
    87		else
    88			trace_nfs4_deallocate(inode, &args, status);
    89		kfree(res.falloc_fattr);
    90		return status;
    91	}
    92	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
