Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E738488594
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiAHT0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:26:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:7453 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbiAHT0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641669969; x=1673205969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rley/fEkH8Nt5zuboRAfD1NjOtmMF0vuVkcLvbKKcio=;
  b=l7mzlrBB/ZKmeoxZjjUeyvroxNDetZCQWR/BvhiVeqX6te3vyO956SAy
   xXgLVywQUIQsgrzlYY8TU63AyLDIY11IeICqSrHSGxl/gyzYk781AnoHA
   Swmj0l0DqaDoXembmCMGVti8olc23mxZaDpgDzjyb0iXeIGwzD0mzKYaY
   bjBAPRtMe/auGYcAOe+Ujb1mecnsWVf61lWBYV7zaBsJtfX8/z2/nBDuN
   eE5qycbVEZ0T588EUrS2Ph0N78UDjeL+qcmoZ31KqMrOCfpvh6MziWuIo
   XswkkP5sl/vRyS6wwlD7SQchhTeR+9zf1bLJ3NtS3uPn7OgzG7OAgfC1X
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="243234254"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="243234254"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 11:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="622270690"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2022 11:26:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6HLq-0000y7-S2; Sat, 08 Jan 2022 19:26:06 +0000
Date:   Sun, 9 Jan 2022 03:25:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 100/2375]
 ./usr/include/asm-generic/shmbuf.h:7:10: fatal error:
 'uapi/asm-generic/ipcbuf.h' file not found
Message-ID: <202201090337.wVCPFbiS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   351ceeab2ef96ab2fc306934ddb201b44636181b
commit: b301094f9e34dbcddaecebd5112e7643e69cd47e [100/2375] headers/deps: Remove <linux/sem.h> from <linux/sched.h>
config: i386-randconfig-r003-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090337.wVCPFbiS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b301094f9e34dbcddaecebd5112e7643e69cd47e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b301094f9e34dbcddaecebd5112e7643e69cd47e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/shm.h:26:
   In file included from ./usr/include/asm/shmbuf.h:6:
>> ./usr/include/asm-generic/shmbuf.h:7:10: fatal error: 'uapi/asm-generic/ipcbuf.h' file not found
   #include <uapi/asm-generic/ipcbuf.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
