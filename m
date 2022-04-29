Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0F5153B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379899AbiD2Seq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiD2Sel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:34:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCBF45ADD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651257082; x=1682793082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=22k+uDUKRz+4AKVJv51f6r8phWje2KTHsjePCuxnph4=;
  b=jIm/EJPOLGCvxWhYwrhVZXRUK9kw7PtNoYBb/O6WgiAPGQauF2NsEQ0D
   6pk66UkIt91u+s85BSwTY7vxZs2US5n6Lb/Pqph/fcmQi5nIBnvKqI0hX
   TzpwjU0r5d+93I/MIHUUsLxA6+kqNko3AdYF2HG3rD+oni7vYRauRzwSY
   ++UhgQV73PJaaKW5B1G3nq0yTf2v7tCTCsOwgYGHrss8CC6Kh3cBOmSOO
   cdhWac31R9KUx7hsJGKjoz9Vcuf9Y3Dr0c1ipXIfHSZO5kNiInZ5iPzCi
   k17K3UIhaquyluGasUj7LbKYtmcaDd7EGS0+e/sOtuaoNuvRoAPbBEL5E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="247295940"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="247295940"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 11:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="542747392"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2022 11:31:20 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkVOh-0006Yd-Ik;
        Fri, 29 Apr 2022 18:31:19 +0000
Date:   Sat, 30 Apr 2022 02:30:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: expecting prototype
 for Handler for protected floating(). Prototype was for
 kvm_handle_pvm_fpsimd() instead
Message-ID: <202204300241.xkeys5UL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
commit: 1423afcb411780c7a6a68f801fdcfb6920ad6f06 KVM: arm64: Trap access to pVM restricted features
date:   7 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220430/202204300241.xkeys5UL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1423afcb411780c7a6a68f801fdcfb6920ad6f06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1423afcb411780c7a6a68f801fdcfb6920ad6f06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/switch.c:126: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Disable host events, enable guest events
   arch/arm64/kvm/hyp/nvhe/switch.c:146: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Disable guest events, enable host events
   arch/arm64/kvm/hyp/nvhe/switch.c:164: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Handler for protected VM restricted exceptions.
   arch/arm64/kvm/hyp/nvhe/switch.c:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Handler for protected VM MSR, MRS or System instruction execution in AArch64.
   arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: Function parameter or member 'vcpu' not described in 'kvm_handle_pvm_fpsimd'
   arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: Function parameter or member 'exit_code' not described in 'kvm_handle_pvm_fpsimd'
>> arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: expecting prototype for Handler for protected floating(). Prototype was for kvm_handle_pvm_fpsimd() instead


vim +196 arch/arm64/kvm/hyp/nvhe/switch.c

   188	
   189	/**
   190	 * Handler for protected floating-point and Advanced SIMD accesses.
   191	 *
   192	 * Returns true if the hypervisor has handled the exit, and control should go
   193	 * back to the guest, or false if it hasn't.
   194	 */
   195	static bool kvm_handle_pvm_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 > 196	{
   197		/* Linux guests assume support for floating-point and Advanced SIMD. */
   198		BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_FP),
   199					PVM_ID_AA64PFR0_ALLOW));
   200		BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_ASIMD),
   201					PVM_ID_AA64PFR0_ALLOW));
   202	
   203		return kvm_hyp_handle_fpsimd(vcpu, exit_code);
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
