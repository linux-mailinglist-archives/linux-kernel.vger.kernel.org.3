Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5B53E1EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiFFIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiFFIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:40:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7334E62229
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654504814; x=1686040814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oOxeXtBgPlXpW8ROnnhWNqbTJmfs8awWagnML1OrpXo=;
  b=lDU73r9K/FazVxg37g91tZ2VnjjIQgP4B+Pm1c4fhXgMjT6ifYLu85Sa
   tPrq2qdHmbe5eRxZBpT8UOY1+k10c+ItxXoY0IXd8cfx+UFdluuQ2vnEI
   2yWqv6hDpU3KTRcgWRkcmIQIuV/uEO8r84JwkIim90xNKUH0mTArdKmsa
   8xhcGt+UIl36ZOZoQXPev1OEsCrR4T6MSfURjxWKM783cCQmYGvaa0xjX
   qMQkrdikdZmk5lyCHPfaqGoVCynsQzrSVf0i7j76c0+bcJcciwfNyMmS2
   ut/kd+jYv7BG2tBqmfTBT847OsA7PXcAu2GqAI0AnVV9V7La1r6hHRHC/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="258886197"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="258886197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 01:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="608592370"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2022 01:40:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny8HS-000CcX-VE;
        Mon, 06 Jun 2022 08:40:10 +0000
Date:   Mon, 6 Jun 2022 16:40:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jungo Lin <jungo.lin@mediatek.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 9034/9999] kismet: WARNING: unmet
 direct dependencies detected for MTK_SCP when selected by
 VIDEO_MEDIATEK_ISP_PASS1
Message-ID: <202206061624.sd15IDv3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 910bef3a45ed1e7f972f68e83327775901629aa7 [9034/9999] BACKPORT: FROMLIST: media: platform: Add Mediatek ISP P1 V4L2 device driver
config: (https://download.01.org/0day-ci/archive/20220606/202206061624.sd15IDv3-lkp@intel.com/config)
reproduce:
        # https://github.com/jsarha/linux/commit/910bef3a45ed1e7f972f68e83327775901629aa7
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 910bef3a45ed1e7f972f68e83327775901629aa7
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_MTK_SCP --selectors CONFIG_VIDEO_MEDIATEK_ISP_PASS1 -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MTK_SCP when selected by VIDEO_MEDIATEK_ISP_PASS1
   
   WARNING: unmet direct dependencies detected for MTK_SCP
     Depends on [n]: REMOTEPROC [=n] && ARCH_MEDIATEK [=n]
     Selected by [y]:
     - VIDEO_MEDIATEK_ISP_PASS1 [=y] && MEDIA_SUPPORT [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_V4L2 [=y] && VIDEO_V4L2_SUBDEV_API [=y] && (ARCH_MEDIATEK [=n] || COMPILE_TEST [=y])
   
   WARNING: unmet direct dependencies detected for SND_SOC_MAX98373
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
     Selected by [y]:
     - SND_SOC_INTEL_CNL_MAX98373_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && SND_SOC_INTEL_SKYLAKE [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
