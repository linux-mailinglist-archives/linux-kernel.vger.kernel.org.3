Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BA55D2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbiF1Cnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiF1Cml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:42:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB3E28E03
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656384020; x=1687920020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6prhAM7uyIz2y3DiMFC1o+cv5uOpyZoaoCenv7Rj18k=;
  b=Ne82lhZJaZzgQHDTgGhcp0V/Vk89Gyrk8qjvMaoKSwKmD1/X8D7e7p2w
   SAEwi8NPaSCIUB9azCJbx6KtjoYLSXr+p6lqEpNKvCUmZlZpM4Wk8BTva
   ff47yN/sBe53xqY3XaIptCuObw24mmvWtkG1BH9xtdUn5y972IYZXhVRL
   nEpwBpxdMzQlfml/8E2Dfs6ot3XDE0VMlGyQLb0dNJcl3tNft2CfF2p2K
   oIQdwyqWgIZK9w594EzRYfrb0fHL/HEJRcQodglBDLF/JdYcfBS1WYjwN
   /NKn4XbmJmMw9OPVEBtgtnv9p2cbawpEyyDr8VgVkOrFn5l8W1ssSaJ1a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280374793"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280374793"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 19:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594573569"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2022 19:40:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o619F-0009Pi-B4;
        Tue, 28 Jun 2022 02:40:17 +0000
Date:   Tue, 28 Jun 2022 10:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: [broadcom-stblinux:drivers/next 5/6]
 drivers/soc/bcm/bcm2835-power.c:635:31: error: 'struct bcm2835_pm' has no
 member named 'rpivid_asb'
Message-ID: <202206281021.SubdbYfn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/Broadcom/stblinux drivers/next
head:   c8a8778a2c38eb66d35008072177cddd7d80eeda
commit: d5eba4a03b1d2d6e2192fa9a03ccc2cfb5d9750e [5/6] soc: bcm: bcm2835-power: Add support for BCM2711's RPiVid ASB
config: riscv-randconfig-r024-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281021.SubdbYfn-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/Broadcom/stblinux/commit/d5eba4a03b1d2d6e2192fa9a03ccc2cfb5d9750e
        git remote add broadcom-stblinux https://github.com/Broadcom/stblinux
        git fetch --no-tags broadcom-stblinux drivers/next
        git checkout d5eba4a03b1d2d6e2192fa9a03ccc2cfb5d9750e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/soc/bcm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/bcm/bcm2835-power.c: In function 'bcm2835_power_probe':
>> drivers/soc/bcm/bcm2835-power.c:635:31: error: 'struct bcm2835_pm' has no member named 'rpivid_asb'
     635 |         power->rpivid_asb = pm->rpivid_asb;
         |                               ^~


vim +635 drivers/soc/bcm/bcm2835-power.c

   607	
   608	static int bcm2835_power_probe(struct platform_device *pdev)
   609	{
   610		struct bcm2835_pm *pm = dev_get_drvdata(pdev->dev.parent);
   611		struct device *dev = &pdev->dev;
   612		struct bcm2835_power *power;
   613		static const struct {
   614			int parent, child;
   615		} domain_deps[] = {
   616			{ BCM2835_POWER_DOMAIN_GRAFX, BCM2835_POWER_DOMAIN_GRAFX_V3D },
   617			{ BCM2835_POWER_DOMAIN_IMAGE, BCM2835_POWER_DOMAIN_IMAGE_PERI },
   618			{ BCM2835_POWER_DOMAIN_IMAGE, BCM2835_POWER_DOMAIN_IMAGE_H264 },
   619			{ BCM2835_POWER_DOMAIN_IMAGE, BCM2835_POWER_DOMAIN_IMAGE_ISP },
   620			{ BCM2835_POWER_DOMAIN_IMAGE_PERI, BCM2835_POWER_DOMAIN_USB },
   621			{ BCM2835_POWER_DOMAIN_IMAGE_PERI, BCM2835_POWER_DOMAIN_CAM0 },
   622			{ BCM2835_POWER_DOMAIN_IMAGE_PERI, BCM2835_POWER_DOMAIN_CAM1 },
   623		};
   624		int ret = 0, i;
   625		u32 id;
   626	
   627		power = devm_kzalloc(dev, sizeof(*power), GFP_KERNEL);
   628		if (!power)
   629			return -ENOMEM;
   630		platform_set_drvdata(pdev, power);
   631	
   632		power->dev = dev;
   633		power->base = pm->base;
   634		power->asb = pm->asb;
 > 635		power->rpivid_asb = pm->rpivid_asb;
   636	
   637		id = readl(power->asb + ASB_AXI_BRDG_ID);
   638		if (id != BCM2835_BRDG_ID /* "BRDG" */) {
   639			dev_err(dev, "ASB register ID returned 0x%08x\n", id);
   640			return -ENODEV;
   641		}
   642	
   643		if (power->rpivid_asb) {
   644			id = readl(power->rpivid_asb + ASB_AXI_BRDG_ID);
   645			if (id != BCM2835_BRDG_ID /* "BRDG" */) {
   646				dev_err(dev, "RPiVid ASB register ID returned 0x%08x\n",
   647					     id);
   648				return -ENODEV;
   649			}
   650		}
   651	
   652		power->pd_xlate.domains = devm_kcalloc(dev,
   653						       ARRAY_SIZE(power_domain_names),
   654						       sizeof(*power->pd_xlate.domains),
   655						       GFP_KERNEL);
   656		if (!power->pd_xlate.domains)
   657			return -ENOMEM;
   658	
   659		power->pd_xlate.num_domains = ARRAY_SIZE(power_domain_names);
   660	
   661		for (i = 0; i < ARRAY_SIZE(power_domain_names); i++) {
   662			ret = bcm2835_init_power_domain(power, i, power_domain_names[i]);
   663			if (ret)
   664				goto fail;
   665		}
   666	
   667		for (i = 0; i < ARRAY_SIZE(domain_deps); i++) {
   668			pm_genpd_add_subdomain(&power->domains[domain_deps[i].parent].base,
   669					       &power->domains[domain_deps[i].child].base);
   670		}
   671	
   672		power->reset.owner = THIS_MODULE;
   673		power->reset.nr_resets = BCM2835_RESET_COUNT;
   674		power->reset.ops = &bcm2835_reset_ops;
   675		power->reset.of_node = dev->parent->of_node;
   676	
   677		ret = devm_reset_controller_register(dev, &power->reset);
   678		if (ret)
   679			goto fail;
   680	
   681		of_genpd_add_provider_onecell(dev->parent->of_node, &power->pd_xlate);
   682	
   683		dev_info(dev, "Broadcom BCM2835 power domains driver");
   684		return 0;
   685	
   686	fail:
   687		for (i = 0; i < ARRAY_SIZE(power_domain_names); i++) {
   688			struct generic_pm_domain *dom = &power->domains[i].base;
   689	
   690			if (dom->name)
   691				pm_genpd_remove(dom);
   692		}
   693		return ret;
   694	}
   695	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
