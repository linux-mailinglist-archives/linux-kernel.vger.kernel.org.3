Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4142E4820B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbhL3Wuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:50:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:13471 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234264AbhL3Wug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640904636; x=1672440636;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RgKRyXlC0a1k7VH6YTbFGzC8N5mGnT1pEKOAOTLMAwA=;
  b=PEwETDbnmKBx2ClvPu1J0zeQf103WF9sDXSfd/3J2yGAJ8ZCpnTW2QM2
   f0cVHMd8qeVjpOdtADqA1AtZzbYbzVrN2RRLVcgZXpFyI22i52ii5UmHn
   8vIAzPBVT7k8DMrPMgT+YVO95aGgXrXZv+bT3J9GARqrNpjowdQK1LLFR
   KHISBo5a7C871mhuIHy67Fgm2+G+d3g770Uo2CUU19yQot84Vvpklmb2P
   Bna91ROAt6Gr/OEYuN89y+0j7sSJjEAbKPXBsesbhHloeVcNEEJ2uSdNy
   CMbv3H+dDy/+i422AlG7eZ4Z+kfkU++nI+iwMMIEumtciVd52yNfHVCbE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241951268"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="241951268"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 14:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="554908440"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2021 14:50:34 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n34Fl-000Ah6-Jy; Thu, 30 Dec 2021 22:50:33 +0000
Date:   Fri, 31 Dec 2021 06:50:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:xor-restrict 1/2] arch/powerpc/lib/xor_vmx.c:52:6: error:
 conflicting types for '__xor_altivec_2'; have 'void(long unsigned int,  long
 unsigned int *, long unsigned int *)'
