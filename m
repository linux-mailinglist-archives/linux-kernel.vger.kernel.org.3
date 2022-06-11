Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047E45473A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiFKKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiFKKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:12:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB2129
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654942332; x=1686478332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yLlNRyWYDSOiB+pqx3VF4dYuiscTI66rqaBv6NV7dlA=;
  b=TjvnL3W99oWE1iaQTYXR1t5u93xWo+tLJ2yuGa+bgVJE1Br83zVHG6Wq
   zPlBL2uE1K6SemrwMNlKuS5oDb1zwYDZCXzeIKr7LkHZQI1b/e9mAMVPP
   WO/tWInk4AkzC4C7P7z24ceRWllVa0kwyc1VgZ06i3slJchSSSHkDdNEd
   5ahWL7Eg7FGwMtxthKu+Sdvn53gua/9Wk99z/NDu2EVELEX57juUzOFvJ
   scDYoJpvNuFxCxRGNRbw7cNP9kQZIwGzkB1t4IXI/mg5gUWPsW+TqK8zQ
   Gf8LMXcXw4Wld0Dnftjpqh9TTzQUKCyyV3NO3dg4KeSBYkN8NAXck7YRz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278648009"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="278648009"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 03:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="616842624"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2022 03:12:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzy6E-000InH-06;
        Sat, 11 Jun 2022 10:12:10 +0000
Date:   Sat, 11 Jun 2022 18:11:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [mkp-scsi:for-next 31/41] drivers/phy/samsung/phy-fsd-ufs.c:50:10:
 error: 'const struct samsung_ufs_phy_drvdata' has no member named 'cfgs';
 did you mean 'cfg'?
Message-ID: <202206111808.SFb27UKr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   b9f50e3cfd13687279f2170ff6ef5d71f6c7db11
commit: f678ce49991950e4964cd82d3f3a8adfb63a9a70 [31/41] scsi: phy: samsung-ufs: Add support for FSD UFS PHY driver
config: alpha-randconfig-r032-20220611 (https://download.01.org/0day-ci/archive/20220611/202206111808.SFb27UKr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=f678ce49991950e4964cd82d3f3a8adfb63a9a70
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout f678ce49991950e4964cd82d3f3a8adfb63a9a70
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/phy/samsung/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/phy/samsung/phy-fsd-ufs.c:50:10: error: 'const struct samsung_ufs_phy_drvdata' has no member named 'cfgs'; did you mean 'cfg'?
      50 |         .cfgs = fsd_ufs_phy_cfgs,
         |          ^~~~
         |          cfg


vim +50 drivers/phy/samsung/phy-fsd-ufs.c

    48	
    49	const struct samsung_ufs_phy_drvdata fsd_ufs_phy = {
  > 50		.cfgs = fsd_ufs_phy_cfgs,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
