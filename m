Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1B4B2C42
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352425AbiBKR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:59:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbiBKR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:59:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF026CD3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602343; x=1676138343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ly4eWRKsJxj3FMJ3dAOIfDAsOe0OiL0UZ2cEYPo6R3E=;
  b=lXCO6AEsr1ESwB65Cdiwiet06HSQkpjQl/6BLkPlSf6CbQOz+QdE6GD5
   qa5JQlCKc9S+rLcZpqJQX1J/OjpIyqZsQPDOErxL1MX3TGmpPhmPAoFE7
   33/gIhCF3Hb9rykzwJTdvm/ClWX1Iyz/ptePlEc1SFaCgCXVv3oQhY10o
   3vwYxtzqwGAHJiHLLzmM5UjAQC5lju2CiRkqQ8IBhC5sMlrogbrj6DV3Y
   Ud6qcgJtvDtdGfUXU3jf9FdHkkSMIaKdmEVEjAPTN9PZzXFLJIzBEG9VP
   EfpwThJKUcrFvIfywwQ5Mpw4OMWGuIcbDP/xDHSLVPTw0Ghh4MJOTOnDM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="247369746"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="247369746"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542184957"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2022 09:59:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaCD-0004uU-3x; Fri, 11 Feb 2022 17:59:01 +0000
Date:   Sat, 12 Feb 2022 01:58:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 111/144]
 arch/x86/kvm/vmx/tdx_stubs.c:14:6: warning: no previous prototype for
 function 'tdx_vm_teardown'
Message-ID: <202202112353.bT0JdIv7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8dfa492341b8e8ba1c9dc534dd55565adc1b0ac0
commit: 1942310bc36276289fa54bb8d077c394078c4b15 [111/144] KVM: TDX: Add methods to ignore accesses to CPU state
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220211/202202112353.bT0JdIv7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/1942310bc36276289fa54bb8d077c394078c4b15
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 1942310bc36276289fa54bb8d077c394078c4b15
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/tdx_stubs.c:14:6: warning: no previous prototype for function 'tdx_vm_teardown' [-Wmissing-prototypes]
   void tdx_vm_teardown(struct kvm *kvm) {}
        ^
   arch/x86/kvm/vmx/tdx_stubs.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void tdx_vm_teardown(struct kvm *kvm) {}
   ^
   static 
   arch/x86/kvm/vmx/tdx_stubs.c:38:5: warning: no previous prototype for function 'tdx_deliver_posted_interrupt' [-Wmissing-prototypes]
   int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
       ^
   arch/x86/kvm/vmx/tdx_stubs.c:38:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
   ^
   static 
   2 warnings generated.


vim +/tdx_vm_teardown +14 arch/x86/kvm/vmx/tdx_stubs.c

    12	
    13	int tdx_vm_init(struct kvm *kvm) { return -EOPNOTSUPP; }
  > 14	void tdx_vm_teardown(struct kvm *kvm) {}
    15	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
