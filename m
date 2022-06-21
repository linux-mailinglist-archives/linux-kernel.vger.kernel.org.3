Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495E553389
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351584AbiFUNYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351392AbiFUNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:23:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153803A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655817788; x=1687353788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hXdxY4k3GLgPK8wxt7Nh9sKg3ZkCs9LlCbHe/wIylRE=;
  b=hNKK38JDOZ+pL7DgATleFk1k+PwRcFLq6ULafDUcT671NPT3FlX+JbQe
   a55Z2BM8vMZBV4GsbDdSAm3ibnzU3vrhElaa25HLgxteaIaqo1aAc9drA
   MNnLG4yIUeHjlVO7VZiVP7khQoApj0Xx7cIRS09LrsuApsYQfW6i7B1bq
   MAd9SGSApqOpiFVBx5gh6TpN95cG3BsiPkYZRaEbZt9qTjJxFYtAo7+lY
   5qvMk5YUGk8fwGSyU8kWPfcwo2pnHMbzMmrCWjaC3QSTSyGP1kmdYw8B4
   Krdhb9TLnRa/iv0n3SJC8iLx5Y9HQY+Er7d6gLE/tYY6mtReSSSi9NZBj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263149546"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263149546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="676997892"
Received: from lkp-server02.sh.intel.com (HELO 08b4593be841) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2022 06:23:05 -0700
Received: from kbuild by 08b4593be841 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3dqS-00001b-JX;
        Tue, 21 Jun 2022 13:23:04 +0000
Date:   Tue, 21 Jun 2022 21:23:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8280xp-v5.19-rc1-crd 106/109]
 drivers/soc/qcom/pmic_glink.c:200:34: warning: 'pmic_glink_of_match' defined
 but not used
Message-ID: <202206212109.Z4xwgClc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8280xp-v5.19-rc1-crd
head:   17069f9e62fb6b18e277e387a0d5be8c79c286e2
commit: d43afb6ba553045e9fafd8abe6f60cb946c37c0f [106/109] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220621/202206212109.Z4xwgClc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/andersson/kernel/commit/d43afb6ba553045e9fafd8abe6f60cb946c37c0f
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8280xp-v5.19-rc1-crd
        git checkout d43afb6ba553045e9fafd8abe6f60cb946c37c0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/pmic_glink.c:200:34: warning: 'pmic_glink_of_match' defined but not used [-Wunused-const-variable=]
     200 | static const struct of_device_id pmic_glink_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/pmic_glink_of_match +200 drivers/soc/qcom/pmic_glink.c

   199	
 > 200	static const struct of_device_id pmic_glink_of_match[] = {
   201		{ .compatible = "qcom,pmic-glink", },
   202		{}
   203	};
   204	MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
   205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
