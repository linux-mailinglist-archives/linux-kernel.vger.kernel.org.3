Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF72F4BD07F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiBTR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:57:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiBTR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:57:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4819292
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645379809; x=1676915809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=di0yTkPPGf0lg8Z1HNTy1Ro4KtR4fZtl+kW8meoe/go=;
  b=gsB0Q7yzgONN54qKRYdTCivoVwGs/3jDltLdinpUN1+p5oSg+Z7kDRzE
   iaklaoG96IdC8k5tgruY91XKE/SnyLxPXOljJ3m7Y/tr1wx4eDjwYKJTr
   rKv3rNhp5aEs3jOLjxyZ6YB+0jIqcOzdBer6z8D8fcxKDcFyOLW+v4XnF
   MXe2/KLTj+GVc3L3pf32+LUgHmn03JWUD30LavwbTnsVeWIbiwJ5EFPGe
   4F6UVjzKtZWIxUdNQ/irEWJnrBmFzcITnXQIkjO33LXJa4uJhb8z6SJpr
   fipfKRMQlPRWB+qyJyDszC4Luj8bOv/YvkYqf0BZSvbPiDipKVwx/dClz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251573666"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="251573666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 09:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="504565884"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Feb 2022 09:56:45 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLqRx-0000Y4-6C; Sun, 20 Feb 2022 17:56:45 +0000
Date:   Mon, 21 Feb 2022 01:55:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 15/28]
 include/linux/pgtable.h:84:29: error: redefinition of 'p4d_index'
Message-ID: <202202210124.8WuKWr52-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   1faeabde0ba3c81ad666ab924ab79ef64843d40d
commit: 8009c0d425d69c34521e0f8123ff62786f1ac8fa [15/28] mm: add default definition of p4d_index()
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220221/202202210124.8WuKWr52-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=8009c0d425d69c34521e0f8123ff62786f1ac8fa
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 8009c0d425d69c34521e0f8123ff62786f1ac8fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:13:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:33:
>> include/linux/pgtable.h:84:29: error: redefinition of 'p4d_index'
   static inline unsigned long p4d_index(unsigned long address)
                               ^
   arch/x86/include/asm/pgtable.h:904:29: note: previous definition is here
   static inline unsigned long p4d_index(unsigned long address)
                               ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/p4d_index +84 include/linux/pgtable.h

    82	
    83	#ifndef p4d_index
  > 84	static inline unsigned long p4d_index(unsigned long address)
    85	{
    86		return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
    87	}
    88	#define p4d_index p4d_index
    89	#endif
    90	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
