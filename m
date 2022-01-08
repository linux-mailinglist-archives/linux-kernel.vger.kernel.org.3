Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF948822E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 08:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiAHH3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 02:29:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:10241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233661AbiAHH3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641626984; x=1673162984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WmRyuzIY+tPoFY4WEGVgh86n0NOzU8FUsaqCLrCaXzU=;
  b=Hc5bE/RBDuEDZ2dqeMZDLzEZEVsLok43TO8bVOhBl/QueMOLxFMZzRUz
   DWPn389pMxqkRd4rdhbE+Al3lA0do+cxCAvuX145hec290P116fbcfMTS
   WSJcpzC6nOaehGlumPl1ret4CA1rlXvUN9bKk6tJHXJzaG+teyMinS9U3
   tsX/FwSMA+HspiOfbVGGLLdha1L26dPbUtm5DmrRpJ/vxxeiubZpWZPI7
   ofCCBIEukX/Jy7GnJ+Smwlx6XaJ6rFBAfZQ3/C1gWsDcQbPIQglrD2Rdo
   KYah2o9Yxp1ThAX6CKXGqJBD17axlm3/OH/Qar+r/zwH+6zKdv5wDj/dK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="303737556"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="303737556"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 23:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="690045002"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2022 23:29:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n66AY-0000NC-UI; Sat, 08 Jan 2022 07:29:42 +0000
Date:   Sat, 8 Jan 2022 15:29:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1824/2372] lib/memcat_p.c:10:8: warning: no
 previous prototype for '__memcat_p'
Message-ID: <202201081547.TX8B6yRX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: fdd4a8e803c246ee0751f572a078ffd97b73ba36 [1824/2372] headers/deps: smp: Optimize <linux/smp.h> dependencies, remove <linux/smp_api.h> inclusion
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220108/202201081547.TX8B6yRX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=fdd4a8e803c246ee0751f572a078ffd97b73ba36
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout fdd4a8e803c246ee0751f572a078ffd97b73ba36
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/memcat_p.c:10:8: warning: no previous prototype for '__memcat_p' [-Wmissing-prototypes]
      10 | void **__memcat_p(void **a, void **b)
         |        ^~~~~~~~~~


vim +/__memcat_p +10 lib/memcat_p.c

93048c0944150b Alexander Shishkin 2018-10-16   4  
93048c0944150b Alexander Shishkin 2018-10-16   5  /*
93048c0944150b Alexander Shishkin 2018-10-16   6   * Merge two NULL-terminated pointer arrays into a newly allocated
93048c0944150b Alexander Shishkin 2018-10-16   7   * array, which is also NULL-terminated. Nomenclature is inspired by
93048c0944150b Alexander Shishkin 2018-10-16   8   * memset_p() and memcat() found elsewhere in the kernel source tree.
93048c0944150b Alexander Shishkin 2018-10-16   9   */
93048c0944150b Alexander Shishkin 2018-10-16 @10  void **__memcat_p(void **a, void **b)

:::::: The code at line 10 was first introduced by commit
:::::: 93048c0944150b316a15f92c41a4d626c8df37fd lib: Fix ia64 bootloader linkage

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
