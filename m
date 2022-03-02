Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12EF4CB1E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiCBWLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:11:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66C5BE48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646259050; x=1677795050;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZZNmIXkT92rLNIrnGw3gjJqLIkRflGEcKN16NURYJHc=;
  b=EpVLu/6URf1NsC2YjjaO4cuHrsctZPrRo4o5Y9CF7M140yY2gXRccaAV
   iqRg2k6lYDDXI9ADy8SLPC4Dvz/jwJivyhN7vILN1/z5fexbW+ksFOJZe
   669nxh99teOH4HORBG6ZjqYog9+2rUcfT8tkn3Zizh0a1vPaW3Yw04dlP
   QaGznUBgaR96w1iltCLO8Tio1dG3oDRJFhPPe+YRCvq+HojQG51Zl1hTC
   rG+P7TSeJ4Hh9JsUy4P6PTKu7jzxuqbc57kMVpii+bAlkSYsa+hL6vGtW
   qHVJBAXqT8lj35nnvjQ/YQYZj663p7CgTypslsSQG8j4evSXIohqb0VS3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253445797"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253445797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 14:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="551457162"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2022 14:10:48 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPXBH-0001zc-F8; Wed, 02 Mar 2022 22:10:47 +0000
Date:   Thu, 3 Mar 2022 06:09:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [mani-mhi:mhi-next 17/30] drivers/bus/mhi/ep/ring.c:45:66: sparse:
 sparse: incorrect type in argument 3 (different address spaces)
Message-ID: <202203030603.3nhJUwR0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   4aa2b597db8f8808b7e0f89239cd98c3a56b21b1
commit: 118a636617aad5e65564efd8c11c60ed1a45e494 [17/30] bus: mhi: ep: Add support for ring management
config: ia64-randconfig-s031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030603.3nhJUwR0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=118a636617aad5e65564efd8c11c60ed1a45e494
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout 118a636617aad5e65564efd8c11c60ed1a45e494
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/bus/mhi/ep/ drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/bus/mhi/ep/ring.c:45:66: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *to @@     got struct mhi_ring_element * @@
   drivers/bus/mhi/ep/ring.c:45:66: sparse:     expected void [noderef] __iomem *to
   drivers/bus/mhi/ep/ring.c:45:66: sparse:     got struct mhi_ring_element *
   drivers/bus/mhi/ep/ring.c:52:66: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *to @@     got struct mhi_ring_element * @@
   drivers/bus/mhi/ep/ring.c:52:66: sparse:     expected void [noderef] __iomem *to
   drivers/bus/mhi/ep/ring.c:52:66: sparse:     got struct mhi_ring_element *
   drivers/bus/mhi/ep/ring.c:58:74: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *to @@     got struct mhi_ring_element * @@
   drivers/bus/mhi/ep/ring.c:58:74: sparse:     expected void [noderef] __iomem *to
   drivers/bus/mhi/ep/ring.c:58:74: sparse:     got struct mhi_ring_element *
>> drivers/bus/mhi/ep/ring.c:130:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *from @@     got struct mhi_ring_element *el @@
   drivers/bus/mhi/ep/ring.c:130:51: sparse:     expected void [noderef] __iomem *from
   drivers/bus/mhi/ep/ring.c:130:51: sparse:     got struct mhi_ring_element *el

vim +45 drivers/bus/mhi/ep/ring.c

    24	
    25	static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
    26	{
    27		struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
    28		struct device *dev = &mhi_cntrl->mhi_dev->dev;
    29		size_t start, copy_size;
    30		int ret;
    31	
    32		/* Don't proceed in the case of event ring. This happens during mhi_ep_ring_start(). */
    33		if (ring->type == RING_TYPE_ER)
    34			return 0;
    35	
    36		/* No need to cache the ring if write pointer is unmodified */
    37		if (ring->wr_offset == end)
    38			return 0;
    39	
    40		start = ring->wr_offset;
    41		if (start < end) {
    42			copy_size = (end - start) * sizeof(struct mhi_ring_element);
    43			ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase +
    44							(start * sizeof(struct mhi_ring_element)),
  > 45							&ring->ring_cache[start], copy_size);
    46			if (ret < 0)
    47				return ret;
    48		} else {
    49			copy_size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
    50			ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase +
    51							(start * sizeof(struct mhi_ring_element)),
    52							&ring->ring_cache[start], copy_size);
    53			if (ret < 0)
    54				return ret;
    55	
    56			if (end) {
    57				ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase,
    58								&ring->ring_cache[0],
    59								end * sizeof(struct mhi_ring_element));
    60				if (ret < 0)
    61					return ret;
    62			}
    63		}
    64	
    65		dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, copy_size);
    66	
    67		return 0;
    68	}
    69	
    70	static int mhi_ep_cache_ring(struct mhi_ep_ring *ring, u64 wr_ptr)
    71	{
    72		size_t wr_offset;
    73		int ret;
    74	
    75		wr_offset = mhi_ep_ring_addr2offset(ring, wr_ptr);
    76	
    77		/* Cache the host ring till write offset */
    78		ret = __mhi_ep_cache_ring(ring, wr_offset);
    79		if (ret)
    80			return ret;
    81	
    82		ring->wr_offset = wr_offset;
    83	
    84		return 0;
    85	}
    86	
    87	int mhi_ep_update_wr_offset(struct mhi_ep_ring *ring)
    88	{
    89		u64 wr_ptr;
    90	
    91		wr_ptr = mhi_ep_mmio_get_db(ring);
    92	
    93		return mhi_ep_cache_ring(ring, wr_ptr);
    94	}
    95	
    96	/* TODO: Support for adding multiple ring elements to the ring */
    97	int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
    98	{
    99		struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
   100		struct device *dev = &mhi_cntrl->mhi_dev->dev;
   101		size_t old_offset = 0;
   102		u32 num_free_elem;
   103		int ret;
   104	
   105		ret = mhi_ep_update_wr_offset(ring);
   106		if (ret) {
   107			dev_err(dev, "Error updating write pointer\n");
   108			return ret;
   109		}
   110	
   111		if (ring->rd_offset < ring->wr_offset)
   112			num_free_elem = (ring->wr_offset - ring->rd_offset) - 1;
   113		else
   114			num_free_elem = ((ring->ring_size - ring->rd_offset) + ring->wr_offset) - 1;
   115	
   116		/* Check if there is space in ring for adding at least an element */
   117		if (!num_free_elem) {
   118			dev_err(dev, "No space left in the ring\n");
   119			return -ENOSPC;
   120		}
   121	
   122		old_offset = ring->rd_offset;
   123		mhi_ep_ring_inc_index(ring);
   124	
   125		dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
   126	
   127		/* Update rp in ring context */
   128		ring->ring_ctx->generic.rp = cpu_to_le64((ring->rd_offset * sizeof(*el)) + ring->rbase);
   129	
 > 130		ret = mhi_cntrl->write_to_host(mhi_cntrl, el, ring->rbase + (old_offset * sizeof(*el)),
   131					       sizeof(*el));
   132		if (ret < 0)
   133			return ret;
   134	
   135		return 0;
   136	}
   137	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
