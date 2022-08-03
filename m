Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF94588501
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiHCADp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHCADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:03:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5821583D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659485022; x=1691021022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o0z94kAoqBM+CRZq9Y2LsYPmhbXzoccpdh/BoOa+kHY=;
  b=eq/XXPtuc4L0uzc/WHqWrdlunQ0WAz5mHw3d54ijhBSH4ciB+r7ABKGw
   hDfwluZwPwpQamlW0EZfrDjPkBIV+blRm0ccd/UK9IuApLS8NejvGcvXW
   zWox7CRW778tAjD594Rwmf+xsuighmjzN0OPVa9GfZYvMSf5G7n/8I6EW
   +veim2ezUrB21zjStahFUm8sEhi1RXNM2KOuZsiXat4mWTB70pnYmD8Ul
   LdvpurLORlwFO/ZPuWS0pvCCfMIEqq9rLchzQAS0e312ZPTwYBjFu1cRi
   EOxuNePLWTBLcJ0qTs4D1U9gDixCF4n2qVjETeIyECqVj0GQW7wezu3qA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351259436"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="351259436"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="930173602"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 17:03:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ1rO-000GaB-27;
        Wed, 03 Aug 2022 00:03:38 +0000
Date:   Wed, 3 Aug 2022 08:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [steev:linux-v5.19.0 69/198] phy-qcom-qmp.c:undefined reference to
 `typec_switch_get_drvdata'
Message-ID: <202208030838.6SUlaoIo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0
head:   a4510d0cef54eda304739679db13f1f17abe4125
commit: 52c2355f918241ce43caf2fbceb8aff380038507 [69/198] phy: qcom-qmp: Register as a typec switch for orientation detection
config: csky-randconfig-r002-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030838.6SUlaoIo-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/52c2355f918241ce43caf2fbceb8aff380038507
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0
        git checkout 52c2355f918241ce43caf2fbceb8aff380038507
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_typec_switch_set':
>> phy-qcom-qmp.c:(.text+0x52a): undefined reference to `typec_switch_get_drvdata'
>> csky-linux-ld: phy-qcom-qmp.c:(.text+0x568): undefined reference to `typec_switch_get_drvdata'
   csky-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_probe':
>> phy-qcom-qmp.c:(.text+0xeb4): undefined reference to `typec_switch_register'
>> csky-linux-ld: phy-qcom-qmp.c:(.text+0xf7c): undefined reference to `typec_switch_register'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
