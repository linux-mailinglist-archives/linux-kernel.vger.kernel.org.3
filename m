Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1B04A2B23
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbiA2CAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:00:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:3769 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344864AbiA2CAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643421617; x=1674957617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HwFzOUQ3ETlxvQNyfQGh+3gx+Q9wov9hHhNb1uvx0fc=;
  b=YawP6mf7zq2DeBzpqytqXVnuzo29EcuC/AlfT/lKgjAySOqeSLGgtILP
   JKUZLRSZz/70BCXNUrmkR/n5mGWBd20c2bZirmKtS2HMxr/2iBU6RcFbd
   8vfnvKLQyUfnjBZfBDNsA6HRi4KHfhRtM04KUbNNs0jpGVWYouXckwso4
   PN6/3V59xHZlW5U0GTOQzhx3GZ1QnAlcphZGmZOdDMTcW1vTDtlQUTbBP
   70ArWPyjXHrlfWXpqesLIv8pk0Cl8uLMGbpEDRKI6XZEtTkcGQBTt9yAt
   WJZkuIg2woZQs+p1OuMPSee3NM/fvsKA/Dxc0/ZX5MuG99I9eNzEUv2XM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="271693722"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="271693722"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 18:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="496313134"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2022 18:00:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDd2F-000Ocy-Dn; Sat, 29 Jan 2022 02:00:15 +0000
Date:   Sat, 29 Jan 2022 10:00:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 53/53] net/ceph/osd_client.c:5775:3: error:
 expected expression
Message-ID: <202201290935.AEKKkabv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   3f014b82b65ebbf30b8e4cd0b307f1f2794d183f
commit: 3f014b82b65ebbf30b8e4cd0b307f1f2794d183f [53/53] libceph: define a structure to track SPARSE_READ reply processing
config: hexagon-randconfig-r002-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290935.AEKKkabv-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=3f014b82b65ebbf30b8e4cd0b307f1f2794d183f
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout 3f014b82b65ebbf30b8e4cd0b307f1f2794d183f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> net/ceph/osd_client.c:5775:3: error: expected expression
                   u64 off = le64_to_cpu(sr->sr_extent[sr->sr_index].off);
                   ^
>> net/ceph/osd_client.c:5776:7: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
                   u64 len = le64_to_cpu(sr->sr_extent[sr->sr_index].len);
                       ^
   1 warning and 1 error generated.


vim +5775 net/ceph/osd_client.c

  5746	
  5747	static int osd_sparse_read(struct ceph_connection *con, u64 *len, char **buf)
  5748	{
  5749		struct ceph_osd *o = con->private;
  5750		struct ceph_sparse_read *sr = &o->o_sparse_read;
  5751		u32 count = __le32_to_cpu(sr->sr_count);
  5752		int ret = 1;
  5753	
  5754		switch (sr->sr_state) {
  5755		case CEPH_SPARSE_READ_COUNT:
  5756			/* number of extents */
  5757			*len = sizeof(sr->sr_count);
  5758			*buf = (char *)&sr->sr_count;
  5759			sr->sr_state = CEPH_SPARSE_READ_EXTENTS;
  5760			break;
  5761		case CEPH_SPARSE_READ_EXTENTS:
  5762			/* the extent array */
  5763			*len = count * sizeof(*sr->sr_extent);
  5764			if (count > 1) {
  5765				/* can't use the embedded extent array */
  5766				sr->sr_extent = kmalloc_array(count, sizeof(*sr->sr_extent),
  5767							   GFP_NOIO);
  5768				if (!sr->sr_extent)
  5769					return -ENOMEM;
  5770			}
  5771			*buf = (char *)sr->sr_extent;
  5772			sr->sr_state = CEPH_SPARSE_READ_DATA;
  5773			break;
  5774		case CEPH_SPARSE_READ_DATA:
> 5775			u64 off = le64_to_cpu(sr->sr_extent[sr->sr_index].off);
> 5776			u64 len = le64_to_cpu(sr->sr_extent[sr->sr_index].len);
  5777	
  5778			/* ret to 0 if this is the last extent */
  5779			++sr->sr_index;
  5780			if (sr->sr_index >= count)
  5781				ret = 0;
  5782			break;
  5783		}
  5784		return ret;
  5785	}
  5786	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
