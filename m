Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271EB4D9AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbiCOLxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbiCOLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:53:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2A506F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647345151; x=1678881151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mTZrygafo35JrEJvSje42SiU4NePKm5RiFT0gPOypi4=;
  b=YJQYGz4d6UUnTMNiUuIV3S+qw5ZEbCdqdV6Oe4/HG9PpYP8d2Ia9K7ko
   q7H8k73s71L8L0gsvjogzL2iMOGnhHvzUfyWyHMo0ZWF04vmJ6t2WUfaS
   +xvHWvGO6G8ZKJ2hTFPrPjpU+DMj79lYh3hZRkZIK5eViujMNJmbBPg7r
   JlyA96l/lLrpFwb0s0oQsHhLKC2fLYQRDEV9bBO5JPZYhT7HJsqBg4Tym
   VbDdMCOCFul99I3ltzHxDOIS5Xo2jYPewrISlGd+gnTQALe+ihEMGZHxQ
   e0mRn4ynsXBj8XjiYZekp1/dUDrW82pvVhaJiPgYA787fBfLknPIxkCM8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281047714"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="281047714"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 04:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="512577540"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2022 04:52:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU5j2-000AuU-Qq; Tue, 15 Mar 2022 11:52:28 +0000
Date:   Tue, 15 Mar 2022 19:52:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Will Deacon <willdeacon@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-02
 961/9999] arch/arm64/kvm/hyp/include/hyp/switch.h:216:9: error: implicit
 declaration of function 'sve_cond_update_zcr_vq'
Message-ID: <202203151945.lySosvnE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-02
head:   138191a069ba3cc62c9b3a287d76cbc0c6202f0f
commit: 1105b4d1cef4bc19ad20129a716194268c937eaf [961/9999] BACKPORT: FROMGIT: KVM: arm64: Rework SVE host-save/guest-restore
config: arm64-randconfig-r036-20220314 (https://download.01.org/0day-ci/archive/20220315/202203151945.lySosvnE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/1105b4d1cef4bc19ad20129a716194268c937eaf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-02
        git checkout 1105b4d1cef4bc19ad20129a716194268c937eaf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kvm/hyp/nvhe/switch.c:8:
   arch/arm64/kvm/hyp/include/hyp/switch.h: In function '__hyp_sve_restore_guest':
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:9: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror=implicit-function-declaration]
     216 |         sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/switch.c: At top level:
   arch/arm64/kvm/hyp/nvhe/switch.c:282:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     282 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/arm64/kvm/hyp/nvhe/hyp-main.c:7:
   arch/arm64/kvm/hyp/include/hyp/switch.h: In function '__hyp_sve_restore_guest':
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:9: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror=implicit-function-declaration]
     216 |         sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/nvhe/hyp-main.c: At top level:
   arch/arm64/kvm/hyp/nvhe/hyp-main.c:233:6: warning: no previous prototype for 'handle_trap' [-Wmissing-prototypes]
     233 | void handle_trap(struct kvm_cpu_context *host_ctxt)
         |      ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/arm64/kvm/hyp/nvhe/mem_protect.c:15:
   arch/arm64/kvm/hyp/include/hyp/switch.h: In function '__hyp_sve_restore_guest':
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:9: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror=implicit-function-declaration]
     216 |         sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/arm64/kvm/hyp/vhe/switch.c:8:
   arch/arm64/kvm/hyp/include/hyp/switch.h: In function '__hyp_sve_restore_guest':
>> arch/arm64/kvm/hyp/include/hyp/switch.h:216:9: error: implicit declaration of function 'sve_cond_update_zcr_vq' [-Werror=implicit-function-declaration]
     216 |         sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/hyp/vhe/switch.c: At top level:
   arch/arm64/kvm/hyp/vhe/switch.c:227:17: warning: no previous prototype for 'kvm_unexpected_el2_exception' [-Wmissing-prototypes]
     227 | asmlinkage void kvm_unexpected_el2_exception(void)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sve_cond_update_zcr_vq +216 arch/arm64/kvm/hyp/include/hyp/switch.h

   213	
   214	static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
   215	{
 > 216		sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
   217		__sve_restore_state(vcpu_sve_pffr(vcpu),
   218				    &vcpu->arch.ctxt.fp_regs.fpsr);
   219		write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
   220	}
   221	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
