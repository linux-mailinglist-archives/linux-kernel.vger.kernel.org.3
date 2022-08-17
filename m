Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF847596F94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiHQNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiHQNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:11:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FCD12E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741881; x=1692277881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xZVZDEskh8xmo6si1vLuNH8TuAVa7WGpjzcJCw2HTI0=;
  b=alT3vu8mkEHGPFFfu48KgtxCNCTqRuag1Pr7zQ/apbAufKxzzOEulGXv
   DVXdAnnzDfNjFYPUBujm4Nlugi2WJjtJql8onh5l5OvfH7duv/XpY6iMx
   53WoDJFEts1CwquEdX/yYcAGhPijJb/scBStLGrGq6nP45+SUfUqULVpF
   E6iF1pG1zWMpYfeaycOJk6nOXbBwzcP9X2Z+htbNURlgj1kxJVs5iuTdQ
   TZKhNeRePoWw+at4JDNVIpAzQ6nYRDjm5NHVUnd/2PG7EK8ti9iL0T+ic
   OCOgxet96V0VUDmTUuf6GLFZDxQ2NaOyn5z5T4jY0L5K62qpCuQYWv/D4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="272254970"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="272254970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="636371738"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 06:11:19 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOIpK-0000wI-2Z;
        Wed, 17 Aug 2022 13:11:18 +0000
Date:   Wed, 17 Aug 2022 21:11:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:kallsyms 2/2] scripts/mod/modpost.h:87:18: error: lvalue
 required as unary '&' operand
Message-ID: <202208172113.PQCj5XHg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux kallsyms
head:   ce39255907a23839bfa3cf1e68a5ed8cfeabc407
commit: ce39255907a23839bfa3cf1e68a5ed8cfeabc407 [2/2] kallsyms: add option to include relative filepaths into kallsyms
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220817/202208172113.PQCj5XHg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/ce39255907a23839bfa3cf1e68a5ed8cfeabc407
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin kallsyms
        git checkout ce39255907a23839bfa3cf1e68a5ed8cfeabc407
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from scripts/mod/sympath.c:15:
   scripts/mod/sympath.c: In function 'move_code':
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:100:31: note: in expansion of macro 't'
     100 |                 eh->e_shoff = t(h(eh->e_shoff) + off);
         |                               ^
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:103:31: note: in expansion of macro 't'
     103 |                 eh->e_phoff = t(h(eh->e_phoff) + off);
         |                               ^
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:115:43: note: in expansion of macro 't'
     115 |                         iter->sh_offset = t(h(iter->sh_offset) + off);
         |                                           ^
   scripts/mod/sympath.c: In function 'fix_strtab':
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:132:29: note: in expansion of macro 't'
     132 |         st->strh->sh_size = t(h(st->strh->sh_size) + len);
         |                             ^
   scripts/mod/sympath.c: In function 'add_file_sym':
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:169:29: note: in expansion of macro 't'
     169 |         st->symh->sh_size = t(h(st->symh->sh_size) + h(st->symh->sh_entsize));
         |                             ^
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:170:29: note: in expansion of macro 't'
     170 |         st->symh->sh_info = t(h(st->symh->sh_info) + 1);
         |                             ^
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:172:24: note: in expansion of macro 't'
     172 |         pos->st_info = t((STB_LOCAL << 4) | STT_FILE);
         |                        ^
>> scripts/mod/modpost.h:87:18: error: lvalue required as unary '&' operand
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                  ^
   scripts/mod/sympath.c:19:25: note: in expansion of macro 'TO_NATIVE'
      19 | #define t(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:173:25: note: in expansion of macro 't'
     173 |         pos->st_shndx = t(SHN_ABS);
         |                         ^
>> scripts/mod/modpost.h:87:24: warning: passing argument 2 of '__endian' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                        ^~~~~~
   scripts/mod/sympath.c:18:25: note: in expansion of macro 'TO_NATIVE'
      18 | #define h(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:177:38: note: in expansion of macro 'h'
     177 |              *end = (void *)st->sh + h(eh->e_shnum) * h(eh->e_shentsize);
         |                                      ^
   scripts/mod/modpost.h:77:52: note: expected 'void *' but argument is of type 'const Elf32_Half *' {aka 'const short unsigned int *'}
      77 | static inline void __endian(const void *src, void *dest, unsigned int size)
         |                                              ~~~~~~^~~~
>> scripts/mod/modpost.h:87:24: warning: passing argument 2 of '__endian' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                        ^~~~~~
   scripts/mod/sympath.c:18:25: note: in expansion of macro 'TO_NATIVE'
      18 | #define h(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:177:55: note: in expansion of macro 'h'
     177 |              *end = (void *)st->sh + h(eh->e_shnum) * h(eh->e_shentsize);
         |                                                       ^
   scripts/mod/modpost.h:77:52: note: expected 'void *' but argument is of type 'const Elf32_Half *' {aka 'const short unsigned int *'}
      77 | static inline void __endian(const void *src, void *dest, unsigned int size)
         |                                              ~~~~~~^~~~
>> scripts/mod/modpost.h:87:24: warning: passing argument 2 of '__endian' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      87 |         __endian(&(x), &(__x), sizeof(__x));                    \
         |                        ^~~~~~
   scripts/mod/sympath.c:18:25: note: in expansion of macro 'TO_NATIVE'
      18 | #define h(x)            TO_NATIVE(x)
         |                         ^~~~~~~~~
   scripts/mod/sympath.c:178:48: note: in expansion of macro 'h'
     178 |              iter < end; iter = (void *)iter + h(eh->e_shentsize)) {
         |                                                ^
   scripts/mod/modpost.h:77:52: note: expected 'void *' but argument is of type 'const Elf32_Half *' {aka 'const short unsigned int *'}
      77 | static inline void __endian(const void *src, void *dest, unsigned int size)
         |                                              ~~~~~~^~~~
>> scripts/mod/sympath.c:185:45: warning: right shift count >= width of type [-Wshift-count-overflow]
     185 |                         if (h(rela->r_info) >> 32 >=
         |                                             ^~
   make[2]: *** [scripts/Makefile.host:95: scripts/mod/sympath] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1206: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +87 scripts/mod/modpost.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  83  
^1da177e4c3f41 Linus Torvalds 2005-04-16  84  #define TO_NATIVE(x)						\
^1da177e4c3f41 Linus Torvalds 2005-04-16  85  ({								\
^1da177e4c3f41 Linus Torvalds 2005-04-16  86  	typeof(x) __x;						\
^1da177e4c3f41 Linus Torvalds 2005-04-16 @87  	__endian(&(x), &(__x), sizeof(__x));			\
^1da177e4c3f41 Linus Torvalds 2005-04-16  88  	__x;							\
^1da177e4c3f41 Linus Torvalds 2005-04-16  89  })
^1da177e4c3f41 Linus Torvalds 2005-04-16  90  

:::::: The code at line 87 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
