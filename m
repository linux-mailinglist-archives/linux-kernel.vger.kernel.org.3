Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3F04F8B04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiDGXmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiDGXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:42:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119BB1E8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649374816; x=1680910816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0VtU0UneVuCkQyvNiHQoIuOKZgrxrtzsJsTWmdxkcV4=;
  b=Fb+Fx/4kf/PsCdcKN5vzoYuwXX3q/dEydt85CUjqaHQXDBkiuA/vaCTB
   /92au/qyxctvPwADhLEn0VWVN196K+/Cpg5fJ2ba67C5s51fAz6BUzDsd
   jCKyfshrI05wX2lfLF8u5twpsno6x1RJgE04Ju6lDD9mwAaUV1AWmjjwg
   jG5tFIX2fq+zaMJ2ddV4khwH5q53JLcGvkJE4EhzsgvGGgvP2eyamPMrq
   K0SDN00ZwLG93/0RJ2Zdrlhpk9MU2Efgh7pylK4pM7sym1zfA0Tie0DXx
   2zavh9SNxzJReOCdfGriSy46xPeyh+WvSgSMm1fBZgp0aTWJxYe9jvNue
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241397956"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="241397956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="506344200"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2022 16:40:14 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncbjZ-0005rv-Ml;
        Thu, 07 Apr 2022 23:40:13 +0000
Date:   Fri, 8 Apr 2022 07:39:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 2/5] include/linux/kallsyms.h:107:5: warning:
 no previous prototype for function 'kallsyms_lookup_names'
Message-ID: <202204080713.3jWhtN6s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   baa78873a24a7e0f21b0a01e82214ce9a096e147
commit: 3f047c53b0e7e747b76f0b3d032e476efbe1222f [2/5] kallsyms: Add kallsyms_lookup_names function
config: powerpc-mpc8313_rdb_defconfig (https://download.01.org/0day-ci/archive/20220408/202204080713.3jWhtN6s-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b306233f78876a1d197ed6e1f05785505de7c63)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=3f047c53b0e7e747b76f0b3d032e476efbe1222f
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 3f047c53b0e7e747b76f0b3d032e476efbe1222f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:36:
   In file included from arch/powerpc/include/asm/dbell.h:17:
   In file included from arch/powerpc/include/asm/kvm_ppc.h:19:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/ftrace.h:12:
>> include/linux/kallsyms.h:107:5: warning: no previous prototype for function 'kallsyms_lookup_names' [-Wmissing-prototypes]
   int kallsyms_lookup_names(const char **syms, u32 cnt, unsigned long *addrs)
       ^
   include/linux/kallsyms.h:107:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int kallsyms_lookup_names(const char **syms, u32 cnt, unsigned long *addrs)
   ^
   static 
   1 warning generated.
   /usr/bin/ld: unrecognised emulation mode: elf32ppclinux
   Supported emulations: elf_x86_64 elf32_x86_64 elf_i386 elf_iamcu elf_l1om elf_k1om i386pep i386pe
   clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
   make[2]: *** [arch/powerpc/kernel/vdso/Makefile:65: arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
   make[2]: Target 'include/generated/vdso32-offsets.h' not remade because of errors.
   make[1]: *** [arch/powerpc/Makefile:423: vdso_prepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/kallsyms_lookup_names +107 include/linux/kallsyms.h

   106	
 > 107	int kallsyms_lookup_names(const char **syms, u32 cnt, unsigned long *addrs)
   108	{
   109		return -ERANGE;
   110	}
   111	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
