Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB1853BEC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiFBTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiFBTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:30:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F704A1AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654198245; x=1685734245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yeLBFSRfAiiQpPmARewcxOGVJkh1rWGnNFTfx9w3h7Q=;
  b=K39SRs0EfwHbu/5L4E7ayeQYMKh76n/DYpQUXC4WDenyhpajLt96QIJk
   HQPzTGiaUJLIqiweVImvJy+RVLPw47jfCHckIpJaHs7WjPJWm0IHFQjYT
   +St98WPXzvp6CDJxNu40SKOBy/0lV61HHGB61y/bLBsBZd26mAjqEyE30
   hM1S926dfF4CKtejBgUiKc52wSDwNzNxuASUrE757SMjfzmOPbAAIFFe1
   e83JqjyyTzRAQY8HxVjc5iS+M0Vh0EnHMb4j6c0gM/leU4foZDfTeOVJ9
   enUE2K+hRAPabRHu+XfgSHsenK4ERih6qa1CZD4OvkWrkyTyQQpKvFU/j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="263699569"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="263699569"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 12:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="668135905"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2022 12:30:41 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwqWm-0005Nj-DF;
        Thu, 02 Jun 2022 19:30:40 +0000
Date:   Fri, 3 Jun 2022 03:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Al Cooper <alcooperx@gmail.com>
Subject: [ulfh-mmc:devel 6/15] drivers/mmc/host/sdhci-brcmstb.c:302:6:
 warning: variable 'base_clk' is used uninitialized whenever 'if' condition
 is true
