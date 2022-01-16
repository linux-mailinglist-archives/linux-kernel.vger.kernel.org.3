Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42948FED5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiAPUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 15:33:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:54559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbiAPUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 15:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642365196; x=1673901196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p6fneE1PjydKK4Dj9v+OLF3B5xwCOjfFi7ZA47Qu78I=;
  b=cHs+QEDYSClnTbzLniAogtw1PFBDe70wYQppQkcx3raMW1aNyaU6SJkl
   KWgPt3axe7zZceUFiErVLjXpS7mK10D6GlNNqOIscN7JYyGcPeXDfvzq8
   Tlv2SWATBbYbN6OLk9WOmwFDhxIN0I8gUHLK5Jjss0hVzQrr8RKfYfExV
   7gughzJoqoA2hIKz3oXim7xnnvcR28wQ1+GuYIr+VRL2AxDc/DQhjt8Fb
   EmPsHKeB5OuL4uSiSboqzJc48iK3ckHy7u/r8P59UkN2oJC2XjwsgpgRR
   pHYHlMcSbNfP+cwxWqgDCbv8SzlS9RHOaqknCtlvO3FmlW5pkHprWxEQz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="242073551"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="242073551"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 12:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="517172824"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2022 12:33:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9CDC-000AyA-4y; Sun, 16 Jan 2022 20:33:14 +0000
Date:   Mon, 17 Jan 2022 04:33:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/bmips/dma.c:7:6: warning: no previous prototype for
 function 'arch_sync_dma_for_cpu_all'
Message-ID: <202201170455.DlrxW9Pv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
commit: d552ddeaab4a15a8dc157ac007833aa0b3706862 MIPS: bmips: Remove obsolete DMA mapping support
date:   5 days ago
config: mips-bmips_stb_defconfig (https://download.01.org/0day-ci/archive/20220117/202201170455.DlrxW9Pv-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d552ddeaab4a15a8dc157ac007833aa0b3706862
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d552ddeaab4a15a8dc157ac007833aa0b3706862
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/bmips/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/bmips/dma.c:7:6: warning: no previous prototype for function 'arch_sync_dma_for_cpu_all' [-Wmissing-prototypes]
   void arch_sync_dma_for_cpu_all(void)
        ^
   arch/mips/bmips/dma.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_sync_dma_for_cpu_all(void)
   ^
   static 
   1 warning generated.


vim +/arch_sync_dma_for_cpu_all +7 arch/mips/bmips/dma.c

d666cd0246f78b arch/mips/bcm3384/dma.c Kevin Cernekee    2014-10-20  6  
56e35f9c5b87ec arch/mips/bmips/dma.c   Christoph Hellwig 2019-11-07 @7  void arch_sync_dma_for_cpu_all(void)

:::::: The code at line 7 was first introduced by commit
:::::: 56e35f9c5b87ec1ae93e483284e189c84388de16 dma-mapping: drop the dev argument to arch_sync_dma_for_*

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
