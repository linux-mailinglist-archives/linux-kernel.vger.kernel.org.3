Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3748DEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiAMUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:07:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:43561 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232557AbiAMUHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642104424; x=1673640424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4LxGpjlcwkojCTGtiOfqq2DXhRhPeZqG9pRj/KNL/Jk=;
  b=n7dvPp6TL1WhApm6SbH/iSols8Y0VTND7+oxGTVY23Cz3zHaApwbL487
   Q8mRdDq3Xzg6TJNXvgqZ1Dn502RlDGGSwajzMkgE+3mP7n0n95//FPkET
   OH0PftyJ50PSn32SZdLcWXyGaRDlsyJiIh4Nkxqm5ploejttzHEfCPnJ0
   whobBwU+qGAAgIU4sBgdJRPhr3LFy6D2OvDFbvNaop/AvBI98vElhQlqF
   azJN5L9mPPskFaqLRWyCLHlfTVLnjfGY/8DSlS50+0t89+TBUBoylLZPw
   dQRgHuOmtozX62Iceuu9nJLHylllvYto7vCgGjn9gSy3vpEdJSTjw3zvO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244307011"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244307011"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 12:07:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="559228131"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2022 12:07:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n86NB-0007bT-9L; Thu, 13 Jan 2022 20:07:01 +0000
Date:   Fri, 14 Jan 2022 04:06:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:treewide/gnu99 2/2] arch/arc/include/asm/disasm.h:32:60:
 warning: left shift of negative value
