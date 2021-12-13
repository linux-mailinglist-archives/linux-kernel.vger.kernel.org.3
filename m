Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40F473161
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbhLMQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:14:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:46557 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235105AbhLMQOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639412079; x=1670948079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qUrF6DCnAYbQ7VDaEHqREF/nZ89MsB0OivMR+pFxIn4=;
  b=NtAfVA3wis+AoB3Ok0Wt9y3MSKudCYwjVFrGOj8rbFg+B1n3NB0O/jRD
   +kfCMSYfBhznJ3rFIyJz1UT6lYr54PsiY3/HkhHCgeQmSz4cXOKC4co7I
   7gMo6iDvD+fmCOaPSffCv/IwfiaLx/rtDTZRflJHovC2LF1tjyYkCYgep
   kWVxVZu/umYb837tySWQZwS5b5yCbt3SfXGrxVNQsDztsZ0exfUnH0Krp
   /bs1HALT68GCq8hpH4SqQkmXFSm/zxOPMTIkOn2Yn6Lt5Ycrg6lQhuVbF
   FxXmxFq+36JX8VUZ8hxa4r6puuGQt/abTdmEq1+GjW5ERHmA8NADSeCZb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="262891984"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="262891984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="660898513"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2021 08:12:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwnwY-0006p2-22; Mon, 13 Dec 2021 16:12:50 +0000
Date:   Tue, 14 Dec 2021 00:12:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, build@wireguard.com,
        linux-kernel@vger.kernel.org
Subject: [zx2c4-wireguard:stable 1/1]
 arch/x86/crypto/curve25519-x86_64.c:1135:15: error: passing 'const u64 *'
 (aka 'const unsigned long long *') to parameter of type 'u64 *' (aka
 'unsigned long long *') discards qualifiers
Message-ID: <202112132233.pOx31Nie-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git stable
head:   4bd76aceb9f2887c6ddfeb1594a0ac0fe863dc7c
commit: 4bd76aceb9f2887c6ddfeb1594a0ac0fe863dc7c [1/1] crypto: x86/curve25519 - use in/out register constraints more precisely
config: x86_64-buildonly-randconfig-r004-20211213 (https://download.01.org/0day-ci/archive/20211213/202112132233.pOx31Nie-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?id=4bd76aceb9f2887c6ddfeb1594a0ac0fe863dc7c
        git remote add zx2c4-wireguard https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git
        git fetch --no-tags zx2c4-wireguard stable
        git checkout 4bd76aceb9f2887c6ddfeb1594a0ac0fe863dc7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/ drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/crypto/curve25519-x86_64.c:1135:15: error: passing 'const u64 *' (aka 'const unsigned long long *') to parameter of type 'u64 *' (aka 'unsigned long long *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           fmul(b, t00, i, tmp);
                        ^
   arch/x86/crypto/curve25519-x86_64.c:159:49: note: passing argument to parameter 'f2' here
   static inline void fmul(u64 *out, u64 *f1, u64 *f2, u64 *tmp)
                                                   ^
   arch/x86/crypto/curve25519-x86_64.c:1218:17: error: passing 'const u64 *' (aka 'const unsigned long long *') to parameter of type 'u64 *' (aka 'unsigned long long *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           fmul(tmp, tmp, x, tmp_w);
                          ^
   arch/x86/crypto/curve25519-x86_64.c:159:49: note: passing argument to parameter 'f2' here
   static inline void fmul(u64 *out, u64 *f1, u64 *f2, u64 *tmp)
                                                   ^
   arch/x86/crypto/curve25519-x86_64.c:1574:12: error: passing 'const u64 *' (aka 'const unsigned long long *') to parameter of type 'u64 *' (aka 'unsigned long long *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                           fmul(c, &table_ladder[4 * k], b, ef);
                                   ^~~~~~~~~~~~~~~~~~~~
   arch/x86/crypto/curve25519-x86_64.c:159:40: note: passing argument to parameter 'f1' here
   static inline void fmul(u64 *out, u64 *f1, u64 *f2, u64 *tmp)
                                          ^
   3 errors generated.


vim +1135 arch/x86/crypto/curve25519-x86_64.c

bb611bdfd6be34 Jason A. Donenfeld 2019-11-08  1122  
07b586fe06625b Jason A. Donenfeld 2020-01-20  1123  static void finv(u64 *o, const u64 *i, u64 *tmp)
bb611bdfd6be34 Jason A. Donenfeld 2019-11-08  1124  {
07b586fe06625b Jason A. Donenfeld 2020-01-20  1125  	u64 t1[16U] = { 0U };
07b586fe06625b Jason A. Donenfeld 2020-01-20  1126  	u64 *a0 = t1;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1127  	u64 *b = t1 + (u32)4U;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1128  	u64 *c = t1 + (u32)8U;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1129  	u64 *t00 = t1 + (u32)12U;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1130  	u64 *tmp1 = tmp;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1131  	u64 *a;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1132  	u64 *t0;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1133  	fsquare_times(a0, i, tmp1, (u32)1U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1134  	fsquare_times(t00, a0, tmp1, (u32)2U);
07b586fe06625b Jason A. Donenfeld 2020-01-20 @1135  	fmul(b, t00, i, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1136  	fmul(a0, b, a0, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1137  	fsquare_times(t00, a0, tmp1, (u32)1U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1138  	fmul(b, t00, b, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1139  	fsquare_times(t00, b, tmp1, (u32)5U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1140  	fmul(b, t00, b, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1141  	fsquare_times(t00, b, tmp1, (u32)10U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1142  	fmul(c, t00, b, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1143  	fsquare_times(t00, c, tmp1, (u32)20U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1144  	fmul(t00, t00, c, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1145  	fsquare_times(t00, t00, tmp1, (u32)10U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1146  	fmul(b, t00, b, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1147  	fsquare_times(t00, b, tmp1, (u32)50U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1148  	fmul(c, t00, b, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1149  	fsquare_times(t00, c, tmp1, (u32)100U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1150  	fmul(t00, t00, c, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1151  	fsquare_times(t00, t00, tmp1, (u32)50U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1152  	fmul(t00, t00, b, tmp);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1153  	fsquare_times(t00, t00, tmp1, (u32)5U);
07b586fe06625b Jason A. Donenfeld 2020-01-20  1154  	a = t1;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1155  	t0 = t1 + (u32)12U;
07b586fe06625b Jason A. Donenfeld 2020-01-20  1156  	fmul(o, t0, a, tmp);
bb611bdfd6be34 Jason A. Donenfeld 2019-11-08  1157  }
bb611bdfd6be34 Jason A. Donenfeld 2019-11-08  1158  

:::::: The code at line 1135 was first introduced by commit
:::::: 07b586fe06625b0b610dc3d3a969c51913d143d4 crypto: x86/curve25519 - replace with formally verified implementation

:::::: TO: Jason A. Donenfeld <Jason@zx2c4.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
