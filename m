Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29767474097
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhLNKkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:40:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:4654 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhLNKkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639478415; x=1671014415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CljH54yPGNFneOI/Y3tvixLkMHnPqoQd+s156aD+NlM=;
  b=k4GqUd0xCIaP2iae/OSLDsQy5Xt0hPffqKt5IjemNqlBDYkQLZaw7BM3
   xcN53kZx24tnNxQc7Tw85W2v3HKspoNzjJWnvD3/qMtYNDT3vd+YoRoc5
   KYu0tIx/jWq5DlF9sjatFrh2EY3Cd3F8oLm/mscAKgUjhJI+yZOmJgDcK
   8rtJr3Em/5VlbG0ja5OAm+dn9kshIcBKUQqx8r+VfpIqHeI6AgLSnylYJ
   K9NwkHqSRQr2fit48sLMyEp3LUQvfNXezZ5zkejaI9dC/i4q8gLXE9BSK
   qRIXG677nQDUlDXZ3Ys4uhni1mh/7sVa8dZG8gj2QJ0IKeAwBC5QWK50A
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263089325"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="263089325"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 02:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="545122888"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2021 02:40:01 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx5E0-0000CC-Da; Tue, 14 Dec 2021 10:40:00 +0000
Date:   Tue, 14 Dec 2021 18:39:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Massot <julien.massot@iot.bzh>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [remoteproc:rproc-next 13/13] drivers/remoteproc/rcar_rproc.c:28:12:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <202112141828.E9RwMXA2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
head:   285892a74f1370a12249f765c6a4e3b16194852e
commit: 285892a74f1370a12249f765c6a4e3b16194852e [13/13] remoteproc: Add Renesas rcar driver
config: arm64-randconfig-s031-20211214 (https://download.01.org/0day-ci/archive/20211214/202112141828.E9RwMXA2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/commit/?id=285892a74f1370a12249f765c6a4e3b16194852e
        git remote add remoteproc git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
        git fetch --no-tags remoteproc rproc-next
        git checkout 285892a74f1370a12249f765c6a4e3b16194852e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +28 drivers/remoteproc/rcar_rproc.c

    20	
    21	static int rcar_rproc_mem_alloc(struct rproc *rproc,
    22					 struct rproc_mem_entry *mem)
    23	{
    24		struct device *dev = &rproc->dev;
    25		void *va;
    26	
    27		dev_dbg(dev, "map memory: %pa+%zx\n", &mem->dma, mem->len);
  > 28		va = ioremap_wc(mem->dma, mem->len);
    29		if (!va) {
    30			dev_err(dev, "Unable to map memory region: %pa+%zx\n",
    31				&mem->dma, mem->len);
    32			return -ENOMEM;
    33		}
    34	
    35		/* Update memory entry va */
    36		mem->va = va;
    37	
    38		return 0;
    39	}
    40	
    41	static int rcar_rproc_mem_release(struct rproc *rproc,
    42					   struct rproc_mem_entry *mem)
    43	{
    44		dev_dbg(&rproc->dev, "unmap memory: %pa\n", &mem->dma);
  > 45		iounmap(mem->va);
    46	
    47		return 0;
    48	}
    49	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
