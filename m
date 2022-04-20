Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B8508155
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350485AbiDTGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiDTGny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:43:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E2B340DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650436869; x=1681972869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eSMluGEM3zFG2k5bkshxCznXFVNbgyN9Ew7MMKDa1J4=;
  b=adIUEu81dqO/43jmnaZPBrfTlBw8x0D/FnbNJyiCOtfhxyL947THWDJE
   Bu4icBjKOGDBCbJ7KzOzmR0Fxm+ED5GX6vMfjMH4HzTKTah6J5tIuDQRL
   85qYumyswc9I3kLVBrYalkZTEk/7fd83JrunC9lLaJ0ornbk4Zba0eHNv
   R8ZoJGTVOvFGdNPwFJUz8ey52HlzDas2EjUhuQLgxV0Y3Z9oOVrw+CJdb
   XLl3csUaMP2qz4rT9a9kwZ3j7r7mJY8s1crAdN9Jz8nvmqyJtovwjZlHB
   ceZzO4xYikwTkiBWTKhosORHAJOANAEjpHhplldqb0IBvPIPCAR5V43ty
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261555609"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="261555609"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="727364130"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 23:41:08 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh41T-0006ft-Lr;
        Wed, 20 Apr 2022 06:41:07 +0000
Date:   Wed, 20 Apr 2022 14:41:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 621/2579]
 include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No
 such file or directory
Message-ID: <202204201450.pNRIlkjX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 224dbd4b77caebda16df2f388e4cb826e22ea64c [621/2579] headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
config: h8300-buildonly-randconfig-r003-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201450.pNRIlkjX-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=224dbd4b77caebda16df2f388e4cb826e22ea64c
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 224dbd4b77caebda16df2f388e4cb826e22ea64c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=h8300 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./arch/h8300/include/generated/asm/barrier.h:1,
                    from include/asm-generic/atomic.h:13,
                    from ./arch/h8300/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/h8300/include/asm/bitops.h:173,
                    from include/linux/bitops.h:28,
                    from include/linux/log2.h:12,
                    from include/asm-generic/getorder.h:8,
                    from include/asm-generic/page.h:95,
                    from arch/h8300/include/asm/page.h:5,
                    from arch/h8300/include/asm/string.h:8,
                    from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from scripts/mod/devicetable-offsets.c:3:
>> include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No such file or directory
      16 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:120: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1193: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 include/asm-generic/barrier.h

    15	
  > 16	#include <asm/vdso/processor.h>
    17	#include <linux/compiler.h>
    18	#include <linux/kcsan-checks.h>
    19	#include <asm/rwonce.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
