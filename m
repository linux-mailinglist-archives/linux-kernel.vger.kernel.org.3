Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97F54EDD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379218AbiFPXT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFPXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:19:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF662A1C;
        Thu, 16 Jun 2022 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655421564; x=1686957564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6pKhvbadUKiA+uhy9tcEuNOI31mATOPj0ZcUE4rcAU=;
  b=mIiKmSZZOevpDSfCOIHLo7hBmN1J+y+xbmp7+fGbW4nVJDR8B+VvpP7P
   Zsl/O4CwYgIvYKs58M70/phItksZeYym+iwfJLlA4L5R0d85XUUdfz2Ei
   nE0zIVOnD8+iH/BfdDttjMn/rosbC8pcB35QaZBva/yvFgSog+JcNJ4sh
   dBdhMk2FTWuU2YJhAD659cccSj8ZJ50zLP8eZxDsk8q/C4f4tXY7JffH3
   v7ykVrcL5guLOppEvNVFDhmhNNhKdg8qUlhgD7Mv3GWVZf26+JxeaJ5OW
   5QAyaVAC/Dz3LDwazl2qi8mjU74wSot5hsFLT72c5kmyok07BQZ45xQZz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278170687"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278170687"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 16:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="613340184"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2022 16:19:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1ylj-000Ort-05;
        Thu, 16 Jun 2022 23:19:19 +0000
Date:   Fri, 17 Jun 2022 07:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, festevam@gmail.com,
        linux-imx@nxp.com, laurent.pinchart@ideasonboard.com,
        paul.elder@ideasonboard.com, marex@denx.de, aford173@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Message-ID: <202206170720.eTetqCJ6-lkp@intel.com>
