Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852E54D9571
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbiCOHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiCOHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:39:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFCC1D307
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647329885; x=1678865885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FYNhQYCA7hfsUV9fqsiMThE6b9nySacqxqWFdbXGZ+4=;
  b=bgPyY5LB5236wWqsWm2e0TMJbk8C5sA+TmJ3UYYM9ZnnEBnML2eMElcV
   iHdwH9XyaWEgpNvVu/jk304pN9ADQerSY/HLtX0LGymf+vkojCq34Gg2+
   kAMxKLT5qGc/qsKqhA8YCvZQ+8AWif9vJDS+GVldKQO6MC47ygJPheaEd
   FJqAsf7AhHusYZf3iWs6XtwEuMSyXTgNexnGdL6SENeYObA3Y4N69e4u+
   rz7s0r6JBN19o3dDPZ1xLlctpVT8ETw/+CeiEFoMg4ELl5yDoQlrKhOJC
   rg2pTECRCAjKQHv4X5fnmPSUE1vNSxPDGWA9XFrLBg2PJLoSUDLcOmNZh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243687420"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="243687420"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 00:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="540320693"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 00:36:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU1j0-000Ah3-Ll; Tue, 15 Mar 2022 07:36:10 +0000
Date:   Tue, 15 Mar 2022 15:35:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 149/296]
 arch/x86/kvm/vmx/main.c:175:51: error: invalid application of 'sizeof' to an
 incomplete type 'struct kvm_tdx'
Message-ID: <202203151531.zATdFM5Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   97612c5f3be3447870b5d6fd476931a4c5ff280f
commit: 540e161d6f1b1e4ca7535ef11258660947ae7b00 [149/296] KVM: TDX: Add placeholders for TDX VM/vcpu structure
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220315/202203151531.zATdFM5Y-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/540e161d6f1b1e4ca7535ef11258660947ae7b00
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 540e161d6f1b1e4ca7535ef11258660947ae7b00
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kvm/vmx/main.c:175:51: error: invalid application of 'sizeof' to an incomplete type 'struct kvm_tdx'
           vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
                                                            ^     ~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:36: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                                            ^
   include/linux/minmax.h:36:38: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                               ^
   include/linux/minmax.h:26:19: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                                   ^
   include/linux/minmax.h:20:39: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                                ^
   arch/x86/kvm/vmx/tdx.h:38:8: note: forward declaration of 'struct kvm_tdx'
   struct kvm_tdx;
          ^
>> arch/x86/kvm/vmx/main.c:175:51: error: invalid application of 'sizeof' to an incomplete type 'struct kvm_tdx'
           vt_x86_ops.vm_size = max(sizeof(struct kvm_vmx), sizeof(struct kvm_tdx));
                                                            ^     ~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:36: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                                            ^
   include/linux/minmax.h:36:38: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                               ^
   include/linux/minmax.h:26:46: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                                                              ^
   include/linux/minmax.h:23:40: note: expanded from macro '__no_side_effects'
                   (__is_constexpr(x) && __is_constexpr(y))
                                                        ^
   include/linux/const.h:12:48: note: expanded from macro '__is_constexpr'
           (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                         ^
   arch/x86/kvm/vmx/tdx.h:38:8: note: forward declaration of 'struct kvm_tdx'
   struct kvm_tdx;
          ^
>> arch/x86/kvm/vmx/main.c:176:43: error: invalid application of 'sizeof' to an incomplete type 'struct vcpu_tdx'
           vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
                                                    ^     ~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:36: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                                            ^
   include/linux/minmax.h:36:38: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                               ^
   include/linux/minmax.h:26:19: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                                   ^
   include/linux/minmax.h:20:39: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                                ^
   arch/x86/kvm/vmx/tdx.h:39:8: note: forward declaration of 'struct vcpu_tdx'
   struct vcpu_tdx;
          ^
>> arch/x86/kvm/vmx/main.c:176:43: error: invalid application of 'sizeof' to an incomplete type 'struct vcpu_tdx'
           vcpu_size = max(sizeof(struct vcpu_vmx), sizeof(struct vcpu_tdx));
                                                    ^     ~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:36: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                                            ^
   include/linux/minmax.h:36:38: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                               ^
   include/linux/minmax.h:26:46: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                                                              ^
   include/linux/minmax.h:23:40: note: expanded from macro '__no_side_effects'
                   (__is_constexpr(x) && __is_constexpr(y))
                                                        ^
   include/linux/const.h:12:48: note: expanded from macro '__is_constexpr'
           (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                         ^
   arch/x86/kvm/vmx/tdx.h:39:8: note: forward declaration of 'struct vcpu_tdx'
   struct vcpu_tdx;
          ^
>> arch/x86/kvm/vmx/main.c:178:4: error: invalid application of '__alignof' to an incomplete type 'struct vcpu_tdx'
                           __alignof__(struct vcpu_tdx));
                           ^          ~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:36: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                                            ^
   include/linux/minmax.h:36:38: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                               ^
   include/linux/minmax.h:26:19: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                                   ^
   include/linux/minmax.h:20:39: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                                ^
   arch/x86/kvm/vmx/tdx.h:39:8: note: forward declaration of 'struct vcpu_tdx'
   struct vcpu_tdx;
          ^
>> arch/x86/kvm/vmx/main.c:178:4: error: invalid application of '__alignof' to an incomplete type 'struct vcpu_tdx'
                           __alignof__(struct vcpu_tdx));
                           ^          ~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:36: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                                            ^
   include/linux/minmax.h:36:38: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                               ^
   include/linux/minmax.h:26:46: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                                                              ^
   include/linux/minmax.h:23:40: note: expanded from macro '__no_side_effects'
                   (__is_constexpr(x) && __is_constexpr(y))
                                                        ^
   include/linux/const.h:12:48: note: expanded from macro '__is_constexpr'
           (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                         ^
   arch/x86/kvm/vmx/tdx.h:39:8: note: forward declaration of 'struct vcpu_tdx'
   struct vcpu_tdx;
          ^
   6 errors generated.


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
