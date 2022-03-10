Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA64D548F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiCJWYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiCJWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:24:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8CBF4D3F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646950989; x=1678486989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fF+3qyUbUukq0jg8sTNO94/16OGrvG79CjMrQVctGRM=;
  b=eL3HYQ+6wn4kiqityd0wayy7d8bZ2605eCui2DwYGcIs7rKt9CFmuSfQ
   rJIMUpFp+84YPW/0ZJOw74IGUq8llsgrmcMaTr/HphIt3d+iJcdBirQ/5
   dtFJSyvV01NCD9rLtyMwnkVQlhrgKAgn9r5uzWRsa6keQnDGYaTdhr+CF
   L7F/EaYBaXktMMiJPGeS4CA+hDXfrKfOAAQz6Flp3+xbr0oKrV4tsa9CM
   QKjxACaflIrJjTQBLFiWKwDYRq12/UaMPdM854q2M9szDrA82h2657HEn
   8i+fp+5jy2a4JsN4RJ+Rzncasvn6TfViGsPBWsIqb/t3iRmp6eBBZJvZj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="252961178"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252961178"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 14:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="633160066"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2022 14:23:04 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSRBY-0005Ta-5G; Thu, 10 Mar 2022 22:23:04 +0000
Date:   Fri, 11 Mar 2022 06:22:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Scull <ascull@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype
 for function 'nvhe_hyp_panic_handler'
Message-ID: <202203110617.SylT3htc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1db333d9a51f3459fba1bcaa564d95befe79f0b3
commit: aec0fae62e47050019474936248a311a0ab08705 KVM: arm64: Log source when panicking from nVHE hyp
date:   11 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220311/202203110617.SylT3htc-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aec0fae62e47050019474936248a311a0ab08705
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aec0fae62e47050019474936248a311a0ab08705
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ arch/arm64/kvm/ drivers/gpu/drm/tegra/ drivers/usb/host/ kernel/debug/kdb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:182:25: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_CP14_64]    = kvm_handle_cp14_64,
                                     ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:183:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_HVC32]      = handle_hvc,
                                     ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:184:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SMC32]      = handle_smc,
                                     ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:185:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_HVC64]      = handle_hvc,
                                     ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:186:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SMC64]      = handle_smc,
                                     ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:187:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SYS64]      = kvm_handle_sys_reg,
                                     ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:188:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SVE]        = handle_sve,
                                     ^~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:189:26: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_IABT_LOW]   = kvm_handle_guest_abort,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:190:26: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_DABT_LOW]   = kvm_handle_guest_abort,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:191:28: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:192:28: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_WATCHPT_LOW]= kvm_handle_guest_debug,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:193:28: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:194:24: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BKPT32]     = kvm_handle_guest_debug,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:195:23: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_BRK64]      = kvm_handle_guest_debug,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:196:26: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_FP_ASIMD]   = handle_no_fpsimd,
                                     ^~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:197:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [ESR_ELx_EC_PAC]        = kvm_handle_ptrauth,
                                     ^~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/handle_exit.c:176:27: note: previous initialization is here
           [0 ... ESR_ELx_EC_MAX]  = kvm_handle_unknown_ec,
                                     ^~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/handle_exit.c:295:24: warning: no previous prototype for function 'nvhe_hyp_panic_handler' [-Wmissing-prototypes]
   void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,
                          ^
   arch/arm64/kvm/handle_exit.c:295:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,
   ^
   static 
   22 warnings generated.


vim +/nvhe_hyp_panic_handler +295 arch/arm64/kvm/handle_exit.c

   294	
 > 295	void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr, u64 elr,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
