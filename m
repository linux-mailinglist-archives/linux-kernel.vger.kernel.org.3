Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20539569561
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiGFWhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiGFWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:37:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8092AE2B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657147049; x=1688683049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OlIELQZTjVc1Cisl+5bvJxCoDfJCjkTUKSSCkgDBSXM=;
  b=YIve9lKmcUXEG7k94gg+q5Jpq3EHnDEh2XNjo5CibH0UaCDEIMZ+PyBH
   oiXtyG65BaCB2Oy5+7MHJA3ednLAH6VhnbJNMkUx7FXNqpccpB28ZTnGQ
   fzJd/5xyLW1p0E07aWdqV9mTiEx+siRAjJJGJwVWq/MpF0pd9pOCchVSd
   3J9l65Atj0QmZADU7DqrQv97bvzzh3SNpYD3B5n85iC+3mmFp+ob5hKwz
   pv/kpIaPeQWmzwLW2/dVKY9MB3KDhdwQ8IJCQFtypdHPGfDA7hZhCCysv
   iyBbVNHerfay/7Cvh7HeBs+POfHJa/dkIohTwSTe2a7+3pbau64C+83xh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347867629"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="347867629"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 15:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="683094081"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2022 15:37:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9DeA-000L95-U1;
        Wed, 06 Jul 2022 22:37:26 +0000
Date:   Thu, 7 Jul 2022 06:36:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Vinod Koul <vkoul@kernel.org>, Kishon <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [phy:next 74/75] drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:2:
 error: use of undeclared identifier 'Return'
Message-ID: <202207070605.0xk0pmxE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git next
head:   fa384dd8b9b8dd3621b8f91c849386a4295d1b01
commit: 6bd9a9be5d732e7697804cba075f11a12dfa6bd3 [74/75] phy: qcom-qmp: add regulator_set_load to dp phy
config: riscv-buildonly-randconfig-r006-20220706 (https://download.01.org/0day-ci/archive/20220707/202207070605.0xk0pmxE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?id=6bd9a9be5d732e7697804cba075f11a12dfa6bd3
        git remote add phy https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
        git fetch --no-tags phy next
        git checkout 6bd9a9be5d732e7697804cba075f11a12dfa6bd3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/phy/qualcomm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:2004:2: error: use of undeclared identifier 'Return'
           Return 0;
           ^
   1 error generated.


vim +/Return +2004 drivers/phy/qualcomm/phy-qcom-qmp-combo.c

  1974	
  1975	static int qcom_qmp_phy_combo_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
  1976	{
  1977		struct qcom_qmp *qmp = dev_get_drvdata(dev);
  1978		int num = cfg->num_vregs;
  1979		int ret, i;
  1980	
  1981		qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
  1982		if (!qmp->vregs)
  1983			return -ENOMEM;
  1984	
  1985		for (i = 0; i < num; i++)
  1986			qmp->vregs[i].supply = cfg->vreg_list[i].name;
  1987	
  1988		ret = devm_regulator_bulk_get(dev, num, qmp->vregs);
  1989		if (ret) {
  1990			dev_err(dev, "failed at devm_regulator_bulk_get\n");
  1991			return ret;
  1992		}
  1993	
  1994		for (i = 0; i < num; i++) {
  1995			ret = regulator_set_load(qmp->vregs[i].consumer,
  1996						cfg->vreg_list[i].enable_load);
  1997			if (ret) {
  1998				dev_err(dev, "failed to set load at %s\n",
  1999					qmp->vregs[i].supply);
  2000				return ret;
  2001			}
  2002		}
  2003	
> 2004		Return 0;
  2005	}
  2006	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
