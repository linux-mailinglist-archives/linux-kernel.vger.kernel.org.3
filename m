Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A224BEFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiBVChS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBVChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:37:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71924F06
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645497411; x=1677033411;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wt9g+xbv4kUGyhlw3xF9+hVAg2BHrkbKccwzplPszNY=;
  b=FUPtGi+1IB/Y60p4w3syBGyFprWiLHG0lDKKAQ9ZAmKPdE34hrCsxaVI
   fr7egrBpuBHtx8VOQyU3w41xuj2AUpT0iB+OC7Ov936NVKU+MDXiaLnli
   urNPfe/BbjGh1PZkQht5TMAsY3/oshFa5lJJlPXA3Ig2aiPR9LDQz1U1h
   mwid9dQiHDfu3VQKQ/7wWzioqiNertN3u1FlMVaA1u0+aQrXggKrQ6vrV
   ZihrIvKuraS+x9Uu17jT1K/sLdzV9cC0bhCxKwk2fA9hFKJyRufHLo+6f
   xKy7LG96uTcjF1S63zVODbuSvRM5KuZVnBoQcgRVFg2cbel81Grzmr18B
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314860470"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="314860470"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 18:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="636840772"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2022 18:36:49 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nML2m-0002Eo-Et; Tue, 22 Feb 2022 02:36:48 +0000
Date:   Tue, 22 Feb 2022 10:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 15/28]
 arch/x86/include/asm/pgtable.h:928:41: error: implicit declaration of
 function 'p4d_index'
Message-ID: <202202221016.jWajJfJO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   5ca7e5f74d85e6d2ddeabaa1b85b64ae50864676
commit: 1f20265f4c3946344b0e7c88cc5ecd758726c752 [15/28] mm: make x86's definition of p4d_index() the default
config: x86_64-randconfig-a011-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221016.jWajJfJO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=1f20265f4c3946344b0e7c88cc5ecd758726c752
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout 1f20265f4c3946344b0e7c88cc5ecd758726c752
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:136:
   In file included from include/linux/kasan.h:30:
   In file included from include/linux/pgtable.h:6:
>> arch/x86/include/asm/pgtable.h:928:41: error: implicit declaration of function 'p4d_index' [-Werror,-Wimplicit-function-declaration]
           return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
                                                  ^
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:136:
   In file included from include/linux/kasan.h:30:
>> include/linux/pgtable.h:84:29: error: static declaration of 'p4d_index' follows non-static declaration
   static inline unsigned long p4d_index(unsigned long address)
                               ^
   arch/x86/include/asm/pgtable.h:928:41: note: previous implicit declaration is here
           return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
                                                  ^
   2 errors generated.
   make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/p4d_index +928 arch/x86/include/asm/pgtable.h

7cfb81024bc1db Jeremy Fitzhardinge 2009-02-05  922  
7cfb81024bc1db Jeremy Fitzhardinge 2009-02-05  923  /* to find an entry in a page-table-directory. */
b8c1e4293a5d1d Kirill A. Shutemov  2018-06-26  924  static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
3d081b1812bd4d Jeremy Fitzhardinge 2009-02-05  925  {
ed7588d5dc6f5e Kirill A. Shutemov  2018-05-18  926  	if (!pgtable_l5_enabled())
98219dda2ab56c Kirill A. Shutemov  2018-02-14  927  		return (p4d_t *)pgd;
f2a6a7050109e0 Kirill A. Shutemov  2017-03-17 @928  	return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
3d081b1812bd4d Jeremy Fitzhardinge 2009-02-05  929  }
30f103167fcf2b Jeremy Fitzhardinge 2009-02-05  930  

:::::: The code at line 928 was first introduced by commit
:::::: f2a6a7050109e0a5c7a84c70aa6010f682b2f1ee x86: Convert the rest of the code to support p4d_t

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
