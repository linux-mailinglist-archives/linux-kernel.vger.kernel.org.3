Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED894E6FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356486AbiCYJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbiCYJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:15:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401ACF48C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648199624; x=1679735624;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=is3Q+6AucukDtN+moqdin1sAeQpxyJgxCS2KqYtKS7Q=;
  b=BmnbH2BvHtyhmqyAC4bVEdVGH4Ea1A72mPCQaW74l4GGtL9CH65r+BEN
   khiVDETzCX0i0v+PGfQbnVeaMh1sySdnhVh9CXbdPbD2G0b/6Z6BMLurT
   goDYt6swMUXZRCuRRm/H4DmDeUhL4WaLSkTur//Ti8rW3WqTChmHbgkbR
   Bot35eL9B522RTqm3EDG0kQylmlk7JqST4AonVy4Uhfvwfm21AjDF+O90
   vmEsSfceNfbVePef+LF3zZxhfmzWVH2evQD7hqoVbWPAt+dZ97qgQWVT6
   6Y3rf38mSuRQiE2D42WFzQBpziABugvskhQcmlP0KSKrmKhoR9zh3SEZP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321787827"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321787827"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 02:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718151170"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 02:13:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXg0a-000Lzt-9o; Fri, 25 Mar 2022 09:13:24 +0000
Date:   Fri, 25 Mar 2022 17:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/kernel/relocate.c:41:12: warning: no previous prototype
 for 'plat_post_relocation'
Message-ID: <202203251712.kpiEBAwp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: a307a4ce9ecd2e23c71318201330d9d648b3f818 MIPS: Loongson64: Add KASLR support
date:   1 year, 4 months ago
config: mips-randconfig-r006-20220325 (https://download.01.org/0day-ci/archive/20220325/202203251712.kpiEBAwp-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a307a4ce9ecd2e23c71318201330d9d648b3f818
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a307a4ce9ecd2e23c71318201330d9d648b3f818
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/relocate.c:41:12: warning: no previous prototype for 'plat_post_relocation' [-Wmissing-prototypes]
      41 | int __weak plat_post_relocation(long offset)
         |            ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/relocate.c:135:12: warning: no previous prototype for 'do_relocations' [-Wmissing-prototypes]
     135 | int __init do_relocations(void *kbase_old, void *kbase_new, long offset)
         |            ^~~~~~~~~~~~~~
>> arch/mips/kernel/relocate.c:304:14: warning: no previous prototype for 'relocate_kernel' [-Wmissing-prototypes]
     304 | void *__init relocate_kernel(void)
         |              ^~~~~~~~~~~~~~~
   arch/mips/kernel/relocate.c:415:6: warning: no previous prototype for 'show_kernel_relocation' [-Wmissing-prototypes]
     415 | void show_kernel_relocation(const char *level)
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +/plat_post_relocation +41 arch/mips/kernel/relocate.c

4c9fff362261d6 Marcin Nowakowski 2016-11-23  35  
8cc709d7d4f013 Steven J. Hill    2016-12-09  36  /*
8cc709d7d4f013 Steven J. Hill    2016-12-09  37   * This function may be defined for a platform to perform any post-relocation
8cc709d7d4f013 Steven J. Hill    2016-12-09  38   * fixup necessary.
8cc709d7d4f013 Steven J. Hill    2016-12-09  39   * Return non-zero to abort relocation
8cc709d7d4f013 Steven J. Hill    2016-12-09  40   */
8cc709d7d4f013 Steven J. Hill    2016-12-09 @41  int __weak plat_post_relocation(long offset)
8cc709d7d4f013 Steven J. Hill    2016-12-09  42  {
8cc709d7d4f013 Steven J. Hill    2016-12-09  43  	return 0;
8cc709d7d4f013 Steven J. Hill    2016-12-09  44  }
8cc709d7d4f013 Steven J. Hill    2016-12-09  45  

:::::: The code at line 41 was first introduced by commit
:::::: 8cc709d7d4f013f51d38ceb2e3c8c82d230cf457 MIPS: Relocatable: Provide plat_post_relocation hook

:::::: TO: Steven J. Hill <Steven.Hill@cavium.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
