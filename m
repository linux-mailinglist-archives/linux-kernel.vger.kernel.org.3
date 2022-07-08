Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1956C200
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiGHTtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiGHTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:49:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3F84EF5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657309746; x=1688845746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wTNwgAlBnkhFBLJp0KT27f8eH+o5zzHGK55CMCp3i+8=;
  b=c70H4c/2dyGr7PavMC/JL98fc9ozJFpugcmz7uCZpCzu8xUXPHN7oIA3
   SdFZsRdQ+qlHZl5DEPl5onTywsCj5yswzjp83tkFOseMqMBHpKm/8FgMl
   FSGKunwjj8hESclnCvMw9nr3L+VfX44ZWTB6IozgftlPdlBDVXFF+EHe0
   OjhC0ZFxEwmssVOsTT9y4kvjFlDIHHI9XT6sJcmtg+Bv8/XzfcFgcbrCd
   tHeljznsRxyG0Mn4KlQjerGxWAuIquATc73UqGtN5ObqAHpvwDP//+6OV
   WSVynOvUPdk4o+a6dg0FucYdMMT7Aul+Qkb44wvnJa4sN69uaCkHphyFs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="346040055"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="346040055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 12:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621339131"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Jul 2022 12:49:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9tyK-000NrO-Ap;
        Fri, 08 Jul 2022 19:49:04 +0000
Date:   Sat, 9 Jul 2022 03:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom <support@vamrs.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 34/50]
 drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:187:9: error:
 implicit declaration of function 'sifive_l2_flush64_range'; did you mean
 'sifive_l2_flush_range'?
Message-ID: <202207090348.pcARMgsd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   943858df470556d0b7f3b31fcc10931603f0f3cc
commit: 4c89873ac3af6a251049da47ab78862c05de9fad [34/50] dmaengine: Add dw-axi-dmac-starfive driver for JH7100
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220709/202207090348.pcARMgsd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/4c89873ac3af6a251049da47ab78862c05de9fad
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 4c89873ac3af6a251049da47ab78862c05de9fad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the esmil/visionfive HEAD 943858df470556d0b7f3b31fcc10931603f0f3cc builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c: In function 'dw_dma_async_do_memcpy':
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:153:9: error: implicit declaration of function 'iort_dma_setup' [-Werror=implicit-function-declaration]
     153 |         iort_dma_setup(dma_dev, &dma_addr, &dma_size);
         |         ^~~~~~~~~~~~~~
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:154:15: warning: assignment to 'const struct iommu_ops *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     154 |         iommu = iort_iommu_configure_id(dma_dev, NULL);
         |               ^
>> drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:187:9: error: implicit declaration of function 'sifive_l2_flush64_range'; did you mean 'sifive_l2_flush_range'? [-Werror=implicit-function-declaration]
     187 |         sifive_l2_flush64_range(src_dma, size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         sifive_l2_flush_range
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c: In function 'dw_dma_memcpy_raw':
   drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c:224:15: warning: assignment to 'const struct iommu_ops *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     224 |         iommu = iort_iommu_configure_id(dma_dev, NULL);
         |               ^
   cc1: some warnings being treated as errors
--
   drivers/dma/dw-axi-dmac-starfive/dw-axi-dmac-starfive-misc.c: In function 'axidma_unlocked_ioctl':
>> drivers/dma/dw-axi-dmac-starfive/dw-axi-dmac-starfive-misc.c:197:17: error: implicit declaration of function 'sifive_l2_flush64_range'; did you mean 'sifive_l2_flush_range'? [-Werror=implicit-function-declaration]
     197 |                 sifive_l2_flush64_range(chncfg.src_addr, chncfg.len);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 sifive_l2_flush_range
   cc1: some warnings being treated as errors


vim +187 drivers/dma/dw-axi-dmac-starfive/starfive_dmaengine_memcpy.c

   132	
   133	int dw_dma_async_do_memcpy(void *src, void *dst, size_t size)
   134	{
   135		int ret;
   136		struct device *dma_dev;
   137		struct dma_chan *chan;
   138		dma_addr_t src_dma, dst_dma;
   139		struct dma_async_tx_descriptor *desc;
   140	
   141		const struct iommu_ops *iommu;
   142		u64 dma_addr = 0, dma_size = 0;
   143	
   144		dma_dev = kzalloc(sizeof(*dma_dev), GFP_KERNEL);
   145		if(!dma_dev){
   146			dev_err(dma_dev, "kmalloc error.\n");
   147			return -ENOMEM;
   148		}
   149	
   150		dma_dev->bus = NULL;
   151		dma_dev->coherent_dma_mask = 0xffffffff;
   152	
   153		iort_dma_setup(dma_dev, &dma_addr, &dma_size);
   154		iommu = iort_iommu_configure_id(dma_dev, NULL);
   155		if (PTR_ERR(iommu) == -EPROBE_DEFER)
   156			return -EPROBE_DEFER;
   157	
   158		arch_setup_dma_ops(dma_dev, dst_dma, dma_size, iommu, true);
   159	
   160		if(_dma_async_alloc_buf(dma_dev, &src, &dst, size, &src_dma, &dst_dma)) {
   161			dev_err(dma_dev, "Err alloc.\n");
   162			return -ENOMEM;
   163		}
   164	
   165		DMA_DEBUG("src=%#llx, dst=%#llx\n", (u64)src, (u64)dst);
   166		DMA_DEBUG("dma_src=%#x dma_dst=%#x\n", (u32)src_dma, (u32)dst_dma);
   167	
   168		_dma_async_prebuf(src, dst, size);
   169	
   170		chan = _dma_get_channel(DMA_MEMCPY);
   171		if(!chan ){
   172			DMA_PRINTK("Err get chan.\n");
   173			return -EBUSY;
   174		}
   175		DMA_DEBUG("get chan ok.\n");
   176	
   177		desc = _dma_async_get_desc(chan, src_dma, dst_dma, size);
   178		if(!desc){
   179			DMA_PRINTK("Err get desc.\n");
   180			dma_release_channel(chan);
   181			return -ENOMEM;
   182		}
   183		DMA_DEBUG("get desc ok.\n");
   184	
   185		desc->callback = tx_callback;
   186	
 > 187		sifive_l2_flush64_range(src_dma, size);
   188		sifive_l2_flush64_range(dst_dma, size);
   189	
   190		_dma_async_do_start(desc, chan);
   191		_dma_async_release(chan);
   192	
   193		ret = _dma_async_check_data(src, dst, size);
   194	
   195		dma_free_coherent(dma_dev, size, src, src_dma);
   196		dma_free_coherent(dma_dev, size, dst, dst_dma);
   197	
   198		return ret;
   199	}
   200	EXPORT_SYMBOL(dw_dma_async_do_memcpy);
   201	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
