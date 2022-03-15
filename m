Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1594DA2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbiCOSyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbiCOSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:54:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE52CC8F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647370418; x=1678906418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v97mMmpqWb5sCshsOarN0ibOICOb8PI1fVjuyevtX+A=;
  b=bQ+/1tFvwqpHBUZw0pDpC/ER+GSdOT+9l5yyCvPgGAed3kqpEIB8hgMg
   DKXvyBp2tYKPca+w00Y3rj/gMA5H6sdCYHVc/52SyZ+wnsMdY7x40hayN
   QL54U9q6mKtrXfhBCRDgho24rsdHEbSmrYTqgI2iLO+KfsRaEb3zSy4Od
   7wbjevSCpWpEV7CiEtD4dcHNVJtlyGrHqE/gvFzBdCzFjM78z1nnCFWmk
   hi64knAzFiSbvxYGOj9quePFeE8qnUxGBNpMTgiTuyYuQPyWoljM6fS8B
   Bn0rhlUwYlAnmY49V+awaU90T55NSC6J2qfuQ9OZwKDIqXVFA/cCHdDhV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342829094"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342829094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 11:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="580627811"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2022 11:53:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUCIZ-000BNA-Tk; Tue, 15 Mar 2022 18:53:35 +0000
Date:   Wed, 16 Mar 2022 02:52:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 149/296]
 arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to
 incomplete type 'struct kvm_tdx'
Message-ID: <202203160228.IRRg53tC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   97612c5f3be3447870b5d6fd476931a4c5ff280f
commit: 540e161d6f1b1e4ca7535ef11258660947ae7b00 [149/296] KVM: TDX: Add placeholders for TDX VM/vcpu structure
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203160228.IRRg53tC-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/540e161d6f1b1e4ca7535ef11258660947ae7b00
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 540e161d6f1b1e4ca7535ef11258660947ae7b00
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:26,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
   arch/x86/kvm/vmx/main.c: In function 'vt_init':
>> arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to incomplete type 'struct kvm_tdx'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                                                          ^~~~~~
   include/linux/minmax.h:20:39: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                       ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
   In file included from include/linux/align.h:5,
                    from include/linux/kernel.h:15,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
>> arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to incomplete type 'struct kvm_tdx'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                                                          ^~~~~~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
   In file included from include/linux/kernel.h:26,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
>> arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to incomplete type 'struct kvm_tdx'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                                                          ^~~~~~
   include/linux/minmax.h:28:34: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                  ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
>> arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to incomplete type 'struct kvm_tdx'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                                                          ^~~~~~
   include/linux/minmax.h:28:46: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                              ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
>> arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to incomplete type 'struct kvm_tdx'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                                                          ^~~~~~
   include/linux/minmax.h:32:10: note: in definition of macro '__cmp_once'
      32 |   typeof(y) unique_y = (y);  \
         |          ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
>> arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to incomplete type 'struct kvm_tdx'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                                                          ^~~~~~
   include/linux/minmax.h:32:25: note: in definition of macro '__cmp_once'
      32 |   typeof(y) unique_y = (y);  \
         |                         ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
   include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:175:23: note: in expansion of macro 'max'
     175 |  vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
         |                       ^~~
>> arch/x86/kvm/vmx/main.c:176:50: error: invalid application of 'sizeof' to incomplete type 'struct vcpu_tdx'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |                                                  ^~~~~~
   include/linux/minmax.h:20:39: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                       ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
   In file included from include/linux/align.h:5,
                    from include/linux/kernel.h:15,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
>> arch/x86/kvm/vmx/main.c:176:50: error: invalid application of 'sizeof' to incomplete type 'struct vcpu_tdx'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |                                                  ^~~~~~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
   In file included from include/linux/kernel.h:26,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
>> arch/x86/kvm/vmx/main.c:176:50: error: invalid application of 'sizeof' to incomplete type 'struct vcpu_tdx'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |                                                  ^~~~~~
   include/linux/minmax.h:28:34: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                  ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
>> arch/x86/kvm/vmx/main.c:176:50: error: invalid application of 'sizeof' to incomplete type 'struct vcpu_tdx'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |                                                  ^~~~~~
   include/linux/minmax.h:28:46: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                              ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
