Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9756C1E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbiGHVLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiGHVLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:11:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE8A23B0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657314671; x=1688850671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2JCvf91oRpLK80OmLNQDMg22hhmlua66lZr4/XxJfBQ=;
  b=I4UJEGfxPedQwCo/Imwvh9a/GqBeFqXHpfLXbEEt6OUFvmyILFM1dw6t
   vzJVBiD5/PtPn8WmiiGN6HwqedCLcRot9Es9RyJZKJ8qpma2CciKCflCl
   htaQ+Q6+Ebk3y0VrjCK3iRaLZQGKtUtGkn/ZJRb1KS1iPeWHAtY6uUjRx
   TaIsitHssYJrzmN1ipWECHsxzEmSLIcnygbmqvTDjSUQpuXt/Z0Xlsdjr
   q/FgqZOQPCoeQ4sZ+4ZE3JV6WUaC47sUcgF8bNVqDXckmTVfYcRX4346J
   5pHKcoW6r5qUkqoKaUxLvGmB+lFz52JFVA40lEbzWnHGb6Q78kUZiIYum
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285494615"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285494615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736467752"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 14:11:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9vFk-000Nx4-HO;
        Fri, 08 Jul 2022 21:11:08 +0000
Date:   Sat, 9 Jul 2022 05:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>
Subject: arch/mips/boot/compressed/dbg.c:12:13: warning: no previous
 prototype for 'putc'
Message-ID: <202207090522.nxw0ERcT-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a471da3100ef2e8feb8449d378a52e29dd1e9ae1
commit: 606b102876e3741851dfb09d53f3ee57f650a52c drm: fb_helper: fix CONFIG_FB dependency
date:   9 months ago
config: mips-randconfig-r015-20220708 (https://download.01.org/0day-ci/archive/20220709/202207090522.nxw0ERcT-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=606b102876e3741851dfb09d53f3ee57f650a52c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 606b102876e3741851dfb09d53f3ee57f650a52c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

>> arch/mips/boot/compressed/dbg.c:12:13: warning: no previous prototype for 'putc' [-Wmissing-prototypes]
      12 | void __weak putc(char c)
         |             ^~~~
>> arch/mips/boot/compressed/dbg.c:16:6: warning: no previous prototype for 'puts' [-Wmissing-prototypes]
      16 | void puts(const char *s)
         |      ^~~~
>> arch/mips/boot/compressed/dbg.c:26:6: warning: no previous prototype for 'puthex' [-Wmissing-prototypes]
      26 | void puthex(unsigned long long val)
         |      ^~~~~~
--
>> arch/mips/boot/compressed/uart-alchemy.c:4:6: warning: no previous prototype for 'putc' [-Wmissing-prototypes]
       4 | void putc(char c)
         |      ^~~~


vim +/putc +12 arch/mips/boot/compressed/dbg.c

1b93b3c3e94be2 Wu Zhangjin 2009-10-14  11  
e52dd9fc6b9e0c Wu Zhangjin 2010-01-26 @12  void __weak putc(char c)
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  13  {
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  14  }
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  15  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14 @16  void puts(const char *s)
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  17  {
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  18  	char c;
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  19  	while ((c = *s++) != '\0') {
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  20  		putc(c);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  21  		if (c == '\n')
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  22  			putc('\r');
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  23  	}
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  24  }
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  25  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14 @26  void puthex(unsigned long long val)

:::::: The code at line 12 was first introduced by commit
:::::: e52dd9fc6b9e0c17b220bd38371ff15032a1a155 MIPS: Simplify the weak annotation with __weak

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
