Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3413591E5F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiHNFKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHNFKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:10:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14147DF23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660453845; x=1691989845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DAJlmgpmNDAnkrnhZlHD0JnNof5YN960V2Twt9HtXfk=;
  b=XbohwwE2DBWjKyEsi8z7pTYHvNV3gnLHK3qHEVgYNPdST9HqIbaoNGzP
   +/vhkZt0Ttsyc3h+u7wBP+CpVMjpPS/1Aq7pZiCHzjO0xegp2VVmHJxZi
   BlEoD8BAemJ+OINQJ0Wlc1uz2kJoTSVq0q9DGeTjv4OmDZmLbdFOTeKGC
   i9FiMlhPbaxp20dlHfglZheFAuG4eu3bN2d7vOpl4FZe5Ox0OjuIrYvI+
   kPB2Rv19WU/r4YihBhy3lrh/YZXVmiAhSeomaxSGSWNfBXsmdryGMv8lI
   xu9KvGmvBVNv11tfKBAAnmsF9sYSfRQUh8DXISSRWRi0D/LhzorSiXrmU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291796394"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="291796394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 22:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="666291699"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2022 22:10:43 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN5ta-0002WN-1p;
        Sun, 14 Aug 2022 05:10:42 +0000
Date:   Sun, 14 Aug 2022 13:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next-hacking 16/18]
 drivers/irqchip/irq-imx-mu-msi.c:142:19: warning: excess elements in struct
 initializer
