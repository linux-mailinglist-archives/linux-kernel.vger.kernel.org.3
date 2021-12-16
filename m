Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7ED47674B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhLPBLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:11:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:59278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhLPBL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639617089; x=1671153089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHEPCO6LZ+V6R2BwHMsCMN+KhkwkGiY/Ym87AnS93nk=;
  b=kITuYToJU+X80/PMUVFawbwTQqHer4Cco3E29FSHloT0081L5WH+XsHi
   Fsnbi9PaTIDQypBZhoh2zNaTPAMWOBbdb47Oe2LHmuPiEsvu4gFohke3U
   tmfeznKlGe7CNNzOOidyj+5oj+yomv03aItEbxOhhjc+nS7VSAR7kfVag
   TZRfH+vDeRyXBljWESeb+dFbhYosV7LOLly+AKnEA/sIumq5kPxRvYfcd
   xBsVXBa/DjAOVSOphstievUI4Wgwwr0d+np0fnZyWeoETignrCYJBnr46
   uybE+b3AKp1xMeTVk7y+uJTg2NzDD4PWH24YFGIIzigm/WUs9ztd/QTyd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="263534742"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="263534742"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 17:11:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="465844064"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2021 17:11:26 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxfIr-0002YY-G8; Thu, 16 Dec 2021 01:11:25 +0000
Date:   Thu, 16 Dec 2021 09:10:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     kbuild-all@lists.01.org, Vincent Shih <vincent.sunplus@gmail.com>
Subject: Re: [PATCH v3 1/2] nvmem: Add driver for OCOTP in Sunplus SP7021
Message-ID: <202112160925.yTjMLuBB-lkp@intel.com>
References: <1639568148-22872-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639568148-22872-2-git-send-email-vincent.sunplus@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linux/master linus/master v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vincent-Shih/Add-driver-for-OCOTP-in-Sunplus-SP7021/20211215-193707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211216/202112160925.yTjMLuBB-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c0a3142f164bb92fe79eafeb333050e7fcf42560
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vincent-Shih/Add-driver-for-OCOTP-in-Sunplus-SP7021/20211215-193707
        git checkout c0a3142f164bb92fe79eafeb333050e7fcf42560
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvmem/sunplus-ocotp.c: In function 'sp_ocotp_probe':
>> drivers/nvmem/sunplus-ocotp.c:158:37: warning: variable 'otp_data' set but not used [-Wunused-but-set-variable]
     158 |         const struct sp_ocotp_data *otp_data;
         |                                     ^~~~~~~~


vim +/otp_data +158 drivers/nvmem/sunplus-ocotp.c

   154	
   155	static int sp_ocotp_probe(struct platform_device *pdev)
   156	{
   157		const struct of_device_id *match;
 > 158		const struct sp_ocotp_data *otp_data;
   159		struct device *dev = &pdev->dev;
   160		struct nvmem_device *nvmem;
   161		struct sp_ocotp_priv *otp;
   162		struct resource *res;
   163		int ret;
   164	
   165		match = of_match_device(dev->driver->of_match_table, dev);
   166		if (match && match->data)
   167			otp_data = match->data;
   168	
   169		otp = devm_kzalloc(dev, sizeof(*otp), GFP_KERNEL);
   170		if (!otp)
   171			return -ENOMEM;
   172	
   173		otp->dev = dev;
   174	
   175		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hb_gpio");
   176		otp->base[HB_GPIO] = devm_ioremap_resource(dev, res);
   177		if (IS_ERR(otp->base[HB_GPIO]))
   178			return PTR_ERR(otp->base[HB_GPIO]);
   179	
   180		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otprx");
   181		otp->base[OTPRX] = devm_ioremap_resource(dev, res);
   182		if (IS_ERR(otp->base[OTPRX]))
   183			return PTR_ERR(otp->base[OTPRX]);
   184	
   185		otp->clk = devm_clk_get(&pdev->dev, NULL);
   186		if (IS_ERR(otp->clk))
   187			return dev_err_probe(&pdev->dev, PTR_ERR(otp->clk),
   188							"devm_clk_get fail\n");
   189	
   190		ret = clk_prepare(otp->clk);
   191		if (ret < 0) {
   192			dev_err(dev, "failed to prepare clk: %d\n", ret);
   193			return ret;
   194		}
   195	
   196		sp_ocotp_nvmem_config.priv = otp;
   197		sp_ocotp_nvmem_config.dev = dev;
   198	
   199		nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
   200		if (IS_ERR(nvmem))
   201			return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
   202							"register nvmem device fail\n");
   203	
   204		platform_set_drvdata(pdev, nvmem);
   205	
   206		dev_dbg(dev, "banks:%d x wpb:%d x wsize:%d = %d",
   207			QAC628_OTP_NUM_BANKS, OTP_WORDS_PER_BANK,
   208			OTP_WORD_SIZE, QAC628_OTP_SIZE);
   209	
   210		dev_info(dev, "by Sunplus (C) 2020");
   211	
   212		return 0;
   213	}
   214	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
