Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C755C418
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiF1IC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiF1ICV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:02:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2192CDE4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656403340; x=1687939340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DBadxJXQdgSnf+S17J9b30u2JHAYLdXbSGCPVPOApvU=;
  b=O4ia6lw5itHdJdf44jOZ2+2sR8s7EbVIiIN0TgPZXLtnolKn/p5DO0kl
   4IrbOaTmq4L86pUBo/zbBsp0QLHc13qd6uNZBuu0G5RORv3FXqwlPqpVb
   8lcSl4+ZJJYZXRGdUm47tnJuKutFRU7K9ad3oXWI3+YuXWl+PpyLh+orU
   7N7MbVQ/iWY5gn0vO4NtHwe79Z0sMnQfxXNVs2uS94FooQYp2bVgMCcob
   dKrAHVF48KDr+JVMVFNtULBCgs10GeNEKaKmC8eVCEkMgd/t7rY/bxK0A
   bTUJ/10Y2285l0+8aOXMqDE9LB1WX+oMh5bmmNJSavUxrwEnw06DeJK/L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279214479"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279214479"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646807185"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2022 01:02:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o66Ao-0009jS-Pl;
        Tue, 28 Jun 2022 08:02:14 +0000
Date:   Tue, 28 Jun 2022 16:01:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:t8112/bringup 8/12] drivers/iommu/apple-dart.c:345:62:
 error: passing argument 1 of 'atomic64_read' from incompatible pointer type
Message-ID: <202206281521.IMM4ifZr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux t8112/bringup
head:   18558a69178b03776aaea0f2aca1d6299f07f8b9
commit: a47ec020cc1bdbed3fc343ebeb29b90cb69f1362 [8/12] iommu: dart: Support >64 stream IDs
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220628/202206281521.IMM4ifZr-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/a47ec020cc1bdbed3fc343ebeb29b90cb69f1362
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux t8112/bringup
        git checkout a47ec020cc1bdbed3fc343ebeb29b90cb69f1362
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/apple-dart.c: In function 'apple_dart_domain_flush_tlb':
>> drivers/iommu/apple-dart.c:345:62: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
     345 |                         stream_map.sidmap[j] = atomic64_read(&domain_stream_map->sidmap[j]);
         |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                              |
         |                                                              atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from drivers/iommu/apple-dart.c:14:
   include/linux/atomic/atomic-instrumented.h:644:33: note: expected 'const atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
     644 | atomic64_read(const atomic64_t *v)
         |               ~~~~~~~~~~~~~~~~~~^
   drivers/iommu/apple-dart.c: In function 'apple_dart_finalize_domain':
>> drivers/iommu/apple-dart.c:441:38: error: passing argument 1 of 'atomic64_set' from incompatible pointer type [-Werror=incompatible-pointer-types]
     441 |                         atomic64_set(&dart_domain->stream_maps[i].sidmap[j],
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      |
         |                                      atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from drivers/iommu/apple-dart.c:14:
   include/linux/atomic/atomic-instrumented.h:658:26: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
     658 | atomic64_set(atomic64_t *v, s64 i)
         |              ~~~~~~~~~~~~^
   drivers/iommu/apple-dart.c: In function 'apple_dart_mod_streams':
>> drivers/iommu/apple-dart.c:490:45: error: passing argument 2 of 'atomic64_or' from incompatible pointer type [-Werror=incompatible-pointer-types]
     490 |                                             &domain_maps[i].sidmap[j]);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from drivers/iommu/apple-dart.c:14:
   include/linux/atomic/atomic-instrumented.h:1015:32: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
    1015 | atomic64_or(s64 i, atomic64_t *v)
         |                    ~~~~~~~~~~~~^
>> drivers/iommu/apple-dart.c:493:46: error: passing argument 2 of 'atomic64_and' from incompatible pointer type [-Werror=incompatible-pointer-types]
     493 |                                              &domain_maps[i].sidmap[j]);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from drivers/iommu/apple-dart.c:14:
   include/linux/atomic/atomic-instrumented.h:941:33: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
     941 | atomic64_and(s64 i, atomic64_t *v)
         |                     ~~~~~~~~~~~~^
   cc1: some warnings being treated as errors


