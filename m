Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20084576D71
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 13:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiGPLQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiGPLQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 07:16:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4111AF01
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657970174; x=1689506174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5LYRerrZfWWJUFEW33dgMxze7x7KiBkBY4ci2jzlk4E=;
  b=UYdpqqZVdX5TnwMOFchDXvU11+lb/ij26PEjlDoemeJp0QVglqo0gYIU
   zSsWQDtR7bzuJjvVW0WDRCGkiJamtU2KmgLDNZIMtpyOQD+mxGvWrn5jw
   MFcum0HTlGbbIk8mGc/QAUzdMFVZWj5DpPBlGgpb9slJsydSNuS2ZaXh6
   kkVWL+qCJ3n7RkL4lB5y/S6RqsiqFLo49OyKN5+khEj95as8VtinXcUfW
   t8TuSCzol69x6PS0lEUpnWBOMI2/qsVW0TcLEzukPum8Ick2AgtYXxlc8
   WCJV7S6+4kRMUlUrH4vLsTOcP/7RjRcXGPP7WzpTYtAUJerWYZN07G9+C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372280954"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="372280954"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 04:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="923806381"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2022 04:16:07 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCfmI-0001Ou-OX;
        Sat, 16 Jul 2022 11:16:06 +0000
Date:   Sat, 16 Jul 2022 19:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: [lee-mfd:ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20 4/12]
 kismet: WARNING: unmet direct dependencies detected for P2SB when selected
 by LPC_ICH
Message-ID: <202207161934.8meBTauD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
head:   a6c80bec3c9357506e2bfdae82623ef34f8cab40
commit: 559793198f9280cdd56c438f5258e315ed8a6cbc [4/12] mfd: lpc_ich: Switch to generic p2sb_bar()
config: (https://download.01.org/0day-ci/archive/20220716/202207161934.8meBTauD-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=559793198f9280cdd56c438f5258e315ed8a6cbc
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch --no-tags lee-mfd ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
        git checkout 559793198f9280cdd56c438f5258e315ed8a6cbc
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_P2SB --selectors CONFIG_LPC_ICH -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for P2SB when selected by LPC_ICH
   
   WARNING: unmet direct dependencies detected for P2SB
     Depends on [n]: X86 [=y] && X86_PLATFORM_DEVICES [=n] && PCI [=y]
     Selected by [y]:
     - LPC_ICH [=y] && HAS_IOMEM [=y] && PCI [=y] && X86 [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
