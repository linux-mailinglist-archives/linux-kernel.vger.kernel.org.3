Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8C513347
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbiD1MDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiD1MDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:03:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E01D0D4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651147229; x=1682683229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cs13BxOFJSg71gWJj66Zszu9dl6cxkj1Zdm4Ew2RCLs=;
  b=EvS//lNauLdUGW3UDd7NYvkGrSLXsOGYiY1sahQoPv4xy+zRUWqGYIr2
   yGh5l1mAmfPt7Uv7m0hxBu2phU+ZXeaXi4aBIh1/mSydexQbAVA6HLmTZ
   q5t73n9JqKFmgN1UcFqvga4S3PxmiuRh6NKz94Qpdte+4qB5/PQSIcAyR
   yGlx32RfDyNuAzFISJ4FJI7NGCKhdeZK8zj3eSSzgxFDDfE+QimsnJuRb
   n0eXSibskYH0L40sEQjy08KNkMkRfdmk5JodsC/ZXp/TaW7YbJxpoDuXJ
   HtSx4TfmxllSc2XrT+IG+qFjdYy6lXRRsdvQQnXlQuTtnLj+3JPO2h0L0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="326760428"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="326760428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 05:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="618104029"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2022 05:00:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk2or-0005KZ-5O;
        Thu, 28 Apr 2022 12:00:25 +0000
