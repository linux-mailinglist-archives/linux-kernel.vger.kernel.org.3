Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1654FC48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382880AbiFQRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346881AbiFQRg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:36:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429D039688
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655487416; x=1687023416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bMtLzQOljOUCZPzV5ltNBGcTCTrefOOBNqtGBtob8NQ=;
  b=AaEzMVouO3yKnnYxT1k1Hr99PpynHCZh7zPMxyp8Zv35moi/la75f/Pr
   GiT1DtMbcin8lBl03+bwa270aV1iZX9M/ObgK6EWCte2p1VZ0mr1ntGNT
   1BBdvxjznBI5HmXOus8F5JaNTdZLv9Fji8tskTZbmPZgXr3iOMDbCeZXE
   /sIs7B1UIJRh3AqQcYcXeyjItyWLx4oV74Vrkf3UE+6PMyiLc3RGuNJBF
   o1NvGDMsAUpyBaXNPEs5fhJ8VS2CxhhFfzLrUOGHlG1j3LadSGW/MMb87
   luyCKZWDUL1ApXo6lUTUaXq1XhjF7dAtSIj6HljZhxGiifEIZTvViyAsq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278274004"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278274004"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 04:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="653592160"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2022 04:26:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2A7b-000PP7-VJ;
        Fri, 17 Jun 2022 11:26:39 +0000
Date:   Fri, 17 Jun 2022 19:26:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap2/board-generic.c:44:6: warning: no previous
 prototype for 'tick_broadcast'
Message-ID: <202206171947.lN5ZaG2s-lkp@intel.com>
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
head:   47700948a4abb4a5ae13ef943ff682a7f327547a
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   2 months ago
config: arm-buildonly-randconfig-r004-20220616 (https://download.01.org/0day-ci/archive/20220617/202206171947.lN5ZaG2s-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/board-generic.c:44:6: warning: no previous prototype for 'tick_broadcast' [-Wmissing-prototypes]
      44 | void tick_broadcast(const struct cpumask *mask)
         |      ^~~~~~~~~~~~~~


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
