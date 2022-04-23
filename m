Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA450CD61
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiDWU1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiDWU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:27:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27D1D83A5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650745488; x=1682281488;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bqodm5onR3UiGvmzHnKsoGBSS/BzMJb9vWhPXpUYzGo=;
  b=Vc9aV2An32SXw9IWeh2IHnF0ShzPPS3riQoob62Om0NsMNKGHPHUWc3M
   QnJEHUC8Tuv7oLF4U0cATs8DGsakSYffG3/fTaB3IiUUHc8hQrw5ZJTjJ
   AbijCWt+gO8oS1bZkrnhuAHbDUbQ19c8C5AmgQlL/Z3BX4FopGy4B0sse
   bIR/D1Zw5PYruZgfZwo1tRAk+6HAiULYrTCzbnKspnVAmMhZg56l/VMls
   g3vMLYGZYcMyhfRNTBa0pYmtW44xu05d0XW+OKKBx3Vu/qnAqGBQcwFHf
   foXJF7umPw4Mo8eBSiLtAdDZ41aSxg6HCMqf0uisXbv3PeO4WEv3vlknk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="262545623"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="262545623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="729048154"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 13:24:47 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niMJC-0000Q5-Jr;
        Sat, 23 Apr 2022 20:24:46 +0000
Date:   Sun, 24 Apr 2022 04:24:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/bmips/dma.c:7:6: warning: no previous prototype for
 'arch_sync_dma_for_cpu_all'
Message-ID: <202204240410.f0TrdLMQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
commit: d552ddeaab4a15a8dc157ac007833aa0b3706862 MIPS: bmips: Remove obsolete DMA mapping support
date:   3 months ago
config: mips-bmips_be_defconfig (https://download.01.org/0day-ci/archive/20220424/202204240410.f0TrdLMQ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d552ddeaab4a15a8dc157ac007833aa0b3706862
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d552ddeaab4a15a8dc157ac007833aa0b3706862
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/bmips/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/bmips/dma.c:7:6: warning: no previous prototype for 'arch_sync_dma_for_cpu_all' [-Wmissing-prototypes]
       7 | void arch_sync_dma_for_cpu_all(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_sync_dma_for_cpu_all +7 arch/mips/bmips/dma.c

d666cd0246f78bd arch/mips/bcm3384/dma.c Kevin Cernekee    2014-10-20  6  
56e35f9c5b87ec1 arch/mips/bmips/dma.c   Christoph Hellwig 2019-11-07 @7  void arch_sync_dma_for_cpu_all(void)

:::::: The code at line 7 was first introduced by commit
:::::: 56e35f9c5b87ec1ae93e483284e189c84388de16 dma-mapping: drop the dev argument to arch_sync_dma_for_*

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