Message-ID: <202206030355.nu0lsR4i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git devel
head:   10980053142d8a3e86eb4d3014574424b42b7a45
commit: 2cecaac1b21c364bdf3639440bf59118ebeee86c [6/15] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
config: mips-bmips_stb_defconfig (https://download.01.org/0day-ci/archive/20220603/202206030355.nu0lsR4i-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?id=2cecaac1b21c364bdf3639440bf59118ebeee86c
        git remote add ulfh-mmc git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
        git fetch --no-tags ulfh-mmc devel
        git checkout 2cecaac1b21c364bdf3639440bf59118ebeee86c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-brcmstb.c:302:6: warning: variable 'base_clk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (res)
               ^~~
   drivers/mmc/host/sdhci-brcmstb.c:376:24: note: uninitialized use occurs here
           clk_disable_unprepare(base_clk);
                                 ^~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:302:2: note: remove the 'if' if its condition is always false
           if (res)
           ^~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:295:6: warning: variable 'base_clk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (IS_ERR(priv->cfg_regs)) {
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:376:24: note: uninitialized use occurs here
           clk_disable_unprepare(base_clk);
                                 ^~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:295:2: note: remove the 'if' if its condition is always false
           if (IS_ERR(priv->cfg_regs)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:280:6: warning: variable 'base_clk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (IS_ERR(host)) {
               ^~~~~~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:376:24: note: uninitialized use occurs here
           clk_disable_unprepare(base_clk);
                                 ^~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:280:2: note: remove the 'if' if its condition is always false
           if (IS_ERR(host)) {
           ^~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-brcmstb.c:259:22: note: initialize the variable 'base_clk' to silence this warning
           struct clk *base_clk;
                               ^
                                = NULL
   3 warnings generated.


vim +302 drivers/mmc/host/sdhci-brcmstb.c

d46ba2d17f9026 Al Cooper           2020-01-13  247  
476bf3d62d5cc0 Al Cooper           2016-06-16  248  static int sdhci_brcmstb_probe(struct platform_device *pdev)
476bf3d62d5cc0 Al Cooper           2016-06-16  249  {
78ab82fdb65c70 Al Cooper           2020-01-13  250  	const struct brcmstb_match_priv *match_priv;
d46ba2d17f9026 Al Cooper           2020-01-13  251  	struct sdhci_pltfm_data brcmstb_pdata;
476bf3d62d5cc0 Al Cooper           2016-06-16  252  	struct sdhci_pltfm_host *pltfm_host;
78ab82fdb65c70 Al Cooper           2020-01-13  253  	const struct of_device_id *match;
78ab82fdb65c70 Al Cooper           2020-01-13  254  	struct sdhci_brcmstb_priv *priv;
2cecaac1b21c36 Kamal Dasu          2022-05-20  255  	u32 actual_clock_mhz;
78ab82fdb65c70 Al Cooper           2020-01-13  256  	struct sdhci_host *host;
78ab82fdb65c70 Al Cooper           2020-01-13  257  	struct resource *iomem;
476bf3d62d5cc0 Al Cooper           2016-06-16  258  	struct clk *clk;
2cecaac1b21c36 Kamal Dasu          2022-05-20  259  	struct clk *base_clk;
476bf3d62d5cc0 Al Cooper           2016-06-16  260  	int res;
476bf3d62d5cc0 Al Cooper           2016-06-16  261  
78ab82fdb65c70 Al Cooper           2020-01-13  262  	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
78ab82fdb65c70 Al Cooper           2020-01-13  263  	match_priv = match->data;
78ab82fdb65c70 Al Cooper           2020-01-13  264  
d46ba2d17f9026 Al Cooper           2020-01-13  265  	dev_dbg(&pdev->dev, "Probe found match for %s\n",  match->compatible);
d46ba2d17f9026 Al Cooper           2020-01-13  266  
b41123f4f57df6 Krzysztof Kozlowski 2020-09-02  267  	clk = devm_clk_get_optional(&pdev->dev, NULL);
b41123f4f57df6 Krzysztof Kozlowski 2020-09-02  268  	if (IS_ERR(clk))
b41123f4f57df6 Krzysztof Kozlowski 2020-09-02  269  		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
b41123f4f57df6 Krzysztof Kozlowski 2020-09-02  270  				     "Failed to get clock from Device Tree\n");
b41123f4f57df6 Krzysztof Kozlowski 2020-09-02  271  
476bf3d62d5cc0 Al Cooper           2016-06-16  272  	res = clk_prepare_enable(clk);
476bf3d62d5cc0 Al Cooper           2016-06-16  273  	if (res)
476bf3d62d5cc0 Al Cooper           2016-06-16  274  		return res;
476bf3d62d5cc0 Al Cooper           2016-06-16  275  
d46ba2d17f9026 Al Cooper           2020-01-13  276  	memset(&brcmstb_pdata, 0, sizeof(brcmstb_pdata));
d46ba2d17f9026 Al Cooper           2020-01-13  277  	brcmstb_pdata.ops = match_priv->ops;
d46ba2d17f9026 Al Cooper           2020-01-13  278  	host = sdhci_pltfm_init(pdev, &brcmstb_pdata,
78ab82fdb65c70 Al Cooper           2020-01-13  279  				sizeof(struct sdhci_brcmstb_priv));
476bf3d62d5cc0 Al Cooper           2016-06-16  280  	if (IS_ERR(host)) {
476bf3d62d5cc0 Al Cooper           2016-06-16  281  		res = PTR_ERR(host);
476bf3d62d5cc0 Al Cooper           2016-06-16  282  		goto err_clk;
476bf3d62d5cc0 Al Cooper           2016-06-16  283  	}
476bf3d62d5cc0 Al Cooper           2016-06-16  284  
78ab82fdb65c70 Al Cooper           2020-01-13  285  	pltfm_host = sdhci_priv(host);
78ab82fdb65c70 Al Cooper           2020-01-13  286  	priv = sdhci_pltfm_priv(pltfm_host);
f3a70f991dd073 Al Cooper           2022-04-27  287  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
f3a70f991dd073 Al Cooper           2022-04-27  288  		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
f3a70f991dd073 Al Cooper           2022-04-27  289  		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
f3a70f991dd073 Al Cooper           2022-04-27  290  	}
78ab82fdb65c70 Al Cooper           2020-01-13  291  
78ab82fdb65c70 Al Cooper           2020-01-13  292  	/* Map in the non-standard CFG registers */
78ab82fdb65c70 Al Cooper           2020-01-13  293  	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
78ab82fdb65c70 Al Cooper           2020-01-13  294  	priv->cfg_regs = devm_ioremap_resource(&pdev->dev, iomem);
78ab82fdb65c70 Al Cooper           2020-01-13  295  	if (IS_ERR(priv->cfg_regs)) {
78ab82fdb65c70 Al Cooper           2020-01-13  296  		res = PTR_ERR(priv->cfg_regs);
78ab82fdb65c70 Al Cooper           2020-01-13  297  		goto err;
78ab82fdb65c70 Al Cooper           2020-01-13  298  	}
78ab82fdb65c70 Al Cooper           2020-01-13  299  
476bf3d62d5cc0 Al Cooper           2016-06-16  300  	sdhci_get_of_property(pdev);
1e20186e706da8 Stefan Wahren       2018-12-23  301  	res = mmc_of_parse(host->mmc);
1e20186e706da8 Stefan Wahren       2018-12-23 @302  	if (res)
1e20186e706da8 Stefan Wahren       2018-12-23  303  		goto err;
476bf3d62d5cc0 Al Cooper           2016-06-16  304  
6bcc55fe648b86 Al Cooper           2022-04-27  305  	/*
6bcc55fe648b86 Al Cooper           2022-04-27  306  	 * Automatic clock gating does not work for SD cards that may
6bcc55fe648b86 Al Cooper           2022-04-27  307  	 * voltage switch so only enable it for non-removable devices.
6bcc55fe648b86 Al Cooper           2022-04-27  308  	 */
6bcc55fe648b86 Al Cooper           2022-04-27  309  	if ((match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE) &&
6bcc55fe648b86 Al Cooper           2022-04-27  310  	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
6bcc55fe648b86 Al Cooper           2022-04-27  311  		priv->flags |= BRCMSTB_PRIV_FLAGS_GATE_CLOCK;
6bcc55fe648b86 Al Cooper           2022-04-27  312  
78ab82fdb65c70 Al Cooper           2020-01-13  313  	/*
78ab82fdb65c70 Al Cooper           2020-01-13  314  	 * If the chip has enhanced strobe and it's enabled, add
78ab82fdb65c70 Al Cooper           2020-01-13  315  	 * callback
78ab82fdb65c70 Al Cooper           2020-01-13  316  	 */
78ab82fdb65c70 Al Cooper           2020-01-13  317  	if (match_priv->hs400es &&
78ab82fdb65c70 Al Cooper           2020-01-13  318  	    (host->mmc->caps2 & MMC_CAP2_HS400_ES))
78ab82fdb65c70 Al Cooper           2020-01-13  319  		host->mmc_host_ops.hs400_enhanced_strobe = match_priv->hs400es;
78ab82fdb65c70 Al Cooper           2020-01-13  320  
476bf3d62d5cc0 Al Cooper           2016-06-16  321  	/*
476bf3d62d5cc0 Al Cooper           2016-06-16  322  	 * Supply the existing CAPS, but clear the UHS modes. This
476bf3d62d5cc0 Al Cooper           2016-06-16  323  	 * will allow these modes to be specified by device tree
476bf3d62d5cc0 Al Cooper           2016-06-16  324  	 * properties through mmc_of_parse().
476bf3d62d5cc0 Al Cooper           2016-06-16  325  	 */
476bf3d62d5cc0 Al Cooper           2016-06-16  326  	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
f3a70f991dd073 Al Cooper           2022-04-27  327  	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_NO_64BIT)
6a3d8ced09482b Jaedon Shin         2016-09-09  328  		host->caps &= ~SDHCI_CAN_64BIT;
476bf3d62d5cc0 Al Cooper           2016-06-16  329  	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
476bf3d62d5cc0 Al Cooper           2016-06-16  330  	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
476bf3d62d5cc0 Al Cooper           2016-06-16  331  			 SDHCI_SUPPORT_DDR50);
78ab82fdb65c70 Al Cooper           2020-01-13  332  	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
78ab82fdb65c70 Al Cooper           2020-01-13  333  
f3a70f991dd073 Al Cooper           2022-04-27  334  	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
78ab82fdb65c70 Al Cooper           2020-01-13  335  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
476bf3d62d5cc0 Al Cooper           2016-06-16  336  
2cecaac1b21c36 Kamal Dasu          2022-05-20  337  	/* Change the base clock frequency if the DT property exists */
2cecaac1b21c36 Kamal Dasu          2022-05-20  338  	if (device_property_read_u32(&pdev->dev, "clock-frequency",
2cecaac1b21c36 Kamal Dasu          2022-05-20  339  				     &priv->base_freq_hz) != 0)
2cecaac1b21c36 Kamal Dasu          2022-05-20  340  		goto add_host;
2cecaac1b21c36 Kamal Dasu          2022-05-20  341  
2cecaac1b21c36 Kamal Dasu          2022-05-20  342  	base_clk = devm_clk_get_optional(&pdev->dev, "sdio_freq");
2cecaac1b21c36 Kamal Dasu          2022-05-20  343  	if (IS_ERR(base_clk)) {
2cecaac1b21c36 Kamal Dasu          2022-05-20  344  		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
2cecaac1b21c36 Kamal Dasu          2022-05-20  345  		goto add_host;
2cecaac1b21c36 Kamal Dasu          2022-05-20  346  	}
2cecaac1b21c36 Kamal Dasu          2022-05-20  347  
2cecaac1b21c36 Kamal Dasu          2022-05-20  348  	res = clk_prepare_enable(base_clk);
2cecaac1b21c36 Kamal Dasu          2022-05-20  349  	if (res)
2cecaac1b21c36 Kamal Dasu          2022-05-20  350  		goto err;
2cecaac1b21c36 Kamal Dasu          2022-05-20  351  
2cecaac1b21c36 Kamal Dasu          2022-05-20  352  	/* set improved clock rate */
2cecaac1b21c36 Kamal Dasu          2022-05-20  353  	clk_set_rate(base_clk, priv->base_freq_hz);
2cecaac1b21c36 Kamal Dasu          2022-05-20  354  	actual_clock_mhz = clk_get_rate(base_clk) / 1000000;
2cecaac1b21c36 Kamal Dasu          2022-05-20  355  
2cecaac1b21c36 Kamal Dasu          2022-05-20  356  	host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
2cecaac1b21c36 Kamal Dasu          2022-05-20  357  	host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
2cecaac1b21c36 Kamal Dasu          2022-05-20  358  	/* Disable presets because they are now incorrect */
2cecaac1b21c36 Kamal Dasu          2022-05-20  359  	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
2cecaac1b21c36 Kamal Dasu          2022-05-20  360  
2cecaac1b21c36 Kamal Dasu          2022-05-20  361  	dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
2cecaac1b21c36 Kamal Dasu          2022-05-20  362  		actual_clock_mhz);
2cecaac1b21c36 Kamal Dasu          2022-05-20  363  	priv->base_clk = base_clk;
2cecaac1b21c36 Kamal Dasu          2022-05-20  364  
2cecaac1b21c36 Kamal Dasu          2022-05-20  365  add_host:
d46ba2d17f9026 Al Cooper           2020-01-13  366  	res = sdhci_brcmstb_add_host(host, priv);
476bf3d62d5cc0 Al Cooper           2016-06-16  367  	if (res)
476bf3d62d5cc0 Al Cooper           2016-06-16  368  		goto err;
476bf3d62d5cc0 Al Cooper           2016-06-16  369  
476bf3d62d5cc0 Al Cooper           2016-06-16  370  	pltfm_host->clk = clk;
476bf3d62d5cc0 Al Cooper           2016-06-16  371  	return res;
476bf3d62d5cc0 Al Cooper           2016-06-16  372  
476bf3d62d5cc0 Al Cooper           2016-06-16  373  err:
476bf3d62d5cc0 Al Cooper           2016-06-16  374  	sdhci_pltfm_free(pdev);
476bf3d62d5cc0 Al Cooper           2016-06-16  375  err_clk:
2cecaac1b21c36 Kamal Dasu          2022-05-20  376  	clk_disable_unprepare(base_clk);
476bf3d62d5cc0 Al Cooper           2016-06-16  377  	clk_disable_unprepare(clk);
476bf3d62d5cc0 Al Cooper           2016-06-16  378  	return res;
476bf3d62d5cc0 Al Cooper           2016-06-16  379  }
476bf3d62d5cc0 Al Cooper           2016-06-16  380  

:::::: The code at line 302 was first introduced by commit
:::::: 1e20186e706da8446f9435f2924cd65ab1397e73 mmc: sdhci-brcmstb: handle mmc_of_parse() errors during probe

:::::: TO: Stefan Wahren <stefan.wahren@i2se.com>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
