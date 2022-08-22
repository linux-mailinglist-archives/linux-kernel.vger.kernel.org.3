Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E859BD85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiHVKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiHVKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:21:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BE2A72C;
        Mon, 22 Aug 2022 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661163708; x=1692699708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iS2KabOwGx1pGkjnF3Mooe8NyNxyaR8bIWE1W2q8zfA=;
  b=NHrcF9XVJxRDXYbxL2gdYhZDn9wNkbrF46CxWqygexCPXuijq/kTl5Tb
   1iWnUU8Scu+oZEOUk0s/ATwZn56PpVCjRLzdDmGuN+oIrb8j9SEsVCa6r
   lQFvpMuLKpwQ8byQXOzGpOYn2ucE/O/A1fNxquUCh9v13ywmsL2s1BOs4
   +1AemVmAW+bO/Q96FfC6pDtfn0kjMeSDTqqBSR1JkAufz7Gh1hCVsW9E5
   nJfK+f73QuhMXwApbB4Gl7wFAgebRcWfhD4wJC6RiccbPnvR+Z5x/OeVx
   /dv+zzednNbXsiXOoosiWCKrRNcfXArqNG0l2mTHH+hHgwF6WL7c/1I10
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="276406120"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="276406120"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 03:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="641978995"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2022 03:21:44 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ4Yy-0005Cd-0s;
        Mon, 22 Aug 2022 10:21:44 +0000
Date:   Mon, 22 Aug 2022 18:21:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V7 4/6] soc: imx: add i.MX93 media blk ctrl driver
Message-ID: <202208221843.9zfKWQu1-lkp@intel.com>
References: <20220822083106.156914-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822083106.156914-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master v6.0-rc2 next-20220822]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/imx-support-i-MX93-SRC-and-mediamix-blk-ctrl/20220822-163300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220822/202208221843.9zfKWQu1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7b6c02f1e51855f1a4b862f3b638721cd64077d4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-support-i-MX93-SRC-and-mediamix-blk-ctrl/20220822-163300
        git checkout 7b6c02f1e51855f1a4b862f3b638721cd64077d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/imx/imx93-blk-ctrl.c: In function 'imx93_blk_ctrl_probe':
>> drivers/soc/imx/imx93-blk-ctrl.c:214:35: error: 'SZ_4K' undeclared (first use in this function)
     214 |                 .max_register   = SZ_4K,
         |                                   ^~~~~
   drivers/soc/imx/imx93-blk-ctrl.c:214:35: note: each undeclared identifier is reported only once for each function it appears in


vim +/SZ_4K +214 drivers/soc/imx/imx93-blk-ctrl.c

   198	
   199	static int imx93_blk_ctrl_probe(struct platform_device *pdev)
   200	{
   201		struct device *dev = &pdev->dev;
   202		const struct imx93_blk_ctrl_data *bc_data = of_device_get_match_data(dev);
   203		const struct imx93_blk_ctrl_domain_data *bus = bc_data->bus;
   204		struct imx93_blk_ctrl *bc;
   205		void __iomem *base;
   206		int i, ret;
   207	
   208		struct regmap_config regmap_config = {
   209			.reg_bits	= 32,
   210			.val_bits	= 32,
   211			.reg_stride	= 4,
   212			.rd_table	= bus->reg_access_table,
   213			.wr_table	= bus->reg_access_table,
 > 214			.max_register   = SZ_4K,
   215		};
   216	
   217		bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
   218		if (!bc)
   219			return -ENOMEM;
   220	
   221		bc->dev = dev;
   222	
   223		base = devm_platform_ioremap_resource(pdev, 0);
   224		if (IS_ERR(base))
   225			return PTR_ERR(base);
   226	
   227		bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
   228		if (IS_ERR(bc->regmap))
   229			return dev_err_probe(dev, PTR_ERR(bc->regmap),
   230					     "failed to init regmap\n");
   231	
   232		bc->domains = devm_kcalloc(dev, bc_data->num_domains + 1,
   233					   sizeof(struct imx93_blk_ctrl_domain),
   234					   GFP_KERNEL);
   235		if (!bc->domains)
   236			return -ENOMEM;
   237	
   238		bc->onecell_data.num_domains = bc_data->num_domains;
   239		bc->onecell_data.xlate = imx93_blk_ctrl_xlate;
   240		bc->onecell_data.domains =
   241			devm_kcalloc(dev, bc_data->num_domains,
   242				     sizeof(struct generic_pm_domain *), GFP_KERNEL);
   243		if (!bc->onecell_data.domains)
   244			return -ENOMEM;
   245	
   246		for (i = 0; i < bus->num_clks; i++)
   247			bc->clks[i].id = bus->clk_names[i];
   248		bc->num_clks = bus->num_clks;
   249	
   250		ret = devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
   251		if (ret) {
   252			dev_err_probe(dev, ret, "failed to get bus clock\n");
   253			return ret;
   254		}
   255	
   256		for (i = 0; i < bc_data->num_domains; i++) {
   257			const struct imx93_blk_ctrl_domain_data *data = &bc_data->domains[i];
   258			struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
   259			int j;
   260	
   261			domain->data = data;
   262	
   263			for (j = 0; j < data->num_clks; j++)
   264				domain->clks[j].id = data->clk_names[j];
   265	
   266			ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
   267			if (ret) {
   268				dev_err_probe(dev, ret, "failed to get clock\n");
   269				goto cleanup_pds;
   270			}
   271	
   272			domain->genpd.name = data->name;
   273			domain->genpd.power_on = imx93_blk_ctrl_power_on;
   274			domain->genpd.power_off = imx93_blk_ctrl_power_off;
   275			domain->bc = bc;
   276	
   277			ret = pm_genpd_init(&domain->genpd, NULL, true);
   278			if (ret) {
   279				dev_err_probe(dev, ret, "failed to init power domain\n");
   280				goto cleanup_pds;
   281			}
   282	
   283			bc->onecell_data.domains[i] = &domain->genpd;
   284		}
   285	
   286		pm_runtime_enable(dev);
   287	
   288		ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
   289		if (ret) {
   290			dev_err_probe(dev, ret, "failed to add power domain provider\n");
   291			goto cleanup_pds;
   292		}
   293	
   294		dev_set_drvdata(dev, bc);
   295	
   296		return 0;
   297	
   298	cleanup_pds:
   299		for (i--; i >= 0; i--)
   300			pm_genpd_remove(&bc->domains[i].genpd);
   301	
   302		return ret;
   303	}
   304	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
