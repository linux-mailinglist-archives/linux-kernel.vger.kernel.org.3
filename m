Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82857D8D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 05:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiGVDFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 23:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVDFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 23:05:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB2D41
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 20:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658459113; x=1689995113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lUiqkvbqMaJlNM2iQLyFq5L0CRlSmzSB9d0/Op66Wfo=;
  b=B6KmzxVXqE5BDA7yko2uFSyR0kpEil3OytrJyELN2DZJppG2dLhA39MX
   V+B27XHM5t8anmfYdnyxybAQtI520myi/pYdk4JNj6RjT4aQXq+X7mF7k
   T67MuFChlvG+BWcSMFCnQsCTB64vlb6hq4LWG2kp9fPYWwgM2DgNMnrQE
   /NVpkX4cqFB70Q0YFunqZShx5Vq925ym9BXpbbJtuKRXrl5OVc2dwcPDG
   /1NRGvx1Q59FG70Zde0Kn5iLmV5kYMyAUA6JAZcmMTNHxtbfdXiRpnS7r
   9wZsa19VrTJNssaBWrhDxav7DbxJ42Pzp5YgcYSE4zAlmqlzoqk8Dc6pT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348926528"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="348926528"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 20:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="549020323"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 20:05:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEiyU-0000tc-2d;
        Fri, 22 Jul 2022 03:05:10 +0000
Date:   Fri, 22 Jul 2022 11:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/020-t6000-dart 7/11]
 drivers/iommu/apple-dart.c:345:62: error: passing argument 1 of
 'atomic64_read' from incompatible pointer type
Message-ID: <202207221059.KojuhNQ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/020-t6000-dart
head:   7db03c131045e7fab006d467a7e037dd7cd3cc95
commit: da3b68972ce1a850fd747f01e05e070f2babe02b [7/11] iommu: dart: Support >64 stream IDs
config: arm-randconfig-r024-20220721 (https://download.01.org/0day-ci/archive/20220722/202207221059.KojuhNQ6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/da3b68972ce1a850fd747f01e05e070f2babe02b
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/020-t6000-dart
        git checkout da3b68972ce1a850fd747f01e05e070f2babe02b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iommu/

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
   include/linux/atomic/atomic-instrumented.h:658:26: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
     658 | atomic64_set(atomic64_t *v, s64 i)
         |              ~~~~~~~~~~~~^
   drivers/iommu/apple-dart.c: In function 'apple_dart_mod_streams':
>> drivers/iommu/apple-dart.c:490:45: error: passing argument 2 of 'atomic64_or' from incompatible pointer type [-Werror=incompatible-pointer-types]
     490 |                                             &domain_maps[i].sidmap[j]);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             atomic_long_t * {aka atomic_t *}
   include/linux/atomic/atomic-instrumented.h:1015:32: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
    1015 | atomic64_or(s64 i, atomic64_t *v)
         |                    ~~~~~~~~~~~~^
>> drivers/iommu/apple-dart.c:493:46: error: passing argument 2 of 'atomic64_and' from incompatible pointer type [-Werror=incompatible-pointer-types]
     493 |                                              &domain_maps[i].sidmap[j]);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              |
         |                                              atomic_long_t * {aka atomic_t *}
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
