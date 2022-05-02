Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE03C516F27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384830AbiEBMAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384823AbiEBMAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:00:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899FA1B79A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651492632; x=1683028632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nZP/1+6lT8kAc58d0aWd4V/lSg7XdvpNjFkvBSMZQLU=;
  b=bxetFV9gaEapfGvQfgjo7cSVIyU5Sdm8YU4aCYfuhBTODoP8nI4bspDZ
   IMtLBWQmPqdi6j3TqV7oRnK6O/XTI0i/TY8IXEZ4xeDo/1BUpqsbHGk4v
   Fi75uQz6ahFoRfvp6JxmFo3G3xP+45Xa//i/oDW6IYqUwXStIhmEdDFj1
   pJwoxy2emzzmd2PQ4dv1WJFkEjpxtINk7uYR3JhihwXq9mskn5pGzHK/R
   kYyMxTEYnmZPRTXrRwf8GYezpaDVVG4gY7ee4O9J0wCNOquelko9LhLKj
   HqQdJHOzYkKxIzGYVOoZGdJrivfZCQ4dl+YZBMOkkwBBdFlbHVj5wssVX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247100668"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247100668"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 04:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707576172"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2022 04:57:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlUfu-0009X9-JN;
        Mon, 02 May 2022 11:57:10 +0000
Date:   Mon, 2 May 2022 19:56:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 44/44]
 drivers/misc/habanalabs/gaudi/gaudi.c:4743:5: warning: no previous prototype
 for 'gaudi_scrub_device_dram'
Message-ID: <202205021930.5T9x6nUF-lkp@intel.com>
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
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205021930.5T9x6nUF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=70f82d1e3fe1618ef992a2bb3cf4af85eaed0f5a
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 70f82d1e3fe1618ef992a2bb3cf4af85eaed0f5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/habanalabs/gaudi/gaudi.c:4743:5: warning: no previous prototype for 'gaudi_scrub_device_dram' [-Wmissing-prototypes]
    4743 | int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


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
