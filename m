Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2521A515519
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380505AbiD2UGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359680AbiD2UGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:06:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246BA5E15A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651262603; x=1682798603;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ymsGuVGiQkzKv0D0VHC2+g9zkH/MqaGyM3EvyGSejs=;
  b=nClMmWJua2TSBDs08TihtWi+DcjnqluHdOuZsntOp5BbIFDPQ2L+mUxw
   YyqFh9ttNK8nzf02VLAZYHEAZuqLfGKZj+aYmyeJPpC+hOx6Moi2l/X4i
   8Ow/CurUYOqAKd/9kbOQhyXNiBGeCRyIEGPvh+ZF0dpD8w7e9ekfi1F37
   K1MGoSyL+NWol55xgwdsqL098a57Q+ZeX3vmMJcBcDWE9WLHX8JSlcfTr
   FPy9IFuiAktWIINEYM3KRZOMpaWsIc9xY5IvJxjOUhmQD47E5MKBQPHhB
   y27fJ9TvQ/QvfwvN8924XXr/c/P2vI6734KBAC5GywqKTvEzGkGfNEIj7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266919560"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="266919560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 13:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="534666456"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2022 13:03:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkWpk-0006al-UP;
        Fri, 29 Apr 2022 20:03:20 +0000
Date:   Sat, 30 Apr 2022 04:02:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/per-callsite-ops 4/6] kernel/exit.c:1815:
 multiple definition of `abort';
 arch/arc/kernel/traps.o:arch/arc/kernel/traps.c:158: first defined here
Message-ID: <202204300335.TrNu3DnY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
head:   2aaba224d039a36f7eca5ad68c77686d3546e4fa
commit: be98798b102a3e28fa0832c9c0473f42e14abe8b [4/6] HACK: arm64: ftrace: align pre-function literal pool
config: arc-randconfig-r043-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300335.TrNu3DnY-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=be98798b102a3e28fa0832c9c0473f42e14abe8b
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/per-callsite-ops
        git checkout be98798b102a3e28fa0832c9c0473f42e14abe8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: kernel/exit.o: in function `abort':
>> kernel/exit.c:1815: multiple definition of `abort'; arch/arc/kernel/traps.o:arch/arc/kernel/traps.c:158: first defined here


vim +1815 kernel/exit.c

38fd525a4c61e7e Eric W. Biederman 2020-07-01  1813  
be98798b102a3e2 Mark Rutland      2022-04-29  1814  void __aligned(8) abort(void)
7c2c11b208be09c Sudip Mukherjee   2017-12-14 @1815  {

:::::: The code at line 1815 was first introduced by commit
:::::: 7c2c11b208be09c156573fc0076b7b3646e05219 arch: define weak abort()

:::::: TO: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
