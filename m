Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AD4E9F91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiC1TOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiC1TOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:14:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C677366C96
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648494775; x=1680030775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DdkMnQt+3cK1i7RyJqY8kdWoHo4RGsdW+SLLoGJFSwA=;
  b=TuUgm6SmHTeu9ogMi8DckTvzIU5aaQrEcB6LO11l8p52k9/7rhZbMSSt
   jc1N7xC+/pCEsoZKn3+GaxBktGEwI5SHH3p5xtCj3Wmb6PB8PY0HSMZWU
   QOufZeTAcvIUL7anfyHSJSZap5Tvbk1LHPTnedot4s6vwqqr47JM1pZrH
   j25m4lkn0JJ1kiB6CAD7NK0chc2GwmBsccatQPof43vVaE617oXdbC3uO
   Cbssvy2Ui3B89r14+xMA0klWpqXdKIUIjSD9OXdWkMdl2agpFNMjg4zm0
   /xC/Vtm2N6tG9lbMLbYfzJwe40N5XoYqz8y6mu+fSLGOiCBWhOWCHJgBV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239017478"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="239017478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 12:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="502627407"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2022 12:12:42 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYunC-0002Fs-61; Mon, 28 Mar 2022 19:12:42 +0000
Date:   Tue, 29 Mar 2022 03:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <willdeacon@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 5561/5564] arch/arm64/kvm/hyp/nvhe/psci-relay.c:249:6: warning: no previous
 prototype for 'psci_mem_protect_inc'
Message-ID: <202203290356.y3LU3iyb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   2692f0f6f17ff8ec82ffbcdf2e151249768724a2
commit: 4347917056dadaf7856cce8312eb1c55e1372a2a [5561/5564] ANDROID: KVM: arm64: Use PSCI MEM_PROTECT to zap guest pages on reset
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220329/202203290356.y3LU3iyb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4347917056dadaf7856cce8312eb1c55e1372a2a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout 4347917056dadaf7856cce8312eb1c55e1372a2a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/psci-relay.c:204:28: warning: no previous prototype for 'kvm_host_psci_cpu_entry' [-Wmissing-prototypes]
     204 | asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/hyp/nvhe/psci-relay.c:249:6: warning: no previous prototype for 'psci_mem_protect_inc' [-Wmissing-prototypes]
     249 | void psci_mem_protect_inc(void)
         |      ^~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/hyp/nvhe/psci-relay.c:256:6: warning: no previous prototype for 'psci_mem_protect_dec' [-Wmissing-prototypes]
     256 | void psci_mem_protect_dec(void)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/psci_mem_protect_inc +249 arch/arm64/kvm/hyp/nvhe/psci-relay.c

   203	
 > 204	asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
   205	{
   206		struct psci_boot_args *boot_args;
   207		struct kvm_cpu_context *host_ctxt;
   208	
   209		host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
   210	
   211		if (is_cpu_on)
   212			boot_args = this_cpu_ptr(&cpu_on_args);
   213		else
   214			boot_args = this_cpu_ptr(&suspend_args);
   215	
   216		cpu_reg(host_ctxt, 0) = boot_args->r0;
   217		write_sysreg_el2(boot_args->pc, SYS_ELR);
   218	
   219		if (is_cpu_on)
   220			release_boot_args(boot_args);
   221	
   222		__host_enter(host_ctxt);
   223	}
   224	
   225	static DEFINE_HYP_SPINLOCK(mem_protect_lock);
   226	
   227	static u64 psci_mem_protect(s64 offset)
   228	{
   229		static u64 cnt;
   230		u64 new = cnt + offset;
   231	
   232		hyp_assert_lock_held(&mem_protect_lock);
   233	
   234		if (!offset || kvm_host_psci_config.version < PSCI_VERSION(1, 1))
   235			return cnt;
   236	
   237		if (!cnt || !new)
   238			psci_call(PSCI_1_1_FN64_MEM_PROTECT, offset < 0 ? 0 : 1, 0, 0);
   239	
   240		cnt = new;
   241		return cnt;
   242	}
   243	
   244	static bool psci_mem_protect_active(void)
   245	{
   246		return psci_mem_protect(0);
   247	}
   248	
 > 249	void psci_mem_protect_inc(void)
   250	{
   251		hyp_spin_lock(&mem_protect_lock);
   252		psci_mem_protect(1);
   253		hyp_spin_unlock(&mem_protect_lock);
   254	}
   255	
 > 256	void psci_mem_protect_dec(void)
   257	{
   258		hyp_spin_lock(&mem_protect_lock);
   259		psci_mem_protect(-1);
   260		hyp_spin_unlock(&mem_protect_lock);
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
