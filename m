Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96A5A4635
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiH2Jhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2Jhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:37:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC35B055
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661765858; x=1693301858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BFtehnuFgv5fVu2/LkSmLdbdP0sndzL6Pbg/gWfp6/k=;
  b=a7YGZTz7FvgO5LnwlHi9u5Q8T8ZLu+Y6+qS0nf06bUd6u+ft1mL8/kBn
   NWn108zQBR8SU+0O9vWiVR6VsrjZKwbCxzYtEzTdI7LO0jhncNxGLsx94
   Vj5onIqz6LX83ZWva07A/Ch+LvsDxnrfDuhB08yxaNZ2vezAgvvjyGNKq
   DKtRrEXL+z0U8H76zlGpUO+bSc+uVvM04x7SL6+FrN/b5QeSA3LbLOFKq
   DjuvHLE/dpCsRCCrkeLjMGUG4jPifc5CY28WzRuhpXrK1cYYayz8hVD8e
   bGK+jOxqV7HNXsbOTB0NJ/c/k5QOqqdNglckUEUTy/j0AbjwrDeho6Z+V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="294863504"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="294863504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="588105399"
Received: from lkp-server01.sh.intel.com (HELO b2bbdd52f619) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 02:37:37 -0700
Received: from kbuild by b2bbdd52f619 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSbD6-0000U6-2L;
        Mon, 29 Aug 2022 09:37:36 +0000
Date:   Mon, 29 Aug 2022 17:37:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-6.0.0-rc3 124/167]
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c:867:27: error: conflicting types
 for 'qmp_phy_vreg_l'; have 'const char * const[]'
Message-ID: <202208291702.B1RMW8LP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux sc8280xp-6.0.0-rc3
head:   219615b30a2e783a7af7d39e20f9e0ce56ac082e
commit: 6dbf5b92242217b22325c932d2b34689147e7398 [124/167] phy: qcom-qmp-combo: Parameterize swing and pre_emphasis tables
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220829/202208291702.B1RMW8LP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/6dbf5b92242217b22325c932d2b34689147e7398
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-6.0.0-rc3
        git checkout 6dbf5b92242217b22325c932d2b34689147e7398
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the steev/sc8280xp-6.0.0-rc3 HEAD 219615b30a2e783a7af7d39e20f9e0ce56ac082e builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-qmp-combo.c:867:27: error: conflicting types for 'qmp_phy_vreg_l'; have 'const char * const[]'
     867 | static const char * const qmp_phy_vreg_l[] = {
         |                           ^~~~~~~~~~~~~~
   drivers/phy/qualcomm/phy-qcom-qmp-combo.c:616:34: note: previous definition of 'qmp_phy_vreg_l' with type 'struct qmp_regulator_data[2]'
     616 | static struct qmp_regulator_data qmp_phy_vreg_l[] = {
         |                                  ^~~~~~~~~~~~~~
   drivers/phy/qualcomm/phy-qcom-qmp-combo.c:616:34: warning: 'qmp_phy_vreg_l' defined but not used [-Wunused-variable]


vim +867 drivers/phy/qualcomm/phy-qcom-qmp-combo.c

94a407cc17a445 Dmitry Baryshkov 2022-06-08  865  
ac462f2fb30368 Johan Hovold     2022-07-20  866  /* list of regulators */
ac462f2fb30368 Johan Hovold     2022-07-20 @867  static const char * const qmp_phy_vreg_l[] = {
ac462f2fb30368 Johan Hovold     2022-07-20  868  	"vdda-phy", "vdda-pll",
ac462f2fb30368 Johan Hovold     2022-07-20  869  };
ac462f2fb30368 Johan Hovold     2022-07-20  870  

:::::: The code at line 867 was first introduced by commit
:::::: ac462f2fb30368fdeb826d0b229bee046c5b7bfb phy: qcom-qmp-combo: drop regulator loads

:::::: TO: Johan Hovold <johan+linaro@kernel.org>
:::::: CC: Steev Klimaszewski <steev@kali.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
