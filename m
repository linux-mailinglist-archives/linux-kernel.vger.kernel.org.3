Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF19583446
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiG0UxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiG0Uw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 16:52:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E615071D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658955176; x=1690491176;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xdEvTODN9bwCEQN4THkpljZuXpgpyz9/fZ1pG2d8C5M=;
  b=hPq59/w88vMrO5GYD1LciSl+NiEdioD+C73PRWiQXMtYVE3ziD+6NU5Z
   ar1iw18Gj4Y5ctpkmMmea1h8ScVSL3ffZSxl+CIkq8/bMlfiAhqyHyfAQ
   JGXbYAlwTkScfYaew7tNIMsleawrvy218rN2bGSYstEPUoJSoipKOIYag
   iCGwkQlkGPcR0vaR4QB3q74bSAY8dXq1jATndRWXHbGz0f43aElQZgIgF
   iKtCOddt+vGgjYNQfjPQOtA6tsKea/13CK6FX15TjpV+ZP1MgocFoPC1Q
   h/Q18D88qXDBx6tX/p3WJIkMEF6BxmnZLS8zpMSKDVZ2Hp3SpfyBd4JIW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289115374"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="289115374"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 13:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="576147075"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2022 13:52:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGo1W-00096g-11;
        Wed, 27 Jul 2022 20:52:54 +0000
Date:   Thu, 28 Jul 2022 04:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:hdmi-dbg 16/23] kismet: WARNING: unmet direct
 dependencies detected for SND_SOC_PCM512x_I2C when selected by
 SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC
Message-ID: <202207280432.VGa4ENtE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git hdmi-dbg
head:   7e5cf0f879352d748b928e53f0411da8a0350bd0
commit: 855d99bdc8325d5c59c539e796a21ae638d9da71 [16/23] hifiberry_dacplusadc: add support for the Hifiberry DAC+ ADC
config: (https://download.01.org/0day-ci/archive/20220728/202207280432.VGa4ENtE-lkp@intel.com/config)
reproduce:
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree hdmi-dbg
        git checkout 855d99bdc8325d5c59c539e796a21ae638d9da71
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_SND_SOC_PCM512x_I2C --selectors CONFIG_SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SND_SOC_PCM512x_I2C when selected by SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC
   
   WARNING: unmet direct dependencies detected for SND_SOC_PCM512x_I2C
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
     Selected by [y]:
     - SND_BCM2708_SOC_HIFIBERRY_DACPLUSADC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (SND_BCM2708_SOC_I2S || SND_BCM2835_SOC_I2S [=n] || COMMON_CLK [=y])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
