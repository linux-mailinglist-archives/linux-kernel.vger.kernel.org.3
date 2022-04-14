Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13B500373
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiDNBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiDNBJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:09:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D1851E41
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649898437; x=1681434437;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kfwuCFOe4z5GV1OG7/YLBg8051tRnVLDcfKqUuH/G78=;
  b=Qd2dhC1HnCeePlPpIGuwWQVJ4iOKJW/9C/qXqktA6bLm3ihIgPLshqEs
   ln7hi+/6l9gzvnKR4Mzyk72zkD0jp7yCVJcKXOzRfRqWtQvp8FzeM1Ga/
   meF4fwfSvZIac7dqoEg7m8GN6x7XKH2a5uZfYR8+InyGXCu/N14VIZL3f
   1++nc2CBlU3lxjbjh7MgwDHBKAZ2+6KpLS2urcD68x2a4+mmJz7NnlR7K
   t/9N0kv6BxphY4YKLfumJqhq09P9u5Fb+r5+0X+FqPDn3rJ9idnh2emm9
   W0+Off8BZApguTfnMdKiERxbz0V1d0LNORfJGwHbN+4joR46/fsUMB8KY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261662259"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="261662259"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 18:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="527175479"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2022 18:07:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nenx5-0000kb-An;
        Thu, 14 Apr 2022 01:07:15 +0000
Date:   Thu, 14 Apr 2022 09:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 11/29] arch/mips/kernel/process.c:46:1:
 warning: 'noreturn' function does return
Message-ID: <202204140853.6K6wh9eM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   6d60b700d2179c68f134da8eda4d9879d460d1a3
commit: f5a10245e0eab8e93b77aa796fdf404d10b32468 [11/29] sched: Mark arch_cpu_idle_dead() __noreturn
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220414/202204140853.6K6wh9eM-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=f5a10245e0eab8e93b77aa796fdf404d10b32468
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout f5a10245e0eab8e93b77aa796fdf404d10b32468
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/kernel/process.c: In function 'arch_cpu_idle_dead':
>> arch/mips/kernel/process.c:46:1: warning: 'noreturn' function does return
      46 | }
         | ^


vim +/noreturn +46 arch/mips/kernel/process.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  41  
cdbedc61c8d012 Thomas Gleixner 2013-03-21  42  #ifdef CONFIG_HOTPLUG_CPU
cdbedc61c8d012 Thomas Gleixner 2013-03-21  43  void arch_cpu_idle_dead(void)
^1da177e4c3f41 Linus Torvalds  2005-04-16  44  {
cdbedc61c8d012 Thomas Gleixner 2013-03-21  45  	play_dead();
cdbedc61c8d012 Thomas Gleixner 2013-03-21 @46  }
cdbedc61c8d012 Thomas Gleixner 2013-03-21  47  #endif
1b2bc75c1bde65 Ralf Baechle    2009-06-23  48  

:::::: The code at line 46 was first introduced by commit
:::::: cdbedc61c8d0122ad682815936f0d11df1fe5f57 mips: Use generic idle loop

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
