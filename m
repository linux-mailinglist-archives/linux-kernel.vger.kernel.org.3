Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA98531FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiEXA3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiEXA3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:29:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3B93470
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653352190; x=1684888190;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oYrjqpjg2g3OYFt20oR0+0u0P/pep0/GP+3FW5OTdTA=;
  b=V3wj7UXIMAtopvuNM9PMgQvMzd/GeP07+fMN6QOCuJnf3dQOYcqoAkbs
   bOTD6XLmTvNG2OGd6v0TAXwaAIx6zNy7cMUnO1mSF32L1Se8+GLa0qTN1
   OJTVtpxB0H+FNGX78dIbURzGRmIQshPc7mvFUGoDPraAiddXJU4J3mfKl
   CeZ5hK3xF0z9AmzSe441gIWpO9nXHfGc7K1kpolcvPXnVyy/pBoVQBRYJ
   NnaTqDm+2FPBGjbjL/knkSY/6uuURPXUcaz7+Hpz3i8m2E9jXnzDBvCjQ
   NCUWx6ejGvs9wCnu5DSIeaBDEU5G7XLXit55gG6vYCAz+Cq3fBKnXZQPG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273389240"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273389240"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="663682519"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 May 2022 17:29:48 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntIQl-0001Xo-Nt;
        Tue, 24 May 2022 00:29:47 +0000
Date:   Tue, 24 May 2022 08:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:hdmi-dbg 16/19] kismet: WARNING: unmet direct
 dependencies detected for COMMON_CLK_HIFIBERRY_DACPRO when selected by
 SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC
Message-ID: <202205240839.re9RD7S2-lkp@intel.com>
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
config: (https://download.01.org/0day-ci/archive/20220524/202205240839.re9RD7S2-lkp@intel.com/config)
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
