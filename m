Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC1528272
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiEPKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbiEPKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:43:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1586324598
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652697811; x=1684233811;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Owx64G3ecx8UOtuzhqX3Xd3y5R0C4s+r3X/71tgzngY=;
  b=FAQ72zdyTH75wtBwMgUwiUW3tXilfBVQt7aHPf0J0+E4hsUjqQnwTcds
   +hcOyZRQ3pdZrJGs0IWmM3Vzt3r6Rw7LZAcDmmH+eQ+nLvSRT0wIAYpCz
   kO0PL5qX9oVbqfaLEqAcpmCfDbPTogVzU9tgHO0SljK0AtJP37JMFjtv0
   BgULJfS4AdQWuJT2803rChQo/yycFWpF/hxkokMdfzwiaxv81boXF+7/u
   E0utFeNXj3AYh90bsnwrVEg/AUz42TWmBgYoss80k5G0fUmzh34zizGO/
   EBtUIrlOjZG74i2G+0fq1ajIrHn+10Jgic25+s9AcU6PSZ706I+cxWghj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="258363991"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="258363991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 03:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="713310177"
Received: from lkp-server02.sh.intel.com (HELO 0628dcddc537) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2022 03:43:27 -0700
Received: from kbuild by 0628dcddc537 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqYCE-00001I-Ja;
        Mon, 16 May 2022 10:43:26 +0000
Date:   Mon, 16 May 2022 18:42:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [akpm-mm:mm-stable 118/151] arch/riscv/include/asm/pgtable.h:662:16:
 error: implicit declaration of function 'pud_leaf'; did you mean 'pmd_leaf'?
Message-ID: <202205161811.2nLxmN2O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-stable
head:   bbe832b9db2e1ad21522f8f0bf02775fff8a0e0e
commit: 3fee229a8eb936b96933c6b2cd02d2e87a4cc997 [118/151] riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
config: riscv-randconfig-p002-20220516 (https://download.01.org/0day-ci/archive/20220516/202205161811.2nLxmN2O-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=3fee229a8eb936b96933c6b2cd02d2e87a4cc997
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-stable
        git checkout 3fee229a8eb936b96933c6b2cd02d2e87a4cc997
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from arch/riscv/kernel/asm-offsets.c:10:
   arch/riscv/include/asm/pgtable.h: In function 'pud_user_accessible_page':
>> arch/riscv/include/asm/pgtable.h:662:16: error: implicit declaration of function 'pud_leaf'; did you mean 'pmd_leaf'? [-Werror=implicit-function-declaration]
     662 |         return pud_leaf(pud) && pud_user(pud);
         |                ^~~~~~~~
         |                pmd_leaf
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +662 arch/riscv/include/asm/pgtable.h

   659	
   660	static inline bool pud_user_accessible_page(pud_t pud)
   661	{
 > 662		return pud_leaf(pud) && pud_user(pud);
   663	}
   664	#endif
   665	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
