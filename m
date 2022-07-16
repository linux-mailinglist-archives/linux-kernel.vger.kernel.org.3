Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D09576E8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGPO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:29:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E908411160
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657981757; x=1689517757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ArMyUK0om5E+XznwVtCh1MIkJjTsHayzf1pxzCAi5U=;
  b=LahCy5eK2E+FLReP417X7XmOsYVNJPLK83O1tw2xoyQE95nKVlmQXXUb
   5y1NGn5UVhywhN+gptZ4SJSWNpjWKFfr0PoHWAiM7M65q5FxRXPT4Dn7h
   3CXl5XSby0CdGnn3TXbYzDnkHhtl+YAkYFNfZnbDJsnLxiKTCTQ8hBsBu
   u4rcGfMqCAM5Zwh5X1NTT9+QDwv3eUZE9VH0rIsAPoFc8D4thObqWcoov
   oGeSMWw0pj5fQ5Dk3q8ITQudXODFTJgEyIimBlS3kW8b29aSyW+bX2OBb
   3ZgUpB4FQALpUhD0cAPjIEXZWD7O3qyzp9PesWa8Bs1TG0DloCGpNibiK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="283544923"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="283544923"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 07:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="546984166"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 07:29:16 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCinD-0001dA-Ft;
        Sat, 16 Jul 2022 14:29:15 +0000
Date:   Sat, 16 Jul 2022 22:29:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 16/18]
 drivers/soc/apple/dockchannel.c:225:25: sparse: sparse: cast removes address
 space '__iomem' of expression
Message-ID: <202207162221.jMZrbhSG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   2902ed1bd2d6ac439a835c53841122c7f3455a6c
commit: 6b3956f7b0e18f8280252c5e03f4773c361768cf [16/18] soc: apple: Add DockChannel driver
config: parisc-randconfig-s041-20220715 (https://download.01.org/0day-ci/archive/20220716/202207162221.jMZrbhSG-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/6b3956f7b0e18f8280252c5e03f4773c361768cf
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 6b3956f7b0e18f8280252c5e03f4773c361768cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc64 SHELL=/bin/bash drivers/bluetooth/ drivers/media/i2c/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ drivers/pci/ drivers/soc/apple/ kernel/trace/ security/apparmor/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/soc/apple/dockchannel.c:225:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/soc/apple/dockchannel.c:229:25: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +225 drivers/soc/apple/dockchannel.c

   211	
   212	struct dockchannel *dockchannel_init(struct platform_device *pdev)
   213	{
   214		struct device *dev = &pdev->dev;
   215		struct dockchannel *dockchannel;
   216		int ret;
   217	
   218		dockchannel = devm_kzalloc(dev, sizeof(*dockchannel), GFP_KERNEL);
   219		if (!dockchannel)
   220			return ERR_PTR(-ENOMEM);
   221	
   222		dockchannel->dev = dev;
   223		dockchannel->config_base = devm_platform_ioremap_resource_byname(pdev, "config");
   224		if (IS_ERR(dockchannel->config_base))
 > 225			return (void *)dockchannel->config_base;
   226	
   227		dockchannel->data_base = devm_platform_ioremap_resource_byname(pdev, "data");
   228		if (IS_ERR(dockchannel->data_base))
   229			return (void *)dockchannel->data_base;
   230	
   231		ret = of_property_read_u32(dev->of_node, "apple,fifo-size", &dockchannel->fifo_size);
   232		if (ret)
   233			return ERR_PTR(dev_err_probe(dev, ret, "Missing apple,fifo-size property"));
   234	
   235		init_completion(&dockchannel->tx_comp);
   236		init_completion(&dockchannel->rx_comp);
   237	
   238		dockchannel->tx_irq = platform_get_irq_byname(pdev, "tx");
   239		if (dockchannel->tx_irq <= 0) {
   240			return ERR_PTR(dev_err_probe(dev, dockchannel->tx_irq,
   241					     "Failed to get TX IRQ"));
   242		}
   243	
   244		dockchannel->rx_irq = platform_get_irq_byname(pdev, "rx");
   245		if (dockchannel->rx_irq <= 0) {
   246			return ERR_PTR(dev_err_probe(dev, dockchannel->rx_irq,
   247					     "Failed to get RX IRQ"));
   248		}
   249	
   250		ret = devm_request_irq(dev, dockchannel->tx_irq, dockchannel_tx_irq, IRQF_NO_AUTOEN,
   251				       "apple-dockchannel-tx", dockchannel);
   252		if (ret)
   253			return ERR_PTR(dev_err_probe(dev, ret, "Failed to request TX IRQ"));
   254	
   255		ret = devm_request_threaded_irq(dev, dockchannel->rx_irq, dockchannel_rx_irq,
   256						dockchannel_rx_irq_thread, IRQF_NO_AUTOEN,
   257						"apple-dockchannel-rx", dockchannel);
   258		if (ret)
   259			return ERR_PTR(dev_err_probe(dev, ret, "Failed to request RX IRQ"));
   260	
   261		return dockchannel;
   262	}
   263	EXPORT_SYMBOL(dockchannel_init);
   264	
   265	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
