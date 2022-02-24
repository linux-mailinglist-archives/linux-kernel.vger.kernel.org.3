Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C54C2FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiBXPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiBXPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:32:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AED15A3D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645716697; x=1677252697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ohKbLViu2Rv+K9nA7kE7xEdvvYGrACT/Wz0SC7agW4Q=;
  b=gXoSPdYx2lWidYq5tqVxtPAprp3eQTp3u43Vy+H8jhHeufsI1zWRCYBm
   QAfVU/pvOxOQbc23KQNujZslKyHrTMv1y+a99SHFe818BKEhMs2OhCCp7
   4f1GCehNcaKdahC24ea5KL67Rjx+ux/Jn6w8RO296W90m53rYCVIUNpUg
   yXyzS46ueuIHje85EepT+tqz02R+DqTPqNN5wnwdh41tiGC8h8B0/j0M8
   SDabCR1vR4ct6kHtTTpQauj6TfHgiYgfg7D29HqicOe/K+3kI2rEiOatG
   eVkLXrbEftYxEJtwrfWCVaMBouwsQtvpQRDP+FcOFFdbI2M9bf8IfRU/r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251088525"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251088525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:31:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="607451426"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2022 07:31:26 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNG5V-0003FK-Pg; Thu, 24 Feb 2022 15:31:25 +0000
Date:   Thu, 24 Feb 2022 23:30:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yee Lee <yee.lee@mediatek.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-kiwi-5.10
 8861/9999] kernel/kcov.c:296:14: warning: conflicting types for built-in
 function '__sanitizer_cov_trace_switch'; expected 'void(long long unsigned
 int,  void *)'
Message-ID: <202202242354.7zL85dQI-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-kiwi-5.10
head:   b0f8b9f7d23884213c86f388be625777f61fb769
commit: c2985e13ddc87258e98fad13e435129a210092b6 [8861/9999] UPSTREAM: ubsan: enable for all*config builds
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220224/202202242354.7zL85dQI-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/c2985e13ddc87258e98fad13e435129a210092b6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-kiwi-5.10
        git checkout c2985e13ddc87258e98fad13e435129a210092b6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/kcov.c:296:14: warning: conflicting types for built-in function '__sanitizer_cov_trace_switch'; expected 'void(long long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
     296 | void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/asm-generic/bug.h:20,
                    from arch/powerpc/include/asm/bug.h:109,
                    from include/linux/bug.h:5,
                    from arch/powerpc/include/asm/cmpxchg.h:8,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from kernel/kcov.c:5:
   kernel/kcov.c:322:15: warning: conflicting types for built-in function '__sanitizer_cov_trace_switch'; expected 'void(long long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
     322 | EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:125:28: note: in definition of macro '___EXPORT_SYMBOL'
     125 |         extern typeof(sym) sym;                                                 \
         |                            ^~~
   include/linux/export.h:187:41: note: in expansion of macro '__EXPORT_SYMBOL'
     187 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:190:41: note: in expansion of macro '_EXPORT_SYMBOL'
     190 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/kcov.c:322:1: note: in expansion of macro 'EXPORT_SYMBOL'
     322 | EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
         | ^~~~~~~~~~~~~


vim +296 kernel/kcov.c

ded97d2c2b2c5f Victor Chibotaru 2017-11-17  295  
ded97d2c2b2c5f Victor Chibotaru 2017-11-17 @296  void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  297  {
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  298  	u64 i;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  299  	u64 count = cases[0];
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  300  	u64 size = cases[1];
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  301  	u64 type = KCOV_CMP_CONST;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  302  
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  303  	switch (size) {
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  304  	case 8:
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  305  		type |= KCOV_CMP_SIZE(0);
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  306  		break;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  307  	case 16:
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  308  		type |= KCOV_CMP_SIZE(1);
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  309  		break;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  310  	case 32:
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  311  		type |= KCOV_CMP_SIZE(2);
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  312  		break;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  313  	case 64:
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  314  		type |= KCOV_CMP_SIZE(3);
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  315  		break;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  316  	default:
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  317  		return;
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  318  	}
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  319  	for (i = 0; i < count; i++)
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  320  		write_comp_data(type, cases[i + 2], val, _RET_IP_);
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  321  }
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  322  EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  323  #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
ded97d2c2b2c5f Victor Chibotaru 2017-11-17  324  

:::::: The code at line 296 was first introduced by commit
:::::: ded97d2c2b2c5f1dcced0bc57133f7753b037dfc kcov: support comparison operands collection

:::::: TO: Victor Chibotaru <tchibo@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
