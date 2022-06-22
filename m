Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFE55483E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348137AbiFVIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348360AbiFVIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:25:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BEB3878F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655886341; x=1687422341;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z4qFujVN0sjGKDZjzxbjpCNKEPLxNusbypR955l5W1k=;
  b=A82QSjP0d7jsbAjMqF2x5fUuqqffR2PkDiuWQINEgS077bDg5LLH08ep
   PDPeycKCLHdzJrT17KPyChii8NuFrzRpulNtdZbkN4EoVKf/wRHrnTUma
   PemIenkb4XYTxllfqRikBjljz7CnRNSbzfeXtU1wcEkw6EANNSHGIQNBJ
   6KVW9ZskpIB7Ako/hhwhfMUvf8vm0YHLmhmFja6ZMM5TI+nvE0U+qzBHH
   U56Kj0ieMxuV+BdB41wcu/b7uWyE8FPNxah6od8bKRAOPONLLyU9iPQJW
   sJp5vuPDEEkp8EeyG49U8ZBwUC3wlS3ei/t737fJMkG+srrBZnF5MfzB4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="342037353"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342037353"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644073573"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2022 01:25:39 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3vgA-00012n-LS;
        Wed, 22 Jun 2022 08:25:38 +0000
Date:   Wed, 22 Jun 2022 16:25:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haijun Liu <haijun.liu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: arch/ia64/include/asm/mmu_context.h:127:48: error: variable
 'old_rr4' set but not used
Message-ID: <202206221623.Gi9Zz88b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haijun,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d
commit: 13e920d93e37fcaef4a9309515798a3cae9dcf19 net: wwan: t7xx: Add core components
date:   6 weeks ago
config: ia64-randconfig-r031-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221623.Gi9Zz88b-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13e920d93e37fcaef4a9309515798a3cae9dcf19
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 13e920d93e37fcaef4a9309515798a3cae9dcf19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/wwan/t7xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dma-mapping.h:10,
                    from drivers/net/wwan/t7xx/t7xx_pci.c:22:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
>> arch/ia64/include/asm/mmu_context.h:127:48: error: variable 'old_rr4' set but not used [-Werror=unused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   cc1: all warnings being treated as errors


vim +/old_rr4 +127 arch/ia64/include/asm/mmu_context.h

^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  121  
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  122  static inline void
badea125d7cbd9 include/asm-ia64/mmu_context.h David Mosberger-Tang 2005-07-25  123  reload_context (nv_mm_context_t context)
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  124  {
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  125  	unsigned long rid;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  126  	unsigned long rid_incr = 0;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16 @127  	unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  128  
0a41e250116058 include/asm-ia64/mmu_context.h Peter Chubb          2005-08-16  129  	old_rr4 = ia64_get_rr(RGN_BASE(RGN_HPAGE));
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  130  	rid = context << 3;	/* make space for encoding the region number */
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  131  	rid_incr = 1 << 8;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  132  
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  133  	/* encode the region id, preferred page size, and VHPT enable bit: */
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  134  	rr0 = (rid << 8) | (PAGE_SHIFT << 2) | 1;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  135  	rr1 = rr0 + 1*rid_incr;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  136  	rr2 = rr0 + 2*rid_incr;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  137  	rr3 = rr0 + 3*rid_incr;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  138  	rr4 = rr0 + 4*rid_incr;
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  139  #ifdef  CONFIG_HUGETLB_PAGE
^1da177e4c3f41 include/asm-ia64/mmu_context.h Linus Torvalds       2005-04-16  140  	rr4 = (rr4 & (~(0xfcUL))) | (old_rr4 & 0xfc);
0a41e250116058 include/asm-ia64/mmu_context.h Peter Chubb          2005-08-16  141  

:::::: The code at line 127 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
