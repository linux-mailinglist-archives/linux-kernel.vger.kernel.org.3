Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26385503355
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiDPEwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiDPEwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:52:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2456423
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650084591; x=1681620591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ubdW1lDS6MmXgtOxA2pvpHJxONTdndhAc/y6sbhgw0=;
  b=UH09X8UeolKE1ZstAhqDUhyHH+XiPWnlnSU/OCRkrNzerKKXetB6tyfH
   WsX8dLrf6gd2qzYpaJ6uuZHwzwbGwWg3Ch0Yg9UHmDrqZL5X2+WV6ONuw
   vxLNrO+nhzyg0/ZX8J7n0Q+3Kz4qz1rKRh1Td0MK7DwMFi5FrMqrlbnSG
   BkGhp5+hdMMrQ9j1US4vqi0w6uQUjx0p7mIU9SYEI1eAVHGeVvLbkV4L2
   voO/X//a1D44ZDZbe9GrBDD0LHWBUHLenMbcSvLDAja1Zj5i+aRED7TMD
   xKpJ07x0pOPDs3Jq8njTvihz1MN51rvAoMtqXCNepRA8CSqhTATyRAWWa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="250565461"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="250565461"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 21:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="646276627"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2022 21:49:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfaNY-0002mg-KS;
        Sat, 16 Apr 2022 04:49:48 +0000
Date:   Sat, 16 Apr 2022 12:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     He Ying <heying24@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/4.9 7698/9999] warning: (ARCH_QCOM && ..)
 selects QCOM_SCM which has unmet direct dependencies ((ARM || ..) && ..)
Message-ID: <202204161210.5CD2EyYP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi He,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   f1812046b492a285de1821980904db86eac86e8f
commit: af0d8dadc1db6f05a3acf6151f98e822eee18b64 [7698/9999] firmware: qcom-scm: Fix QCOM_SCM configuration
config: arm-randconfig-r035-20220414 (https://download.01.org/0day-ci/archive/20220416/202204161210.5CD2EyYP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=af0d8dadc1db6f05a3acf6151f98e822eee18b64
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout af0d8dadc1db6f05a3acf6151f98e822eee18b64
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=arm distclean

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> warning: (ARCH_QCOM && DRM_MSM && QCOM_WCNSS_PIL && QCOM_PM) selects QCOM_SCM which has unmet direct dependencies ((ARM || ARM64) && HAVE_ARM_SMCCC)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
