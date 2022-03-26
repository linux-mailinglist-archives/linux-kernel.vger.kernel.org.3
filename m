Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAA4E80AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiCZL6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiCZL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:57:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14C12779
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648295776; x=1679831776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ivDKaobFn5wiKg1iHFaivVQBStZi+kKKXUIdxP8urZc=;
  b=Kp5DpiEYLfS3GHqC+OZRrvZKrdDQGMSXGj7Hc5zUwECw2EZDk4MhgF7n
   O+ZJ5S34JKHAiKw17FF26O1sFRcbR6SCTWlAPKPqMCs79MAioeoytNY/z
   R6LyXpUgYc3ZUbq3KHvItskeHgOpJHUntu4HW6fXWphXPxEIko/6gGIbx
   NYc0TcS/hJizm227fquqVLWNRW4YowWK1bkQ782hcYbmMxUpa7S5R7odj
   9gfunSwlv+qCbeUeoourHD4RMVQnOXouFStbMF1EkgbcLpYR5vlsu68xC
   +YULB2ql5mN/+S/s9NcNMTUZkYyALTvKh229QmMlKhfTsDtf+0tK7/X4D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283658695"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="283658695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 04:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="545384821"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2022 04:56:14 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY51i-000NLd-9x; Sat, 26 Mar 2022 11:56:14 +0000
Date:   Sat, 26 Mar 2022 19:55:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220301 6/27] phy-qcom-qmp.c:undefined
 reference to `typec_switch_get_drvdata'
Message-ID: <202203261950.GxOlPtmS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301
head:   0289eb1e5447f549241a40b2a0742a796467ecd8
commit: 2b468636da740585f10846641a44f7f8c1ce89c3 [6/27] phy: qcom-qmp: Register as a typec switch for orientation detection
config: arc-buildonly-randconfig-r002-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261950.GxOlPtmS-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/2b468636da740585f10846641a44f7f8c1ce89c3
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301
        git checkout 2b468636da740585f10846641a44f7f8c1ce89c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_typec_switch_set':
>> phy-qcom-qmp.c:(.text+0xf04): undefined reference to `typec_switch_get_drvdata'
>> arc-elf-ld: phy-qcom-qmp.c:(.text+0xf04): undefined reference to `typec_switch_get_drvdata'
   arc-elf-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_probe':
>> phy-qcom-qmp.c:(.text+0x188c): undefined reference to `typec_switch_register'
>> arc-elf-ld: phy-qcom-qmp.c:(.text+0x188c): undefined reference to `typec_switch_register'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
