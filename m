Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35EA4E831B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiCZRyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 13:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiCZRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 13:54:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BEA43388
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648317149; x=1679853149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LLQsOCiKw2FAVdyQAueidX6qAQWeqjRHheWsb2KUuvk=;
  b=flxQV3FJ8g20dR2WCSLoaFgRzFrunHvUR29ae0PJzNMMQj7+mghz98Dj
   KaHuKq9VNnlAutXLzUX4VZDbAaWner7b7eoeKJMltg1tBztckMNXDAKXT
   6DHhHus0cEP3MpbDtR7gQM+2/6nYisDkgYiaMaG8L5qOX//dtWWM7+9fx
   mhtBIk0j64LQjI+ZxqeHe1BS328fLjpVGjrFO3s2KR2Kth3IIz+z6eUGJ
   PSBLRB4USjQECWgjUOYpoTKFuL0IZ5oPLdC8xCtA8KTlFGEFyHhKRQBKH
   k1fVPzSuOxCSo7uU9XvxMw4LKJWBYB9FXzzfl9N2m2nrt+f/uV9RztZd2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="240951957"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="240951957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 10:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="545442055"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2022 10:52:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYAaR-0000FB-Lg; Sat, 26 Mar 2022 17:52:27 +0000
Date:   Sun, 27 Mar 2022 01:52:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sparx5_ethtool.c:undefined reference to `ptp_clock_index'
Message-ID: <202203270155.TM6fFFRf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: 608111fc580fe9a1b9a2a35d5a4f92784274b0d5 net: sparx5: Implement get_ts_info
date:   3 weeks ago
config: arc-randconfig-r013-20220324 (https://download.01.org/0day-ci/archive/20220327/202203270155.TM6fFFRf-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=608111fc580fe9a1b9a2a35d5a4f92784274b0d5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 608111fc580fe9a1b9a2a35d5a4f92784274b0d5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.o: in function `sparx5_get_ts_info':
>> sparx5_ethtool.c:(.text+0x14a): undefined reference to `ptp_clock_index'
>> arc-elf-ld: sparx5_ethtool.c:(.text+0x14a): undefined reference to `ptp_clock_index'
   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ptp.o: in function `sparx5_ptp_init':
   sparx5_ptp.c:(.text+0xd4a): undefined reference to `ptp_clock_register'
   arc-elf-ld: sparx5_ptp.c:(.text+0xd4a): undefined reference to `ptp_clock_register'
   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ptp.o: in function `sparx5_ptp_deinit':
   sparx5_ptp.c:(.text+0xf28): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0xf28): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0xf30): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0xf30): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0xf3e): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ptp.o:sparx5_ptp.c:(.text+0xf3e): more undefined references to `ptp_clock_unregister' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
