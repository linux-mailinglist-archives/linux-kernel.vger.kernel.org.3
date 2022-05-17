Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C181552AC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiEQT5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbiEQT5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:57:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC038788
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652817418; x=1684353418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fPsVOaqVsswBJF7YYuk48XX7iG9H4V7CPV/kkGoqpTk=;
  b=P93RtFp0e1QZST5od1ncqTNRtjtsJdIS+Xe1c3WWBaqelo0I9E8HAvB8
   5sot28D4A5qVWqOOo5zTe8BS8xHUCOyFc9CIKlEZQ0u4vtk6Xh+dvlbtF
   eFLdB4XLqky8MYIDfWmq1ovjjnjw+fkVJa+xOFmRQUFcdMo+U5agN48dI
   CahFvIzc2MtVtXfDLV0PmBNOoYi0x2Es/Pg080op4PYIVKKVyyTL2ErC4
   VYTd38L97Ek3qRxqfaVmA14z6aT+8RL5sS1Vrn1ITIulBNQ7jGwvZ51Se
   7r0awlTfXkqIUrcdfm3PbH1qQyGRABjCHwxxRtoI7oJqpWhLiw8ON0O1F
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="357718982"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="357718982"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 12:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="700220258"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 May 2022 12:56:55 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr3JP-0001Kv-8R;
        Tue, 17 May 2022 19:56:55 +0000
Date:   Wed, 18 May 2022 03:56:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 6050/6576]
 util/parse-events-bison.c:1565:6: error: expected '}'
Message-ID: <202205180342.UWV0h7yb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   4aa8770e7dfca33d694a86ec8fc85900ada99c26
commit: 773ca67ffc964785fae7e950e164ed845c9b365d [6050/6576] stat: fix inconsistency between struct stat and struct compat_stat
config: x86_64-randconfig-r036-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180342.UWV0h7yb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=773ca67ffc964785fae7e950e164ed845c9b365d
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 773ca67ffc964785fae7e950e164ed845c9b365d
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 SHELL=/bin/bash tools/all

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/linux-5.15.y HEAD 4aa8770e7dfca33d694a86ec8fc85900ada99c26 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
   Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
   Makefile.config:573: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
   Makefile.config:621: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
   Makefile.config:739: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
   Makefile.config:786: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
   Makefile.config:821: No 'python-config' tool was found: disables Python support - please install python-devel/python-dev
   Makefile.config:883: No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling
   Makefile.config:927: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
   Makefile.config:1006: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
   Makefile.config:1032: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
   pmu-events/jevents.c:73:22: warning: no previous prototype for function 'convert' [-Wmissing-prototypes]
   enum aggr_mode_class convert(const char *aggr_mode)
                        ^
   pmu-events/jevents.c:73:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   enum aggr_mode_class convert(const char *aggr_mode)
   ^
   static 
   event-parse.c:112:13: warning: variable 'x' set but not used [-Wunused-but-set-variable]
           static int x;
                      ^
   1 warning generated.
   1 warning generated.
     PERF_VERSION = 5.15.35.g773ca67ffc96
   tests/mmap-basic.c:112:8: error: variable 'foo' set but not used [-Werror,-Wunused-but-set-variable]
                           int foo = syscalls[i]();
                               ^
   1 error generated.
   make[6]: *** [/kbuild/worktree/build-ktools-consumer/tools/build/Makefile.build:97: /kbuild/worktree/build-ktools-consumer/tools/perf/tests/mmap-basic.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
>> util/parse-events-bison.c:1565:6: error: expected '}'
       {
        ^
   util/parse-events-bison.c:1565:5: note: to match this '{'
       {
       ^
>> util/parse-events-bison.c:1565:6: error: expected '}'
       {
        ^
   util/parse-events-bison.c:1372:1: note: to match this '{'
   {
   ^
   util/parse-events-bison.c:1501:9: error: use of undeclared label 'yyexhaustedlab'
           YYNOMEM;
           ^
   util/parse-events-bison.c:844:30: note: expanded from macro 'YYNOMEM'
   #define YYNOMEM         goto yyexhaustedlab
                                ^
   util/parse-events-bison.c:1532:9: error: use of undeclared label 'yyabortlab'
           YYABORT;
           ^
   util/parse-events-bison.c:842:30: note: expanded from macro 'YYABORT'
   #define YYABORT         goto yyabortlab
                                ^
   util/parse-events-bison.c:1538:5: error: use of undeclared label 'yyacceptlab'
       YYACCEPT;
       ^
   util/parse-events-bison.c:841:30: note: expanded from macro 'YYACCEPT'
   #define YYACCEPT        goto yyacceptlab
                                ^
   util/parse-events-bison.c:1553:10: error: use of undeclared label 'yydefault'
       goto yydefault;
            ^
   6 errors generated.
   make[6]: *** [/kbuild/worktree/build-ktools-consumer/tools/build/Makefile.build:97: /kbuild/worktree/build-ktools-consumer/tools/perf/util/parse-events-bison.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
   make[5]: *** [/kbuild/worktree/build-ktools-consumer/tools/build/Makefile.build:139: tests] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[5]: *** [/kbuild/worktree/build-ktools-consumer/tools/build/Makefile.build:139: util] Error 2
   make[4]: *** [Makefile.perf:658: /kbuild/worktree/build-ktools-consumer/tools/perf/perf-in.o] Error 2
   make[3]: *** [Makefile.perf:238: sub-make] Error 2
   make[2]: *** [Makefile:70: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