vim +/atomic64_read +345 drivers/iommu/apple-dart.c

   334	
   335	static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
   336	{
   337		int i, j;
   338		struct apple_dart_atomic_stream_map *domain_stream_map;
   339		struct apple_dart_stream_map stream_map;
   340	
   341		for_each_stream_map(i, domain, domain_stream_map) {
   342			stream_map.dart = domain_stream_map->dart;
   343	
   344			for (j = 0; j < BITS_TO_LONGS(stream_map.dart->num_streams); j++)
 > 345				stream_map.sidmap[j] = atomic64_read(&domain_stream_map->sidmap[j]);
   346	
   347			apple_dart_hw_invalidate_tlb(&stream_map);
   348		}
   349	}
   350	
   351	static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
   352	{
   353		apple_dart_domain_flush_tlb(to_dart_domain(domain));
   354	}
   355	
   356	static void apple_dart_iotlb_sync(struct iommu_domain *domain,
   357					  struct iommu_iotlb_gather *gather)
   358	{
   359		apple_dart_domain_flush_tlb(to_dart_domain(domain));
   360	}
   361	
   362	static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
   363					      unsigned long iova, size_t size)
   364	{
   365		apple_dart_domain_flush_tlb(to_dart_domain(domain));
   366	}
   367	
   368	static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
   369						   dma_addr_t iova)
   370	{
   371		struct apple_dart_domain *dart_domain = to_dart_domain(domain);
   372		struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
   373	
   374		if (!ops)
   375			return 0;
   376	
   377		return ops->iova_to_phys(ops, iova);
   378	}
   379	
   380	static int apple_dart_map_pages(struct iommu_domain *domain, unsigned long iova,
   381					phys_addr_t paddr, size_t pgsize,
   382					size_t pgcount, int prot, gfp_t gfp,
   383					size_t *mapped)
   384	{
   385		struct apple_dart_domain *dart_domain = to_dart_domain(domain);
   386		struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
   387	
   388		if (!ops)
   389			return -ENODEV;
   390	
   391		return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp,
   392				      mapped);
   393	}
   394	
   395	static size_t apple_dart_unmap_pages(struct iommu_domain *domain,
   396					     unsigned long iova, size_t pgsize,
   397					     size_t pgcount,
   398					     struct iommu_iotlb_gather *gather)
   399	{
   400		struct apple_dart_domain *dart_domain = to_dart_domain(domain);
   401		struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
   402	
   403		return ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
   404	}
   405	
   406	static void
   407	apple_dart_setup_translation(struct apple_dart_domain *domain,
   408				     struct apple_dart_stream_map *stream_map)
   409	{
   410		int i;
   411		struct io_pgtable_cfg *pgtbl_cfg =
   412			&io_pgtable_ops_to_pgtable(domain->pgtbl_ops)->cfg;
   413	
   414		for (i = 0; i < pgtbl_cfg->apple_dart_cfg.n_ttbrs; ++i)
   415			apple_dart_hw_set_ttbr(stream_map, i,
   416					       pgtbl_cfg->apple_dart_cfg.ttbr[i]);
   417		for (; i < DART_MAX_TTBR; ++i)
   418			apple_dart_hw_clear_ttbr(stream_map, i);
   419	
   420		apple_dart_hw_enable_translation(stream_map);
   421		apple_dart_hw_invalidate_tlb(stream_map);
   422	}
   423	
   424	static int apple_dart_finalize_domain(struct iommu_domain *domain,
   425					      struct apple_dart_master_cfg *cfg)
   426	{
   427		struct apple_dart_domain *dart_domain = to_dart_domain(domain);
   428		struct apple_dart *dart = cfg->stream_maps[0].dart;
   429		struct io_pgtable_cfg pgtbl_cfg;
   430		int ret = 0;
   431		int i, j;
   432	
   433		mutex_lock(&dart_domain->init_lock);
   434	
   435		if (dart_domain->finalized)
   436			goto done;
   437	
   438		for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
   439			dart_domain->stream_maps[i].dart = cfg->stream_maps[i].dart;
   440			for (j = 0; j < BITS_TO_LONGS(dart->num_streams); j++)
 > 441				atomic64_set(&dart_domain->stream_maps[i].sidmap[j],
   442					     cfg->stream_maps[i].sidmap[j]);
   443		}
   444	
   445		pgtbl_cfg = (struct io_pgtable_cfg){
   446			.pgsize_bitmap = dart->pgsize,
   447			.ias = 32,
   448			.oas = dart->hw->oas,
   449			.coherent_walk = 1,
   450			.iommu_dev = dart->dev,
   451		};
   452	
   453		dart_domain->pgtbl_ops =
   454			alloc_io_pgtable_ops(dart->hw->fmt, &pgtbl_cfg, domain);
   455		if (!dart_domain->pgtbl_ops) {
   456			ret = -ENOMEM;
   457			goto done;
   458		}
   459	
   460		domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
   461		domain->geometry.aperture_start = 0;
   462		domain->geometry.aperture_end = DMA_BIT_MASK(32);
   463		domain->geometry.force_aperture = true;
   464	
   465		dart_domain->finalized = true;
   466	
   467	done:
   468		mutex_unlock(&dart_domain->init_lock);
   469		return ret;
   470	}
   471	
   472	static int
   473	apple_dart_mod_streams(struct apple_dart_atomic_stream_map *domain_maps,
   474			       struct apple_dart_stream_map *master_maps,
   475			       bool add_streams)
   476	{
   477		int i, j;
   478	
   479		for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
   480			if (domain_maps[i].dart != master_maps[i].dart)
   481				return -EINVAL;
   482		}
   483	
   484		for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
   485			if (!domain_maps[i].dart)
   486				break;
   487			for (j = 0; j < BITS_TO_LONGS(domain_maps[i].dart->num_streams); j++) {
   488				if (add_streams)
   489					atomic64_or(master_maps[i].sidmap[j],
 > 490						    &domain_maps[i].sidmap[j]);
   491				else
   492					atomic64_and(~master_maps[i].sidmap[j],
 > 493						     &domain_maps[i].sidmap[j]);
   494			}
   495		}
   496	
   497		return 0;
   498	}
   499	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