Message-ID: <202201140413.8kgvmUzA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git treewide/gnu99
head:   4c56f3c557cbc276326c329e05f64a53398affec
commit: 4c56f3c557cbc276326c329e05f64a53398affec [2/2] treewide: use -std=gnu99
config: arc-randconfig-r033-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140413.8kgvmUzA-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=4c56f3c557cbc276326c329e05f64a53398affec
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark treewide/gnu99
        git checkout 4c56f3c557cbc276326c329e05f64a53398affec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arc/kernel/disasm.c:13:
   arch/arc/kernel/disasm.c: In function 'disasm_instr':
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:50:47: note: in expansion of macro 'BITS'
      50 | #define FIELD_s25(word)         sign_extend(((BITS(word, 0, 3) << 21) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:73:25: note: in expansion of macro 'FIELD_s25'
      73 |                         FIELD_s25(state->words[0]) :
         |                         ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:51:42: note: in expansion of macro 'BITS'
      51 |                                         (BITS(word, 6, 15) << 11) | \
         |                                          ^~~~
   arch/arc/kernel/disasm.c:73:25: note: in expansion of macro 'FIELD_s25'
      73 |                         FIELD_s25(state->words[0]) :
         |                         ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:52:42: note: in expansion of macro 'BITS'
      52 |                                         (BITS(word, 17, 26) << 1)), 12)
         |                                          ^~~~
   arch/arc/kernel/disasm.c:73:25: note: in expansion of macro 'FIELD_s25'
      73 |                         FIELD_s25(state->words[0]) :
         |                         ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:48:47: note: in expansion of macro 'BITS'
      48 | #define FIELD_s21(word)         sign_extend(((BITS(word, 6, 15) << 11) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:74:25: note: in expansion of macro 'FIELD_s21'
      74 |                         FIELD_s21(state->words[0]);
         |                         ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:49:42: note: in expansion of macro 'BITS'
      49 |                                         (BITS(word, 17, 26) << 1)), 12)
         |                                          ^~~~
   arch/arc/kernel/disasm.c:74:25: note: in expansion of macro 'FIELD_s21'
      74 |                         FIELD_s21(state->words[0]);
         |                         ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:50:47: note: in expansion of macro 'BITS'
      50 | #define FIELD_s25(word)         sign_extend(((BITS(word, 0, 3) << 21) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:86:34: note: in expansion of macro 'FIELD_s25'
      86 |                                 (FIELD_s25(state->words[0]) & ~0x3) :
         |                                  ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:51:42: note: in expansion of macro 'BITS'
      51 |                                         (BITS(word, 6, 15) << 11) | \
         |                                          ^~~~
   arch/arc/kernel/disasm.c:86:34: note: in expansion of macro 'FIELD_s25'
      86 |                                 (FIELD_s25(state->words[0]) & ~0x3) :
         |                                  ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:52:42: note: in expansion of macro 'BITS'
      52 |                                         (BITS(word, 17, 26) << 1)), 12)
         |                                          ^~~~
   arch/arc/kernel/disasm.c:86:34: note: in expansion of macro 'FIELD_s25'
      86 |                                 (FIELD_s25(state->words[0]) & ~0x3) :
         |                                  ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:48:47: note: in expansion of macro 'BITS'
      48 | #define FIELD_s21(word)         sign_extend(((BITS(word, 6, 15) << 11) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:87:33: note: in expansion of macro 'FIELD_s21'
      87 |                                 FIELD_s21(state->words[0]);
         |                                 ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:49:42: note: in expansion of macro 'BITS'
      49 |                                         (BITS(word, 17, 26) << 1)), 12)
         |                                          ^~~~
   arch/arc/kernel/disasm.c:87:33: note: in expansion of macro 'FIELD_s21'
      87 |                                 FIELD_s21(state->words[0]);
         |                                 ^~~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:46:47: note: in expansion of macro 'BITS'
      46 | #define FIELD_s9(word)          sign_extend(((BITS(word, 15, 15) << 8) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:92:34: note: in expansion of macro 'FIELD_s9'
      92 |                         fieldA = FIELD_s9(state->words[0]) & ~0x3;
         |                                  ^~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:47:41: note: in expansion of macro 'BITS'
      47 |                                         BITS(word, 16, 23)), 9)
         |                                         ^~~~
   arch/arc/kernel/disasm.c:92:34: note: in expansion of macro 'FIELD_s9'
      92 |                         fieldA = FIELD_s9(state->words[0]) & ~0x3;
         |                                  ^~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:103:29: note: in expansion of macro 'BITS'
     103 |                 state->di = BITS(state->words[0], 11, 11);
         |                             ^~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:106:28: note: in expansion of macro 'BITS'
     106 |                 state->x = BITS(state->words[0], 6, 6);
         |                            ^~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:107:29: note: in expansion of macro 'BITS'
     107 |                 state->zz = BITS(state->words[0], 7, 8);
         |                             ^~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:108:29: note: in expansion of macro 'BITS'
     108 |                 state->aa = BITS(state->words[0], 9, 10);
         |                             ^~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:37:35: note: in expansion of macro 'BITS'
      37 | #define FIELD_B(word)           ((BITS((word), 12, 14)<<3) | \
         |                                   ^~~~
   arch/arc/kernel/disasm.c:109:33: note: in expansion of macro 'FIELD_B'
     109 |                 state->wb_reg = FIELD_B(state->words[0]);
         |                                 ^~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:38:34: note: in expansion of macro 'BITS'
      38 |                                 (BITS((word), 24, 26)))
         |                                  ^~~~
   arch/arc/kernel/disasm.c:109:33: note: in expansion of macro 'FIELD_B'
     109 |                 state->wb_reg = FIELD_B(state->words[0]);
         |                                 ^~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:46:47: note: in expansion of macro 'BITS'
      46 | #define FIELD_s9(word)          sign_extend(((BITS(word, 15, 15) << 8) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:117:31: note: in expansion of macro 'FIELD_s9'
     117 |                 state->src2 = FIELD_s9(state->words[0]);
         |                               ^~~~~~~~
>> arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:47:41: note: in expansion of macro 'BITS'
      47 |                                         BITS(word, 16, 23)), 9)
         |                                         ^~~~
   arch/arc/kernel/disasm.c:117:31: note: in expansion of macro 'FIELD_s9'
     117 |                 state->src2 = FIELD_s9(state->words[0]);
         |                               ^~~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:36:34: note: in expansion of macro 'BITS'
      36 | #define FIELD_A(word)           (BITS((word), 0, 5))
         |                                  ^~~~
   arch/arc/kernel/disasm.c:118:31: note: in expansion of macro 'FIELD_A'
     118 |                 state->dest = FIELD_A(state->words[0]);
         |                               ^~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:124:29: note: in expansion of macro 'BITS'
     124 |                 state->di = BITS(state->words[0], 5, 5);
         |                             ^~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:127:29: note: in expansion of macro 'BITS'
     127 |                 state->aa = BITS(state->words[0], 3, 4);
         |                             ^~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:128:29: note: in expansion of macro 'BITS'
     128 |                 state->zz = BITS(state->words[0], 1, 2);
         |                             ^~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:39:34: note: in expansion of macro 'BITS'
      39 | #define FIELD_C(word)           (BITS((word), 6, 11))
         |                                  ^~~~
   arch/arc/kernel/disasm.c:129:31: note: in expansion of macro 'FIELD_C'
     129 |                 state->src1 = FIELD_C(state->words[0]);
         |                               ^~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:37:35: note: in expansion of macro 'BITS'
      37 | #define FIELD_B(word)           ((BITS((word), 12, 14)<<3) | \
         |                                   ^~~~
   arch/arc/kernel/disasm.c:136:33: note: in expansion of macro 'FIELD_B'
     136 |                 state->wb_reg = FIELD_B(state->words[0]);
         |                                 ^~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:38:34: note: in expansion of macro 'BITS'
      38 |                                 (BITS((word), 24, 26)))
         |                                  ^~~~
   arch/arc/kernel/disasm.c:136:33: note: in expansion of macro 'FIELD_B'
     136 |                 state->wb_reg = FIELD_B(state->words[0]);
         |                                 ^~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:46:47: note: in expansion of macro 'BITS'
      46 | #define FIELD_s9(word)          sign_extend(((BITS(word, 15, 15) << 8) | \
         |                                               ^~~~
   arch/arc/kernel/disasm.c:144:31: note: in expansion of macro 'FIELD_s9'
     144 |                 state->src3 = FIELD_s9(state->words[0]);
         |                               ^~~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:47:41: note: in expansion of macro 'BITS'
      47 |                                         BITS(word, 16, 23)), 9)
         |                                         ^~~~
   arch/arc/kernel/disasm.c:144:31: note: in expansion of macro 'FIELD_s9'
     144 |                 state->src3 = FIELD_s9(state->words[0]);
         |                               ^~~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:35:34: note: in expansion of macro 'BITS'
      35 | #define MINOR_OPCODE(word)      (BITS((word), 16, 21))
         |                                  ^~~~
   arch/arc/kernel/disasm.c:148:29: note: in expansion of macro 'MINOR_OPCODE'
     148 |                 subopcode = MINOR_OPCODE(state->words[0]);
         |                             ^~~~~~~~~~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/kernel/disasm.c:163:37: note: in expansion of macro 'BITS'
     163 |                         op_format = BITS(state->words[0], 22, 23);
         |                                     ^~~~
   arch/arc/include/asm/disasm.h:32:60: warning: left shift of negative value [-Wshift-negative-value]
      32 | #define BITS(word, s, e)        (((word) >> (s)) & (~((-2) << ((e) - (s)))))
         |                                                            ^~
   arch/arc/include/asm/disasm.h:39:34: note: in expansion of macro 'BITS'
      39 | #define FIELD_C(word)           (BITS((word), 6, 11))


vim +32 arch/arc/include/asm/disasm.h

e65ab5a875d9e8 Vineet Gupta 2013-01-30  30  
e65ab5a875d9e8 Vineet Gupta 2013-01-30  31  #define IS_BIT(word, n)		((word) & (1<<n))
e65ab5a875d9e8 Vineet Gupta 2013-01-30 @32  #define BITS(word, s, e)	(((word) >> (s)) & (~((-2) << ((e) - (s)))))
e65ab5a875d9e8 Vineet Gupta 2013-01-30  33  

:::::: The code at line 32 was first introduced by commit
:::::: e65ab5a875d9e8ad8ff37529c2ae844699fefad1 ARC: disassembly (needed by kprobes/kgdb/unaligned-access-emul)

:::::: TO: Vineet Gupta <vgupta@synopsys.com>
:::::: CC: Vineet Gupta <vgupta@synopsys.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
