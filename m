Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FFE56990D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiGGEQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 00:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGGEQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:16:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B92C654
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657167383; x=1688703383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NYUem57k4d9KlwTi4E1UdwPd14YIObBaInKLMcgeXPk=;
  b=NaoIu5OT31UOI/t+msKgcE6Ch/OhVbSA/I5XxjSSxoaDT3iGxKav2QYw
   VB53C5MVFQtCTStfz4Tr4z4gZIoxd55NXwJBqxIVRTAaFJ7JW8DdNU8vC
   i7RwdCjwoE/Mrlxkeu3sk8InsRuq17DJflefrD8RGGRSqVix7G2dcl1CW
   ApG+ZngW30Iqj2qjZdI/JPPAh4L8QiviZ0KNVXLmgJu5JnKiT7jAmHErB
   xLMUuwoKBVhd6hMttejhuI1pJBNx9l8BGTmesWIrTqEDPdUlHEKREfI/w
   we3tz119+KzdE3OU3GNcL6uN6rgOxzD6iicDP+QzbYY1NzKNKGh6X4RQy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281473572"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="281473572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 21:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="620612989"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2022 21:16:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Iw8-000LWI-V0;
        Thu, 07 Jul 2022 04:16:20 +0000
Date:   Thu, 7 Jul 2022 12:15:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [sbates130272-p2pmem:p2pdma_user_cmb_v8 7/21]
 drivers/iommu/iommu.c:2460:21: error: implicit declaration of function
 'sg_is_dma_bus_address'; did you mean 'sg_dma_address'?
Message-ID: <202207071221.UPqIJ9mF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git p2pdma_user_cmb_v8
head:   a2dd359c3f1baca6c0438adec8900b7fe57f92af
commit: 34dbc33ec51c9e22ca9094054216d5e63d5cab08 [7/21] iommu: Explicitly skip bus address marked segments  in __iommu_map_sg()
config: xtensa-randconfig-r015-20220706 (https://download.01.org/0day-ci/archive/20220707/202207071221.UPqIJ9mF-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/sbates130272/linux-p2pmem/commit/34dbc33ec51c9e22ca9094054216d5e63d5cab08
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem p2pdma_user_cmb_v8
        git checkout 34dbc33ec51c9e22ca9094054216d5e63d5cab08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/iommu.c: In function '__iommu_map_sg':
>> drivers/iommu/iommu.c:2460:21: error: implicit declaration of function 'sg_is_dma_bus_address'; did you mean 'sg_dma_address'? [-Werror=implicit-function-declaration]
    2460 |                 if (sg_is_dma_bus_address(sg))
         |                     ^~~~~~~~~~~~~~~~~~~~~
         |                     sg_dma_address
   cc1: some warnings being treated as errors


vim +2460 drivers/iommu/iommu.c

  2435	
  2436	static ssize_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
  2437			struct scatterlist *sg, unsigned int nents, int prot,
  2438			gfp_t gfp)
  2439	{
  2440		const struct iommu_domain_ops *ops = domain->ops;
  2441		size_t len = 0, mapped = 0;
  2442		phys_addr_t start;
  2443		unsigned int i = 0;
  2444		int ret;
  2445	
  2446		while (i <= nents) {
  2447			phys_addr_t s_phys = sg_phys(sg);
  2448	
  2449			if (len && s_phys != start + len) {
  2450				ret = __iommu_map(domain, iova + mapped, start,
  2451						len, prot, gfp);
  2452	
  2453				if (ret)
  2454					goto out_err;
  2455	
  2456				mapped += len;
  2457				len = 0;
  2458			}
  2459	
> 2460			if (sg_is_dma_bus_address(sg))
  2461				goto next;
  2462	
  2463			if (len) {
  2464				len += sg->length;
  2465			} else {
  2466				len = sg->length;
  2467				start = s_phys;
  2468			}
  2469	
  2470	next:
  2471			if (++i < nents)
  2472				sg = sg_next(sg);
  2473		}
  2474	
  2475		if (ops->iotlb_sync_map)
  2476			ops->iotlb_sync_map(domain, iova, mapped);
  2477		return mapped;
  2478	
  2479	out_err:
  2480		/* undo mappings already done */
  2481		iommu_unmap(domain, iova, mapped);
  2482	
  2483		return ret;
  2484	}
  2485	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
