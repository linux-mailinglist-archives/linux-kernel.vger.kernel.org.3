Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7EA591C09
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiHMQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbiHMQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:53:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D4827CEC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660409607; x=1691945607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LmcB/q6NARwbiXArOS7NHzvDZGa/JsvRACGrZWWC8JY=;
  b=JuvEq+EjFXdt4nvWjZ45pgp8BJ6rxd2C0TjC0EGCS3blaNG6/8ssJ4HB
   uNn3W9hUG7GtOdlESbYU2oJUKrxLwyVbqwhsG0Q4hGrP4jHoQTlVMl1Q0
   zy3ayZZt3wrhPbyR4vIbpxQQbdCxDhs5E13EbFNE6gIzSoE8/31OsDHUV
   j+/Pu7e9w3mRiebgznDcnigYuVEoZKUgO7Tf1mLVxJ/KWWo/F0JtBDv8i
   uWdWn9/8dPK3kgEZgCucFEG6T0dJkl5i2WIA5RwWmfIlk/ss5T4mVVNzL
   BXcJoftVk4Z6C2pGz0GVbEJTUqiBeOYrgN2Cv37vS7gBxmQ8bdoMR3LgW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="293034679"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="293034679"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 09:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="851862305"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 09:53:24 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMuO4-0001sb-0Q;
        Sat, 13 Aug 2022 16:53:24 +0000
Date:   Sun, 14 Aug 2022 00:53:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v6 6/6] drivers/nvme/host/pci.c:1935:7: warning:
 variable 'pages_per' set but not used
Message-ID: <202208140037.VHIG9r0t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v6
head:   cdcec28a049590800a8726d83b7e635527204a26
commit: cdcec28a049590800a8726d83b7e635527204a26 [6/6] nvme-pci: implement dma_map support
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220814/202208140037.VHIG9r0t-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=cdcec28a049590800a8726d83b7e635527204a26
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v6
        git checkout cdcec28a049590800a8726d83b7e635527204a26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/host/pci.c:967:7: warning: variable 'nprps_left' is uninitialized when used here [-Wuninitialized]
                   if (nprps_left <= last_prp + 1) {
                       ^~~~~~~~~~
   drivers/nvme/host/pci.c:893:49: note: initialize the variable 'nprps_left' to silence this warning
           int index, offset, i, length, nprps, nprps_left;
                                                          ^
                                                           = 0
>> drivers/nvme/host/pci.c:1935:7: warning: variable 'pages_per' set but not used [-Wunused-but-set-variable]
                   int pages_per = nvme_pages;
                       ^
   2 warnings generated.


vim +/pages_per +1935 drivers/nvme/host/pci.c

  1905	
  1906	#ifdef CONFIG_HAS_DMA
  1907	/*
  1908	 * Important: bvec must be describing a virtually contiguous buffer.
  1909	 */
  1910	static void *nvme_pci_dma_map(struct request_queue *q,
  1911				       struct bio_vec *bvec, int nr_vecs)
  1912	{
  1913		const int nvme_pages = 1 << (PAGE_SIZE - NVME_CTRL_PAGE_SIZE);
  1914		struct nvme_ns *ns = q->queuedata;
  1915		struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
  1916		struct nvme_dma_mapping *mapping;
  1917		int i, j, k, size, ret = -ENOMEM;
  1918	
  1919		if (!nr_vecs)
  1920			return ERR_PTR(-EINVAL);
  1921	
  1922		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
  1923		if (!mapping)
  1924			return ERR_PTR(-ENOMEM);
  1925	
  1926		mapping->nr_pages = nr_vecs * nvme_pages;
  1927		size = sizeof(*mapping->prps) * mapping->nr_pages;
  1928		mapping->prps = dma_alloc_coherent(dev->dev, size,
  1929					&mapping->prp_dma_addr, GFP_KERNEL);
  1930		if (!mapping->prps)
  1931			goto free_mapping;
  1932	
  1933		for (i = 0, k = 0; i < nr_vecs; i++) {
  1934			struct bio_vec *bv = bvec + i;
> 1935			int pages_per = nvme_pages;
  1936			dma_addr_t dma_addr;
  1937	
  1938			if (i == 0) {
  1939				mapping->offset = bv->bv_offset;
  1940				pages_per -= mapping->offset >> NVME_CTRL_PAGE_SHIFT;
  1941			} else if (bv->bv_offset) {
  1942				ret = -EINVAL;
  1943				goto err;
  1944			}
  1945	
  1946			if (bv->bv_offset + bv->bv_len != PAGE_SIZE &&
  1947			    i < nr_vecs - 1) {
  1948				ret = -EINVAL;
  1949				goto err;
  1950			}
  1951	
  1952			dma_addr = dma_map_bvec(dev->dev, bv, 0, 0);
  1953			if (dma_mapping_error(dev->dev, dma_addr)) {
  1954				ret = -EIO;
  1955				goto err;
  1956			}
  1957	
  1958			if (i == 0)
  1959				dma_addr -= mapping->offset;
  1960	
  1961			for (j = 0; j < nvme_pages; j++)
  1962				mapping->prps[k++] = cpu_to_le64(dma_addr +
  1963							j * NVME_CTRL_PAGE_SIZE);
  1964		}
  1965	
  1966		get_device(dev->dev);
  1967		return mapping;
  1968	
  1969	err:
  1970		for (i = 0; i < k; i += nvme_pages) {
  1971			__u64 dma_addr = le64_to_cpu(mapping->prps[i]);
  1972	
  1973			dma_unmap_page(dev->dev, dma_addr,
  1974				       PAGE_SIZE - offset_in_page(dma_addr), 0);
  1975		}
  1976	
  1977		dma_free_coherent(dev->dev, size, (void *)mapping->prps,
  1978				  mapping->prp_dma_addr);
  1979	free_mapping:
  1980		kfree(mapping);
  1981		return ERR_PTR(ret);
  1982	}
  1983	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
