Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D604B4CB3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiCCAgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiCCAgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:36:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F63D4AD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267718; x=1677803718;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YdbNZix3kvfTgZtZTRj7hiixQw5+lMbwx7a+p6mD5nk=;
  b=E405AWC106i4mId4u34yx2XnVwtCeQ7NsBHn6RaWVwBw/K75WCuEZDaV
   PvVgBplF4BYKsEKf9+wLuG7wP+CzqDdxB+MMazZTC3Nx/t5UBxDR91Ud4
   QtqCOGOgS6j0hMOLwmGKuZ9LfAiMFZy/jomVBBUe4TWiJ8bXYxoTM6e6L
   DEIxvi/AeZpVUvyM6u3jNhhBO6uNEqbfbHdNzA7OtUJ/LD4q8NUWEu9tj
   E+ULURD0sevC4c/AfGWj3cagp1u9FCKLZxgMNkfA6vU9SXjm34cR7aKGc
   mxMMV2+alUvDvWEwtm0I37VZV8l4chirFvcMAg8jyu9eckhA7sd8EccE1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253269110"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253269110"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="493737930"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2022 16:35:03 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPZQs-000295-D9; Thu, 03 Mar 2022 00:35:02 +0000
Date:   Thu, 3 Mar 2022 08:34:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [mani-mhi:mhi-next 21/30] drivers/bus/mhi/ep/main.c:213:34: sparse:
 sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202203030804.CVhSRnt6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   4aa2b597db8f8808b7e0f89239cd98c3a56b21b1
commit: a0b0a77f43f02c80b9b942edf45233635cd6850f [21/30] bus: mhi: ep: Add support for powering up the MHI endpoint stack
config: ia64-randconfig-s031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030804.CVhSRnt6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=a0b0a77f43f02c80b9b942edf45233635cd6850f
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout a0b0a77f43f02c80b9b942edf45233635cd6850f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/bus/mhi/ep/ drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/bus/mhi/ep/main.c:213:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_cmd_ctxt *cmd_ctx_cache @@
   drivers/bus/mhi/ep/main.c:213:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:213:34: sparse:     got struct mhi_cmd_ctxt *cmd_ctx_cache
>> drivers/bus/mhi/ep/main.c:217:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_event_ctxt *ev_ctx_cache @@
   drivers/bus/mhi/ep/main.c:217:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:217:34: sparse:     got struct mhi_event_ctxt *ev_ctx_cache
>> drivers/bus/mhi/ep/main.c:221:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_chan_ctxt *ch_ctx_cache @@
   drivers/bus/mhi/ep/main.c:221:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:221:34: sparse:     got struct mhi_chan_ctxt *ch_ctx_cache
   drivers/bus/mhi/ep/main.c:235:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_cmd_ctxt *cmd_ctx_cache @@
   drivers/bus/mhi/ep/main.c:235:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:235:34: sparse:     got struct mhi_cmd_ctxt *cmd_ctx_cache
   drivers/bus/mhi/ep/main.c:237:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_event_ctxt *ev_ctx_cache @@
   drivers/bus/mhi/ep/main.c:237:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:237:34: sparse:     got struct mhi_event_ctxt *ev_ctx_cache
   drivers/bus/mhi/ep/main.c:239:34: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct mhi_chan_ctxt *ch_ctx_cache @@
   drivers/bus/mhi/ep/main.c:239:34: sparse:     expected void [noderef] __iomem *virt
   drivers/bus/mhi/ep/main.c:239:34: sparse:     got struct mhi_chan_ctxt *ch_ctx_cache

vim +213 drivers/bus/mhi/ep/main.c

   148	
   149	static int mhi_ep_cache_host_cfg(struct mhi_ep_cntrl *mhi_cntrl)
   150	{
   151		size_t cmd_ctx_host_size, ch_ctx_host_size, ev_ctx_host_size;
   152		struct device *dev = &mhi_cntrl->mhi_dev->dev;
   153		int ret;
   154	
   155		/* Update the number of event rings (NER) programmed by the host */
   156		mhi_ep_mmio_update_ner(mhi_cntrl);
   157	
   158		dev_dbg(dev, "Number of Event rings: %u, HW Event rings: %u\n",
   159			 mhi_cntrl->event_rings, mhi_cntrl->hw_event_rings);
   160	
   161		ch_ctx_host_size = sizeof(struct mhi_chan_ctxt) * mhi_cntrl->max_chan;
   162		ev_ctx_host_size = sizeof(struct mhi_event_ctxt) * mhi_cntrl->event_rings;
   163		cmd_ctx_host_size = sizeof(struct mhi_cmd_ctxt) * NR_OF_CMD_RINGS;
   164	
   165		/* Get the channel context base pointer from host */
   166		mhi_ep_mmio_get_chc_base(mhi_cntrl);
   167	
   168		/* Allocate and map memory for caching host channel context */
   169		ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, ch_ctx_host_size,
   170					&mhi_cntrl->ch_ctx_cache_phys,
   171					(void __iomem **)&mhi_cntrl->ch_ctx_cache);
   172		if (ret) {
   173			dev_err(dev, "Failed to allocate and map ch_ctx_cache\n");
   174			return ret;
   175		}
   176	
   177		/* Get the event context base pointer from host */
   178		mhi_ep_mmio_get_erc_base(mhi_cntrl);
   179	
   180		/* Allocate and map memory for caching host event context */
   181		ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, ev_ctx_host_size,
   182					&mhi_cntrl->ev_ctx_cache_phys,
   183					(void __iomem **)&mhi_cntrl->ev_ctx_cache);
   184		if (ret) {
   185			dev_err(dev, "Failed to allocate and map ev_ctx_cache\n");
   186			goto err_ch_ctx;
   187		}
   188	
   189		/* Get the command context base pointer from host */
   190		mhi_ep_mmio_get_crc_base(mhi_cntrl);
   191	
   192		/* Allocate and map memory for caching host command context */
   193		ret = mhi_ep_alloc_map(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, cmd_ctx_host_size,
   194					&mhi_cntrl->cmd_ctx_cache_phys,
   195					(void __iomem **)&mhi_cntrl->cmd_ctx_cache);
   196		if (ret) {
   197			dev_err(dev, "Failed to allocate and map cmd_ctx_cache\n");
   198			goto err_ev_ctx;
   199		}
   200	
   201		/* Initialize command ring */
   202		ret = mhi_ep_ring_start(mhi_cntrl, &mhi_cntrl->mhi_cmd->ring,
   203					(union mhi_ep_ring_ctx *)mhi_cntrl->cmd_ctx_cache);
   204		if (ret) {
   205			dev_err(dev, "Failed to start the command ring\n");
   206			goto err_cmd_ctx;
   207		}
   208	
   209		return ret;
   210	
   211	err_cmd_ctx:
   212		mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->cmd_ctx_host_pa, mhi_cntrl->cmd_ctx_cache_phys,
 > 213				mhi_cntrl->cmd_ctx_cache, cmd_ctx_host_size);
   214	
   215	err_ev_ctx:
   216		mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ev_ctx_host_pa, mhi_cntrl->ev_ctx_cache_phys,
 > 217				mhi_cntrl->ev_ctx_cache, ev_ctx_host_size);
   218	
   219	err_ch_ctx:
   220		mhi_ep_unmap_free(mhi_cntrl, mhi_cntrl->ch_ctx_host_pa, mhi_cntrl->ch_ctx_cache_phys,
 > 221				mhi_cntrl->ch_ctx_cache, ch_ctx_host_size);
   222	
   223		return ret;
   224	}
   225	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
