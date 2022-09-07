Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83E35B05A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIGNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIGNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:48:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66DB29
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662558499; x=1694094499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2hq9VsMNI2YsNBzowapDtlL+tQ7fFahjo10RC0uEpMc=;
  b=F1f8P3OicNN5EldLOsTrHx85IhCJcn4V+HhRh31ap+HkV1F/AWOdHnRY
   LUhtrJV8vYegtHkQ+Qfq+cW7X4sP3KJFB35xRccpesUaKMGIonmVXxWx0
   VR1lVRI4ax5GKaoGqIL+vuykEc0HeMl3eV1rNre8D6qB8zwIQptb+IxKv
   G0wF4WBinpjmA+5K1oWLWw1NlYxH4vr/Ne1by+/CKTEvGl3KaRKu5xUlN
   X/k7ctEdptxlo5XC3DjF2ZX4A0iapudf22bC4/W4ug0zPSCFZGqhsqShX
   guROfgv7S93tkiPYy8zMz3xBlUd1g5HuTQMwkgoLvc2hztD2ifCFqxl+H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279885603"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="279885603"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="942893438"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 06:48:17 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVvPc-0006cT-2a;
        Wed, 07 Sep 2022 13:48:16 +0000
Date:   Wed, 7 Sep 2022 21:47:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [mani-mhi:mhi-next 2/3] drivers/bus/mhi/host/pci_generic.c:734:60:
 error: assignment of member 'irq' in read-only object
Message-ID: <202209072144.lWoBySRH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
head:   0a3b31f6259f4849e4e93731d4c8d7910be072a7
commit: 4a98958ca237a4b7974ea1ec2092b3666bdd26ab [2/3] bus: mhi: host: make mhi_controller_config::event_cfg const
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220907/202209072144.lWoBySRH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=4a98958ca237a4b7974ea1ec2092b3666bdd26ab
        git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
        git fetch --no-tags mani-mhi mhi-next
        git checkout 4a98958ca237a4b7974ea1ec2092b3666bdd26ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/bus/mhi/host/pci_generic.c: In function 'mhi_pci_get_irqs':
>> drivers/bus/mhi/host/pci_generic.c:734:60: error: assignment of member 'irq' in read-only object
     734 |                         mhi_cntrl_config->event_cfg[i].irq = 0;
         |                                                            ^


vim +/irq +734 drivers/bus/mhi/host/pci_generic.c

855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  708  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  709  static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  710  			    const struct mhi_controller_config *mhi_cntrl_config)
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  711  {
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  712  	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  713  	int nr_vectors, i;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  714  	int *irq;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  715  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  716  	/*
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  717  	 * Alloc one MSI vector for BHI + one vector per event ring, ideally...
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  718  	 * No explicit pci_free_irq_vectors required, done by pcim_release.
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  719  	 */
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  720  	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  721  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  722  	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSI);
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  723  	if (nr_vectors < 0) {
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  724  		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  725  			nr_vectors);
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  726  		return nr_vectors;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  727  	}
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  728  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  729  	if (nr_vectors < mhi_cntrl->nr_irqs) {
b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  730  		dev_warn(&pdev->dev, "using shared MSI\n");
b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  731  
b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  732  		/* Patch msi vectors, use only one (shared) */
b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  733  		for (i = 0; i < mhi_cntrl_config->num_events; i++)
b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05 @734  			mhi_cntrl_config->event_cfg[i].irq = 0;
b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  735  		mhi_cntrl->nr_irqs = 1;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  736  	}
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  737  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  738  	irq = devm_kcalloc(&pdev->dev, mhi_cntrl->nr_irqs, sizeof(int), GFP_KERNEL);
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  739  	if (!irq)
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  740  		return -ENOMEM;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  741  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  742  	for (i = 0; i < mhi_cntrl->nr_irqs; i++) {
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  743  		int vector = i >= nr_vectors ? (nr_vectors - 1) : i;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  744  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  745  		irq[i] = pci_irq_vector(pdev, vector);
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  746  	}
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  747  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  748  	mhi_cntrl->irq = irq;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  749  
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  750  	return 0;
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  751  }
855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  752  

:::::: The code at line 734 was first introduced by commit
:::::: b91c3b30e2267265cd7e67cb3d0c99c48c02b001 mhi: pci_generic: Fix shared MSI vector support

:::::: TO: Loic Poulain <loic.poulain@linaro.org>
:::::: CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
