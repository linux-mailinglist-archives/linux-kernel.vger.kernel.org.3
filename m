Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAFC4EC665
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbiC3OX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbiC3OXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:23:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF4A19B07E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648650130; x=1680186130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3BHM//KxN/L/Kk8e1wzynNcmkq/HH5ezJ9aW6BKd3I=;
  b=MzBbMLuv4ZehPipUb9U7NbXa+QyOh6IkPkodoGhDhqTgMwM8ZZf728kG
   rvNsuvZxsDYB9uOJg2Ym2t6X9IUp15KQRfcDg4MTqkl84uQ0BRgLSk2Kh
   nKutDa/Ci7USJnibaveUKBxEGfvgGYFKUmq1v9l0tFCXSMdCfCL6X9Y01
   5M82CS04RN/jDq/KMcZDKlbkPAWUgSfYQycW41Dm02gHvIp5EicmFoBlF
   R4AnjCOP91VW6GA7hQNESJTP24jGBO5YRkB0lD32l0chHWKnQn+uCjc1M
   PEXGaguiNT6sVuP9gc61KjMbgsoVpD2ECLILedZ3CkTWrTnhSlXvFO9CK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241709706"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="241709706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="503330779"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 07:22:08 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZZD5-00004E-FY;
        Wed, 30 Mar 2022 14:22:07 +0000
Date:   Wed, 30 Mar 2022 22:21:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <willdeacon@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 5600/5615] arch/arm64/kvm/hyp/nvhe/psci-relay.c:249:6: warning: no previous
 prototype for function 'psci_mem_protect_inc'
Message-ID: <202203302232.NQaL6oOJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   73a2a894a9b4d0fe1ba09039e381e658c1f62593
commit: 4347917056dadaf7856cce8312eb1c55e1372a2a [5600/5615] ANDROID: KVM: arm64: Use PSCI MEM_PROTECT to zap guest pages on reset
config: arm64-randconfig-r036-20220330 (https://download.01.org/0day-ci/archive/20220330/202203302232.NQaL6oOJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/4347917056dadaf7856cce8312eb1c55e1372a2a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout 4347917056dadaf7856cce8312eb1c55e1372a2a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/psci-relay.c:204:28: warning: no previous prototype for function 'kvm_host_psci_cpu_entry' [-Wmissing-prototypes]
   asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
                              ^
   arch/arm64/kvm/hyp/nvhe/psci-relay.c:204:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
              ^
              static 
>> arch/arm64/kvm/hyp/nvhe/psci-relay.c:249:6: warning: no previous prototype for function 'psci_mem_protect_inc' [-Wmissing-prototypes]
   void psci_mem_protect_inc(void)
        ^
   arch/arm64/kvm/hyp/nvhe/psci-relay.c:249:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void psci_mem_protect_inc(void)
   ^
   static 
>> arch/arm64/kvm/hyp/nvhe/psci-relay.c:256:6: warning: no previous prototype for function 'psci_mem_protect_dec' [-Wmissing-prototypes]
   void psci_mem_protect_dec(void)
        ^
   arch/arm64/kvm/hyp/nvhe/psci-relay.c:256:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void psci_mem_protect_dec(void)
   ^
   static 
   3 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_PHY
   Depends on USB_SUPPORT
   Selected by
   - GKI_HIDDEN_USB_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_ELD
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_PROC
   Depends on NET && WIRELESS && PROC_FS && WEXT_CORE
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_PRIV
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for PAGE_POOL
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_SPY
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for PHYLINK
   Depends on NETDEVICES
   Selected by
   - GKI_HIDDEN_ETHERNET_CONFIGS
   WARNING: unmet direct dependencies detected for WIRELESS_EXT
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_CORE
   Depends on NET && WIRELESS && (CFG80211_WEXT || WIRELESS_EXT
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for NET_PTP_CLASSIFY
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for SND_JACK
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_VMASTER
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_IEC958
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_SOC_CONFIGS
   WARNING: unmet direct dependencies detected for SND_JACK_INPUT_DEV
   Depends on SOUND && !UML && SND && SND_JACK
   Selected by
   - GKI_HIDDEN_SND_CONFIGS


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
