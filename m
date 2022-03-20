Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0664E19A9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 05:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiCTEoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 00:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbiCTEoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 00:44:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE60213D08
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 21:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647751378; x=1679287378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tyApDY/F9hpuzZkPssjm2BwZi1DRxFXK3xySQNu/crE=;
  b=iM1RE+cWOvVE+AQlBvPSbj9F4rps6+yCBJpnHOJpC22NpeKYdhIVQM+s
   NjNTu12ahT8lbbwDWgcfRXSqF+o9a/M4ENSBKIWmEFAuv+3ygnMCucw+m
   mK1u2mc5RB+3oz2lzoJkuu5vjgjeKzA9khl9H71i5YAzKzjrFONyS6xF8
   i68fh1qkpHaMjYLMBmmm1Bs1PwHZ1FA3PStfTT0i3zFmpPUFBoZoDtjTS
   iBtazHYNyXjvYj9bR/ubRWH2egVdqgiZM1EpWnjp64EelRu8Xmek4GbDA
   RlBBkDFgKtLbIZoN5e7dwvjZ///KMNI+5f6hNNM8MIQ4NG15wejQu2jlj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237956239"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="237956239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 21:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="559367096"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2022 21:42:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVnP5-000GaT-SK; Sun, 20 Mar 2022 04:42:55 +0000
Date:   Sun, 20 Mar 2022 12:42:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:atc-WIP 186/186] atc.c:undefined reference to
 `typec_mux_get_drvdata'
Message-ID: <202203201229.cPfbWcJt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux atc-WIP
head:   edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
commit: edd8b87e1973b03d2a8ae654018e6a01cd1cc03e [186/186] WIP: atcphy
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220320/202203201229.cPfbWcJt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux atc-WIP
        git checkout edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: Entry trampoline text too big
   aarch64-linux-ld: drivers/phy/apple/atc.o: in function `atcphy_mux_set':
>> atc.c:(.text+0x1d8): undefined reference to `typec_mux_get_drvdata'
   aarch64-linux-ld: drivers/phy/apple/atc.o: in function `atcphy_sw_set':
>> atc.c:(.text+0x308): undefined reference to `typec_switch_get_drvdata'
   aarch64-linux-ld: drivers/phy/apple/atc.o: in function `atcphy_probe':
>> atc.c:(.text+0x760): undefined reference to `typec_mux_register'
>> aarch64-linux-ld: atc.c:(.text+0x78c): undefined reference to `typec_switch_register'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
