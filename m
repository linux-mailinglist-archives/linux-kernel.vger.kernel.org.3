Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2959BD96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiHVKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiHVKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:31:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF22F3B1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661164307; x=1692700307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9ex5t4ytfumm6Wsq9uJG78mnESKnj7rd8OGsNfvqKSQ=;
  b=DYx5yFP4f5S1+Y00BzxZChqdelMwz1dQ8TeerKxOQCuGVqiyKHCqfzbt
   tuke0N/JJPe5+c8uApvrVItNR8DAs/yrMY6znbmuHQZe1g7+B4y4F6cm7
   XM0mkidAotXJAwCINl4WjgDdXYi9M+DmnuX/+DBp9x+MG6F/WH1B5yPXE
   2+tWJ20BfgvlLnXxfd7bBW7/vqYSeyAqSUBu+MDAYhOORBEw2yeQ0cWH3
   besSmxW0alL53ld3ouBpdXY+Z1V0EtgcwDo9hkyhq8U3FZ0j69A69F1KW
   MTq1fx2hn0i4+hM2E0wVrIgcDlVOxc/MX0qV+VWm9U0HbKaCW11vRuv4m
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="273133309"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="273133309"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 03:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="698240197"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 03:31:45 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQ4ie-0005DE-2C;
        Mon, 22 Aug 2022 10:31:44 +0000
Date:   Mon, 22 Aug 2022 18:31:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/base/power/domain.c:2894:34: warning: unused variable
 'idle_state_match'
Message-ID: <202208221825.M4zoR8e6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
commit: 7d0221fb59125181a31ef3a561306c70fb238bc7 soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
date:   7 weeks ago
config: x86_64-buildonly-randconfig-r004-20220822 (https://download.01.org/0day-ci/archive/20220822/202208221825.M4zoR8e6-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d0221fb59125181a31ef3a561306c70fb238bc7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7d0221fb59125181a31ef3a561306c70fb238bc7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/base/power/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/base/power/domain.c:2894:34: warning: unused variable 'idle_state_match' [-Wunused-const-variable]
   static const struct of_device_id idle_state_match[] = {
                                    ^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [m]:
   - QCOM_RPMPD [=m] && QCOM_SMD_RPM [=y]


vim +/idle_state_match +2894 drivers/base/power/domain.c

5d6be70add65e3 Ulf Hansson 2018-06-29  2893  
30f604283e05d3 Lina Iyer   2016-10-14 @2894  static const struct of_device_id idle_state_match[] = {
598da548ef7892 Lina Iyer   2016-11-03  2895  	{ .compatible = "domain-idle-state", },
30f604283e05d3 Lina Iyer   2016-10-14  2896  	{ }
30f604283e05d3 Lina Iyer   2016-10-14  2897  };
30f604283e05d3 Lina Iyer   2016-10-14  2898  

:::::: The code at line 2894 was first introduced by commit
:::::: 30f604283e05d34cb10108c7ba017e5f4fc9d62c PM / Domains: Allow domain power states to be read from DT

:::::: TO: Lina Iyer <lina.iyer@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
