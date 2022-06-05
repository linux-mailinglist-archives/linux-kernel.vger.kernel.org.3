Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81B53D8DC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 02:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiFEANX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 20:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiFEANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 20:13:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3614D605
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654387999; x=1685923999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tjCLWlnDd1xOelaMV0Mv+df88jS7FOL8Fp/HZ2+wZzY=;
  b=erO7fR4cj7sms+VCCClDLhBkk4bwKd2A4b5QyYKAn8ulYJPNO4/T8RMi
   PR+fmKdlwWmKhFS6J6kpL1ehX5T4poNh04cfpddxXqpjluy9ukSX23W9X
   Y/W7JdKl58dYiZdKDjvVps15EpsXQv7AgmvlyZ4yjHC1lYE7YSifbNzMV
   oHiNodrTO6brXx8Oawqe+Lz+53fTpq7zxFGlAromIaek+9SoTg9r/CP3g
   SPp4+EZ5UvmoBKOXSdHswgOpeUl8lWp1gVt6yFJWiYbhV5axSjKrE9YDa
   oLDSrL7gmGCLX0mCGWoYesS6pnDgYNgiMOYmRN4C2jdZuo1Qih2fVEnK7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256966880"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256966880"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:13:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="906001734"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2022 17:13:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxdtN-000BIk-Es;
        Sun, 05 Jun 2022 00:13:17 +0000
Date:   Sun, 5 Jun 2022 08:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap2/board-generic.c:44:6: warning: no previous
 prototype for function 'tick_broadcast'
Message-ID: <202206050825.OuexWb2X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   9 weeks ago
config: arm-randconfig-r002-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050825.OuexWb2X-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0a90b72c432d70aae035727ece4ba80ce820f381)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/board-generic.c:44:6: warning: no previous prototype for function 'tick_broadcast' [-Wmissing-prototypes]
   void tick_broadcast(const struct cpumask *mask)
        ^
   arch/arm/mach-omap2/board-generic.c:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tick_broadcast(const struct cpumask *mask)
   ^
   static 
   1 warning generated.


vim +/tick_broadcast +44 arch/arm/mach-omap2/board-generic.c

e69b4e1a7577c1 Tony Lindgren 2020-05-07  41  
d86ad463d6706d Tony Lindgren 2020-05-28  42  /* Used by am437x for ARM timer in non-SMP configurations */
d86ad463d6706d Tony Lindgren 2020-05-28  43  #if !defined(CONFIG_SMP) && defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
d86ad463d6706d Tony Lindgren 2020-05-28 @44  void tick_broadcast(const struct cpumask *mask)
d86ad463d6706d Tony Lindgren 2020-05-28  45  {
d86ad463d6706d Tony Lindgren 2020-05-28  46  }
d86ad463d6706d Tony Lindgren 2020-05-28  47  #endif
d86ad463d6706d Tony Lindgren 2020-05-28  48  

:::::: The code at line 44 was first introduced by commit
:::::: d86ad463d6706d35167418660ae3293207ee9d1c ARM: OMAP2+: Fix regression for using local timer on non-SMP SoCs

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
