Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F75A3A91
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiH1ABW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiH1AAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:00:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3413F1F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661644822; x=1693180822;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y9hrtxUvGqjPVnBe4hUbk7ZVAXNc9gmlm+YsW0+QMik=;
  b=YE3+r+ud/c2Fpr86aD4i5iMRmwu5W7TKMlCay5mDn4688me0XctLjVlU
   U/JIQSz03gz8Qb6ds7xVrLGMnwpNE/8cjKOKfCpdPxEFkTDiOVKtQPTYp
   cTjaqo9ajNedux234IaJwFEcf4ZB30syOyPeEykOLeHJfzAuwCrZjSmqK
   0B27pvLSJqQumZ/TW8qtJlLMjUI79/KbIsunTys9F49RYqIaA/UfmRm9b
   pc85kjoSNJbeyzg9iCNvNRIDaVUROU427IaxW0EDNNZKqF4wiD/5m+jvz
   PIXyCJasj2J5m3eHvzyUTVHJ6SgvG+TbgAhYFvkIgwrIc8Odz75REd9vC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="320811966"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="320811966"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 17:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="753238570"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2022 17:00:20 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS5iu-0000aV-0h;
        Sun, 28 Aug 2022 00:00:20 +0000
Date:   Sun, 28 Aug 2022 07:59:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 298/313]
 arch/sparc/kernel/setup_32.c:86:9: error: too few arguments to function
 'show_free_areas'
Message-ID: <202208280710.5Qy7NnB7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   47641223db134ff730539d1f03c2e4d8f9607100
commit: e6b756890bbd7fdc97acec0d1ecbd5bd180b1bf3 [298/313] mm: reduce noise in show_mem for lowmem allocations
config: sparc-defconfig (https://download.01.org/0day-ci/archive/20220828/202208280710.5Qy7NnB7-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e6b756890bbd7fdc97acec0d1ecbd5bd180b1bf3
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout e6b756890bbd7fdc97acec0d1ecbd5bd180b1bf3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/kernel/setup_32.c: In function 'prom_sync_me':
>> arch/sparc/kernel/setup_32.c:86:9: error: too few arguments to function 'show_free_areas'
      86 |         show_free_areas(0, NULL);
         |         ^~~~~~~~~~~~~~~
   In file included from arch/sparc/kernel/setup_32.c:12:
   include/linux/mm.h:1845:13: note: declared here
    1845 | extern void show_free_areas(unsigned int flags, nodemask_t *nodemask, gfp_t gfp_mask);
         |             ^~~~~~~~~~~~~~~


vim +/show_free_areas +86 arch/sparc/kernel/setup_32.c

^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   65  
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   66  /* Typing sync at the prom prompt calls the function pointed to by
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   67   * romvec->pv_synchook which I set to the following function.
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   68   * This should sync all filesystems and return, for now it just
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   69   * prints out pretty messages and returns.
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   70   */
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   71  
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   72  /* Pretty sick eh? */
c61c65cdcd1021 arch/sparc/kernel/setup.c    Adrian Bunk       2008-06-05   73  static void prom_sync_me(void)
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   74  {
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   75  	unsigned long prom_tbr, flags;
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   76  
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   77  	/* XXX Badly broken. FIX! - Anton */
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   78  	local_irq_save(flags);
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   79  	__asm__ __volatile__("rd %%tbr, %0\n\t" : "=r" (prom_tbr));
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   80  	__asm__ __volatile__("wr %0, 0x0, %%tbr\n\t"
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   81  			     "nop\n\t"
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   82  			     "nop\n\t"
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   83  			     "nop\n\t" : : "r" (&trapbase));
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   84  
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   85  	prom_printf("PROM SYNC COMMAND...\n");
9af744d743170b arch/sparc/kernel/setup_32.c Michal Hocko      2017-02-22  @86  	show_free_areas(0, NULL);
29f043a2caea28 arch/sparc/kernel/setup_32.c Paul E. McKenney  2011-11-10   87  	if (!is_idle_task(current)) {
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   88  		local_irq_enable();
70f68ee81e2e9a arch/sparc/kernel/setup_32.c Dominik Brodowski 2018-03-14   89  		ksys_sync();
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   90  		local_irq_disable();
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   91  	}
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   92  	prom_printf("Returning to prom\n");
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   93  
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   94  	__asm__ __volatile__("wr %0, 0x0, %%tbr\n\t"
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   95  			     "nop\n\t"
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   96  			     "nop\n\t"
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   97  			     "nop\n\t" : : "r" (prom_tbr));
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   98  	local_irq_restore(flags);
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16   99  }
^1da177e4c3f41 arch/sparc/kernel/setup.c    Linus Torvalds    2005-04-16  100  

:::::: The code at line 86 was first introduced by commit
:::::: 9af744d743170b5f5ef70031dea8d772d166ab28 lib/show_mem.c: teach show_mem to work with the given nodemask

:::::: TO: Michal Hocko <mhocko@suse.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
