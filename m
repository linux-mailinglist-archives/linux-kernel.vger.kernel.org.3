Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9D47701B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhLPLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:21:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:4499 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231820AbhLPLVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639653668; x=1671189668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xE81kgNNriwdWp1WYCYz9TJ3ZIFhei3NS9V9FDyjOF8=;
  b=LKYxZyHWGjaFZ84gdPP2uf03Vkmw5vQLckF7fkecIf7NhA9dUvjDk1ND
   YGS3mcyLwhS+WWiGmaFQrkl8hqzlv0jbQpHwRB5GrPevS/JJhhDwcdVHn
   lWXoxEcewPKLqkkjMVShZDa/plQxFgrp2nBxW8yXc9qeS79ZT6ttAPdnx
   XeraarB7zJ24UqEbl9xDIbtg+brKmr3pG5nYfCStxFH7bfTxvp47y6Qy4
   h+6POV8oTKT42mKGGgh3xo9+e4isAWPhQPBJPxtpa8uViRKaAU1Pw9aM7
   5KtPnFAy1F7Tt97+/eFLW8b0zr9gnsj6ubev1ofRMKCDNcH2GjJQ6GBVQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239416303"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239416303"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:20:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="466008198"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 03:20:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxooj-00034F-Bu; Thu, 16 Dec 2021 11:20:57 +0000
Date:   Thu, 16 Dec 2021 19:20:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/kernel/relocate.c:41:12: warning: no previous prototype
 for 'plat_post_relocation'
Message-ID: <202112161913.eRJj41Fh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: a307a4ce9ecd2e23c71318201330d9d648b3f818 MIPS: Loongson64: Add KASLR support
date:   1 year, 1 month ago
config: mips-randconfig-r012-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161913.eRJj41Fh-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ arch/mips/lib/

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

4c9fff362261d68 Marcin Nowakowski 2016-11-23  35  
8cc709d7d4f013f Steven J. Hill    2016-12-09  36  /*
8cc709d7d4f013f Steven J. Hill    2016-12-09  37   * This function may be defined for a platform to perform any post-relocation
8cc709d7d4f013f Steven J. Hill    2016-12-09  38   * fixup necessary.
8cc709d7d4f013f Steven J. Hill    2016-12-09  39   * Return non-zero to abort relocation
8cc709d7d4f013f Steven J. Hill    2016-12-09  40   */
8cc709d7d4f013f Steven J. Hill    2016-12-09 @41  int __weak plat_post_relocation(long offset)
8cc709d7d4f013f Steven J. Hill    2016-12-09  42  {
8cc709d7d4f013f Steven J. Hill    2016-12-09  43  	return 0;
8cc709d7d4f013f Steven J. Hill    2016-12-09  44  }
8cc709d7d4f013f Steven J. Hill    2016-12-09  45  

:::::: The code at line 41 was first introduced by commit
:::::: 8cc709d7d4f013f51d38ceb2e3c8c82d230cf457 MIPS: Relocatable: Provide plat_post_relocation hook

:::::: TO: Steven J. Hill <Steven.Hill@cavium.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
