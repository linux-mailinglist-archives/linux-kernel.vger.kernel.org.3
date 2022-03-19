Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A854DEA85
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbiCSUF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiCSUFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:05:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777924370E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647720272; x=1679256272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uZi+QY8aqIWvheu1K5ByqP1Ofa8djYNjjjpQQUUSs2U=;
  b=nXS2NEVDLoQoSJZeLWmyrCA5oSprQ4hE3n9cppAjcyt5EGs7Awlk7+1h
   5XiGfZ4vZ1NMLC6YtOqeq8DYU93SERL55jO7X1HjME4bP3t7SMJ9l5P1P
   u9e2D6lEXug5EcWTUVpm30vvqDdqUr6lu/KYv8zFL+zo9+lF400DQD8/o
   8csVw92qP3qq/kfKFTfuMioi9TrfMamOIfezM+cEkjYpecNYvl/b835uH
   IkibUo9PxZmwPHinGpLjjFZYQo8mYkHxEGXeHm3znbfOujgmrRc2S0hDz
   pKBb6wxxqEB1LpPr8HkhYS+MgOLInY0ZckZqs48Uxlf8K+vzPO1S/al8O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="257271008"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="257271008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 13:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="715970535"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2022 13:04:30 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVfJN-000GG5-KZ; Sat, 19 Mar 2022 20:04:29 +0000
Date:   Sun, 20 Mar 2022 04:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:atc-WIP 186/186] ld.lld: error: undefined symbol:
 typec_mux_register
Message-ID: <202203200422.ztLTB1O5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
config: arm64-randconfig-r005-20220319 (https://download.01.org/0day-ci/archive/20220320/202203200422.ztLTB1O5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 217f267efe3082438e698e2f08566b9df8c530fa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux atc-WIP
        git checkout edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: typec_mux_register
   >>> referenced by atc.c
   >>> phy/apple/atc.o:(atcphy_probe_mux) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: typec_switch_register
   >>> referenced by atc.c
   >>> phy/apple/atc.o:(atcphy_probe_switch) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: typec_mux_get_drvdata
   >>> referenced by atc.c
   >>> phy/apple/atc.o:(atcphy_mux_set) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: typec_switch_get_drvdata
   >>> referenced by atc.c
   >>> phy/apple/atc.o:(atcphy_sw_set) in archive drivers/built-in.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for APPLE_ADMAC
   Depends on DMADEVICES && (ARCH_APPLE || COMPILE_TEST
   Selected by
   - SND_SOC_APPLE_MCA && SOUND && !UML && SND && SND_SOC && (ARCH_APPLE || COMPILE_TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
