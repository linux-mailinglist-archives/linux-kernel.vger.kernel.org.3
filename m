Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1FA46F42C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhLITqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:46:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:43843 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhLITqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639078959; x=1670614959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yd3l/kjEw4yDS26E3b8SCIgekJ8tBmQf5mbpjCk8K1o=;
  b=bXar1WJnNkS5iLt8bD4VaykRVkrIK77PI3GCLRCTZ1TqorC5bejoHuxZ
   Ka+twIePKX1bEGuiTFJHFHIbbYowWAn23oxDBLwXxanGsbdktpEyIbmte
   N828LmBX93fx7ABa8OvR53+zDX3C3pkXWWxTQi51Yz3FPmcjj2Wr6SLHK
   vzIaIfVBXwu7rwxAdlwnQTsHF8d9fE+9M+U5kwDxQz7y6XsRWKL75d/8+
   6Y0m8N4C3D0kN7/r4Q/ew7nCYTxo9pfX6Z7hkOkiaK0d3m779vlfPNEaR
   pT2ubHQrm44/auEKBLHTe0Q3RpQbJbcMk77KV4OEmusWM+hPjC3Ncm9LX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="236929277"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="236929277"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="463377403"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 11:42:37 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvPJM-0002J2-KP; Thu, 09 Dec 2021 19:42:36 +0000
Date:   Fri, 10 Dec 2021 03:42:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Avihai Horon <avihaih@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [leon-rdma:rdma-next 24/31] drivers/infiniband/core/cache.c:968:17:
 error: expected ';' before 'goto'
Message-ID: <202112100326.X7X2uSiO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git rdma-next
head:   3851deadf6de976fe0d2f72ca1084b47a044c2c7
commit: 1f2b65dfb4d995e74b621e3e21e7c7445d187956 [24/31] RDMA/core: Modify rdma_query_gid() to return accurate error codes
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20211210/202112100326.X7X2uSiO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=1f2b65dfb4d995e74b621e3e21e7c7445d187956
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma rdma-next
        git checkout 1f2b65dfb4d995e74b621e3e21e7c7445d187956
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/infiniband/core/cache.c: In function 'rdma_query_gid':
>> drivers/infiniband/core/cache.c:968:17: error: expected ';' before 'goto'
     968 |                 goto done;
         |                 ^~~~


vim +968 drivers/infiniband/core/cache.c

03db3a2d81e6e8 Matan Barak     2015-07-30  938  
6612b4983f7e8d Parav Pandit    2018-03-13  939  /**
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  940   * rdma_query_gid - Read the GID content from the GID software cache
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  941   * @device:		Device to query the GID
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  942   * @port_num:		Port number of the device
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  943   * @index:		Index of the GID table entry to read
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  944   * @gid:		Pointer to GID where to store the entry's GID
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  945   *
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  946   * rdma_query_gid() only reads the GID entry content for requested device,
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  947   * port and index. It reads for IB, RoCE and iWarp link layers.  It doesn't
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  948   * hold any reference to the GID table entry in the HCA or software cache.
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  949   *
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  950   * Returns 0 on success or appropriate error code.
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  951   *
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  952   */
1fb7f8973f51ca Mark Bloch      2021-03-01  953  int rdma_query_gid(struct ib_device *device, u32 port_num,
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  954  		   int index, union ib_gid *gid)
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  955  {
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  956  	struct ib_gid_table *table;
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  957  	unsigned long flags;
1f2b65dfb4d995 Avihai Horon    2021-10-25  958  	int res;
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  959  
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  960  	if (!rdma_is_port_valid(device, port_num))
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  961  		return -EINVAL;
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  962  
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  963  	table = rdma_gid_table(device, port_num);
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  964  	read_lock_irqsave(&table->rwlock, flags);
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  965  
1f2b65dfb4d995 Avihai Horon    2021-10-25  966  	if (index < 0 || index >= table->sz) {
1f2b65dfb4d995 Avihai Horon    2021-10-25  967  		res = -EINVAL
c3d71b69a75cbb Jason Gunthorpe 2018-06-05 @968  		goto done;
1f2b65dfb4d995 Avihai Horon    2021-10-25  969  	}
1f2b65dfb4d995 Avihai Horon    2021-10-25  970  
1f2b65dfb4d995 Avihai Horon    2021-10-25  971  	if (!is_gid_entry_valid(table->data_vec[index])) {
1f2b65dfb4d995 Avihai Horon    2021-10-25  972  		res = -ENOENT;
1f2b65dfb4d995 Avihai Horon    2021-10-25  973  		goto done;
1f2b65dfb4d995 Avihai Horon    2021-10-25  974  	}
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  975  
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  976  	memcpy(gid, &table->data_vec[index]->attr.gid, sizeof(*gid));
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  977  	res = 0;
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  978  
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  979  done:
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  980  	read_unlock_irqrestore(&table->rwlock, flags);
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  981  	return res;
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  982  }
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  983  EXPORT_SYMBOL(rdma_query_gid);
c3d71b69a75cbb Jason Gunthorpe 2018-06-05  984  

:::::: The code at line 968 was first introduced by commit
:::::: c3d71b69a75cbbc03c8f43571b003ddadd40d056 IB/core: Provide rdma_ versions of the gid cache API

:::::: TO: Jason Gunthorpe <jgg@mellanox.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
