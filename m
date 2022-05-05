Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF151CC62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386516AbiEEXDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384846AbiEEXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:03:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72425EBE8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651791575; x=1683327575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EJCeTwcho2rg+vtX69Tp2tAbVfSDGR5rxtbXy0ad6/c=;
  b=BDNox4eh6iCRM2B9mynYbZeSmtDJo918/KbQ2heu2c8wPZT0/P0PIvLl
   ZFG8oSNhqlQlteWHjpka3y5GdXHzApbQMPPHrlHfXo7Gzv4toz0wsnMGY
   2JVXPoA/UhtI0Tp8LZWZ4yOOUgOVRRVTdv8xWAFWilNu2kil66WFvffZk
   7bY7uMrYXm0jjiopiWfIQGCH4YUFebTc91AAobqeLvVyUKlU7v7tZHGSm
   m2kyXL19X5zOaN3CorEoVqPAEm63dXCMMH9MFQE/b829z5MTJl/GyU9EK
   n+vvkmX/Nfank+oYnnNAyzqo5L3z7WilOLVopZr7PMhJsyXr9+jKPULOu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267117906"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267117906"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537578658"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2022 15:59:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmkR7-000Cog-Nk;
        Thu, 05 May 2022 22:59:05 +0000
Date:   Fri, 6 May 2022 06:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [intel-tdx:kvm-upstream-workaround 99/361]
 arch/x86/kvm/vmx/vmx.c:4410:5: warning: no previous prototype for function
 'vmx_get_pid_table_order'
Message-ID: <202205060641.5vrhv8DY-lkp@intel.com>
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
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220506/202205060641.5vrhv8DY-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/vmx.c:4410:5: warning: no previous prototype for function 'vmx_get_pid_table_order' [-Wmissing-prototypes]
   int vmx_get_pid_table_order(struct kvm *kvm)
       ^
   arch/x86/kvm/vmx/vmx.c:4410:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vmx_get_pid_table_order(struct kvm *kvm)
   ^
   static 
   1 warning generated.


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
