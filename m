Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35AD536BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiE1Idg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiE1Ide (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:33:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5861D321
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653726813; x=1685262813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O5Jf8AFkuLLjEnuW70tzraQr5gayQ0y+1vLYPyAtXYQ=;
  b=OyHVa/1z8hVBdmuv/4uN5bjZ59zKNOkmSup2BYQhmWFFQD3wlIWUI+Lf
   9RK0P9OCgulw+IDpMxiCHRCV2bbb5gIOlmKSKa9sQR5/uVFa+A2abJRl/
   smuSH6B0h3mO2oRbeJJqt5fqqKhP2zGtgZ+WQZsXrUpK/LpPAkG+cxjfA
   2RjDZjgc9rKI/N1g9t/qcy+hTKp2q6KhGFu62QgDkA5LBTv2LvTo8udLw
   eHi6kr4BLWKrv7twPGUyCsnL7Jb8FPJ2W8kZiKNmaSbriAmfJwletXisk
   8wdc2Kh3METqUSL41N3tywcxnU/b9OpyR+RXrfpBhTQe3dfwtyw5KuPeK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="335298513"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="335298513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 01:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="528529475"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2022 01:33:31 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nurt5-00002v-60;
        Sat, 28 May 2022 08:33:31 +0000
Date:   Sat, 28 May 2022 16:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kismet: WARNING: unmet direct dependencies detected for
 DRM_DP_AUX_BUS when selected by DRM_MSM
Message-ID: <202205281602.wAVTngoc-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: f5d01644921b7cba461fe1cde57d60a0e4ab3518 drm/msm: select DRM_DP_AUX_BUS for the AUX bus support
date:   4 weeks ago
config: (https://download.01.org/0day-ci/archive/20220528/202205281602.wAVTngoc-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5d01644921b7cba461fe1cde57d60a0e4ab3518
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f5d01644921b7cba461fe1cde57d60a0e4ab3518
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_DRM_DP_AUX_BUS --selectors CONFIG_DRM_MSM -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS when selected by DRM_MSM
   
   WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
     Selected by [y]:
     - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=n] || QCOM_LLCC [=n]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
