Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696B64C245F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiBXHJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiBXHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:09:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F722F97F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645686551; x=1677222551;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1AEB+rXO4qYNx/T+8IC5iwE0UDDcuGwkqExAN7yCpKE=;
  b=Wmfyarw+9MbQgvONTa0W1ixjMbVZmD6QcXfnkdxsXuNtu3GCm8drIyDw
   C7q9RUTKHSmHQlSTjoCGTnxiadFygtZNYi+wc35iTF3Nl1R3S83GCbmnc
   0Z3AuidEaznX9ihC90ingbxAreyG6H4JUIvl23f9sO8+NCWRmWsjOQ+zY
   y+KRF7Y69o6p/YIhNH1+ohmJVyys51yf/5pOF4Z19xLTyQNZuN2EO/Zms
   BpBmC00WSuv9k/69pBX4CcZgwc2Xo6z8u6ri2uX16ZTD97Poe3oUQjET2
   JAE9xMHM/WdWKuLFPwas2J3ppds7nDmUpyo9hRm7Nui4iIbsE/698K3wH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235676720"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="235676720"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 23:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="543609273"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2022 23:09:08 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN8FP-0002R6-9V; Thu, 24 Feb 2022 07:09:07 +0000
Date:   Thu, 24 Feb 2022 15:08:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:next/linux-next/akpm 334/334]
 lib/Kconfig.debug:337:error: recursive dependency detected!
Message-ID: <202202241522.25enBK5u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/akpm
head:   4b738f94b3a6492ae5adad0940d580851fb9019b
commit: 4b738f94b3a6492ae5adad0940d580851fb9019b [334/334] Merge commit 'next-20220215~2' into tmp-akpm/master
config: hexagon-randconfig-r045-20220223
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4b738f94b3a6492ae5adad0940d580851fb9019b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/akpm
        git checkout 4b738f94b3a6492ae5adad0940d580851fb9019b
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon  randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/Kconfig.debug:343:warning: choice value used outside its choice group
   lib/Kconfig.debug:355:warning: choice value used outside its choice group
   lib/Kconfig.debug:364:warning: choice value used outside its choice group
>> lib/Kconfig.debug:337:error: recursive dependency detected!
   lib/Kconfig.debug:337: choice <choice> contains symbol DEBUG_INFO
   lib/Kconfig.debug:227: symbol DEBUG_INFO is selected by DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
   lib/Kconfig.debug:253: symbol DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is part of choice <choice>
   lib/Kconfig.debug:234: choice <choice> contains symbol DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
   lib/Kconfig.debug:253: symbol DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is part of choice <choice>
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"


vim +337 lib/Kconfig.debug

