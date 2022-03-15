Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2994DA578
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352281AbiCOWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348559AbiCOWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:40:05 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DC65D185
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647383931; x=1678919931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+QR2ILQfl/Z/6mymgKHQW6ltgGMO45UuFgE6ofk8f0o=;
  b=b6qjPpvITQwixvdEuGlekgTORs7lIX5QvzLyQK2wXM7d6Fjur2YQCKlp
   3dkDra86yfTa1zsDYhybQWrTwLksywvDDoVADBYGhMollwemWCBNJt/yS
   hdxb4rNhoeYmEGqYKLN7xc5qbxwlNQ1hCv9S5yuvEgmnwOI1TAmaR2pRM
   hqUpuSJZ8GAVsSIyPSkuYUfpMaoMrei1rWXW75R/FvVqDm9tBHORJWmYO
   Me7d/onl3Js9pR0+TVLVK5NaaEUP72zPPgfh+/NoDcwBxh23pI8lBReyT
   uBIB0FHWDjMvyziP+lBLxTdbJR5HzDXHTW8I4fsxhjaN8DX8zBBb0dPNN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317158160"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="317158160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 15:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646405761"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 15:38:16 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUFnz-000Ba1-Cc; Tue, 15 Mar 2022 22:38:15 +0000
Date:   Wed, 16 Mar 2022 06:37:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 149/296]
 arch/x86/kvm/vmx/main.c:175:58: error: invalid application of 'sizeof' to
 incomplete type 'struct kvm_tdx'
Message-ID: <202203160607.2mVzGlMC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220316/202203160607.2mVzGlMC-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/540e161d6f1b1e4ca7535ef11258660947ae7b00
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 540e161d6f1b1e4ca7535ef11258660947ae7b00
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

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
>> include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
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
>> include/linux/minmax.h:36:2: error: first argument to '__builtin_choose_expr' not a constant
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
