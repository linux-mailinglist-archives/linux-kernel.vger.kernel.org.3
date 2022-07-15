Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAD57670F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiGOTCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiGOTCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:02:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D4B735B7;
        Fri, 15 Jul 2022 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657911766; x=1689447766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGUUBxTZ8rX2/Jgg4FqVh+XRL0HS6zwE20FR9HNXvcc=;
  b=VZ7jGj8cI5Rt12xGFFLJKspaElTbLdhY+hreOdThEdyzmU1xS33HhHEG
   LFMB8rqXtxH17lybDzkPhXr9bx//+3M1DCFTEJZCumdi26yIQQKorHK45
   XkpMX2YpyfE3taw+V/pMyPq2TAA7h6iGXEQ4xZEE4G0rrIXPX0CkZJ9ZY
   gdrUpn+n3yVac/qc60DMmqoOlUj4kUF2vJwKwLmvaBSWshdko6BqRKnV1
   ydg9X0fXt1hz4EnqC6LhtpwTAxK50IPpPgre0DfCZTujC73O3+oRh1LYl
   zIan1fYKGjZpfblTxPosdNIPcjVVHuyU0hinl3mUuwGrwNoFc8lRft3qt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266290534"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="266290534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="738770495"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jul 2022 12:02:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCQaH-0000fQ-Vp;
        Fri, 15 Jul 2022 19:02:41 +0000
Date:   Sat, 16 Jul 2022 03:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kbuild-all@lists.01.org, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 3/6] soc: imx: add i.MX93 SRC power domain driver
Message-ID: <202207160211.szAgqVtl-lkp@intel.com>
References: <20220711062452.3575032-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711062452.3575032-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v5.19-rc6 next-20220715]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/imx-support-i-MX93-SRC-and-mediamix-blk-ctrl/20220711-142509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: nios2-randconfig-s042-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160211.szAgqVtl-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f4041693bcbc49608e02f34daad89d9ace678cfd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-support-i-MX93-SRC-and-mediamix-blk-ctrl/20220711-142509
        git checkout f4041693bcbc49608e02f34daad89d9ace678cfd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/iio/adc/ drivers/soc/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/soc/imx/imx93-pd.c:48:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:48:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:48:26: sparse:     got void *
>> drivers/soc/imx/imx93-pd.c:50:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:50:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:50:26: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:52:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:52:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:52:15: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:52:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:52:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:52:15: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:70:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:70:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:70:26: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:72:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:72:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:72:26: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:74:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:74:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:74:15: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:74:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:74:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:74:15: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:111:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] addr @@     got void [noderef] __iomem * @@
   drivers/soc/imx/imx93-pd.c:111:22: sparse:     expected void *[noderef] addr
   drivers/soc/imx/imx93-pd.c:111:22: sparse:     got void [noderef] __iomem *
   drivers/soc/imx/imx93-pd.c:125:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/soc/imx/imx93-pd.c:125:47: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/imx/imx93-pd.c:125:47: sparse:     got void *
   drivers/soc/imx/imx93-pd.c:38:31: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:48:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:48:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:50:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:50:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:52:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:52:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:52:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:52:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:65:31: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:70:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:70:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:72:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:72:21: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:74:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:74:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:74:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:74:15: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:112:20: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:112:20: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:113:32: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:113:32: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:125:34: sparse: sparse: dereference of noderef expression
   drivers/soc/imx/imx93-pd.c:125:34: sparse: sparse: dereference of noderef expression

vim +48 drivers/soc/imx/imx93-pd.c

    34	
    35	static int imx93_pd_on(struct generic_pm_domain *genpd)
    36	{
    37		struct imx93_power_domain *domain = to_imx93_pd(genpd);
    38		void * __iomem addr = domain->addr;
    39		u32 val;
    40		int ret;
    41	
    42		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
    43		if (ret) {
    44			dev_err(domain->dev, "failed to enable clocks for domain: %s\n", genpd->name);
    45			return ret;
    46		}
    47	
  > 48		val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
    49		val &= ~SLICE_SW_CTRL_PDN_SOFT_MASK;
  > 50		writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
    51	
    52		ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
    53					 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
    54		if (ret) {
    55			dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
    56			return ret;
    57		}
    58	
    59		return 0;
    60	}
    61	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
