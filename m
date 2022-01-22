Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B4496B13
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiAVImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:42:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:7559 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233568AbiAVIma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642840950; x=1674376950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iSu2dHir+1DpBPckIWyOwjHydpAqp42k5jdYclvcbDM=;
  b=dIjQZJsFlXn1lr6S61meozf881mLAxBMwIqhY1ZAC1lt60UzhY/YWUg8
   uG2I1NP2/CcpHUxAlxKlHc11BF4fNIyL4RHULluS3Rqt+nrGuIBmcTRsv
   sFKK0Mp9C3XAOfUQhPX1ntjs9N6mYxxwQ63pvogoRFocJ1R+8XR+byhOm
   OS340myP5cMT77JTX7oQKkIIf2bjctmoFBnln+EOWSRCCRCr5HDw3V58h
   vKnqlAkr699bgBsYe2WBrNPCbXnje32fCy50isZSJvWbrelkucKWG3SDJ
   JwnqaKrbGdGL0m+8D64xiCkVmBiEdrOslWh3l1jfvwpHgArDfLkEBsY+k
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="233163932"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="233163932"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 00:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="476210254"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jan 2022 00:42:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBByc-000GDd-Rl; Sat, 22 Jan 2022 08:42:26 +0000
Date:   Sat, 22 Jan 2022 16:42:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Subject: arch/s390/lib/uaccess.c:65:15: error: variable 'spec' has
 initializer but incomplete type
