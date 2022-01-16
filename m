Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167B448FAE0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 06:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiAPF3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 00:29:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:5488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbiAPF3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 00:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642310990; x=1673846990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lmBg6MERgB4bvXPiG7vaW7zqgfks6qUYbIXScuJG+u8=;
  b=mc+lz5PRZToqgQfzHoUg1lDSSowExvYb+/LRTXcySrkxwXNMHRTpDgzv
   gp0UYNLz1qKR7NuRT49BcD0dcOqnxM8X70QwOGU3PXki6gCAcw1HU36+f
   lvg6M6AmuK2I7+hRiJXeOtY60Wbq7mLMN05PpQExFA7VBKAsqdBUzZHX5
   Gg1waSWRqatGzFWci5CGjd7Afx2csC21mEZzJIFu9aaed6GS0J/DaieES
   3Q2WTScmZj4VND7RnITrHXl9qPSZNEUA4NtFGHHXY3qJzwoImrqmmFJU8
   gcHSJYyYpBUW7F6cupkIjBLVl5lpkYzZp2WR8X7dNqw1OQQiZDTypEuhl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="225144546"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="225144546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 21:29:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="476235046"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jan 2022 21:29:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8y6t-000ATA-Tn; Sun, 16 Jan 2022 05:29:47 +0000
Date:   Sun, 16 Jan 2022 13:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1943/2384]
 ./usr/include/linux/rtnetlink.h:5:10: fatal error: 'uapi/linux/types.h' file
 not found
Message-ID: <202201161354.vVp8FWLb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   4c707c1c0de83967079b4e385012fa5b00e2cd11
commit: c23f2d841e378347986864822f333c0b10346a94 [1943/2384] headers/deps: net: Optimize <uapi/linux/rtnetlink.h> dependencies
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220116/202201161354.vVp8FWLb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c23f2d841e378347986864822f333c0b10346a94
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c23f2d841e378347986864822f333c0b10346a94
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/fib_rules.h:6:
>> ./usr/include/linux/rtnetlink.h:5:10: fatal error: 'uapi/linux/types.h' file not found
   #include <uapi/linux/types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
