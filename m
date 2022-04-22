Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7335C50C563
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiDVX40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiDVX4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:56:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A441836EE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650671609; x=1682207609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xfanVpJdC/UZMEnT2IP+wkQsamtqXmIteH+qcMhR0ls=;
  b=NTKrxFxFi4doeNrS6M/roQg4JxoZdOaCpzvroKyKmfVwk11TITO1voGj
   kYXdJZYGJ8UZKqVbU4YGlpVzr59kdx0aANJ3J8j6jBki9AgzcqI9hIP6Y
   ZlJLw67f/zEStu8QYjZ06AIniCZeD0dyBNc+NZHXF55lCDs7vLfHEbgzT
   M8257CdgjCHqz5fd/AEcukdblNWTWimAT+YFWH6zvZXxjuamcHUId5t2U
   EECKKy09BpIR8attFVXi/6iS9JC44qmd4qIlTMQH4v5e7GbddEuSerPU5
   lKwsOF/DXRJ5ydoTbmFiY+EHn2A3kjudyXBcVzmnduRiYh4ILcxW+llYL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244743026"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244743026"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="672754530"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2022 16:53:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni35a-000Agr-JG;
        Fri, 22 Apr 2022 23:53:26 +0000
Date:   Sat, 23 Apr 2022 07:52:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuan Yao <yuan.yao@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 275/293]
 arch/x86/kvm/vmx/tdx.c:2513:6: warning: variable 'intr_info' set but not
 used
Message-ID: <202204230704.f0zI8eIQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   d32e9a403c5c4f16dc577cbe92148e5b80f79d59
commit: da013991b3b3b4a9e20f84f268dc69f139aa8bdb [275/293] KVM: TDX: Basic exception injection support for DEBUG TDX guest
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220423/202204230704.f0zI8eIQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/da013991b3b3b4a9e20f84f268dc69f139aa8bdb
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout da013991b3b3b4a9e20f84f268dc69f139aa8bdb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/tdx.c:2513:6: warning: variable 'intr_info' set but not used [-Wunused-but-set-variable]
           u32 intr_info;
               ^
   1 warning generated.


vim +/intr_info +2513 arch/x86/kvm/vmx/tdx.c

  2498	
  2499	void tdx_set_gdt(struct kvm_vcpu *vcpu, struct desc_ptr *dt)
  2500	{
  2501		if (!is_debug_td(vcpu))
  2502			return;
  2503	
  2504		td_vmcs_write32(to_tdx(vcpu), GUEST_GDTR_LIMIT, dt->size);
  2505		td_vmcs_write64(to_tdx(vcpu), GUEST_GDTR_BASE, dt->address);
  2506	}
  2507	void tdx_queue_exception(struct kvm_vcpu *vcpu)
  2508	{
  2509		struct vcpu_tdx *tdx;
  2510		unsigned int nr;
  2511		bool has_error_code;
  2512		u32 error_code;
> 2513		u32 intr_info;
  2514	
  2515		if (KVM_BUG_ON(!is_debug_td(vcpu), vcpu->kvm))
  2516			return;
  2517	
  2518		tdx = to_tdx(vcpu);
  2519		nr = vcpu->arch.exception.nr;
  2520		has_error_code = vcpu->arch.exception.has_error_code;
  2521		error_code = vcpu->arch.exception.error_code;
  2522		intr_info = nr | INTR_INFO_VALID_MASK;
  2523	
  2524		kvm_deliver_exception_payload(vcpu);
  2525	
  2526		if (has_error_code) {
  2527			td_vmcs_write32(tdx, VM_ENTRY_EXCEPTION_ERROR_CODE,
  2528					error_code);
  2529			intr_info |= INTR_INFO_DELIVER_CODE_MASK;
  2530		}
  2531	
  2532		if (kvm_exception_is_soft(nr)) {
  2533			td_vmcs_write32(tdx, VM_ENTRY_INSTRUCTION_LEN,
  2534					vcpu->arch.event_exit_inst_len);
  2535			intr_info |= INTR_TYPE_SOFT_EXCEPTION;
  2536		} else {
  2537			intr_info |= INTR_TYPE_HARD_EXCEPTION;
  2538		}
  2539	
  2540		pr_warn_once("Exception injection is not supported by TDX.\n");
  2541		/* td_vmcs_write32(tdx, VM_ENTRY_INTR_INFO_FIELD, intr_info);*/
  2542	}
  2543	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