Message-ID: <202201221613.fgIWUw0F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b57f458985742bd1c585f4c7f36d04634ce1143
commit: 012a224e1fa31fc256aab921f691598e03db6018 s390/uaccess: introduce bit field for OAC specifier
date:   5 days ago
config: s390-randconfig-r033-20220120 (https://download.01.org/0day-ci/archive/20220122/202201221613.fgIWUw0F-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=012a224e1fa31fc256aab921f691598e03db6018
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 012a224e1fa31fc256aab921f691598e03db6018
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/lib/uaccess.c: In function 'copy_from_user_mvcos':
>> arch/s390/lib/uaccess.c:65:15: error: variable 'spec' has initializer but incomplete type
      65 |         union oac spec = {
         |               ^~~
>> arch/s390/lib/uaccess.c:66:18: error: 'union oac' has no member named 'oac2'
      66 |                 .oac2.as = PSW_BITS_AS_SECONDARY,
         |                  ^~~~
   arch/s390/lib/uaccess.c:66:28: warning: excess elements in union initializer
      66 |                 .oac2.as = PSW_BITS_AS_SECONDARY,
         |                            ^~~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/uaccess.c:66:28: note: (near initialization for 'spec')
   arch/s390/lib/uaccess.c:67:18: error: 'union oac' has no member named 'oac2'
      67 |                 .oac2.a = 1,
         |                  ^~~~
   arch/s390/lib/uaccess.c:67:27: warning: excess elements in union initializer
      67 |                 .oac2.a = 1,
         |                           ^
   arch/s390/lib/uaccess.c:67:27: note: (near initialization for 'spec')
>> arch/s390/lib/uaccess.c:65:19: error: storage size of 'spec' isn't known
      65 |         union oac spec = {
         |                   ^~~~
   arch/s390/lib/uaccess.c:65:19: warning: unused variable 'spec' [-Wunused-variable]
   arch/s390/lib/uaccess.c: In function 'copy_to_user_mvcos':
   arch/s390/lib/uaccess.c:142:15: error: variable 'spec' has initializer but incomplete type
     142 |         union oac spec = {
         |               ^~~
>> arch/s390/lib/uaccess.c:143:18: error: 'union oac' has no member named 'oac1'
     143 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
         |                  ^~~~
   arch/s390/lib/uaccess.c:143:28: warning: excess elements in union initializer
     143 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
         |                            ^~~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/uaccess.c:143:28: note: (near initialization for 'spec')
   arch/s390/lib/uaccess.c:144:18: error: 'union oac' has no member named 'oac1'
     144 |                 .oac1.a = 1,
         |                  ^~~~
   arch/s390/lib/uaccess.c:144:27: warning: excess elements in union initializer
     144 |                 .oac1.a = 1,
         |                           ^
   arch/s390/lib/uaccess.c:144:27: note: (near initialization for 'spec')
   arch/s390/lib/uaccess.c:142:19: error: storage size of 'spec' isn't known
     142 |         union oac spec = {
         |                   ^~~~
   arch/s390/lib/uaccess.c:142:19: warning: unused variable 'spec' [-Wunused-variable]
   arch/s390/lib/uaccess.c: In function 'clear_user_mvcos':
   arch/s390/lib/uaccess.c:218:15: error: variable 'spec' has initializer but incomplete type
     218 |         union oac spec = {
         |               ^~~
   arch/s390/lib/uaccess.c:219:18: error: 'union oac' has no member named 'oac1'
     219 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
         |                  ^~~~
   arch/s390/lib/uaccess.c:219:28: warning: excess elements in union initializer
     219 |                 .oac1.as = PSW_BITS_AS_SECONDARY,
         |                            ^~~~~~~~~~~~~~~~~~~~~
   arch/s390/lib/uaccess.c:219:28: note: (near initialization for 'spec')
   arch/s390/lib/uaccess.c:220:18: error: 'union oac' has no member named 'oac1'
     220 |                 .oac1.a = 1,
         |                  ^~~~
   arch/s390/lib/uaccess.c:220:27: warning: excess elements in union initializer
     220 |                 .oac1.a = 1,
         |                           ^
   arch/s390/lib/uaccess.c:220:27: note: (near initialization for 'spec')
   arch/s390/lib/uaccess.c:218:19: error: storage size of 'spec' isn't known
     218 |         union oac spec = {
         |                   ^~~~
   arch/s390/lib/uaccess.c:218:19: warning: unused variable 'spec' [-Wunused-variable]


vim +/spec +65 arch/s390/lib/uaccess.c

    60	
    61	static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr,
    62							 unsigned long size)
    63	{
    64		unsigned long tmp1, tmp2;
  > 65		union oac spec = {
  > 66			.oac2.as = PSW_BITS_AS_SECONDARY,
  > 67			.oac2.a = 1,
    68		};
    69	
    70		tmp1 = -4096UL;
    71		asm volatile(
    72			"   lr	  0,%[spec]\n"
    73			"0: .insn ss,0xc80000000000,0(%0,%2),0(%1),0\n"
    74			"6: jz    4f\n"
    75			"1: algr  %0,%3\n"
    76			"   slgr  %1,%3\n"
    77			"   slgr  %2,%3\n"
    78			"   j     0b\n"
    79			"2: la    %4,4095(%1)\n"/* %4 = ptr + 4095 */
    80			"   nr    %4,%3\n"	/* %4 = (ptr + 4095) & -4096 */
    81			"   slgr  %4,%1\n"
    82			"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
    83			"   jnh   5f\n"
    84			"3: .insn ss,0xc80000000000,0(%4,%2),0(%1),0\n"
    85			"7: slgr  %0,%4\n"
    86			"   j     5f\n"
    87			"4: slgr  %0,%0\n"
    88			"5:\n"
    89			EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
    90			: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
    91			: [spec] "d" (spec.val)
    92			: "cc", "memory", "0");
    93		return size;
    94	}
    95	
    96	static inline unsigned long copy_from_user_mvcp(void *x, const void __user *ptr,
    97							unsigned long size)
    98	{
    99		unsigned long tmp1, tmp2;
   100	
   101		tmp1 = -256UL;
   102		asm volatile(
   103			"   sacf  0\n"
   104			"0: mvcp  0(%0,%2),0(%1),%3\n"
   105			"7: jz    5f\n"
   106			"1: algr  %0,%3\n"
   107			"   la    %1,256(%1)\n"
   108			"   la    %2,256(%2)\n"
   109			"2: mvcp  0(%0,%2),0(%1),%3\n"
   110			"8: jnz   1b\n"
   111			"   j     5f\n"
   112			"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
   113			"   lghi  %3,-4096\n"
   114			"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
   115			"   slgr  %4,%1\n"
   116			"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
   117			"   jnh   6f\n"
   118			"4: mvcp  0(%4,%2),0(%1),%3\n"
   119			"9: slgr  %0,%4\n"
   120			"   j     6f\n"
   121			"5: slgr  %0,%0\n"
   122			"6: sacf  768\n"
   123			EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
   124			EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
   125			: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
   126			: : "cc", "memory");
   127		return size;
   128	}
   129	
   130	unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n)
   131	{
   132		if (copy_with_mvcos())
   133			return copy_from_user_mvcos(to, from, n);
   134		return copy_from_user_mvcp(to, from, n);
   135	}
   136	EXPORT_SYMBOL(raw_copy_from_user);
   137	
   138	static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
   139						       unsigned long size)
   140	{
   141		unsigned long tmp1, tmp2;
   142		union oac spec = {
 > 143			.oac1.as = PSW_BITS_AS_SECONDARY,
   144			.oac1.a = 1,
   145		};
   146	
   147		tmp1 = -4096UL;
   148		asm volatile(
   149			"   lr	  0,%[spec]\n"
   150			"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
   151			"6: jz    4f\n"
   152			"1: algr  %0,%3\n"
   153			"   slgr  %1,%3\n"
   154			"   slgr  %2,%3\n"
   155			"   j     0b\n"
   156			"2: la    %4,4095(%1)\n"/* %4 = ptr + 4095 */
   157			"   nr    %4,%3\n"	/* %4 = (ptr + 4095) & -4096 */
   158			"   slgr  %4,%1\n"
   159			"   clgr  %0,%4\n"	/* copy crosses next page boundary? */
   160			"   jnh   5f\n"
   161			"3: .insn ss,0xc80000000000,0(%4,%1),0(%2),0\n"
   162			"7: slgr  %0,%4\n"
   163			"   j     5f\n"
   164			"4: slgr  %0,%0\n"
   165			"5:\n"
   166			EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
   167			: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
   168			: [spec] "d" (spec.val)
   169			: "cc", "memory", "0");
   170		return size;
   171	}
   172	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