695afd3d7d58ec Sedat Dilek      2020-08-16  294  
6dfc06651b3d29 Dave Hansen      2013-07-01  295  config DEBUG_INFO_REDUCED
6dfc06651b3d29 Dave Hansen      2013-07-01  296  	bool "Reduce debugging information"
6dfc06651b3d29 Dave Hansen      2013-07-01  297  	help
6dfc06651b3d29 Dave Hansen      2013-07-01  298  	  If you say Y here gcc is instructed to generate less debugging
6dfc06651b3d29 Dave Hansen      2013-07-01  299  	  information for structure types. This means that tools that
6dfc06651b3d29 Dave Hansen      2013-07-01  300  	  need full debugging information (like kgdb or systemtap) won't
6dfc06651b3d29 Dave Hansen      2013-07-01  301  	  be happy. But if you merely need debugging information to
6dfc06651b3d29 Dave Hansen      2013-07-01  302  	  resolve line numbers there is no loss. Advantage is that
6dfc06651b3d29 Dave Hansen      2013-07-01  303  	  build directory object sizes shrink dramatically over a full
6dfc06651b3d29 Dave Hansen      2013-07-01  304  	  DEBUG_INFO build and compile times are reduced too.
6dfc06651b3d29 Dave Hansen      2013-07-01  305  	  Only works with newer gcc versions.
6dfc06651b3d29 Dave Hansen      2013-07-01  306  
10e68b02c861cc Nick Desaulniers 2020-05-26  307  config DEBUG_INFO_COMPRESSED
10e68b02c861cc Nick Desaulniers 2020-05-26  308  	bool "Compressed debugging information"
10e68b02c861cc Nick Desaulniers 2020-05-26  309  	depends on $(cc-option,-gz=zlib)
10e68b02c861cc Nick Desaulniers 2020-05-26  310  	depends on $(ld-option,--compress-debug-sections=zlib)
10e68b02c861cc Nick Desaulniers 2020-05-26  311  	help
10e68b02c861cc Nick Desaulniers 2020-05-26  312  	  Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
10e68b02c861cc Nick Desaulniers 2020-05-26  313  	  5.0+, binutils 2.26+, and zlib.
10e68b02c861cc Nick Desaulniers 2020-05-26  314  
10e68b02c861cc Nick Desaulniers 2020-05-26  315  	  Users of dpkg-deb via scripts/package/builddeb may find an increase in
10e68b02c861cc Nick Desaulniers 2020-05-26  316  	  size of their debug .deb packages with this config set, due to the
10e68b02c861cc Nick Desaulniers 2020-05-26  317  	  debug info being compressed with zlib, then the object files being
10e68b02c861cc Nick Desaulniers 2020-05-26  318  	  recompressed with a different compression scheme. But this is still
10e68b02c861cc Nick Desaulniers 2020-05-26  319  	  preferable to setting $KDEB_COMPRESS to "none" which would be even
10e68b02c861cc Nick Desaulniers 2020-05-26  320  	  larger.
10e68b02c861cc Nick Desaulniers 2020-05-26  321  
866ced950bcd54 Andi Kleen       2014-07-30  322  config DEBUG_INFO_SPLIT
866ced950bcd54 Andi Kleen       2014-07-30  323  	bool "Produce split debuginfo in .dwo files"
9d9374440072eb Masahiro Yamada  2019-02-22  324  	depends on $(cc-option,-gsplit-dwarf)
866ced950bcd54 Andi Kleen       2014-07-30  325  	help
866ced950bcd54 Andi Kleen       2014-07-30  326  	  Generate debug info into separate .dwo files. This significantly
866ced950bcd54 Andi Kleen       2014-07-30  327  	  reduces the build directory size for builds with DEBUG_INFO,
866ced950bcd54 Andi Kleen       2014-07-30  328  	  because it stores the information only once on disk in .dwo
866ced950bcd54 Andi Kleen       2014-07-30  329  	  files instead of multiple times in object files and executables.
866ced950bcd54 Andi Kleen       2014-07-30  330  	  In addition the debug information is also compressed.
866ced950bcd54 Andi Kleen       2014-07-30  331  
866ced950bcd54 Andi Kleen       2014-07-30  332  	  Requires recent gcc (4.7+) and recent gdb/binutils.
866ced950bcd54 Andi Kleen       2014-07-30  333  	  Any tool that packages or reads debug information would need
866ced950bcd54 Andi Kleen       2014-07-30  334  	  to know about the .dwo files and include them.
866ced950bcd54 Andi Kleen       2014-07-30  335  	  Incompatible with older versions of ccache.
866ced950bcd54 Andi Kleen       2014-07-30  336  
a66049e2cf0ef1 Nick Desaulniers 2021-02-05 @337  choice
a66049e2cf0ef1 Nick Desaulniers 2021-02-05  338  	prompt "DWARF version"
a66049e2cf0ef1 Nick Desaulniers 2021-02-05  339  	help
a66049e2cf0ef1 Nick Desaulniers 2021-02-05  340  	  Which version of DWARF debug info to emit.
a66049e2cf0ef1 Nick Desaulniers 2021-02-05  341  

:::::: The code at line 337 was first introduced by commit
:::::: a66049e2cf0ef166dba5bafdbb3062287fc965ad Kbuild: make DWARF version a choice

:::::: TO: Nick Desaulniers <ndesaulniers@google.com>
:::::: CC: Masahiro Yamada <masahiroy@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
