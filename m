Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8EC52FFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 01:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiEUXRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUXQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:16:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113433BA7F
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653175017; x=1684711017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rycxr443wFid+g2GJ0o9jGmTRhZeCqNzHxVhatzRSCo=;
  b=kufpzR53orrm8ly/9DBUVJRmginzneA4x9dpkc1cvI+xgwohpM0E8aCL
   CSzOUL8KdxPuKXzpPLqpBFnWrO2hUA8T6O2g1tj4ENKEf6uJxJ41RPu36
   zVv4OTDWNfypl6M9WMd4/QF7pGp54hFbS12u3WY/8oppEJzkHuTExaY9X
   pAQkGd0mVNvuSX54hnsI36iewwBqJo5XbIRs9ozxebRWMGjl+Gfwo8NA+
   gxY7iipINEPQUhmkCHHu+IsduTe2z0uaCy7UQNS5gVoUsUKTkaZT9lu9j
   XLp0XKb8Z7oOgk5ZhKSS3jFrSJRUX7Fd4tIMc0oR9mCDAmaZOSa/xcuwE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="272623882"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="272623882"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 16:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="558038650"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2022 16:16:54 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsYL8-0006hM-7I;
        Sat, 21 May 2022 23:16:54 +0000
Date:   Sun, 22 May 2022 07:16:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/bmips/dma.c:7:6: warning: no previous prototype for
 'arch_sync_dma_for_cpu_all'
Message-ID: <202205220745.AYB1Q33g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c3f5bec9b40b9437410abb08eccd5cdd1598a3c
commit: d552ddeaab4a15a8dc157ac007833aa0b3706862 MIPS: bmips: Remove obsolete DMA mapping support
date:   4 months ago
config: mips-randconfig-r004-20220522 (https://download.01.org/0day-ci/archive/20220522/202205220745.AYB1Q33g-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d552ddeaab4a15a8dc157ac007833aa0b3706862
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d552ddeaab4a15a8dc157ac007833aa0b3706862
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/bmips/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/bmips/dma.c:7:6: warning: no previous prototype for 'arch_sync_dma_for_cpu_all' [-Wmissing-prototypes]
       7 | void arch_sync_dma_for_cpu_all(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_sync_dma_for_cpu_all +7 arch/mips/bmips/dma.c

d666cd0246f78b arch/mips/bcm3384/dma.c Kevin Cernekee    2014-10-20  6  
56e35f9c5b87ec arch/mips/bmips/dma.c   Christoph Hellwig 2019-11-07 @7  void arch_sync_dma_for_cpu_all(void)

:::::: The code at line 7 was first introduced by commit
:::::: 56e35f9c5b87ec1ae93e483284e189c84388de16 dma-mapping: drop the dev argument to arch_sync_dma_for_*

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
