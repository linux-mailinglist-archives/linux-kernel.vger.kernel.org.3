Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC244E47C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiCVUxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiCVUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:53:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF092ACD;
        Tue, 22 Mar 2022 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647982294; x=1679518294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u+g2t6h/8tEyEAQw7dkgkTjyKlXtj+uVsc+F5RSyiwI=;
  b=EpYet1/tPuZOrCTSyaDM9Wzecz0RM1U67ga6rJHnqQiRGWeXGI6SXo5F
   0Xm1OUwFbsHG4ymn1VpxvMpCucPl2lTyfmibQjDhpBCgxkI3xr9BnwhsQ
   Ga3kDWdpPjmtMqIpgBOsiLXeBP7/6MHPdDaIXVgOhfytEjzgU12WWZiKq
   7Iqe96bFHzC4KhyQlKF8YZx2I6hUuen+v+9q4f2K+Mvv2katb5Je3HzH8
   BTyAY9AibASNoq+IzVJ19JKcg4TIzZE1QpRUp2zxIkt3qBloLI9FqFev3
   zg3dcJdPDfK5mV6acE2yJXMMFbExAIxyTXQY/fNMaKkEyO6VXrpuZWZnC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="245419051"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="245419051"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="583434398"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2022 13:51:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWlTX-000JHA-0j; Tue, 22 Mar 2022 20:51:31 +0000
Date:   Wed, 23 Mar 2022 04:50:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v4 3/4] input/i8042: Add debug output for quirks
Message-ID: <202203230435.z5FH2fWa-lkp@intel.com>
References: <20220322162125.59838-4-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322162125.59838-4-wse@tuxedocomputers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Werner,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on v5.17 next-20220322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20220323/202203230435.z5FH2fWa-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Werner-Sembach/input-i8042-Move-__initconst-to-fix-code-styling-warning/20220323-012205
        git checkout d92be72641d5753be3aa94fe5961e2dbe2b5bdc9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/input/serio/i8042.c:12:
   drivers/input/serio/i8042-x86ia64io.h: In function 'i8042_platform_init':
>> drivers/input/serio/i8042-x86ia64io.h:1511:17: error: 'i8042_dritek' undeclared (first use in this function); did you mean 'i8042_direct'?
    1511 |                 i8042_dritek ? " dritek" : "",
         |                 ^~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
    1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
         |         ^~~~~~~~
   drivers/input/serio/i8042-x86ia64io.h:1511:17: note: each undeclared identifier is reported only once for each function it appears in
    1511 |                 i8042_dritek ? " dritek" : "",
         |                 ^~~~~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   drivers/input/serio/i8042-x86ia64io.h:1497:9: note: in expansion of macro 'pr_debug'
    1497 |         pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
         |         ^~~~~~~~


vim +1511 drivers/input/serio/i8042-x86ia64io.h

  1494	
  1495		i8042_check_quirks();
  1496	
  1497		pr_debug("Active quirks (empty means none):%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
  1498			i8042_nokbd ? " nokbd" : "",
  1499			i8042_noaux ? " noaux" : "",
  1500			i8042_nomux ? " nomux" : "",
  1501			i8042_unlock ? " unlock" : "",
  1502			i8042_probe_defer ? "probe_defer" : "",
  1503			i8042_reset == I8042_RESET_DEFAULT ?
  1504				"" : i8042_reset == I8042_RESET_ALWAYS ?
  1505					" reset_always" : " reset_never",
  1506			i8042_direct ? " direct" : "",
  1507			i8042_dumbkbd ? " dumbkbd" : "",
  1508			i8042_noloop ? " noloop" : "",
  1509			i8042_notimeout ? " notimeout" : "",
  1510			i8042_kbdreset ? " kbdreset" : "",
> 1511			i8042_dritek ? " dritek" : "",
  1512			i8042_nopnp ? " nopnp" : "");
  1513	
  1514		retval = i8042_pnp_init();
  1515		if (retval)
  1516			return retval;
  1517	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
