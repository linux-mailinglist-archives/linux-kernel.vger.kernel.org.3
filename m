Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A4E591A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbiHMNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiHMNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:17:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086222CE22
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660396641; x=1691932641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZzyeZeMQf7LcT0PLpclDV8yTfhZqkaLAgZc3+RUTD6w=;
  b=kgzYWhJydOsoOhUJWS+pKfo+5Wi0MsBWzGtWIBC9zUcSFZmXUAsaiSPn
   FsDh/5IraGb+5X5xe78gVRrOpFKsqbc2OZmDQW565txerdvn607wWxaLz
   KbWPHjIVf4p1irU5cjoFDMUFTEvuu4lklxUehqn/wA2BaPbgj4gg2HXaG
   2x9fxyK/lDpoFxarl1BAQJDNCDMl0ZdAMuj9v6hjqULUwCAGTUfhSxWMM
   rTjJf2YS7yzWost/R3WRw8fhhRYbctkLFyyVw2kz0z9fNJxrua4A7TGu6
   iSpMKuRCVhyuAnsa9k7eOLw8fEJ334Z8nsrBTBFCXJ63X8+Z2rnl/T0Uy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292547655"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="292547655"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="609511854"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2022 06:17:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMr0w-0001hD-19;
        Sat, 13 Aug 2022 13:17:18 +0000
Date:   Sat, 13 Aug 2022 21:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:io_uring/dma-register-v3 8/8]
 drivers/nvme/host/pci.c:1920:34: warning: left shift count >= width of type
Message-ID: <202208132117.LrIKYDQx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git io_uring/dma-register-v3
head:   e1c6d38d05e532b3aaf12a5ab8707929bcdc1180
commit: e1c6d38d05e532b3aaf12a5ab8707929bcdc1180 [8/8] nvme-pci: implement dma_map support
config: ia64-buildonly-randconfig-r004-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132117.LrIKYDQx-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=e1c6d38d05e532b3aaf12a5ab8707929bcdc1180
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch io_uring/dma-register-v3
        git checkout e1c6d38d05e532b3aaf12a5ab8707929bcdc1180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/nvme/host/pci.c:10:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   drivers/nvme/host/pci.c: In function 'nvme_pci_dma_map':
>> drivers/nvme/host/pci.c:1920:34: warning: left shift count >= width of type [-Wshift-count-overflow]
    1920 |         const int nvme_pages = 1 << (PAGE_SIZE - NVME_CTRL_PAGE_SIZE);
         |                                  ^~
   drivers/nvme/host/pci.c: In function 'nvme_pci_dma_unmap':
   drivers/nvme/host/pci.c:2000:34: warning: left shift count >= width of type [-Wshift-count-overflow]
    2000 |         const int nvme_pages = 1 << (PAGE_SIZE - NVME_CTRL_PAGE_SIZE);
         |                                  ^~


vim +1920 drivers/nvme/host/pci.c

  1912	
  1913	#ifdef CONFIG_HAS_DMA
  1914	/*
  1915	 * Important: bvec must be describing a virtually contiguous buffer.
  1916	 */
  1917	static void *nvme_pci_dma_map(struct request_queue *q,
  1918				       struct bio_vec *bvec, int nr_vecs)
  1919	{
> 1920		const int nvme_pages = 1 << (PAGE_SIZE - NVME_CTRL_PAGE_SIZE);
  1921		struct nvme_ns *ns = q->queuedata;
  1922		struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
  1923		struct nvme_dma_mapping *mapping;
  1924		int i, j, k, size, ppv, ret = -ENOMEM;
  1925	
  1926		if (!nr_vecs)
  1927			return ERR_PTR(-EINVAL);
  1928	
  1929		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
  1930		if (!mapping)
  1931			return ERR_PTR(-ENOMEM);
  1932	
  1933		mapping->nr_pages = nr_vecs * nvme_pages;
  1934		size = sizeof(*mapping->prps) * mapping->nr_pages;
  1935		mapping->prps = dma_alloc_coherent(dev->dev, size,
  1936					&mapping->prp_dma_addr, GFP_KERNEL);
  1937		if (!mapping->prps)
  1938			goto free_mapping;
  1939	
  1940		mapping->needs_sync = false;
  1941		for (i = 0, k = 0; i < nr_vecs; i++) {
  1942			struct bio_vec *bv = bvec + i;
  1943			dma_addr_t dma_addr;
  1944	
  1945			ppv = nvme_pages;
  1946			if (i == 0) {
  1947				mapping->offset = bv->bv_offset;
  1948				ppv -= mapping->offset >> NVME_CTRL_PAGE_SHIFT;
  1949			} else if (bv->bv_offset) {
  1950				ret = -EINVAL;
  1951				goto err;
  1952			}
  1953	
  1954			if (bv->bv_offset + bv->bv_len != PAGE_SIZE &&
  1955			    i < nr_vecs - 1) {
  1956				ret = -EINVAL;
  1957				goto err;
  1958			}
  1959	
  1960			dma_addr = dma_map_bvec(dev->dev, bv, 0, 0);
  1961			if (dma_mapping_error(dev->dev, dma_addr)) {
  1962				ret = -EIO;
  1963				goto err;
  1964			}
  1965	
  1966			if (i == 0)
  1967				dma_addr -= mapping->offset;
  1968	
  1969			if (dma_need_sync(dev->dev, dma_addr))
  1970				mapping->needs_sync = true;
  1971	
  1972			for (j = 0; j < ppv; j++)
  1973				mapping->prps[k++] = cpu_to_le64(dma_addr +
  1974							j * NVME_CTRL_PAGE_SIZE);
  1975		}
  1976	
  1977		get_device(dev->dev);
  1978		return mapping;
  1979	
  1980	err:
  1981		for (i = 0; i < k; i += ppv) {
  1982			__u64 dma_addr = le64_to_cpu(mapping->prps[i]);
  1983			ppv = nvme_pages;
  1984	
  1985			if (i == 0)
  1986				ppv -= mapping->offset >> NVME_CTRL_PAGE_SHIFT;
  1987			dma_unmap_page(dev->dev, dma_addr,
  1988				       PAGE_SIZE - offset_in_page(dma_addr), 0);
  1989		}
  1990	
  1991		dma_free_coherent(dev->dev, size, (void *)mapping->prps,
  1992				  mapping->prp_dma_addr);
  1993	free_mapping:
  1994		kfree(mapping);
  1995		return ERR_PTR(ret);
  1996	}
  1997	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
