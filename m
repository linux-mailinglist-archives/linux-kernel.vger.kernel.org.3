Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F7574ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiGNNPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiGNNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:15:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1744AD75
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657804521; x=1689340521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9JhJXGsNh3uS5zji9zMKU6HbNI2F6dZtUhXMVs0s8Co=;
  b=dxUsUyMcNAqvNSFLFFeCwtXHwLOZT7lyjSAOlNtCH/VLebRHPC2sxYPn
   ldVJW+AJfmmlnh3WlOpZN5lvnhghJ8R6jH15RBOTmsoMoq1PtAjJkfM93
   sEdWcQ+KM183aB5yhZaM9sQH6jnK+kLAwUbfZln/6jxtsqfoZgdQVwLqS
   9R2ksRvdugB9l3GAAZCwyImacEJp7fqOgo2l8vB83z0vuZ84qmO+aMub/
   vL4eQ6cKFtEXesS+NhvRTtWvxhNKpbk93i+g0aVKJSX9YdkaxK5ZIjzgJ
   IbPFeM2PZ8RmaGvLWwMPw/MxgsDU7wFJa8cPID9bDbym7w3puT6KZf7l6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285529634"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="285529634"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="628701335"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2022 06:15:19 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBygZ-0000h9-0t;
        Thu, 14 Jul 2022 13:15:19 +0000
Date:   Thu, 14 Jul 2022 21:14:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8280xp-next-20220708-incomplete 23/25]
 drivers/soc/qcom/pmic_glink.c:200:34: warning: 'pmic_glink_of_match' defined
 but not used
Message-ID: <202207142105.MZ2AEE5w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8280xp-next-20220708-incomplete
head:   49ce77f5c8eae56c32a9638a971b18ae1078a222
commit: 75703ed2e9bd3cfaa15461fba5fb0bc53cc0c1ea [23/25] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220714/202207142105.MZ2AEE5w-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/andersson/kernel/commit/75703ed2e9bd3cfaa15461fba5fb0bc53cc0c1ea
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8280xp-next-20220708-incomplete
        git checkout 75703ed2e9bd3cfaa15461fba5fb0bc53cc0c1ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/soc/qcom/

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