Message-ID: <202112310646.kuh2pXiG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git xor-restrict
head:   d2950492157a7e6af397c6d68c6e212a4844be64
commit: e754a2be51e5330e138271067808681b4a13ade2 [1/2] lib/xor: make xor prototypes more friendely to compiler vectorization
config: powerpc-g5_defconfig (https://download.01.org/0day-ci/archive/20211231/202112310646.kuh2pXiG-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=e754a2be51e5330e138271067808681b4a13ade2
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb xor-restrict
        git checkout e754a2be51e5330e138271067808681b4a13ade2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/lib/xor_vmx.c:52:6: error: conflicting types for '__xor_altivec_2'; have 'void(long unsigned int,  long unsigned int *, long unsigned int *)'
      52 | void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
         |      ^~~~~~~~~~~~~~~
   In file included from arch/powerpc/lib/xor_vmx.c:20:
   arch/powerpc/lib/xor_vmx.h:9:6: note: previous declaration of '__xor_altivec_2' with type 'void(long unsigned int,  long unsigned int * __restrict__,  const long unsigned int * __restrict__)'
       9 | void __xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
         |      ^~~~~~~~~~~~~~~
>> arch/powerpc/lib/xor_vmx.c:70:6: error: conflicting types for '__xor_altivec_3'; have 'void(long unsigned int,  long unsigned int *, long unsigned int *, long unsigned int *)'
      70 | void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
         |      ^~~~~~~~~~~~~~~
   In file included from arch/powerpc/lib/xor_vmx.c:20:
   arch/powerpc/lib/xor_vmx.h:11:6: note: previous declaration of '__xor_altivec_3' with type 'void(long unsigned int,  long unsigned int * __restrict__,  const long unsigned int * __restrict__,  const long unsigned int * __restrict__)'
      11 | void __xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
         |      ^~~~~~~~~~~~~~~
>> arch/powerpc/lib/xor_vmx.c:92:6: error: conflicting types for '__xor_altivec_4'; have 'void(long unsigned int,  long unsigned int *, long unsigned int *, long unsigned int *, long unsigned int *)'
      92 | void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
         |      ^~~~~~~~~~~~~~~
   In file included from arch/powerpc/lib/xor_vmx.c:20:
   arch/powerpc/lib/xor_vmx.h:14:6: note: previous declaration of '__xor_altivec_4' with type 'void(long unsigned int,  long unsigned int * __restrict__,  const long unsigned int * __restrict__,  const long unsigned int * __restrict__,  const long unsigned int * __restrict__)'
      14 | void __xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
         |      ^~~~~~~~~~~~~~~
>> arch/powerpc/lib/xor_vmx.c:119:6: error: conflicting types for '__xor_altivec_5'; have 'void(long unsigned int,  long unsigned int *, long unsigned int *, long unsigned int *, long unsigned int *, long unsigned int *)'
     119 | void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
         |      ^~~~~~~~~~~~~~~
   In file included from arch/powerpc/lib/xor_vmx.c:20:
   arch/powerpc/lib/xor_vmx.h:18:6: note: previous declaration of '__xor_altivec_5' with type 'void(long unsigned int,  long unsigned int * __restrict__,  const long unsigned int * __restrict__,  const long unsigned int * __restrict__,  const long unsigned int * __restrict__,  const long unsigned int * __restrict__)'
      18 | void __xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
         |      ^~~~~~~~~~~~~~~


vim +52 arch/powerpc/lib/xor_vmx.c

ef1313deafb7ba Anton Blanchard 2013-10-14   23  
ef1313deafb7ba Anton Blanchard 2013-10-14   24  #define DEFINE(V)				\
ef1313deafb7ba Anton Blanchard 2013-10-14   25  	unative_t *V = (unative_t *)V##_in;	\
ef1313deafb7ba Anton Blanchard 2013-10-14   26  	unative_t V##_0, V##_1, V##_2, V##_3
ef1313deafb7ba Anton Blanchard 2013-10-14   27  
ef1313deafb7ba Anton Blanchard 2013-10-14   28  #define LOAD(V)			\
ef1313deafb7ba Anton Blanchard 2013-10-14   29  	do {			\
ef1313deafb7ba Anton Blanchard 2013-10-14   30  		V##_0 = V[0];	\
ef1313deafb7ba Anton Blanchard 2013-10-14   31  		V##_1 = V[1];	\
ef1313deafb7ba Anton Blanchard 2013-10-14   32  		V##_2 = V[2];	\
ef1313deafb7ba Anton Blanchard 2013-10-14   33  		V##_3 = V[3];	\
ef1313deafb7ba Anton Blanchard 2013-10-14   34  	} while (0)
ef1313deafb7ba Anton Blanchard 2013-10-14   35  
ef1313deafb7ba Anton Blanchard 2013-10-14   36  #define STORE(V)		\
ef1313deafb7ba Anton Blanchard 2013-10-14   37  	do {			\
ef1313deafb7ba Anton Blanchard 2013-10-14   38  		V[0] = V##_0;	\
ef1313deafb7ba Anton Blanchard 2013-10-14   39  		V[1] = V##_1;	\
ef1313deafb7ba Anton Blanchard 2013-10-14   40  		V[2] = V##_2;	\
ef1313deafb7ba Anton Blanchard 2013-10-14   41  		V[3] = V##_3;	\
ef1313deafb7ba Anton Blanchard 2013-10-14   42  	} while (0)
ef1313deafb7ba Anton Blanchard 2013-10-14   43  
ef1313deafb7ba Anton Blanchard 2013-10-14   44  #define XOR(V1, V2)					\
ef1313deafb7ba Anton Blanchard 2013-10-14   45  	do {						\
ef1313deafb7ba Anton Blanchard 2013-10-14   46  		V1##_0 = vec_xor(V1##_0, V2##_0);	\
ef1313deafb7ba Anton Blanchard 2013-10-14   47  		V1##_1 = vec_xor(V1##_1, V2##_1);	\
ef1313deafb7ba Anton Blanchard 2013-10-14   48  		V1##_2 = vec_xor(V1##_2, V2##_2);	\
ef1313deafb7ba Anton Blanchard 2013-10-14   49  		V1##_3 = vec_xor(V1##_3, V2##_3);	\
ef1313deafb7ba Anton Blanchard 2013-10-14   50  	} while (0)
ef1313deafb7ba Anton Blanchard 2013-10-14   51  
f718d426d7e42e Matt Brown      2017-05-24  @52  void __xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
ef1313deafb7ba Anton Blanchard 2013-10-14   53  		     unsigned long *v2_in)
ef1313deafb7ba Anton Blanchard 2013-10-14   54  {
ef1313deafb7ba Anton Blanchard 2013-10-14   55  	DEFINE(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   56  	DEFINE(v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   57  	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   58  
ef1313deafb7ba Anton Blanchard 2013-10-14   59  	do {
ef1313deafb7ba Anton Blanchard 2013-10-14   60  		LOAD(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   61  		LOAD(v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   62  		XOR(v1, v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   63  		STORE(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   64  
ef1313deafb7ba Anton Blanchard 2013-10-14   65  		v1 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   66  		v2 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   67  	} while (--lines > 0);
ef1313deafb7ba Anton Blanchard 2013-10-14   68  }
ef1313deafb7ba Anton Blanchard 2013-10-14   69  
f718d426d7e42e Matt Brown      2017-05-24  @70  void __xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
ef1313deafb7ba Anton Blanchard 2013-10-14   71  		     unsigned long *v2_in, unsigned long *v3_in)
ef1313deafb7ba Anton Blanchard 2013-10-14   72  {
ef1313deafb7ba Anton Blanchard 2013-10-14   73  	DEFINE(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   74  	DEFINE(v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   75  	DEFINE(v3);
ef1313deafb7ba Anton Blanchard 2013-10-14   76  	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   77  
ef1313deafb7ba Anton Blanchard 2013-10-14   78  	do {
ef1313deafb7ba Anton Blanchard 2013-10-14   79  		LOAD(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   80  		LOAD(v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   81  		LOAD(v3);
ef1313deafb7ba Anton Blanchard 2013-10-14   82  		XOR(v1, v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   83  		XOR(v1, v3);
ef1313deafb7ba Anton Blanchard 2013-10-14   84  		STORE(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   85  
ef1313deafb7ba Anton Blanchard 2013-10-14   86  		v1 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   87  		v2 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   88  		v3 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14   89  	} while (--lines > 0);
ef1313deafb7ba Anton Blanchard 2013-10-14   90  }
ef1313deafb7ba Anton Blanchard 2013-10-14   91  
f718d426d7e42e Matt Brown      2017-05-24  @92  void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
ef1313deafb7ba Anton Blanchard 2013-10-14   93  		     unsigned long *v2_in, unsigned long *v3_in,
ef1313deafb7ba Anton Blanchard 2013-10-14   94  		     unsigned long *v4_in)
ef1313deafb7ba Anton Blanchard 2013-10-14   95  {
ef1313deafb7ba Anton Blanchard 2013-10-14   96  	DEFINE(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14   97  	DEFINE(v2);
ef1313deafb7ba Anton Blanchard 2013-10-14   98  	DEFINE(v3);
ef1313deafb7ba Anton Blanchard 2013-10-14   99  	DEFINE(v4);
ef1313deafb7ba Anton Blanchard 2013-10-14  100  	unsigned long lines = bytes / (sizeof(unative_t)) / 4;
ef1313deafb7ba Anton Blanchard 2013-10-14  101  
ef1313deafb7ba Anton Blanchard 2013-10-14  102  	do {
ef1313deafb7ba Anton Blanchard 2013-10-14  103  		LOAD(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14  104  		LOAD(v2);
ef1313deafb7ba Anton Blanchard 2013-10-14  105  		LOAD(v3);
ef1313deafb7ba Anton Blanchard 2013-10-14  106  		LOAD(v4);
ef1313deafb7ba Anton Blanchard 2013-10-14  107  		XOR(v1, v2);
ef1313deafb7ba Anton Blanchard 2013-10-14  108  		XOR(v3, v4);
ef1313deafb7ba Anton Blanchard 2013-10-14  109  		XOR(v1, v3);
ef1313deafb7ba Anton Blanchard 2013-10-14  110  		STORE(v1);
ef1313deafb7ba Anton Blanchard 2013-10-14  111  
ef1313deafb7ba Anton Blanchard 2013-10-14  112  		v1 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14  113  		v2 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14  114  		v3 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14  115  		v4 += 4;
ef1313deafb7ba Anton Blanchard 2013-10-14  116  	} while (--lines > 0);
ef1313deafb7ba Anton Blanchard 2013-10-14  117  }
ef1313deafb7ba Anton Blanchard 2013-10-14  118  
f718d426d7e42e Matt Brown      2017-05-24 @119  void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,

:::::: The code at line 52 was first introduced by commit
:::::: f718d426d7e42eec6e5d2932f52a51de23bd3b30 powerpc/lib/xor_vmx: Ensure no altivec code executes before enable_kernel_altivec()

:::::: TO: Matt Brown <matthew.brown.dev@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
