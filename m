Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40846F17C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbhLIRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:23:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:30358 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242472AbhLIRXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639070377; x=1670606377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p13HYdA78gGYb5YUmGUWNrOvFjqweYjLhA5kxPLO9E0=;
  b=Xp18dQDJ0SrptRqm863fG4LVOeizAKk8AD0uPitXcLM8s9vc29/15bIA
   nxTw6YnAQtjP9olfslQIFN3ZPVN2HUGUSvc0hSM85eaRzLgNHLqTN2dnl
   yE1FuRyrzdWvR9KWP7CxmCW3+BBOlV6yBr2esHJqknwmsYAVIYg8T4JAY
   2VOwvuhyiOQCdkuOpikQKMlFXfvQSB2DPIi6PW79L+3sn/0/87MC2U+gK
   kqfrTS8dJSVuhgF8vcaeASnzgf5YmVutRF1roXI3aEHvo4qqIZ/AwTrNg
   95lC/i5eBRkwQC2hgatFCKB+ijgl0JhLIAKkRmQUWnUlKccr1gTasOuR0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="236896327"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="236896327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:19:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="564897213"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2021 09:19:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvN4w-0002Cw-G0; Thu, 09 Dec 2021 17:19:34 +0000
Date:   Fri, 10 Dec 2021 01:19:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Avihai Horon <avihaih@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [leon-rdma:rdma-next 24/31] drivers/infiniband/core/cache.c:967:16:
 error: expected ';' after expression
Message-ID: <202112100121.3lkxU859-lkp@intel.com>
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
config: riscv-buildonly-randconfig-r003-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100121.3lkxU859-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=1f2b65dfb4d995e74b621e3e21e7c7445d187956
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma rdma-next
        git checkout 1f2b65dfb4d995e74b621e3e21e7c7445d187956
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/infiniband/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/infiniband/core/cache.c:967:16: error: expected ';' after expression
                   res = -EINVAL
                                ^
                                ;
   1 error generated.


vim +967 drivers/infiniband/core/cache.c

   938	
   939	/**
   940	 * rdma_query_gid - Read the GID content from the GID software cache
   941	 * @device:		Device to query the GID
   942	 * @port_num:		Port number of the device
   943	 * @index:		Index of the GID table entry to read
   944	 * @gid:		Pointer to GID where to store the entry's GID
   945	 *
   946	 * rdma_query_gid() only reads the GID entry content for requested device,
   947	 * port and index. It reads for IB, RoCE and iWarp link layers.  It doesn't
   948	 * hold any reference to the GID table entry in the HCA or software cache.
   949	 *
   950	 * Returns 0 on success or appropriate error code.
   951	 *
   952	 */
   953	int rdma_query_gid(struct ib_device *device, u32 port_num,
   954			   int index, union ib_gid *gid)
   955	{
   956		struct ib_gid_table *table;
   957		unsigned long flags;
   958		int res;
   959	
   960		if (!rdma_is_port_valid(device, port_num))
   961			return -EINVAL;
   962	
   963		table = rdma_gid_table(device, port_num);
   964		read_lock_irqsave(&table->rwlock, flags);
   965	
   966		if (index < 0 || index >= table->sz) {
 > 967			res = -EINVAL
   968			goto done;
   969		}
   970	
   971		if (!is_gid_entry_valid(table->data_vec[index])) {
   972			res = -ENOENT;
   973			goto done;
   974		}
   975	
   976		memcpy(gid, &table->data_vec[index]->attr.gid, sizeof(*gid));
   977		res = 0;
   978	
   979	done:
   980		read_unlock_irqrestore(&table->rwlock, flags);
   981		return res;
   982	}
   983	EXPORT_SYMBOL(rdma_query_gid);
   984	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
