Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C286B4C21B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiBXCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiBXCZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:25:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C122C6FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669486; x=1677205486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YbRBSSWOu+EklGcdgUzstcqOBzhi9A/f9C5QAcIY1t0=;
  b=PLnEfk5I7AjfPSvbkGEloznXsfE5DALe1uCa1HxdHGoO+mZe7zsCFcMK
   XgCz4S/s1xk6oen92WUcK62c6gGye6TlPTi8t9OsT6CL0QlnICkhEP7jT
   ZgoGQNtzZYqFTlt2CRnHWb/NqShQZgk3WIqmw8Bq5qbZlnbmCzozHdaTf
   3Xr08jAfQDxFXfcxk5FipoF1hKkeDA6BHJDP3SDvKKcT0f0rL6xVdHL9H
   Gpyg5UKoCvZ20+PUPCmpTAngNJMWfg/q8xeBCW85pgiAXabDJJoZ4QCE7
   AccOKduKe8R1FptdKTJvVQn/FF+R+0bOjB4RBqUGMS5KAqXMMbBP+h0KR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235626073"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235626073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548509742"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 16:46:54 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN2HV-00022b-RN; Thu, 24 Feb 2022 00:46:53 +0000
Date:   Thu, 24 Feb 2022 08:45:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [mingo-tip:sched/headers 12/2340]
 include/linux/entry-common.h:11:10: fatal error: asm/entry-common.h: No such
 file or directory
Message-ID: <202202240812.Ynrlsu5B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: e66f6481a8c748ce2d4b37a3d5e10c4dd0d65e80 [12/2340] sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
config: arm64-randconfig-r033-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240812.Ynrlsu5B-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e66f6481a8c748ce2d4b37a3d5e10c4dd0d65e80
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e66f6481a8c748ce2d4b37a3d5e10c4dd0d65e80
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:66:
>> include/linux/entry-common.h:11:10: fatal error: asm/entry-common.h: No such file or directory
      11 | #include <asm/entry-common.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 include/linux/entry-common.h

142781e108b13b Thomas Gleixner 2020-07-22  10  
142781e108b13b Thomas Gleixner 2020-07-22 @11  #include <asm/entry-common.h>
142781e108b13b Thomas Gleixner 2020-07-22  12  

:::::: The code at line 11 was first introduced by commit
:::::: 142781e108b13b2b0e8f035cfb5bfbbc8f14d887 entry: Provide generic syscall entry functionality

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
