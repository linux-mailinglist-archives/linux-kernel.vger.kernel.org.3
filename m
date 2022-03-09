Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952244D2893
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiCIFu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCIFuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:50:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F66C4B49
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646804996; x=1678340996;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zvQZ5nPQCTC5UYnCj2+lFrGh0evpkgZTD7/DaQxXUcs=;
  b=DZZQ4y4nCKK9lPMo/ZaDlUfUThUYHBOOk8G99iQWaIhKOoE6j2J3w9kF
   OD5YFMXVrKclq5Q738y98LOClIk7hG0W4tbcGxVNfR5BsifdDJM2Lcs7L
   mYpIek3pdT3HZ9QuBN39XH/sSA0D4twe2OeZwFHIEtaS37zxZlkrGmbyn
   cWoU7tL6mo2y2htyWMDB4Vvjqf4JsO8YA5PPElHY1hjM+AbBwa4GxGBPP
   h6Hmwt8nqjYpmQ57TWGHmNVM15u8FfoUGmr9hYB14dZNPcMgney/WWkBB
   echmY7mW/zX5yDhz43mQCMaedyDjCs8U/JfZzii119kxulb88cJvSdoBg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="235502718"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="235502718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 21:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="780976621"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2022 21:49:54 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRpCr-0002gL-UP; Wed, 09 Mar 2022 05:49:53 +0000
Date:   Wed, 9 Mar 2022 13:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:tuxsuite 29/42] drivers/soc/qcom/pmic_glink.c:200:34:
 warning: unused variable 'pmic_glink_of_match'
Message-ID: <202203091303.wDvLl30f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel tuxsuite
head:   d1c9502cfe160da3c09a0f379147f16d559e4ab7
commit: eb61d6c02e912eee3c26927b311b643f262b4036 [29/42] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
config: arm64-randconfig-r016-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091303.wDvLl30f-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/andersson/kernel/commit/eb61d6c02e912eee3c26927b311b643f262b4036
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson tuxsuite
        git checkout eb61d6c02e912eee3c26927b311b643f262b4036
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/pmic_glink.c:200:34: warning: unused variable 'pmic_glink_of_match' [-Wunused-const-variable]
   static const struct of_device_id pmic_glink_of_match[] = {
                                    ^
   1 warning generated.


vim +/pmic_glink_of_match +200 drivers/soc/qcom/pmic_glink.c

   199	
 > 200	static const struct of_device_id pmic_glink_of_match[] = {
   201		{ .compatible = "qcom,pmic-glink", },
   202		{}
   203	};
   204	MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
   205	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