Message-ID: <202208141350.BoRK1ikN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jonmason/ntb ntb-next-hacking
head:   d90921d21692b59734d2452efea346217a526f44
commit: 1db755129d2544df84dc197095c14170cfa419c7 [16/18] irqchip: imx mu worked as msi controller
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208141350.BoRK1ikN-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jonmason/ntb/commit/1db755129d2544df84dc197095c14170cfa419c7
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next-hacking
        git checkout 1db755129d2544df84dc197095c14170cfa419c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-imx-mu-msi.c:138:15: error: variable 'its_pmsi_ops' has initializer but incomplete type
     138 | static struct msi_domain_ops its_pmsi_ops = {
         |               ^~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:141:15: error: variable 'imx_mu_msi_domain_info' has initializer but incomplete type
     141 | static struct msi_domain_info imx_mu_msi_domain_info = {
         |               ^~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:142:10: error: 'struct msi_domain_info' has no member named 'flags'
     142 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS |
         |          ^~~~~
   drivers/irqchip/irq-imx-mu-msi.c:142:20: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
     142 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS |
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:143:20: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
     143 |                    MSI_FLAG_USE_DEF_CHIP_OPS |
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:144:20: error: 'MSI_FLAG_PCI_MSIX' undeclared here (not in a function)
     144 |                    MSI_FLAG_PCI_MSIX),
         |                    ^~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-imx-mu-msi.c:142:19: warning: excess elements in struct initializer
     142 |         .flags  = (MSI_FLAG_USE_DEF_DOM_OPS |
         |                   ^
   drivers/irqchip/irq-imx-mu-msi.c:142:19: note: (near initialization for 'imx_mu_msi_domain_info')
   drivers/irqchip/irq-imx-mu-msi.c:145:10: error: 'struct msi_domain_info' has no member named 'ops'
     145 |         .ops    = &its_pmsi_ops,
         |          ^~~
   drivers/irqchip/irq-imx-mu-msi.c:145:19: warning: excess elements in struct initializer
     145 |         .ops    = &its_pmsi_ops,
         |                   ^
   drivers/irqchip/irq-imx-mu-msi.c:145:19: note: (near initialization for 'imx_mu_msi_domain_info')
   drivers/irqchip/irq-imx-mu-msi.c:146:10: error: 'struct msi_domain_info' has no member named 'chip'
     146 |         .chip   = &imx_mu_msi_irq_chip,
         |          ^~~~
   drivers/irqchip/irq-imx-mu-msi.c:146:19: warning: excess elements in struct initializer
     146 |         .chip   = &imx_mu_msi_irq_chip,
         |                   ^
   drivers/irqchip/irq-imx-mu-msi.c:146:19: note: (near initialization for 'imx_mu_msi_domain_info')
   drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_msi_domain_irq_alloc':
   drivers/irqchip/irq-imx-mu-msi.c:179:9: error: unknown type name 'msi_alloc_info_t'
     179 |         msi_alloc_info_t *info = args;
         |         ^~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:197:41: error: request for member 'desc' in something not a structure or union
     197 |         err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr + pos * 4);
         |                                         ^~
   drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_msi_domains_init':
   drivers/irqchip/irq-imx-mu-msi.c:262:32: error: implicit declaration of function 'platform_msi_create_irq_domain' [-Werror=implicit-function-declaration]
     262 |         msi_data->msi_domain = platform_msi_create_irq_domain(
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-imx-mu-msi.c:262:30: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     262 |         msi_data->msi_domain = platform_msi_create_irq_domain(
         |                              ^
   drivers/irqchip/irq-imx-mu-msi.c: At top level:
   drivers/irqchip/irq-imx-mu-msi.c:138:30: error: storage size of 'its_pmsi_ops' isn't known
     138 | static struct msi_domain_ops its_pmsi_ops = {
         |                              ^~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:141:31: error: storage size of 'imx_mu_msi_domain_info' isn't known
     141 | static struct msi_domain_info imx_mu_msi_domain_info = {
         |                               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +142 drivers/irqchip/irq-imx-mu-msi.c

   140	
   141	static struct msi_domain_info imx_mu_msi_domain_info = {
 > 142		.flags	= (MSI_FLAG_USE_DEF_DOM_OPS |
   143			   MSI_FLAG_USE_DEF_CHIP_OPS |
   144			   MSI_FLAG_PCI_MSIX),
   145		.ops	= &its_pmsi_ops,
   146		.chip	= &imx_mu_msi_irq_chip,
   147	};
   148	
   149	static void imx_mu_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
   150	{
   151		struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data);
   152	
   153		msg->address_hi = upper_32_bits(msi_data->msiir_addr);
   154		msg->address_lo = lower_32_bits(msi_data->msiir_addr + 4 * data->hwirq);
   155		msg->data = data->hwirq;
   156	
   157		iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
   158	}
   159	
   160	static int imx_mu_msi_set_affinity(struct irq_data *irq_data,
   161					   const struct cpumask *mask, bool force)
   162	
   163	{
   164		return IRQ_SET_MASK_OK;
   165	}
   166	
   167	static struct irq_chip imx_mu_msi_parent_chip = {
   168		.name			= "MU",
   169		.irq_compose_msi_msg	= imx_mu_msi_compose_msg,
   170		.irq_set_affinity = imx_mu_msi_set_affinity,
   171	};
   172	
   173	static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
   174						unsigned int virq,
   175						unsigned int nr_irqs,
   176						void *args)
   177	{
   178		struct imx_mu_msi *msi_data = domain->host_data;
   179		msi_alloc_info_t *info = args;
   180		int pos, err = 0;
   181	
   182		pm_runtime_get_sync(&msi_data->pdev->dev);
   183	
   184		WARN_ON(nr_irqs != 1);
   185	
   186		spin_lock(&msi_data->lock);
   187		pos = find_first_zero_bit(&msi_data->used, msi_data->irqs_num);
   188		if (pos < msi_data->irqs_num)
   189			__set_bit(pos, &msi_data->used);
   190		else
   191			err = -ENOSPC;
   192		spin_unlock(&msi_data->lock);
   193	
   194		if (err)
   195			return err;
   196	
   197		err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr + pos * 4);
   198		if (err)
   199			return err;
   200	
   201		irq_domain_set_info(domain, virq, pos,
   202				    &imx_mu_msi_parent_chip, msi_data,
   203				    handle_simple_irq, NULL, NULL);
   204		return 0;
   205	}
   206	
   207	static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
   208					       unsigned int virq, unsigned int nr_irqs)
   209	{
   210		struct irq_data *d = irq_domain_get_irq_data(domain, virq);
   211		struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(d);
   212		int pos;
   213	
   214		pos = d->hwirq;
   215		if (pos < 0 || pos >= msi_data->irqs_num) {
   216			pr_err("failed to teardown msi. Invalid hwirq %d\n", pos);
   217			return;
   218		}
   219	
   220		spin_lock(&msi_data->lock);
   221		__clear_bit(pos, &msi_data->used);
   222		spin_unlock(&msi_data->lock);
   223	
   224		pm_runtime_put(&msi_data->pdev->dev);
   225	}
   226	
   227	static const struct irq_domain_ops imx_mu_msi_domain_ops = {
   228		.alloc	= imx_mu_msi_domain_irq_alloc,
   229		.free	= imx_mu_msi_domain_irq_free,
   230	};
   231	
   232	static void imx_mu_msi_irq_handler(struct irq_desc *desc)
   233	{
   234		struct imx_mu_msi *msi_data = irq_desc_get_handler_data(desc);
   235		u32 status;
   236		int i;
   237	
   238		status = imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
   239	
   240		chained_irq_enter(irq_desc_get_chip(desc), desc);
   241		for (i = 0; i < IMX_MU_CHANS; i++) {
   242			if (status & IMX_MU_xSR_RFn(msi_data->cfg->type, i)) {
   243				imx_mu_read(msi_data, msi_data->cfg->xRR + i * 4);
   244				generic_handle_domain_irq(msi_data->parent, i);
   245			}
   246		}
   247		chained_irq_exit(irq_desc_get_chip(desc), desc);
   248	}
   249	
   250	static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data)
   251	{
   252		/* Initialize MSI domain parent */
   253		msi_data->parent = irq_domain_add_linear(NULL,
   254							 msi_data->irqs_num,
   255							 &imx_mu_msi_domain_ops,
   256							 msi_data);
   257		if (!msi_data->parent) {
   258			dev_err(&msi_data->pdev->dev, "failed to create IRQ domain\n");
   259			return -ENOMEM;
   260		}
   261	
 > 262		msi_data->msi_domain = platform_msi_create_irq_domain(
   263					of_node_to_fwnode(msi_data->pdev->dev.of_node),
   264					&imx_mu_msi_domain_info,
   265					msi_data->parent);
   266	
   267		if (!msi_data->msi_domain) {
   268			dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
   269			irq_domain_remove(msi_data->parent);
   270			return -ENOMEM;
   271		}
   272	
   273		return 0;
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
