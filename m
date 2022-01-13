Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436FB48D4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiAMJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:10:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:33246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbiAMJKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642065039; x=1673601039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jc4Q2uFmzhBQwAXijmpR5Nzc4O+eByXdzeBCKZM7DIs=;
  b=Rpx1Kwju7bdiK8uosgVH7Hz3CgmoItYYa5t7VHVApPQN0sq8KV2NJYOr
   wrt0MVEhwU57wseMSd69mm71wz/KuGxDUlzfvhSzPZAMjbHodjRdOkpdm
   ciNt3onQn5J2ANcyyuG61/0Sfb+JGLuCnQPcfxF2IEbP7RNpNRwcJnEAx
   vLcnQV75Mu65p3hz7hRGdZ/BOTSXDcz3MaRbw3rY1CtGAthCmT1XK29CM
   2q//276aHZ2g9WPd8q65Yqer6wZ+ysafTPgNopM4JbUr92zMyTuziEXOh
   GEd/TT1jyd+RRuIFIOnf5cK/VBjcfJN0JYREWDhWpU94bN3M8H84aYXvg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="241527914"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="241527914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 01:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529586860"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 01:10:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7w7w-000729-Th; Thu, 13 Jan 2022 09:10:36 +0000
Date:   Thu, 13 Jan 2022 17:10:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/toc.c:15:1: sparse: sparse: symbol
 '__pcpu_scope_toc_stack' was not declared. Should it be static?
Message-ID: <202201131656.0KxahoSS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: d6ab9fc74513ae6501afcdae2547334a03b9a5c9 parisc: Enable TOC (transfer of contents) feature unconditionally
date:   2 days ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201131656.0KxahoSS-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6ab9fc74513ae6501afcdae2547334a03b9a5c9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d6ab9fc74513ae6501afcdae2547334a03b9a5c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/parisc/kernel/toc.c:15:1: sparse: sparse: symbol '__pcpu_scope_toc_stack' was not declared. Should it be static?

vim +/__pcpu_scope_toc_stack +15 arch/parisc/kernel/toc.c

    13	
    14	static unsigned int __aligned(16) toc_lock = 1;
  > 15	DEFINE_PER_CPU_PAGE_ALIGNED(char [16384], toc_stack);
    16	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
