Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BFA51CB00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385916AbiEEVao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385616AbiEEVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:30:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39164BB8E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651786015; x=1683322015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iuqFmlGTItxGsNc0Xs2oz0mIeZSptY8ovrLsK52ti4s=;
  b=Otl8hdgz9q4NUfcCTqKHI3/BYWZjAMQOTb6jIlVonA/nfk6sU90+eadX
   f5lVJ9/WqlqifuGIQhDFl89UTmVZ05jY78GaO5xScd7Y9d4y/D8TSvqH4
   nKx2SuOKld450WBXGWAUkDbfpNBMxdWYzt5kbOGL08i21KtT5a5XQPE09
   7JVp00fZak+LJwPb32evyAcwiuSPv6hpssixUbhOJFgMrUUjSK99DVdZR
   RJnhrEBMwkIH6GDbNVcXoYLQ90R1pE8X9Osqzx207xTy+FYXX+29DU1Ig
   fAufpJQcuE8h652AuJDqURylYbmenKy5SqDVMsT0Q1p8IMCP19KiMo6sh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354690704"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="354690704"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 14:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="632623928"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 May 2022 14:26:54 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmizt-000CmC-LK;
        Thu, 05 May 2022 21:26:53 +0000
Date:   Fri, 6 May 2022 05:26:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [intel-tdx:kvm-upstream-workaround 99/361]
 arch/x86/kvm/vmx/vmx.c:4410:5: warning: no previous prototype for
 'vmx_get_pid_table_order'
Message-ID: <202205060503.iU8bElBs-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220506/202205060503.iU8bElBs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/833404c859e4357ba656b2d19d5a405ba7bf4ec4
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 833404c859e4357ba656b2d19d5a405ba7bf4ec4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/vmx.c:4410:5: warning: no previous prototype for 'vmx_get_pid_table_order' [-Wmissing-prototypes]
    4410 | int vmx_get_pid_table_order(struct kvm *kvm)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


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
