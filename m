Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3351CDA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387450AbiEFAPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387441AbiEFAOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:14:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D23A5DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795872; x=1683331872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PDsnw3ASTnR8ThsfVBTdSrYjKJCXtE4HRyK2jWA9t1s=;
  b=K1Iu71Ggz2xxVpRg1du8fYPm3cwK4jof4vDob2kVE2NpCJ7t2xHcDQoj
   RvVt65O1Bq4RA/TPHeXeJSLRBWnftgEQyVyyalBhD5nYI+460yLITC/C1
   IX8kzinmdcNhUhdZUIKH+fM0+mh7K3TvtISOYX2U9tyxGvoMu5365pE1X
   dj89mMQozGEGnPIiCh3B0gY6BkMu61DaZ01aPNQQSgxL1hzpbx2Ex1HZP
   6N/fVoA9tOEq+eLCTrrguYaXmcm5sZF9IeZ3+TH7dn3PCBR4d9kNFSVKO
   OV+6DRLmUSSieyElsbiTp795p62lAH21Q1/Kx1NwvNdXfb/gD89IgYfMm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331285498"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331285498"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585649802"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2022 17:11:10 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmlYr-000Cru-GR;
        Fri, 06 May 2022 00:11:09 +0000
Date:   Fri, 6 May 2022 08:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [intel-tdx:kvm-upstream-workaround 99/361]
 arch/x86/kvm/vmx/vmx.c:4410:5: error: no previous prototype for function
 'vmx_get_pid_table_order'
Message-ID: <202205060807.LvZYGFIP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   3b5b338cdf10dca7a2435d1f86b2dd9f1a3ad833
commit: 833404c859e4357ba656b2d19d5a405ba7bf4ec4 [99/361] KVM: VMX: enable IPI virtualization
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220506/202205060807.LvZYGFIP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/833404c859e4357ba656b2d19d5a405ba7bf4ec4
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 833404c859e4357ba656b2d19d5a405ba7bf4ec4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kvm/vmx/vmx.c:4410:5: error: no previous prototype for function 'vmx_get_pid_table_order' [-Werror,-Wmissing-prototypes]
   int vmx_get_pid_table_order(struct kvm *kvm)
       ^
   arch/x86/kvm/vmx/vmx.c:4410:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vmx_get_pid_table_order(struct kvm *kvm)
   ^
   static 
   1 error generated.


vim +/vmx_get_pid_table_order +4410 arch/x86/kvm/vmx/vmx.c

  4409	
> 4410	int vmx_get_pid_table_order(struct kvm *kvm)
  4411	{
  4412		return get_order(kvm->arch.max_vcpu_ids * sizeof(*to_kvm_vmx(kvm)->pid_table));
  4413	}
  4414	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