>> arch/x86/kvm/vmx/main.c:176:50: error: invalid application of 'sizeof' to incomplete type 'struct vcpu_tdx'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |                                                  ^~~~~~
   include/linux/minmax.h:32:10: note: in definition of macro '__cmp_once'
      32 |   typeof(y) unique_y = (y);  \
         |          ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
>> arch/x86/kvm/vmx/main.c:176:50: error: invalid application of 'sizeof' to incomplete type 'struct vcpu_tdx'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |                                                  ^~~~~~
   include/linux/minmax.h:32:25: note: in definition of macro '__cmp_once'
      32 |   typeof(y) unique_y = (y);  \
         |                         ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
   include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:176:14: note: in expansion of macro 'max'
     176 |  vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
         |              ^~~
>> arch/x86/kvm/vmx/main.c:178:16: error: invalid application of '__alignof__' to incomplete type 'struct vcpu_tdx'
     178 |    __alignof__(struct vcpu_tdx));
         |                ^~~~~~
   include/linux/minmax.h:20:39: note: in definition of macro '__typecheck'
      20 |  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                       ^
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~
   In file included from include/linux/align.h:5,
                    from include/linux/kernel.h:15,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
>> arch/x86/kvm/vmx/main.c:178:16: error: invalid application of '__alignof__' to incomplete type 'struct vcpu_tdx'
     178 |    __alignof__(struct vcpu_tdx));
         |                ^~~~~~
   include/linux/const.h:12:48: note: in definition of macro '__is_constexpr'
      12 |  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                ^
   include/linux/minmax.h:26:25: note: in expansion of macro '__no_side_effects'
      26 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: in expansion of macro '__safe_cmp'
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~
   In file included from include/linux/kernel.h:26,
                    from include/linux/moduleparam.h:7,
                    from arch/x86/kvm/vmx/main.c:2:
>> arch/x86/kvm/vmx/main.c:178:16: error: invalid application of '__alignof__' to incomplete type 'struct vcpu_tdx'
     178 |    __alignof__(struct vcpu_tdx));
         |                ^~~~~~
   include/linux/minmax.h:28:34: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                  ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~
>> arch/x86/kvm/vmx/main.c:178:16: error: invalid application of '__alignof__' to incomplete type 'struct vcpu_tdx'
     178 |    __alignof__(struct vcpu_tdx));
         |                ^~~~~~
   include/linux/minmax.h:28:46: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                              ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~
>> arch/x86/kvm/vmx/main.c:178:16: error: invalid application of '__alignof__' to incomplete type 'struct vcpu_tdx'
     178 |    __alignof__(struct vcpu_tdx));
         |                ^~~~~~
   include/linux/minmax.h:32:10: note: in definition of macro '__cmp_once'
      32 |   typeof(y) unique_y = (y);  \
         |          ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~
