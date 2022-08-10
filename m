Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6E58EF96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiHJPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:47:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7B5A156
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660146474; x=1691682474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o7/oxvnTzOXN33NjHC3bHhySXVzZzlb3J6meONRHtpg=;
  b=aNlPSPSuON20KfeGSrdoZjU2xWqfynUd0uhbDJ5cTbqCVqjWDNg5alcV
   udL5Kvi2qCAdIjCTMDD8oXXBO4H/d43VS61H2n3AdaQhkEXOV5rEdo9Vl
   CVhUtDxdXW5+Z/SvctEaT5RwiFfL+2gcVNLSOwVl5n/RCnyJ8JI27n2r/
   vKFyslt4BUnjh2ixtl+NJF5unMGqOyfs9eLOl0ok/iRcwtZiUQPCabpSm
   tXet9ihfohhHn7Skzt70QSLpD41RQxd562aOe7hZvIWceJ1YO9409xfuW
   o8dBE4pmoRN9sk5CQwPTN00gTP+3L8iCeiND/qoRO1Ckb94hnopas1Dnl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="352855211"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="352855211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 08:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="638154771"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 08:47:52 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLnw0-0000Po-08;
        Wed, 10 Aug 2022 15:47:52 +0000
Date:   Wed, 10 Aug 2022 23:46:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next-hacking 16/18]
 drivers/irqchip/irq-imx-mu-msi.c:128: undefined reference to
 `pci_msi_unmask_irq'
Message-ID: <202208102343.yHsh1iyB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm64-randconfig-r022-20220810 (https://download.01.org/0day-ci/archive/20220810/202208102343.yHsh1iyB-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jonmason/ntb/commit/1db755129d2544df84dc197095c14170cfa419c7
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next-hacking
        git checkout 1db755129d2544df84dc197095c14170cfa419c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: ID map text too big or misaligned
   aarch64-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function `imx_mu_msi_unmask_irq':
>> drivers/irqchip/irq-imx-mu-msi.c:128: undefined reference to `pci_msi_unmask_irq'
   aarch64-linux-ld: drivers/irqchip/irq-imx-mu-msi.o: in function `imx_mu_msi_mask_irq':
>> drivers/irqchip/irq-imx-mu-msi.c:120: undefined reference to `pci_msi_mask_irq'


vim +128 drivers/irqchip/irq-imx-mu-msi.c

   115	
   116	static void imx_mu_msi_mask_irq(struct irq_data *data)
   117	{
   118		struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
   119	
 > 120		pci_msi_mask_irq(data);
   121		imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
   122	}
   123	
   124	static void imx_mu_msi_unmask_irq(struct irq_data *data)
   125	{
   126		struct imx_mu_msi *msi_data = irq_data_get_irq_chip_data(data->parent_data);
   127	
 > 128		pci_msi_unmask_irq(data);
   129		imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq), 0);
   130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
