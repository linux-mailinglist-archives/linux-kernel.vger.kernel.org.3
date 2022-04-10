Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408EE4FAF2A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiDJRJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDJRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:09:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075EA1117C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649610434; x=1681146434;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3irv/Hvk7J3OLv+AdB6F7l6hdeozHP/Z6qCmFvQNX4Q=;
  b=a3T+ZsBn2WNpa4XCvrKhJki3fHBitmxs9Uz4cHUOhiqJtI1BHhfTpqyZ
   70jf/q8BtzScWfhpCZobtAfMf9F7XWpcqboAORY9pQxQH/kNQXczpxfY5
   RmBYM13jtb5BNyEmyLltimlZlC5dXsMIef4XyxWp8X9X03Yx5R80Jzd3t
   IKsjFIJ0erjdYoTbL0hN76y8bXb6O6g9x14qjelpLCPq8tGCr/YpHMSpd
   lCd/vjxnDDCANy0CdwUyAPWGmFOSPFxUSzY1e9l1GbhPQhtY1HI038YJu
   LMdB9a+GmfVvXp8aBj5mDtPP77xdYd6n/UMxTx7piiiQDWN3fmJnDwfA2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261728428"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="261728428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 10:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="699083777"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 10:07:12 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndb1r-0000yW-OV;
        Sun, 10 Apr 2022 17:07:11 +0000
Date:   Mon, 11 Apr 2022 01:06:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:jd/not-zero-entropy 7/12]
 arch/arm/include/asm/timex.h:14:63: error: implicit declaration of function
 'sched_clock'
Message-ID: <202204110106.XXNJ3BEs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git jd/not-zero-entropy
head:   efec3e2057963ad20223fa50a657b3ca9314ed45
commit: 904df0ccc3b52e7dffc4b968b8839d63ecba08ce [7/12] arm: use sched_clock() for random_get_entropy() instead of zero
config: arm-buildonly-randconfig-r001-20220410 (https://download.01.org/0day-ci/archive/20220411/202204110106.XXNJ3BEs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=904df0ccc3b52e7dffc4b968b8839d63ecba08ce
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random jd/not-zero-entropy
        git checkout 904df0ccc3b52e7dffc4b968b8839d63ecba08ce
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/jiffies.h:10,
                    from lib/random32.c:38:
   lib/random32.c: In function 'prandom_init_early':
>> arch/arm/include/asm/timex.h:14:63: error: implicit declaration of function 'sched_clock' [-Werror=implicit-function-declaration]
      14 | #define random_get_entropy() ((unsigned long)(get_cycles() ?: sched_clock()))
         |                                                               ^~~~~~~~~~~
   lib/random32.c:469:22: note: in expansion of macro 'random_get_entropy'
     469 |                 v1 = random_get_entropy();
         |                      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from crypto/jitterentropy-kcapi.c:41:
   crypto/jitterentropy-kcapi.c: In function 'jent_get_nstime':
>> arch/arm/include/asm/timex.h:14:63: error: implicit declaration of function 'sched_clock' [-Werror=implicit-function-declaration]
      14 | #define random_get_entropy() ((unsigned long)(get_cycles() ?: sched_clock()))
         |                                                               ^~~~~~~~~~~
   crypto/jitterentropy-kcapi.c:85:15: note: in expansion of macro 'random_get_entropy'
      85 |         tmp = random_get_entropy();
         |               ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sched_clock +14 arch/arm/include/asm/timex.h

    11	
    12	typedef unsigned long cycles_t;
    13	#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
  > 14	#define random_get_entropy() ((unsigned long)(get_cycles() ?: sched_clock()))
    15	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