>> arch/x86/kvm/vmx/main.c:178:16: error: invalid application of '__alignof__' to incomplete type 'struct vcpu_tdx'
     178 |    __alignof__(struct vcpu_tdx));
         |                ^~~~~~
   include/linux/minmax.h:32:25: note: in definition of macro '__cmp_once'
      32 |   typeof(y) unique_y = (y);  \
         |                         ^
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~
   include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
      36 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: in expansion of macro '__careful_cmp'
      52 | #define max(x, y) __careful_cmp(x, y, >)
         |                   ^~~~~~~~~~~~~
   arch/x86/kvm/vmx/main.c:177:15: note: in expansion of macro 'max'
     177 |  vcpu_align = max(__alignof__(struct vcpu_vmx),
         |               ^~~


vim +175 arch/x86/kvm/vmx/main.c

   > 2	#include <linux/moduleparam.h>
     3	
     4	#include "x86_ops.h"
     5	#include "vmx.h"
     6	#include "nested.h"
     7	#include "pmu.h"
     8	#include "tdx.h"
     9	
    10	static __init int vt_hardware_setup(void)
    11	{
    12		int ret;
    13	
    14		ret = vmx_hardware_setup();
    15		if (ret)
    16			return ret;
    17	
    18		tdx_hardware_setup(&vt_x86_ops);
    19	
    20		return 0;
    21	}
    22	
    23	struct kvm_x86_ops vt_x86_ops __initdata = {
    24		.name = "kvm_intel",
    25	
    26		.hardware_unsetup = vmx_hardware_unsetup,
    27	
    28		.hardware_enable = vmx_hardware_enable,
    29		.hardware_disable = vmx_hardware_disable,
    30		.cpu_has_accelerated_tpr = report_flexpriority,
    31		.has_emulated_msr = vmx_has_emulated_msr,
    32	
    33		.vm_size = sizeof(struct kvm_vmx),
    34		.vm_init = vmx_vm_init,
    35	
    36		.vcpu_create = vmx_vcpu_create,
    37		.vcpu_free = vmx_vcpu_free,
    38		.vcpu_reset = vmx_vcpu_reset,
    39	
    40		.prepare_guest_switch = vmx_prepare_switch_to_guest,
    41		.vcpu_load = vmx_vcpu_load,
    42		.vcpu_put = vmx_vcpu_put,
    43	
    44		.update_exception_bitmap = vmx_update_exception_bitmap,
    45		.get_msr_feature = vmx_get_msr_feature,
    46		.get_msr = vmx_get_msr,
    47		.set_msr = vmx_set_msr,
    48		.get_segment_base = vmx_get_segment_base,
    49		.get_segment = vmx_get_segment,
    50		.set_segment = vmx_set_segment,
    51		.get_cpl = vmx_get_cpl,
    52		.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
    53		.set_cr0 = vmx_set_cr0,
    54		.is_valid_cr4 = vmx_is_valid_cr4,
    55		.set_cr4 = vmx_set_cr4,
    56		.set_efer = vmx_set_efer,
    57		.get_idt = vmx_get_idt,
    58		.set_idt = vmx_set_idt,
    59		.get_gdt = vmx_get_gdt,
    60		.set_gdt = vmx_set_gdt,
    61		.set_dr7 = vmx_set_dr7,
    62		.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
    63		.cache_reg = vmx_cache_reg,
    64		.get_rflags = vmx_get_rflags,
    65		.set_rflags = vmx_set_rflags,
    66		.get_if_flag = vmx_get_if_flag,
    67	
    68		.tlb_flush_all = vmx_flush_tlb_all,
    69		.tlb_flush_current = vmx_flush_tlb_current,
    70		.tlb_flush_gva = vmx_flush_tlb_gva,
    71		.tlb_flush_guest = vmx_flush_tlb_guest,
    72	
    73		.vcpu_pre_run = vmx_vcpu_pre_run,
    74		.run = vmx_vcpu_run,
    75		.handle_exit = vmx_handle_exit,
    76		.skip_emulated_instruction = vmx_skip_emulated_instruction,
    77		.update_emulated_instruction = vmx_update_emulated_instruction,
    78		.set_interrupt_shadow = vmx_set_interrupt_shadow,
    79		.get_interrupt_shadow = vmx_get_interrupt_shadow,
    80		.patch_hypercall = vmx_patch_hypercall,
    81		.set_irq = vmx_inject_irq,
    82		.set_nmi = vmx_inject_nmi,
    83		.queue_exception = vmx_queue_exception,
    84		.cancel_injection = vmx_cancel_injection,
    85		.interrupt_allowed = vmx_interrupt_allowed,
    86		.nmi_allowed = vmx_nmi_allowed,
    87		.get_nmi_mask = vmx_get_nmi_mask,
    88		.set_nmi_mask = vmx_set_nmi_mask,
    89		.enable_nmi_window = vmx_enable_nmi_window,
    90		.enable_irq_window = vmx_enable_irq_window,
    91		.update_cr8_intercept = vmx_update_cr8_intercept,
    92		.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
    93		.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
    94		.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
    95		.load_eoi_exitmap = vmx_load_eoi_exitmap,
    96		.apicv_post_state_restore = vmx_apicv_post_state_restore,
    97		.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
    98		.hwapic_irr_update = vmx_hwapic_irr_update,
    99		.hwapic_isr_update = vmx_hwapic_isr_update,
   100		.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
   101		.sync_pir_to_irr = vmx_sync_pir_to_irr,
   102		.deliver_interrupt = vmx_deliver_interrupt,
   103		.dy_apicv_has_pending_interrupt = pi_has_pending_interrupt,
   104	
   105		.set_tss_addr = vmx_set_tss_addr,
   106		.set_identity_map_addr = vmx_set_identity_map_addr,
   107		.get_mt_mask = vmx_get_mt_mask,
   108	
   109		.get_exit_info = vmx_get_exit_info,
   110	
   111		.vcpu_after_set_cpuid = vmx_vcpu_after_set_cpuid,
   112	
   113		.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
   114	
   115		.get_l2_tsc_offset = vmx_get_l2_tsc_offset,
   116		.get_l2_tsc_multiplier = vmx_get_l2_tsc_multiplier,
   117		.write_tsc_offset = vmx_write_tsc_offset,
   118		.write_tsc_multiplier = vmx_write_tsc_multiplier,
   119	
   120		.load_mmu_pgd = vmx_load_mmu_pgd,
   121	
   122		.check_intercept = vmx_check_intercept,
   123		.handle_exit_irqoff = vmx_handle_exit_irqoff,
   124	
   125		.request_immediate_exit = vmx_request_immediate_exit,
   126	
   127		.sched_in = vmx_sched_in,
   128	
   129		.cpu_dirty_log_size = PML_ENTITY_NUM,
   130		.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
   131	
   132		.pmu_ops = &intel_pmu_ops,
   133		.nested_ops = &vmx_nested_ops,
   134	
   135		.update_pi_irte = pi_update_irte,
   136		.start_assignment = vmx_pi_start_assignment,
   137	
   138	#ifdef CONFIG_X86_64
   139		.set_hv_timer = vmx_set_hv_timer,
   140		.cancel_hv_timer = vmx_cancel_hv_timer,
   141	#endif
   142	
   143		.setup_mce = vmx_setup_mce,
   144	
   145		.smi_allowed = vmx_smi_allowed,
   146		.enter_smm = vmx_enter_smm,
   147		.leave_smm = vmx_leave_smm,
   148		.enable_smi_window = vmx_enable_smi_window,
   149	
   150		.can_emulate_instruction = vmx_can_emulate_instruction,
   151		.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
   152		.migrate_timers = vmx_migrate_timers,
   153	
   154		.msr_filter_changed = vmx_msr_filter_changed,
   155		.complete_emulated_msr = kvm_complete_insn_gp,
   156	
   157		.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
   158	};
   159	
   160	struct kvm_x86_init_ops vt_init_ops __initdata = {
   161		.cpu_has_kvm_support = vmx_cpu_has_kvm_support,
   162		.disabled_by_bios = vmx_disabled_by_bios,
   163		.check_processor_compatibility = vmx_check_processor_compat,
   164		.hardware_setup = vt_hardware_setup,
   165		.handle_intel_pt_intr = NULL,
   166	
   167		.runtime_ops = &vt_x86_ops,
   168	};
   169	
   170	static int __init vt_init(void)
   171	{
   172		unsigned int vcpu_size, vcpu_align;
   173		int r;
   174	
 > 175		vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
 > 176		vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
   177		vcpu_align = max(__alignof__(struct vcpu_vmx),
 > 178				__alignof__(struct vcpu_tdx));
   179	
   180		hv_vp_assist_page_init();
   181	
   182		r = kvm_init(&vt_init_ops, vcpu_size, vcpu_align, THIS_MODULE);
   183		if (r)
   184			goto err_vmx_post_exit;
   185	
   186		r = vmx_init();
   187		if (r)
   188			goto err_kvm_exit;
   189	
   190		return 0;
   191	
   192	err_kvm_exit:
   193		kvm_exit();
   194	err_vmx_post_exit:
   195		hv_vp_assist_page_exit();
   196		return r;
   197	}
   198	module_init(vt_init);
   199	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
