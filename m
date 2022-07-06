Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA3567B41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGFBEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFBEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:04:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C3A458
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 18:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657069446; x=1688605446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8gOGUqoUsaeh8k6s6xukSZO0pCloqvc3JODT4DMy+8g=;
  b=NCeCssEbDncvTHZoO5XHCeKyRt5FKCFwFC3RbWVQY1n859xBn0gxTw/v
   OuvJCfR84TlLfwCNgkn1QaEZHrj6TJ+hrm46kw4QJdPYvVgcDymU1YGuZ
   CEqneyFI7yAiixeZeSwT+7ZUxOPcQJDj8zYxas1cCzyPVEQV1TMhjLQx8
   obkop4Z5T2vLWgbLy3VYHPQQ4aFlw7OIAo272HE7yxsPmLZszjONqtAfS
   SU0kfBhlXzXEw51rPQxuXTv+D8ml/OwecUZPQF7lR9W7fMwWR9bZUbO2A
   WzeB806wxD/JUQSANi3Ru2CIPUHIZOTZLjbmP2aEh42STrg5/K6wCg5ur
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="264025193"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="264025193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 18:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="695876476"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2022 18:04:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8tSV-000Jlp-TT;
        Wed, 06 Jul 2022 01:04:03 +0000
Date:   Wed, 6 Jul 2022 09:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 2/50] arch/riscv/include/asm/string.h:25:31:
 error: redefinition of '__memcpy'
Message-ID: <202207060838.WP0TpRCc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   943858df470556d0b7f3b31fcc10931603f0f3cc
commit: 6a48862f530a593cadaab50ae4006b3a70a112e6 [2/50] riscv: optimized memcpy
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060838.WP0TpRCc-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/6a48862f530a593cadaab50ae4006b3a70a112e6
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 6a48862f530a593cadaab50ae4006b3a70a112e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from arch/riscv/lib/string.c:11:
>> arch/riscv/include/asm/string.h:25:31: error: redefinition of '__memcpy'
      25 | #define memcpy(dst, src, len) __memcpy(dst, src, len)
         |                               ^~~~~~~~
   arch/riscv/lib/string.c:90:7: note: in expansion of macro 'memcpy'
      90 | void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
         |       ^~~~~~
   arch/riscv/lib/string.c:31:7: note: previous definition of '__memcpy' with type 'void *(void *, const void *, size_t)' {aka 'void *(void *, const void *, long unsigned int)'}
      31 | void *__memcpy(void *dest, const void *src, size_t count)
         |       ^~~~~~~~


vim +/__memcpy +25 arch/riscv/include/asm/string.h

6a48862f530a59 Matteo Croce 2021-09-29  19  
04091d6c0535f6 Nylon Chen   2020-11-30  20  #define __HAVE_ARCH_MEMMOVE
04091d6c0535f6 Nylon Chen   2020-11-30  21  extern asmlinkage void *memmove(void *, const void *, size_t);
04091d6c0535f6 Nylon Chen   2020-11-30  22  extern asmlinkage void *__memmove(void *, const void *, size_t);
8ad8b72721d0f0 Nick Hu      2020-01-06  23  /* For those files which don't want to check by kasan. */
8ad8b72721d0f0 Nick Hu      2020-01-06  24  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
8ad8b72721d0f0 Nick Hu      2020-01-06 @25  #define memcpy(dst, src, len) __memcpy(dst, src, len)
8ad8b72721d0f0 Nick Hu      2020-01-06  26  #define memset(s, c, n) __memset(s, c, n)
04091d6c0535f6 Nylon Chen   2020-11-30  27  #define memmove(dst, src, len) __memmove(dst, src, len)
9530141455c968 Kefeng Wang  2021-02-25  28  

:::::: The code at line 25 was first introduced by commit
:::::: 8ad8b72721d0f07fa02dbe71f901743f9c71c8e6 riscv: Add KASAN support

:::::: TO: Nick Hu <nickhu@andestech.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
