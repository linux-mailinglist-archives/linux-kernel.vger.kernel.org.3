Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524C94AEB43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiBIHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiBIHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:38:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E72DC0612C3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644392314; x=1675928314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lgv+VjqMbLy3IP9kp6JGQJxxv3sm/OsYAT8Wk27x+JA=;
  b=Em0EcrcVTlS3iH/N5+hLHGLClWA+C2QqOQuJX8ltx788IkA0Vnu67I5D
   vu2xJnO3j0u/CwrxZzX06f6RwMUUUPRZWD+evbRxZ1ZhDqrsiyoWbYLjp
   qPq6OtQrt2xyIS3HJLPL+vDQY2s+NdyFVgDVrdv6fqWvBvuCY/hqwUQJM
   Skni5/yx2HGcnzv+KttUDb0CSsk7t9/Lgq5v5xYP0IMUo2qRlgPJ7aDVU
   gS/Bz05i2vyh1PGbJ1NzwNBLsElx8kK/6MT8A4+FV88sgpXt4gvHZonYl
   vnCb5Yv01njfJZVDMXQfl0FJOBTgPprs3Wdq0FFhPgFscgFZqlEvGEXAT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312441992"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="312441992"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 23:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="701164801"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2022 23:38:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHhYd-0001QZ-Rc; Wed, 09 Feb 2022 07:38:31 +0000
Date:   Wed, 9 Feb 2022 15:38:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 86/141]
 arch/x86/kvm/vmx/tdx_stubs.c:26:5: warning: no previous prototype for
 'tdx_deliver_posted_interrupt'
Message-ID: <202202091551.vEzKN4Pb-lkp@intel.com>
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
head:   58f28b2fcc73d05d6a5a9f70a8fdacefa99acb85
commit: c4a72d4d1cfe13ebb2ee11e183fc4ebc9bc831d0 [86/141] KVM: TDX: Implement interrupt injection
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220209/202202091551.vEzKN4Pb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/c4a72d4d1cfe13ebb2ee11e183fc4ebc9bc831d0
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout c4a72d4d1cfe13ebb2ee11e183fc4ebc9bc831d0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kvm/vmx/tdx_stubs.c:9:5: warning: no previous prototype for 'tdx_module_setup' [-Wmissing-prototypes]
       9 | int tdx_module_setup(void) { return -EOPNOTSUPP; };
         |     ^~~~~~~~~~~~~~~~
>> arch/x86/kvm/vmx/tdx_stubs.c:26:5: warning: no previous prototype for 'tdx_deliver_posted_interrupt' [-Wmissing-prototypes]
      26 | int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tdx_deliver_posted_interrupt +26 arch/x86/kvm/vmx/tdx_stubs.c

    24	
    25	void tdx_apicv_post_state_restore(struct kvm_vcpu *vcpu) {}
  > 26	int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { return 0; }
    27	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
