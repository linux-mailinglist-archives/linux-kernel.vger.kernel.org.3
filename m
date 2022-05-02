Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0459F516FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385094AbiEBMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiEBMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:51:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B361E14000
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651495695; x=1683031695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LJyisvBfntxgR8HUsmpbZAIgluWtIfFxjvi7b9/X/8M=;
  b=dc60HTSVE4XATEnS1Guc0rt4xPc3V4fz0idYuZ9j5JpH4ESdjKyE2oAG
   iQc+soQ757M5/mtCm7X/XF4Vm3NXfWfBgmUT8zksDkKxDEgn7mSjkUAT2
   DQlzAESXWU79s15jgue1UIL2anYFCZDubrEkAb2ikeKvT7vH9jIVbej3c
   JN4h+u76yRt/FIi08bGS9+J+GhSQNM22dwhNxZ8T/f36rmQTDTPxZO/8S
   yh4d+4xP2AEGHVI39IvfdVXbbPgC+Rvl9aZb8HBFvEJTeCmJVZOuboSyh
   lRwRHKtIsY1ObkKZJPO4GBAyNRcpOVH0dz4wXzNVh/oQRvGG/Xfv7b9U9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247110225"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="247110225"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="652802553"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2022 05:48:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlVTJ-0009YR-Bt;
        Mon, 02 May 2022 12:48:13 +0000
Date:   Mon, 2 May 2022 20:47:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 44/44]
 drivers/misc/habanalabs/gaudi/gaudi.c:4743:5: warning: no previous prototype
 for function 'gaudi_scrub_device_dram'
Message-ID: <202205022000.4qwpPGir-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   70f82d1e3fe1618ef992a2bb3cf4af85eaed0f5a
commit: 70f82d1e3fe1618ef992a2bb3cf4af85eaed0f5a [44/44] habanalabs: add device memory scrub ability through debugfs
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205022000.4qwpPGir-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=70f82d1e3fe1618ef992a2bb3cf4af85eaed0f5a
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 70f82d1e3fe1618ef992a2bb3cf4af85eaed0f5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/gaudi/gaudi.c:4743:5: warning: no previous prototype for function 'gaudi_scrub_device_dram' [-Wmissing-prototypes]
   int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
       ^
   drivers/misc/habanalabs/gaudi/gaudi.c:4743:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
   ^
   static 
   1 warning generated.


vim +/gaudi_scrub_device_dram +4743 drivers/misc/habanalabs/gaudi/gaudi.c

  4742	
> 4743	int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
  4744	{
  4745		struct asic_fixed_properties *prop = &hdev->asic_prop;
  4746		u64  cur_addr = DRAM_BASE_ADDR_USER;
  4747		u32 chunk_size, busy;
  4748		int rc, dma_id;
  4749	
  4750		while (cur_addr < prop->dram_end_address) {
  4751			for (dma_id = 0 ; dma_id < DMA_NUMBER_OF_CHANNELS ; dma_id++) {
  4752				u32 dma_offset = dma_id * DMA_CORE_OFFSET;
  4753	
  4754				chunk_size =
  4755				min((u64)SZ_2G, prop->dram_end_address - cur_addr);
  4756	
  4757				dev_dbg(hdev->dev,
  4758					"Doing HBM scrubbing for 0x%09llx - 0x%09llx\n",
  4759					cur_addr, cur_addr + chunk_size);
  4760	
  4761				WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset,
  4762						lower_32_bits(val));
  4763				WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset,
  4764						upper_32_bits(val));
  4765				WREG32(mmDMA0_CORE_DST_BASE_LO + dma_offset,
  4766							lower_32_bits(cur_addr));
  4767				WREG32(mmDMA0_CORE_DST_BASE_HI + dma_offset,
  4768							upper_32_bits(cur_addr));
  4769				WREG32(mmDMA0_CORE_DST_TSIZE_0 + dma_offset,
  4770						chunk_size);
  4771				WREG32(mmDMA0_CORE_COMMIT + dma_offset,
  4772						((1 << DMA0_CORE_COMMIT_LIN_SHIFT) |
  4773						(1 << DMA0_CORE_COMMIT_MEM_SET_SHIFT)));
  4774	
  4775				cur_addr += chunk_size;
  4776	
  4777				if (cur_addr == prop->dram_end_address)
  4778					break;
  4779			}
  4780	
  4781			for (dma_id = 0 ; dma_id < DMA_NUMBER_OF_CHANNELS ; dma_id++) {
  4782				u32 dma_offset = dma_id * DMA_CORE_OFFSET;
  4783	
  4784				rc = hl_poll_timeout(
  4785					hdev,
  4786					mmDMA0_CORE_STS0 + dma_offset,
  4787					busy,
  4788					((busy & DMA0_CORE_STS0_BUSY_MASK) == 0),
  4789					1000,
  4790					HBM_SCRUBBING_TIMEOUT_US);
  4791	
  4792				if (rc) {
  4793					dev_err(hdev->dev,
  4794						"DMA Timeout during HBM scrubbing of DMA #%d\n",
  4795						dma_id);
  4796					return -EIO;
  4797				}
  4798			}
  4799		}
  4800	
  4801		return 0;
  4802	}
  4803	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
