Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A474C1F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiBWWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiBWWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:52:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2535864
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645656712; x=1677192712;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9UChX+Z6I3uebtKSdtS/c4QDANq5pg7hMaISFlrV910=;
  b=GEwpFW2eS8dk65RxMjfa2Uq56pkYcJnkO1zHmDmrwGpqOjF+N2ypxWVV
   H8e+keBLeDl3DSKJP8DiFTNJFYX3/haBWSjlDFghbAt6vL5b9voYXcu+m
   dWWaYy0JFb2JYt0vJ47DSWMtc4j/iyr4oEWFXFmBjGVSwhL+e1P43eM4j
   BdILsE1MBkyNnVElfxW0AuJ0HAnvk289SmtyFdfBd6W01f3CvDDkUakR0
   s5DjR6F92s0M9Y9u5jLXWfFj+ONJq+9fj73EEAGbTjXeJU4sSWpeOgS5B
   ovV6NGfTv0+b+RghPFtfwPRoO7ByxaEEdqXDkhSdzJX0C9EZj5sDIf0ob
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276722529"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="276722529"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548475186"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 14:51:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN0UA-0001uP-GF; Wed, 23 Feb 2022 22:51:50 +0000
Date:   Thu, 24 Feb 2022 06:51:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [thierryreding:for-5.18/work 143/143]
 drivers/iommu/tegra-smmu.c:906:38: error: 'struct tegra_smmu' has no member
 named 'parent'
Message-ID: <202202240656.fYdbh6e7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.18/work
head:   1cdb7fffbcf8f949410bfa97c8cca5acc0285a48
commit: 1cdb7fffbcf8f949410bfa97c8cca5acc0285a48 [143/143] WIP
config: arm64-buildonly-randconfig-r004-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240656.fYdbh6e7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/thierryreding/linux/commit/1cdb7fffbcf8f949410bfa97c8cca5acc0285a48
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.18/work
        git checkout 1cdb7fffbcf8f949410bfa97c8cca5acc0285a48
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iommu/ drivers/soc/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/iommu/tegra-smmu.c: In function 'tegra_smmu_probe_device':
>> drivers/iommu/tegra-smmu.c:906:38: error: 'struct tegra_smmu' has no member named 'parent'
     906 |                         parent = smmu->parent;
         |                                      ^~
>> drivers/iommu/tegra-smmu.c:914:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     914 |         if (!smmu)
         |         ^~
   drivers/iommu/tegra-smmu.c:918:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     918 |                 return ERR_PTR(-ENODEV);
         |                 ^~~~~~
   drivers/iommu/tegra-smmu.c: At top level:
>> drivers/iommu/tegra-smmu.c:921:9: error: expected identifier or '(' before 'return'
     921 |         return &smmu->iommu;
         |         ^~~~~~
>> drivers/iommu/tegra-smmu.c:922:1: error: expected identifier or '(' before '}' token
     922 | }
         | ^
--
>> make[4]: *** No rule to make target 'drivers/soc/tegra/dce.o', needed by 'drivers/soc/tegra/built-in.a'.
   make[4]: *** [scripts/Makefile.build:614: drivers/soc/tegra/cbb] Error 2
   make[4]: Target '__build' not remade because of errors.


vim +906 drivers/iommu/tegra-smmu.c

   885	
   886	static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
   887	{
   888		struct device_node *np = dev->of_node;
   889		struct tegra_smmu *smmu = NULL;
   890		struct device *parent = NULL;
   891		struct of_phandle_args args;
   892		unsigned int index = 0;
   893		int err;
   894	
   895		while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
   896						  &args) == 0) {
   897			smmu = tegra_smmu_find(args.np);
   898			if (smmu) {
   899				err = tegra_smmu_configure(smmu, dev, &args);
   900				if (err < 0) {
   901					put_device(smmu->dev);
   902					of_node_put(args.np);
   903					return ERR_PTR(err);
   904				}
   905	
 > 906				parent = smmu->parent;
   907			}
   908	
   909			of_node_put(args.np);
   910			index++;
   911		}
   912	
   913		smmu = dev_iommu_priv_get(dev);
 > 914		if (!smmu)
   915			if (parent)
   916				put_device(parent);
   917	
 > 918			return ERR_PTR(-ENODEV);
   919		}
   920	
 > 921		return &smmu->iommu;
 > 922	}
   923	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
