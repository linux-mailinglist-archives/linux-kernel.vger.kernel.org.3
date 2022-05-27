Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DE5368FA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354995AbiE0Wtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352519AbiE0Wtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:49:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4311CA35
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653691780; x=1685227780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u9GUuKmZrf3hlF+ZoaG+FgjMraBwA7Z6pCN5eaiTQ9U=;
  b=hPvf2k0tn7AaLVGGI3KM/KCSSYDg93QjflKjzdQA1X1VC3l+cRNTKo+3
   krsK4CqHSsEZ7VhkjbpsBcxn+aRlwTTobk8f+crFPqYeuxuonEXq5rJQ/
   kV3rIDfNFx/78oSq2l92wmwXDLse6MDJovL3bQn2hjgw0YmxrAlCfrfjr
   zSrkOHnfAY5dvM0iZswWx4TtZ5bVFr5L3XrtJMGlJjmDHEHU+t1iaSR7f
   QOaXgG0isAnEuys2NdAwg/GLpBSnJs+d971MFbHpiaV3+88CUNdeyzIXT
   IgarXVFu8MAVlErYX69z1NparKOaWyp/7u23QOzPxUsC7MpGuMMwgOmJo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274319034"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274319034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 15:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="719093848"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2022 15:49:38 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuim1-0005CJ-NK;
        Fri, 27 May 2022 22:49:37 +0000
Date:   Sat, 28 May 2022 06:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference of
 noderef expression
Message-ID: <202205280635.XKlMkfKD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8291eaafed36f575f23951f3ce18407f480e9ecf
commit: e0838f6373e5cb72516fc4c26bba309097e2a80a arm64/sme: Save and restore streaming mode over EFI runtime calls
date:   5 weeks ago
config: arm64-randconfig-s032-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280635.XKlMkfKD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0838f6373e5cb72516fc4c26bba309097e2a80a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e0838f6373e5cb72516fc4c26bba309097e2a80a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/fpsimd.c:1944:55: sparse: sparse: dereference of noderef expression

vim +1944 arch/arm64/kernel/fpsimd.c

  1916	
  1917	/*
  1918	 * __efi_fpsimd_end(): clean up FPSIMD after an EFI runtime services call
  1919	 */
  1920	void __efi_fpsimd_end(void)
  1921	{
  1922		if (!system_supports_fpsimd())
  1923			return;
  1924	
  1925		if (!__this_cpu_xchg(efi_fpsimd_state_used, false)) {
  1926			kernel_neon_end();
  1927		} else {
  1928			if (system_supports_sve() &&
  1929			    likely(__this_cpu_read(efi_sve_state_used))) {
  1930				char const *sve_state = this_cpu_ptr(efi_sve_state);
  1931				bool ffr = true;
  1932	
  1933				/*
  1934				 * Restore streaming mode; EFI calls are
  1935				 * normal function calls so should not return in
  1936				 * streaming mode.
  1937				 */
  1938				if (system_supports_sme()) {
  1939					if (__this_cpu_read(efi_sm_state)) {
  1940						sysreg_clear_set_s(SYS_SVCR_EL0,
  1941								   0,
  1942								   SYS_SVCR_EL0_SM_MASK);
  1943						if (!system_supports_fa64())
> 1944							ffr = efi_sm_state;
  1945					}
  1946				}
  1947	
  1948				sve_load_state(sve_state + sve_ffr_offset(sve_max_vl()),
  1949					       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
  1950					       ffr);
  1951	
  1952				__this_cpu_write(efi_sve_state_used, false);
  1953			} else {
  1954				fpsimd_load_state(this_cpu_ptr(&efi_fpsimd_state));
  1955			}
  1956		}
  1957	}
  1958	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
