Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7315B0A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIGQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:45:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041A0240AB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59EF1B81E0C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5567FC433C1;
        Wed,  7 Sep 2022 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662569119;
        bh=J2mEXKxCyPXp3HIG7vxdAx/c1xyIHhsBFchWTEVlcMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5gj7kA8ha0hKE7fZZG8DEzCX0/lQY7oifkMyUyTrO2Ns6uehSCKed9+6Gb1izul3
         /0kxzn/eCbfSPAcEK0GUm+kT3MCco1Lt1QxHcbzTbHwNiuNNJajgUUQPobzeia27s7
         vxeFHrVQgdAl05R577m+VqaJj2b8LDjolkzCyB66/7SfieYNo/r8Tg4Zw+xh+9qGcY
         V6FRlHdBHP9KCqrKGWNvEAZIsQ23wr/y1+gtDP3OE5/ACKuGFSL+bnHADfj6Ml3FDz
         s6N7a0XAjzvu/5ppDRYFvNJJB8wBPwnhekEFrrA+KNQKLxcpKND52mQst3Ua9Pz3Yo
         MFpqzFbrtqpbg==
Date:   Wed, 7 Sep 2022 22:15:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mani-mhi:mhi-next 2/3]
 drivers/bus/mhi/host/pci_generic.c:734:60: error: assignment of member 'irq'
 in read-only object
Message-ID: <20220907164506.GA499781@thinkpad>
References: <202209072144.lWoBySRH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202209072144.lWoBySRH-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:47:42PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
> head:   0a3b31f6259f4849e4e93731d4c8d7910be072a7
> commit: 4a98958ca237a4b7974ea1ec2092b3666bdd26ab [2/3] bus: mhi: host: make mhi_controller_config::event_cfg const
> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220907/202209072144.lWoBySRH-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?id=4a98958ca237a4b7974ea1ec2092b3666bdd26ab
>         git remote add mani-mhi https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
>         git fetch --no-tags mani-mhi mhi-next
>         git checkout 4a98958ca237a4b7974ea1ec2092b3666bdd26ab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/bus/mhi/host/pci_generic.c: In function 'mhi_pci_get_irqs':
> >> drivers/bus/mhi/host/pci_generic.c:734:60: error: assignment of member 'irq' in read-only object
>      734 |                         mhi_cntrl_config->event_cfg[i].irq = 0;

Ah, so this is why I didn't make it constant in the first place...
Dropped the patch now.

Thanks,
Mani

>          |                                                            ^
> 
> 
> vim +/irq +734 drivers/bus/mhi/host/pci_generic.c
> 
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  708  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  709  static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  710  			    const struct mhi_controller_config *mhi_cntrl_config)
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  711  {
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  712  	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  713  	int nr_vectors, i;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  714  	int *irq;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  715  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  716  	/*
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  717  	 * Alloc one MSI vector for BHI + one vector per event ring, ideally...
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  718  	 * No explicit pci_free_irq_vectors required, done by pcim_release.
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  719  	 */
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  720  	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  721  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  722  	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSI);
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  723  	if (nr_vectors < 0) {
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  724  		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  725  			nr_vectors);
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  726  		return nr_vectors;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  727  	}
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  728  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  729  	if (nr_vectors < mhi_cntrl->nr_irqs) {
> b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  730  		dev_warn(&pdev->dev, "using shared MSI\n");
> b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  731  
> b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  732  		/* Patch msi vectors, use only one (shared) */
> b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  733  		for (i = 0; i < mhi_cntrl_config->num_events; i++)
> b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05 @734  			mhi_cntrl_config->event_cfg[i].irq = 0;
> b91c3b30e226726 drivers/bus/mhi/pci_generic.c Loic Poulain 2021-01-05  735  		mhi_cntrl->nr_irqs = 1;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  736  	}
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  737  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  738  	irq = devm_kcalloc(&pdev->dev, mhi_cntrl->nr_irqs, sizeof(int), GFP_KERNEL);
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  739  	if (!irq)
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  740  		return -ENOMEM;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  741  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  742  	for (i = 0; i < mhi_cntrl->nr_irqs; i++) {
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  743  		int vector = i >= nr_vectors ? (nr_vectors - 1) : i;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  744  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  745  		irq[i] = pci_irq_vector(pdev, vector);
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  746  	}
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  747  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  748  	mhi_cntrl->irq = irq;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  749  
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  750  	return 0;
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  751  }
> 855a70c12021bdc drivers/bus/mhi/pci_generic.c Loic Poulain 2020-10-21  752  
> 
> :::::: The code at line 734 was first introduced by commit
> :::::: b91c3b30e2267265cd7e67cb3d0c99c48c02b001 mhi: pci_generic: Fix shared MSI vector support
> 
> :::::: TO: Loic Poulain <loic.poulain@linaro.org>
> :::::: CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

-- 
மணிவண்ணன் சதாசிவம்