References: <20220616073953.2204978-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616073953.2204978-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on shawnguo/for-next linus/master v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/Add-interconnect-for-i-MX8MP-blk-ctrl/20220616-153932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: hexagon-randconfig-r045-20220616 (https://download.01.org/0day-ci/archive/20220617/202206170720.eTetqCJ6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/118c632adf7409c5a51e85fa0c61286665116b10
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/Add-interconnect-for-i-MX8MP-blk-ctrl/20220616-153932
        git checkout 118c632adf7409c5a51e85fa0c61286665116b10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/imx/imx8m-blk-ctrl.c:247:9: error: call to undeclared function 'devm_of_icc_bulk_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
                         ^
   1 error generated.


vim +/devm_of_icc_bulk_get +247 drivers/soc/imx/imx8m-blk-ctrl.c

   178	
   179	static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
   180	{
   181		const struct imx8m_blk_ctrl_data *bc_data;
   182		struct device *dev = &pdev->dev;
   183		struct imx8m_blk_ctrl *bc;
   184		void __iomem *base;
   185		int i, ret;
   186	
   187		struct regmap_config regmap_config = {
   188			.reg_bits	= 32,
   189			.val_bits	= 32,
   190			.reg_stride	= 4,
   191		};
   192	
   193		bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
   194		if (!bc)
   195			return -ENOMEM;
   196	
   197		bc->dev = dev;
   198	
   199		bc_data = of_device_get_match_data(dev);
   200	
   201		base = devm_platform_ioremap_resource(pdev, 0);
   202		if (IS_ERR(base))
   203			return PTR_ERR(base);
   204	
   205		regmap_config.max_register = bc_data->max_reg;
   206		bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
   207		if (IS_ERR(bc->regmap))
   208			return dev_err_probe(dev, PTR_ERR(bc->regmap),
   209					     "failed to init regmap\n");
   210	
   211		bc->domains = devm_kcalloc(dev, bc_data->num_domains,
   212					   sizeof(struct imx8m_blk_ctrl_domain),
   213					   GFP_KERNEL);
   214		if (!bc->domains)
   215			return -ENOMEM;
   216	
   217		bc->onecell_data.num_domains = bc_data->num_domains;
   218		bc->onecell_data.xlate = imx8m_blk_ctrl_xlate;
   219		bc->onecell_data.domains =
   220			devm_kcalloc(dev, bc_data->num_domains,
   221				     sizeof(struct generic_pm_domain *), GFP_KERNEL);
   222		if (!bc->onecell_data.domains)
   223			return -ENOMEM;
   224	
   225		bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
   226		if (IS_ERR(bc->bus_power_dev))
   227			return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
   228					     "failed to attach power domain\n");
   229	
   230		for (i = 0; i < bc_data->num_domains; i++) {
   231			const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
   232			struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
   233			int j;
   234	
   235			domain->data = data;
   236	
   237			for (j = 0; j < data->num_clks; j++)
   238				domain->clks[j].id = data->clk_names[j];
   239	
   240			for (j = 0; j < data->num_paths; j++) {
   241				domain->paths[j].name = data->path_names[j];
   242				/* Fake value for now, just let ICC could configure NoC mode/priority */
   243				domain->paths[j].avg_bw = 1;
   244				domain->paths[j].peak_bw = 1;
   245			}
   246	
 > 247			ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
   248			if (ret) {
   249				dev_err_probe(dev, ret, "failed to get noc entries\n");
   250				goto cleanup_pds;
   251			}
   252	
   253			ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
   254			if (ret) {
   255				dev_err_probe(dev, ret, "failed to get clock\n");
   256				goto cleanup_pds;
   257			}
   258	
   259			domain->power_dev =
   260				dev_pm_domain_attach_by_name(dev, data->gpc_name);
   261			if (IS_ERR(domain->power_dev)) {
   262				dev_err_probe(dev, PTR_ERR(domain->power_dev),
   263					      "failed to attach power domain\n");
   264				ret = PTR_ERR(domain->power_dev);
   265				goto cleanup_pds;
   266			}
   267			dev_set_name(domain->power_dev, "%s", data->name);
   268	
   269			domain->genpd.name = data->name;
   270			domain->genpd.power_on = imx8m_blk_ctrl_power_on;
   271			domain->genpd.power_off = imx8m_blk_ctrl_power_off;
   272			domain->bc = bc;
   273	
   274			ret = pm_genpd_init(&domain->genpd, NULL, true);
   275			if (ret) {
   276				dev_err_probe(dev, ret, "failed to init power domain\n");
   277				dev_pm_domain_detach(domain->power_dev, true);
   278				goto cleanup_pds;
   279			}
   280	
   281			/*
   282			 * We use runtime PM to trigger power on/off of the upstream GPC
   283			 * domain, as a strict hierarchical parent/child power domain
   284			 * setup doesn't allow us to meet the sequencing requirements.
   285			 * This means we have nested locking of genpd locks, without the
   286			 * nesting being visible at the genpd level, so we need a
   287			 * separate lock class to make lockdep aware of the fact that
   288			 * this are separate domain locks that can be nested without a
   289			 * self-deadlock.
   290			 */
   291			lockdep_set_class(&domain->genpd.mlock,
   292					  &blk_ctrl_genpd_lock_class);
   293	
   294			bc->onecell_data.domains[i] = &domain->genpd;
   295		}
   296	
   297		ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
   298		if (ret) {
   299			dev_err_probe(dev, ret, "failed to add power domain provider\n");
   300			goto cleanup_pds;
   301		}
   302	
   303		bc->power_nb.notifier_call = bc_data->power_notifier_fn;
   304		ret = dev_pm_genpd_add_notifier(bc->bus_power_dev, &bc->power_nb);
   305		if (ret) {
   306			dev_err_probe(dev, ret, "failed to add power notifier\n");
   307			goto cleanup_provider;
   308		}
   309	
   310		dev_set_drvdata(dev, bc);
   311	
   312		return 0;
   313	
   314	cleanup_provider:
   315		of_genpd_del_provider(dev->of_node);
   316	cleanup_pds:
   317		for (i--; i >= 0; i--) {
   318			pm_genpd_remove(&bc->domains[i].genpd);
   319			dev_pm_domain_detach(bc->domains[i].power_dev, true);
   320		}
   321	
   322		dev_pm_domain_detach(bc->bus_power_dev, true);
   323	
   324		return ret;
   325	}
   326	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
