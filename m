Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46F576C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGPF4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPF4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:56:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED78481C8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 22:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657950962; x=1689486962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TatwdpbC7wBndV8ZFr4Y17EEsUA15Ugo7XvNTW6V+rY=;
  b=n0g0OvEsTl9HlXQN4lLDAQxiM570Mlv5H5Ao0IAQHKzNzYlwWADzffVd
   5vgkvPNIpoyiuF9XHyU+ck9dJETczfsXq72lG5oBdvaeNv+UBySKsx8c2
   ez2BymdmWJys7W87OKkQTZim7txoihGmUv6HSxZB1aupScMg8rF7spsIj
   HYxG3pt09uHYFf0EP8ElWxhbfvX0stLYem0BnMSowtJ5cGyVRqgRug/UH
   nG9xhn2rFUKoAoXzTid84zFIncmNEOxbE16LBXTYZ2QIt3eZNrgndsNg4
   j0EnQ1e7Nw4/24Co2LpdjBD9g2s1jHkUpuX7LJveJzFw3RYo2nTA/1b7J
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="265739869"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="265739869"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 22:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="546907444"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 22:55:59 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCamV-0001CC-8k;
        Sat, 16 Jul 2022 05:55:59 +0000
Date:   Sat, 16 Jul 2022 13:55:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [lee-mfd:ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20 8/12]
 kismet: WARNING: unmet direct dependencies detected for P2SB when selected
 by EDAC_PND2
Message-ID: <202207161302.MOaXr8ob-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
head:   a6c80bec3c9357506e2bfdae82623ef34f8cab40
commit: 7b2db7049bb9e55efb7e0c8a7169d5a021b50284 [8/12] EDAC, pnd2: convert to use common P2SB accessor
config: (https://download.01.org/0day-ci/archive/20220716/202207161302.MOaXr8ob-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=7b2db7049bb9e55efb7e0c8a7169d5a021b50284
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch --no-tags lee-mfd ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
        git checkout 7b2db7049bb9e55efb7e0c8a7169d5a021b50284
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_P2SB --selectors CONFIG_EDAC_PND2 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for P2SB when selected by EDAC_PND2
   
   WARNING: unmet direct dependencies detected for P2SB
     Depends on [n]: X86 [=y] && X86_PLATFORM_DEVICES [=n] && PCI [=y]
     Selected by [y]:
     - EDAC_PND2 [=y] && EDAC [=y] && PCI [=y] && X86_64 [=y] && X86_MCE_INTEL [=y] && X86 [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
