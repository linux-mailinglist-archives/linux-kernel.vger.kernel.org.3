Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056584B2C41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiBKR7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:59:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352421AbiBKR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:59:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C08D43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602348; x=1676138348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xYDS/U/XsDwMg0NrYXLrZA7t+yRx2dLl76tvsJyU43w=;
  b=F1KRQiSLJ46RAXcDxE9SukKtbhha8bmCYhkFWQXNiSC+TMRH0jUfM4VM
   XypJoH2ZGpVwzHwkrXMCjrlzb6gJYedPlHKJi0KlbVptdjxUq8FW19H46
   Z4RhsP/f1ZhxsP4/x143cMaXIstHTzrpAs3JdIs5xU+xZGTw5ElMHBzdb
   27BNEx/5N6VBdFqkzld2bOeK9g8W/t4Ws0N+E3EsBL6cv3jSj07/kOrpZ
   O7moNyHxViugdMdFqdfCl5MnTtPMOwAw3+kfaT7EckdeXin7Mvc4CAXdz
   mt7bpN2/EvLbRI6USdDZ8UhA/XVzg0r1NUwc3Do7PhVKiT+5Bhi7oSBvX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="313059422"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313059422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483542309"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2022 09:59:06 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaCD-0004uF-0G; Fri, 11 Feb 2022 17:59:01 +0000
Date:   Sat, 12 Feb 2022 01:58:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 111/144]
 arch/x86/kvm/vmx/tdx_stubs.c:14:6: warning: no previous prototype for
 'tdx_vm_teardown'
Message-ID: <202202112348.D1I1yBvA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8dfa492341b8e8ba1c9dc534dd55565adc1b0ac0
commit: 1942310bc36276289fa54bb8d077c394078c4b15 [111/144] KVM: TDX: Add methods to ignore accesses to CPU state
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220211/202202112348.D1I1yBvA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/1942310bc36276289fa54bb8d077c394078c4b15
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 1942310bc36276289fa54bb8d077c394078c4b15
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/tdx_stubs.c:14:6: warning: no previous prototype for 'tdx_vm_teardown' [-Wmissing-prototypes]
      14 | void tdx_vm_teardown(struct kvm *kvm) {}
         |      ^~~~~~~~~~~~~~~
   arch/x86/kvm/vmx/tdx_stubs.c:38:5: warning: no previous prototype for 'tdx_deliver_posted_interrupt' [-Wmissing-prototypes]
      38 | int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tdx_vm_teardown +14 arch/x86/kvm/vmx/tdx_stubs.c

    12	
    13	int tdx_vm_init(struct kvm *kvm) { return -EOPNOTSUPP; }
  > 14	void tdx_vm_teardown(struct kvm *kvm) {}
    15	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
