Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50F958DD29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbiHIR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbiHIR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:27:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209FC255B7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660066032; x=1691602032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KbAmLrsPAMJeQZW4HtFLatkKOlP4VKEmMGPsMkdfRG0=;
  b=E0g2NFYjDuYKdXw45KLwoyNcJvgSEwBg0FZCDV2E/7EAo5mPtpjBx+YK
   s61cFe3GkqgDOBtth2FO1+Lnk7R0zTl0av3oE8ldjV/ztMmgfEpXY+lQm
   fMTQ90ivSVTnJqTOLe26Q+0bJ9TIFpwjtYTEs2nLFJ160I24BTHa2cTuX
   Lq0lzr752/qi4b18u1sgkJGWVeEyxpgfHD3r3g7sjsW9+0ccg23uc6dvo
   08cNFrCh3KJA4l0tozL9sMA6ZyTLc6VlUNbNniac0gU+LGvO5AW/lRilo
   OFY7ylsx3mmFy/fo9GMI8kGnzdrOuZuKrshCKQw2q7y3cEmOXEOXxDCqs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="316829624"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="316829624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 10:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="580886074"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 10:26:53 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLT0H-000N6b-0P;
        Tue, 09 Aug 2022 17:26:53 +0000
Date:   Wed, 10 Aug 2022 01:26:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202208100114.eOo1r59A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb555cb5b794f4e12a9897f3d46d5a72104cd4a7
commit: ec0e5549f3586d2cb99a05edd006d722ebad912c remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX
date:   10 months ago
config: arm64-randconfig-s041-20220808 (https://download.01.org/0day-ci/archive/20220810/202208100114.eOo1r59A-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec0e5549f3586d2cb99a05edd006d722ebad912c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ec0e5549f3586d2cb99a05edd006d722ebad912c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
   drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     expected void *va
   drivers/remoteproc/imx_dsp_rproc.c:602:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr
   drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *va @@     got void [noderef] __iomem *[assigned] cpu_addr @@
   drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     expected void *va
   drivers/remoteproc/imx_dsp_rproc.c:638:49: sparse:     got void [noderef] __iomem *[assigned] cpu_addr

vim +602 drivers/remoteproc/imx_dsp_rproc.c

   563	
   564	/**
   565	 * imx_dsp_rproc_add_carveout() - request mailbox channels
   566	 * @priv: private data pointer
   567	 *
   568	 * This function registers specified memory entry in @rproc carveouts list
   569	 * The carveouts can help to mapping the memory address for DSP.
   570	 */
   571	static int imx_dsp_rproc_add_carveout(struct imx_dsp_rproc *priv)
   572	{
   573		const struct imx_dsp_rproc_dcfg *dsp_dcfg = priv->dsp_dcfg;
   574		const struct imx_rproc_dcfg *dcfg = dsp_dcfg->dcfg;
   575		struct rproc *rproc = priv->rproc;
   576		struct device *dev = rproc->dev.parent;
   577		struct device_node *np = dev->of_node;
   578		struct of_phandle_iterator it;
   579		struct rproc_mem_entry *mem;
   580		struct reserved_mem *rmem;
   581		void __iomem *cpu_addr;
   582		int a;
   583		u64 da;
   584	
   585		/* Remap required addresses */
   586		for (a = 0; a < dcfg->att_size; a++) {
   587			const struct imx_rproc_att *att = &dcfg->att[a];
   588	
   589			if (!(att->flags & ATT_OWN))
   590				continue;
   591	
   592			if (imx_dsp_rproc_sys_to_da(priv, att->sa, att->size, &da))
   593				return -EINVAL;
   594	
   595			cpu_addr = devm_ioremap_wc(dev, att->sa, att->size);
   596			if (!cpu_addr) {
   597				dev_err(dev, "failed to map memory %p\n", &att->sa);
   598				return -ENOMEM;
   599			}
   600	
   601			/* Register memory region */
 > 602			mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)att->sa,
   603						   att->size, da, NULL, NULL, "dsp_mem");
   604	
   605			if (mem)
   606				rproc_coredump_add_segment(rproc, da, att->size);
   607			else
   608				return -ENOMEM;
   609	
   610			rproc_add_carveout(rproc, mem);
   611		}
   612	
   613		of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
   614		while (of_phandle_iterator_next(&it) == 0) {
   615			/*
   616			 * Ignore the first memory region which will be used vdev buffer.
   617			 * No need to do extra handlings, rproc_add_virtio_dev will handle it.
   618			 */
   619			if (!strcmp(it.node->name, "vdev0buffer"))
   620				continue;
   621	
   622			rmem = of_reserved_mem_lookup(it.node);
   623			if (!rmem) {
   624				dev_err(dev, "unable to acquire memory-region\n");
   625				return -EINVAL;
   626			}
   627	
   628			if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da))
   629				return -EINVAL;
   630	
   631			cpu_addr = devm_ioremap_wc(dev, rmem->base, rmem->size);
   632			if (!cpu_addr) {
   633				dev_err(dev, "failed to map memory %p\n", &rmem->base);
   634				return -ENOMEM;
   635			}
   636	
   637			/* Register memory region */
   638			mem = rproc_mem_entry_init(dev, cpu_addr, (dma_addr_t)rmem->base,
   639						   rmem->size, da, NULL, NULL, it.node->name);
   640	
   641			if (mem)
   642				rproc_coredump_add_segment(rproc, da, rmem->size);
   643			else
   644				return -ENOMEM;
   645	
   646			rproc_add_carveout(rproc, mem);
   647		}
   648	
   649		return 0;
   650	}
   651	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
