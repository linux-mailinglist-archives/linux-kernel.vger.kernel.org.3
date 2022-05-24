Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7D753234F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiEXGhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiEXGh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:37:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F2197284
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653374247; x=1684910247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CWIdFV7kd+q4a+RvZstYFwNN6bwBAfhOCJj1RrbERKQ=;
  b=W2KRew4INvZKyBwxf9TasRR/qtSKPg00T6W6LeGql1Rg4gmBXvnoH4JK
   2jBIAKhjRbTaBQjzJQRdfqGoCaBZLae/CexyNR680XlF6iexGsR9UxEix
   ioT58vmQHoJBCvGD2nCrxHVx6QLsVPkSGDN7r4pfgodtTH1xK4c0hDvC4
   xshlHCJD7LjNzoxWVig9kTxmv3caSR06oluVL4P+qTYVGQaXGdwJgU5hl
   fpUDT2LR1kLPEJupy66bIhCTp3Kt+5M/419+FybM4kRqFCOD1rBnEeSrM
   xuEio3ZlL8BmEwr9x5Uw9yJX4qe+iQkACOLAI5AraHOywshx+MCWD/3HW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273440388"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273440388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 23:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717046628"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2022 23:37:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntOAI-0001p8-Lw;
        Tue, 24 May 2022 06:37:10 +0000
Date:   Tue, 24 May 2022 14:36:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:hdmi-dbg 16/19] kismet: WARNING: unmet direct
 dependencies detected for COMMON_CLK_HIFIBERRY_DACPRO when selected by
 SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC
Message-ID: <202205241452.l7BgDioy-lkp@intel.com>
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

tree:   git://linuxtv.org/hverkuil/media_tree.git hdmi-dbg
head:   ee615790d156297c4b230eff7aabfd4865e2e6b9
commit: 46edebc1ac787bb2e7bdd1bfa4d69821cf32a291 [16/19] hifiberry_dacplusadc: add support for the Hifiberry DAC+ ADC
config: (https://download.01.org/0day-ci/archive/20220524/202205241452.l7BgDioy-lkp@intel.com/config)
reproduce:
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree hdmi-dbg
        git checkout 46edebc1ac787bb2e7bdd1bfa4d69821cf32a291
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_COMMON_CLK_HIFIBERRY_DACPRO --selectors CONFIG_SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for COMMON_CLK_HIFIBERRY_DACPRO when selected by SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC
   
   WARNING: unmet direct dependencies detected for SND_SOC_PCM512x_I2C
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
     Selected by [y]:
     - SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (SND_BCM2708_SOC_I2S || SND_BCM2835_SOC_I2S [=y])
   
   WARNING: unmet direct dependencies detected for COMMON_CLK_HIFIBERRY_DACPRO
     Depends on [n]: COMMON_CLK [=n]
     Selected by [y]:
     - SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (SND_BCM2708_SOC_I2S || SND_BCM2835_SOC_I2S [=y])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
