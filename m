Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE404C1F67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiBWXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiBWXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:13:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FE49270
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645657973; x=1677193973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a5GGleKOcJsVMPluXQJYywZgYJPNzl5qwlwGoYupikY=;
  b=VU8G3K2BqP/AmVta6lhRgD8eQESKY3ABNYUZOA4Dk6oIqQYYxab8J8+w
   /vim8J54eWVDDAV38YtF5oThslEFVVZ3LZtNqhEe8+cgzVs8n54HlMpZ8
   J0RTL8FW7IIajDytTPSZZRIioe1s8MvO41ZBaHIc0bggR43DqYNoholbI
   31GxnLQiL8YK0v+kCXA1GCIEX8497NJbjxVwrJqlbLdfEGek/x+Rt1sGR
   X/GbwJTB5WM06g+gugBnMtGh+8o2DHqnRkjO8L+q2TtLGHygufyHshCh5
   hDNQ8xZB+ve1W+h/qTcv5BdFDZKQ/qOQRdvDcCkq6OqW6iv8Kztq5Bgmr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315330423"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315330423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:12:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="591882107"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2022 15:12:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN0oU-0001vn-W2; Wed, 23 Feb 2022 23:12:50 +0000
Date:   Thu, 24 Feb 2022 07:12:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: drivers/soc/tegra/fuse/fuse-tegra.c:188:20: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202202240701.z0513hxM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23d04328444a8fa0ca060c5e532220dac8e8bc26
commit: 88724b78a84c85350c21ac8d4432f2cf5a77a10a soc/tegra: fuse: Use resource-managed helpers
date:   10 weeks ago
config: arm64-randconfig-s031-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240701.z0513hxM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88724b78a84c85350c21ac8d4432f2cf5a77a10a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 88724b78a84c85350c21ac8d4432f2cf5a77a10a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/tegra/fuse/ kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/soc/tegra/fuse/fuse-tegra.c:188:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *base @@     got void *base @@
   drivers/soc/tegra/fuse/fuse-tegra.c:188:20: sparse:     expected void [noderef] __iomem *base
   drivers/soc/tegra/fuse/fuse-tegra.c:188:20: sparse:     got void *base
>> drivers/soc/tegra/fuse/fuse-tegra.c:198:63: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *base @@
   drivers/soc/tegra/fuse/fuse-tegra.c:198:63: sparse:     expected void *data
   drivers/soc/tegra/fuse/fuse-tegra.c:198:63: sparse:     got void [noderef] __iomem *base

vim +188 drivers/soc/tegra/fuse/fuse-tegra.c

   184	
   185	static void tegra_fuse_restore(void *base)
   186	{
   187		fuse->clk = NULL;
 > 188		fuse->base = base;
   189	}
   190	
   191	static int tegra_fuse_probe(struct platform_device *pdev)
   192	{
   193		void __iomem *base = fuse->base;
   194		struct nvmem_config nvmem;
   195		struct resource *res;
   196		int err;
   197	
 > 198		err = devm_add_action(&pdev->dev, tegra_fuse_restore, base);
   199		if (err)
   200			return err;
   201	
   202		/* take over the memory region from the early initialization */
   203		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   204		fuse->phys = res->start;
   205		fuse->base = devm_ioremap_resource(&pdev->dev, res);
   206		if (IS_ERR(fuse->base)) {
   207			err = PTR_ERR(fuse->base);
   208			return err;
   209		}
   210	
   211		fuse->clk = devm_clk_get(&pdev->dev, "fuse");
   212		if (IS_ERR(fuse->clk)) {
   213			if (PTR_ERR(fuse->clk) != -EPROBE_DEFER)
   214				dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
   215					PTR_ERR(fuse->clk));
   216	
   217			return PTR_ERR(fuse->clk);
   218		}
   219	
   220		platform_set_drvdata(pdev, fuse);
   221		fuse->dev = &pdev->dev;
   222	
   223		err = devm_pm_runtime_enable(&pdev->dev);
   224		if (err)
   225			return err;
   226	
   227		if (fuse->soc->probe) {
   228			err = fuse->soc->probe(fuse);
   229			if (err < 0)
   230				return err;
   231		}
   232	
   233		memset(&nvmem, 0, sizeof(nvmem));
   234		nvmem.dev = &pdev->dev;
   235		nvmem.name = "fuse";
   236		nvmem.id = -1;
   237		nvmem.owner = THIS_MODULE;
   238		nvmem.cells = tegra_fuse_cells;
   239		nvmem.ncells = ARRAY_SIZE(tegra_fuse_cells);
   240		nvmem.type = NVMEM_TYPE_OTP;
   241		nvmem.read_only = true;
   242		nvmem.root_only = true;
   243		nvmem.reg_read = tegra_fuse_read;
   244		nvmem.size = fuse->soc->info->size;
   245		nvmem.word_size = 4;
   246		nvmem.stride = 4;
   247		nvmem.priv = fuse;
   248	
   249		fuse->nvmem = devm_nvmem_register(&pdev->dev, &nvmem);
   250		if (IS_ERR(fuse->nvmem)) {
   251			err = PTR_ERR(fuse->nvmem);
   252			dev_err(&pdev->dev, "failed to register NVMEM device: %d\n",
   253				err);
   254			return err;
   255		}
   256	
   257		fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
   258		if (IS_ERR(fuse->rst)) {
   259			err = PTR_ERR(fuse->rst);
   260			dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
   261				fuse->rst);
   262			return err;
   263		}
   264	
   265		/*
   266		 * FUSE clock is enabled at a boot time, hence this resume/suspend
   267		 * disables the clock besides the h/w resetting.
   268		 */
   269		err = pm_runtime_resume_and_get(&pdev->dev);
   270		if (err)
   271			return err;
   272	
   273		err = reset_control_reset(fuse->rst);
   274		pm_runtime_put(&pdev->dev);
   275	
   276		if (err < 0) {
   277			dev_err(&pdev->dev, "failed to reset FUSE: %d\n", err);
   278			return err;
   279		}
   280	
   281		/* release the early I/O memory mapping */
   282		iounmap(base);
   283	
   284		return 0;
   285	}
   286	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
