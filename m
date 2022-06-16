Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2435954DF47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359777AbiFPKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFPKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:42:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA475DBD5;
        Thu, 16 Jun 2022 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655376120; x=1686912120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZOvbw99JvmDg4H99wsOmPD3+DITNMSCjWUsS1KotlXI=;
  b=O91SlD+nFZ03qOp9jqKMfrPRyJHAOK0t/OYkhJ5kjsFoj5WOVMJuu8HQ
   HoQSoxuyrDcpXs6PWg72i3mnh89xs2zo64ktBk3oTWfxkW0JNEDJCZeSD
   lR1ZSr+xl+jErpzD92DhGc3NN8VAkmbox9vmxIb3CezlZjAwwCZy/oTBv
   VbdquXhfvPucrtzMalFSmGEzLFhtDcVDophlbICVVei7+BrsPHNN+orYv
   jepNq6/n/RR07aZdRaf24SHml2xjYOh2yQvl6ayUtUkfGSQIhloOLvjtj
   RLoyVA8zNKDfQNZqYam57NvTkt4bsCFCrou2DZk9zaerhnwUAhNWN87Uu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262239693"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="262239693"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 03:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="559706072"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2022 03:40:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1mvn-000OIZ-Th;
        Thu, 16 Jun 2022 10:40:55 +0000
Date:   Thu, 16 Jun 2022 18:40:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kbuild-all@lists.01.org, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 5/8] soc: imx: add icc paths for i.MX8MP hsio/hdmi blk
 ctrl
