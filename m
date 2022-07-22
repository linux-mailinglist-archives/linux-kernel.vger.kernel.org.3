Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD44457D8A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGVCeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiGVCeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:34:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664A80F66
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658457251; x=1689993251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bq7oeKufIfbDJH8GFsQ4Tla/nZQnoIjiqIX/zBwBpQc=;
  b=UwaKa87R1Rz7GSiHqo0nWZrS5riANN+hbjZnlPt6Xsc8SwI9ACD27sWp
   dgAFK7wGrfhZZ3UkbTz321BjMp3r7X7DpS0kNtsDZ7APkIwwT86j0tSCq
   Yarc6hxUdYdsShxjiXspMeO+cuw8CQQl1sT5GhEUIArT2XALJD5U1AkOx
   QKWy1kABJL7OTQXt7Vqi7kFXT09qZzUIJF9k7s4oQ0H5xQE7/TJI2hvQh
   cMzHpQ11VBhfdEMdM47a5AHFzk4eDudTaGIJZSljCymOrbT5ICNSpNdVO
   dnJ3WkR0AgQ6cqsF5fb7WOx93XgoCFcUKU/d1C3Q6VWZ0v8uWvGmBoMl7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287975186"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287975186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="549013777"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 19:34:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEiUT-0000ro-0m;
        Fri, 22 Jul 2022 02:34:09 +0000
Date:   Fri, 22 Jul 2022 10:33:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v3-wip 6/6] drivers/nvme/host/pci.c:565:17:
 error: implicit declaration of function 'nvme_free_sgls'; did you mean
 'nvme_pci_use_sgls'?
Message-ID: <202207221004.Th4xLMWP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v3-wip
head:   7b981a9cb1de32a6e73fe14d2665e0a2fb5dcd3c
commit: 7b981a9cb1de32a6e73fe14d2665e0a2fb5dcd3c [6/6] nvme-pci: implement dma_map support
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220722/202207221004.Th4xLMWP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=7b981a9cb1de32a6e73fe14d2665e0a2fb5dcd3c
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v3-wip
        git checkout 7b981a9cb1de32a6e73fe14d2665e0a2fb5dcd3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/pci.c: In function 'nvme_free_prp_chain':
>> drivers/nvme/host/pci.c:565:17: error: implicit declaration of function 'nvme_free_sgls'; did you mean 'nvme_pci_use_sgls'? [-Werror=implicit-function-declaration]
     565 |                 nvme_free_sgls(dev, req);
         |                 ^~~~~~~~~~~~~~
         |                 nvme_pci_use_sgls
>> drivers/nvme/host/pci.c:567:17: error: implicit declaration of function 'nvme_free_prps'; did you mean 'nvme_req_op'? [-Werror=implicit-function-declaration]
     567 |                 nvme_free_prps(dev, req);
         |                 ^~~~~~~~~~~~~~
         |                 nvme_req_op
   drivers/nvme/host/pci.c: At top level:
   drivers/nvme/host/pci.c:599:13: warning: conflicting types for 'nvme_free_prps'; have 'void(struct nvme_dev *, struct request *)'
     599 | static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
         |             ^~~~~~~~~~~~~~
>> drivers/nvme/host/pci.c:599:13: error: static declaration of 'nvme_free_prps' follows non-static declaration
   drivers/nvme/host/pci.c:567:17: note: previous implicit declaration of 'nvme_free_prps' with type 'void(struct nvme_dev *, struct request *)'
     567 |                 nvme_free_prps(dev, req);
         |                 ^~~~~~~~~~~~~~
   drivers/nvme/host/pci.c:615:13: warning: conflicting types for 'nvme_free_sgls'; have 'void(struct nvme_dev *, struct request *)'
     615 | static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
         |             ^~~~~~~~~~~~~~
>> drivers/nvme/host/pci.c:615:13: error: static declaration of 'nvme_free_sgls' follows non-static declaration
   drivers/nvme/host/pci.c:565:17: note: previous implicit declaration of 'nvme_free_sgls' with type 'void(struct nvme_dev *, struct request *)'
     565 |                 nvme_free_sgls(dev, req);
         |                 ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +565 drivers/nvme/host/pci.c

   554	
   555	static void nvme_free_prp_chain(struct nvme_dev *dev, struct request *req,
   556					struct nvme_iod *iod)
   557	{
   558		if (iod->npages < 0)
   559			return;
   560	
   561		if (iod->npages == 0)
   562			dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
   563				      iod->first_dma);
   564		else if (iod->use_sgl)
 > 565			nvme_free_sgls(dev, req);
   566		else
 > 567			nvme_free_prps(dev, req);
   568	}
   569	
   570	static void nvme_sync_dma(struct nvme_dev *dev, struct request *req)
   571	{
   572		int index, offset, i, length, nprps;
   573		struct nvme_dma_mapping *mapping;
   574		bool needs_sync;
   575	
   576		mapping = blk_rq_dma_tag(req);
   577		offset = blk_rq_dma_offset(req) + mapping->offset;
   578		index = offset >> NVME_CTRL_PAGE_SHIFT;
   579		needs_sync = rq_data_dir(req) == READ &&
   580			 dma_need_sync(dev->dev, le64_to_cpu(mapping->prps[index]));
   581	
   582		if (!needs_sync)
   583			return;
   584	
   585		offset = offset & (NVME_CTRL_PAGE_SIZE - 1);
   586		length = blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offset);
   587		nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
   588	
   589		dma_sync_single_for_cpu(dev->dev,
   590			le64_to_cpu(mapping->prps[index++]),
   591			NVME_CTRL_PAGE_SIZE - offset, DMA_FROM_DEVICE);
   592		for (i = 1; i < nprps; i++) {
   593			dma_sync_single_for_cpu(dev->dev,
   594				le64_to_cpu(mapping->prps[index++]),
   595				NVME_CTRL_PAGE_SIZE, DMA_FROM_DEVICE);
   596		}
   597	}
   598	
 > 599	static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
   600	{
   601		const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
   602		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
   603		dma_addr_t dma_addr = iod->first_dma;
   604		int i;
   605	
   606		for (i = 0; i < iod->npages; i++) {
   607			__le64 *prp_list = nvme_pci_iod_list(req)[i];
   608			dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
   609	
   610			dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
   611			dma_addr = next_dma_addr;
   612		}
   613	}
   614	
 > 615	static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
   616	{
   617		const int last_sg = SGES_PER_PAGE - 1;
   618		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
   619		dma_addr_t dma_addr = iod->first_dma;
   620		int i;
   621	
   622		for (i = 0; i < iod->npages; i++) {
   623			struct nvme_sgl_desc *sg_list = nvme_pci_iod_list(req)[i];
   624			dma_addr_t next_dma_addr = le64_to_cpu((sg_list[last_sg]).addr);
   625	
   626			dma_pool_free(dev->prp_page_pool, sg_list, dma_addr);
   627			dma_addr = next_dma_addr;
   628		}
   629	}
   630	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