Date:   Thu, 28 Apr 2022 20:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/h8300/kernel/signal.c:112:14: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202204281940.PxJNtrGR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f4dd16603ce834d1c5c4da67803ea82dd282511
commit: 12700c17fc286149324f92d6d380bc48e43f253d uaccess: generalize access_ok()
date:   9 weeks ago
config: h8300-randconfig-s031-20220428 (https://download.01.org/0day-ci/archive/20220428/202204281940.PxJNtrGR-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12700c17fc286149324f92d6d380bc48e43f253d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 12700c17fc286149324f92d6d380bc48e43f253d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash arch/h8300/kernel/ kernel/debug/kdb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/h8300/kernel/signal.c:112:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got struct rt_sigframe *frame @@
   arch/h8300/kernel/signal.c:112:14: sparse:     expected void const [noderef] __user *ptr
   arch/h8300/kernel/signal.c:112:14: sparse:     got struct rt_sigframe *frame
   arch/h8300/kernel/signal.c:114:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct sigset_t * @@
   arch/h8300/kernel/signal.c:114:37: sparse:     expected void const [noderef] __user *from
   arch/h8300/kernel/signal.c:114:37: sparse:     got struct sigset_t *
   arch/h8300/kernel/signal.c:122:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigaltstack const [noderef] [usertype] __user * @@     got struct sigaltstack * @@
   arch/h8300/kernel/signal.c:122:31: sparse:     expected struct sigaltstack const [noderef] [usertype] __user *
   arch/h8300/kernel/signal.c:122:31: sparse:     got struct sigaltstack *
   arch/h8300/kernel/signal.c:105:16: sparse: sparse: symbol 'sys_rt_sigreturn' was not declared. Should it be static?
   arch/h8300/kernel/signal.c:165:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct rt_sigframe *frame @@     got void [noderef] __user * @@
   arch/h8300/kernel/signal.c:165:15: sparse:     expected struct rt_sigframe *frame
   arch/h8300/kernel/signal.c:165:15: sparse:     got void [noderef] __user *
   arch/h8300/kernel/signal.c:167:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got struct rt_sigframe *frame @@
   arch/h8300/kernel/signal.c:167:14: sparse:     expected void const [noderef] __user *ptr
   arch/h8300/kernel/signal.c:167:14: sparse:     got struct rt_sigframe *frame
   arch/h8300/kernel/signal.c:171:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct siginfo [noderef] [usertype] __user *to @@     got struct siginfo * @@
   arch/h8300/kernel/signal.c:171:46: sparse:     expected struct siginfo [noderef] [usertype] __user *to
   arch/h8300/kernel/signal.c:171:46: sparse:     got struct siginfo *
   arch/h8300/kernel/signal.c:174:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:174:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:174:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:174:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:174:16: sparse:     expected void [noderef] __user *to
   arch/h8300/kernel/signal.c:174:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:175:16: sparse: sparse: Using plain integer as NULL pointer
   arch/h8300/kernel/signal.c:175:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct ucontext ** @@
   arch/h8300/kernel/signal.c:175:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:175:16: sparse:     got struct ucontext **
   arch/h8300/kernel/signal.c:175:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *to @@     got struct ucontext ** @@
   arch/h8300/kernel/signal.c:175:16: sparse:     expected void [noderef] __user *to
   arch/h8300/kernel/signal.c:175:16: sparse:     got struct ucontext **
   arch/h8300/kernel/signal.c:176:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigaltstack [noderef] [usertype] __user * @@     got struct sigaltstack * @@
   arch/h8300/kernel/signal.c:176:33: sparse:     expected struct sigaltstack [noderef] [usertype] __user *
   arch/h8300/kernel/signal.c:176:33: sparse:     got struct sigaltstack *
   arch/h8300/kernel/signal.c:177:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sigcontext [noderef] __user *sc @@     got struct sigcontext * @@
   arch/h8300/kernel/signal.c:177:34: sparse:     expected struct sigcontext [noderef] __user *sc
   arch/h8300/kernel/signal.c:177:34: sparse:     got struct sigcontext *
   arch/h8300/kernel/signal.c:178:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct sigset_t * @@
   arch/h8300/kernel/signal.c:178:30: sparse:     expected void [noderef] __user *to
   arch/h8300/kernel/signal.c:178:30: sparse:     got struct sigset_t *
   arch/h8300/kernel/signal.c:185:24: sparse: sparse: cast removes address space '__user' of expression
   arch/h8300/kernel/signal.c:188:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:188:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:188:24: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:188:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:188:24: sparse:     expected void [noderef] __user *to
   arch/h8300/kernel/signal.c:188:24: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:190:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short * @@
   arch/h8300/kernel/signal.c:190:24: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:190:24: sparse:     got unsigned short *
   arch/h8300/kernel/signal.c:190:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned short * @@
   arch/h8300/kernel/signal.c:190:24: sparse:     expected void [noderef] __user *to
   arch/h8300/kernel/signal.c:190:24: sparse:     got unsigned short *
   arch/h8300/kernel/signal.c:193:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char ** @@
   arch/h8300/kernel/signal.c:193:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:193:16: sparse:     got char **
   arch/h8300/kernel/signal.c:193:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *to @@     got char ** @@
   arch/h8300/kernel/signal.c:193:16: sparse:     expected void [noderef] __user *to
   arch/h8300/kernel/signal.c:193:16: sparse:     got char **
   arch/h8300/kernel/signal.c:86:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:86:9: sparse:     expected void const [noderef] __user *__p
   arch/h8300/kernel/signal.c:86:9: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:87:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:87:9: sparse:     expected void const [noderef] __user *__p
   arch/h8300/kernel/signal.c:87:9: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:88:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:88:9: sparse:     expected void const [noderef] __user *__p
   arch/h8300/kernel/signal.c:88:9: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:89:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:89:9: sparse:     expected void const [noderef] __user *__p
   arch/h8300/kernel/signal.c:89:9: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:90:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:90:9: sparse:     expected void const [noderef] __user *__p
   arch/h8300/kernel/signal.c:90:9: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:92:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned short * @@
   arch/h8300/kernel/signal.c:92:9: sparse:     expected void const [noderef] __user *__p
   arch/h8300/kernel/signal.c:92:9: sparse:     got unsigned short *
   arch/h8300/kernel/signal.c:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:97:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:97:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:97:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:97:16: sparse:     expected void const [noderef] __user *from
   arch/h8300/kernel/signal.c:97:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:97:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:97:16: sparse:     expected void const [noderef] __user *from
   arch/h8300/kernel/signal.c:97:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:97:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:97:16: sparse:     expected void const [noderef] __user *from
   arch/h8300/kernel/signal.c:97:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:97:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:97:16: sparse:     expected void const [noderef] __user *from
   arch/h8300/kernel/signal.c:97:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:100:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:100:16: sparse:     expected void const volatile [noderef] __user *ptr
   arch/h8300/kernel/signal.c:100:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:100:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long * @@
   arch/h8300/kernel/signal.c:100:16: sparse:     expected void const [noderef] __user *from
   arch/h8300/kernel/signal.c:100:16: sparse:     got unsigned long *
   arch/h8300/kernel/signal.c:100:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long * @@

vim +112 arch/h8300/kernel/signal.c

883251dd163c55 Yoshinori Sato    2015-05-11  104  
883251dd163c55 Yoshinori Sato    2015-05-11  105  asmlinkage int sys_rt_sigreturn(void)
883251dd163c55 Yoshinori Sato    2015-05-11  106  {
883251dd163c55 Yoshinori Sato    2015-05-11  107  	unsigned long usp = rdusp();
883251dd163c55 Yoshinori Sato    2015-05-11  108  	struct rt_sigframe *frame = (struct rt_sigframe *)(usp - 4);
883251dd163c55 Yoshinori Sato    2015-05-11  109  	sigset_t set;
883251dd163c55 Yoshinori Sato    2015-05-11  110  	int er0;
883251dd163c55 Yoshinori Sato    2015-05-11  111  
96d4f267e40f95 Linus Torvalds    2019-01-03 @112  	if (!access_ok(frame, sizeof(*frame)))
883251dd163c55 Yoshinori Sato    2015-05-11  113  		goto badframe;
883251dd163c55 Yoshinori Sato    2015-05-11  114  	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
883251dd163c55 Yoshinori Sato    2015-05-11  115  		goto badframe;
883251dd163c55 Yoshinori Sato    2015-05-11  116  
883251dd163c55 Yoshinori Sato    2015-05-11  117  	set_current_blocked(&set);
883251dd163c55 Yoshinori Sato    2015-05-11  118  
883251dd163c55 Yoshinori Sato    2015-05-11  119  	if (restore_sigcontext(&frame->uc.uc_mcontext, &er0))
883251dd163c55 Yoshinori Sato    2015-05-11  120  		goto badframe;
883251dd163c55 Yoshinori Sato    2015-05-11  121  
883251dd163c55 Yoshinori Sato    2015-05-11  122  	if (restore_altstack(&frame->uc.uc_stack))
883251dd163c55 Yoshinori Sato    2015-05-11  123  		goto badframe;
883251dd163c55 Yoshinori Sato    2015-05-11  124  
883251dd163c55 Yoshinori Sato    2015-05-11  125  	return er0;
883251dd163c55 Yoshinori Sato    2015-05-11  126  
883251dd163c55 Yoshinori Sato    2015-05-11  127  badframe:
3cf5d076fb4d48 Eric W. Biederman 2019-05-23  128  	force_sig(SIGSEGV);
883251dd163c55 Yoshinori Sato    2015-05-11  129  	return 0;
883251dd163c55 Yoshinori Sato    2015-05-11  130  }
883251dd163c55 Yoshinori Sato    2015-05-11  131  

:::::: The code at line 112 was first introduced by commit
:::::: 96d4f267e40f9509e8a66e2b39e8b95655617693 Remove 'type' argument from access_ok() function

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