Message-ID: <202206161809.ZDbwd4YD-lkp@intel.com>
References: <20220616073953.2204978-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616073953.2204978-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test ERROR on robh/for-next]
[also build test ERROR on shawnguo/for-next linus/master v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/Add-interconnect-for-i-MX8MP-blk-ctrl/20220616-153932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-randconfig-r043-20220616 (https://download.01.org/0day-ci/archive/20220616/202206161809.ZDbwd4YD-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/60034edb256677d3671a2409c83c8a0a2c11d101
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/Add-interconnect-for-i-MX8MP-blk-ctrl/20220616-153932
        git checkout 60034edb256677d3671a2409c83c8a0a2c11d101
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/soc/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/imx/imx8mp-blk-ctrl.c: In function 'imx8mp_blk_ctrl_probe':
>> drivers/soc/imx/imx8mp-blk-ctrl.c:539:23: error: implicit declaration of function 'devm_of_icc_bulk_get'; did you mean 'of_icc_bulk_get'? [-Werror=implicit-function-declaration]
     539 |                 ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
         |                       ^~~~~~~~~~~~~~~~~~~~
         |                       of_icc_bulk_get
   cc1: some warnings being treated as errors


vim +539 drivers/soc/imx/imx8mp-blk-ctrl.c

   466	
   467	static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
   468	{
   469		const struct imx8mp_blk_ctrl_data *bc_data;
   470		struct device *dev = &pdev->dev;
   471		struct imx8mp_blk_ctrl *bc;
   472		void __iomem *base;
   473		int num_domains, i, ret;
   474	
   475		struct regmap_config regmap_config = {
   476			.reg_bits	= 32,
   477			.val_bits	= 32,
   478			.reg_stride	= 4,
   479		};
   480	
   481		bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
   482		if (!bc)
   483			return -ENOMEM;
   484	
   485		bc->dev = dev;
   486	
   487		bc_data = of_device_get_match_data(dev);
   488		num_domains = bc_data->num_domains;
   489	
   490		base = devm_platform_ioremap_resource(pdev, 0);
   491		if (IS_ERR(base))
   492			return PTR_ERR(base);
   493	
   494		regmap_config.max_register = bc_data->max_reg;
   495		bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
   496		if (IS_ERR(bc->regmap))
   497			return dev_err_probe(dev, PTR_ERR(bc->regmap),
   498					     "failed to init regmap\n");
   499	
   500		bc->domains = devm_kcalloc(dev, num_domains,
   501					   sizeof(struct imx8mp_blk_ctrl_domain),
   502					   GFP_KERNEL);
   503		if (!bc->domains)
   504			return -ENOMEM;
   505	
   506		bc->onecell_data.num_domains = num_domains;
   507		bc->onecell_data.xlate = imx8m_blk_ctrl_xlate;
   508		bc->onecell_data.domains =
   509			devm_kcalloc(dev, num_domains,
   510				     sizeof(struct generic_pm_domain *), GFP_KERNEL);
   511		if (!bc->onecell_data.domains)
   512			return -ENOMEM;
   513	
   514		bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
   515		if (IS_ERR(bc->bus_power_dev))
   516			return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
   517					     "failed to attach bus power domain\n");
   518	
   519		bc->power_off = bc_data->power_off;
   520		bc->power_on = bc_data->power_on;
   521	
   522		for (i = 0; i < num_domains; i++) {
   523			const struct imx8mp_blk_ctrl_domain_data *data = &bc_data->domains[i];
   524			struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
   525			int j;
   526	
   527			domain->data = data;
   528	
   529			for (j = 0; j < data->num_clks; j++)
   530				domain->clks[j].id = data->clk_names[j];
   531	
   532			for (j = 0; j < data->num_paths; j++) {
   533				domain->paths[j].name = data->path_names[j];
   534				/* Fake value for now, just let ICC could configure NoC mode/priority */
   535				domain->paths[j].avg_bw = 1;
   536				domain->paths[j].peak_bw = 1;
   537			}
   538	
 > 539			ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
   540			if (ret) {
   541				dev_err_probe(dev, ret, "failed to get noc entries\n");
   542				goto cleanup_pds;
   543			}
   544	
   545	
   546			ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
   547			if (ret) {
   548				dev_err_probe(dev, ret, "failed to get clock\n");
   549				goto cleanup_pds;
   550			}
   551	
   552			domain->power_dev =
   553				dev_pm_domain_attach_by_name(dev, data->gpc_name);
   554			if (IS_ERR(domain->power_dev)) {
   555				dev_err_probe(dev, PTR_ERR(domain->power_dev),
   556					      "failed to attach power domain %s\n",
   557					      data->gpc_name);
   558				ret = PTR_ERR(domain->power_dev);
   559				goto cleanup_pds;
   560			}
   561			dev_set_name(domain->power_dev, "%s", data->name);
   562	
   563			domain->genpd.name = data->name;
   564			domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
   565			domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
   566			domain->bc = bc;
   567			domain->id = i;
   568	
   569			ret = pm_genpd_init(&domain->genpd, NULL, true);
   570			if (ret) {
   571				dev_err_probe(dev, ret, "failed to init power domain\n");
   572				dev_pm_domain_detach(domain->power_dev, true);
   573				goto cleanup_pds;
   574			}
   575	
   576			/*
   577			 * We use runtime PM to trigger power on/off of the upstream GPC
   578			 * domain, as a strict hierarchical parent/child power domain
   579			 * setup doesn't allow us to meet the sequencing requirements.
   580			 * This means we have nested locking of genpd locks, without the
   581			 * nesting being visible at the genpd level, so we need a
   582			 * separate lock class to make lockdep aware of the fact that
   583			 * this are separate domain locks that can be nested without a
   584			 * self-deadlock.
   585			 */
   586			lockdep_set_class(&domain->genpd.mlock,
   587					  &blk_ctrl_genpd_lock_class);
   588	
   589			bc->onecell_data.domains[i] = &domain->genpd;
   590		}
   591	
   592		ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
   593		if (ret) {
   594			dev_err_probe(dev, ret, "failed to add power domain provider\n");
   595			goto cleanup_pds;
   596		}
   597	
   598		bc->power_nb.notifier_call = bc_data->power_notifier_fn;
   599		ret = dev_pm_genpd_add_notifier(bc->bus_power_dev, &bc->power_nb);
   600		if (ret) {
   601			dev_err_probe(dev, ret, "failed to add power notifier\n");
   602			goto cleanup_provider;
   603		}
   604	
   605		dev_set_drvdata(dev, bc);
   606	
   607		return 0;
   608	
   609	cleanup_provider:
   610		of_genpd_del_provider(dev->of_node);
   611	cleanup_pds:
   612		for (i--; i >= 0; i--) {
   613			pm_genpd_remove(&bc->domains[i].genpd);
   614			dev_pm_domain_detach(bc->domains[i].power_dev, true);
   615		}
   616	
   617		dev_pm_domain_detach(bc->bus_power_dev, true);
   618	
   619		return ret;
   620	}
   621	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
