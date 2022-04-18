Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8170A505AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiDRP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345824AbiDRP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:27:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1457B0A62
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650292198; x=1681828198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ifS3XtFcJQRTBaVSs08mRr3Tjr+RXy8lzcRFTyzR5W0=;
  b=kW2kB9L1k99E9W1EA5xu1TB95SV+pHB+DpMgAEpOro1w9YODlVni6GAM
   z3TAYk8Oek57geUxV1WjZaU9SJiw2m52bN0RadGt4WhqtoLbYThlc9a5R
   vSkCNf8oPw9p6Og7Tb8+rxO49NZCvvTmEbSNjaGg+uH/M412VgzWVuBs3
   KhXA9uQe+V45c3BGzr+aXAB7YX/b39p4NC1UxDusRqLhwdS33y9tCzg9N
   K39UeFew5wldEmIJEpu6P2OCIuCm2KKp+20r440qaLCrOyikWqH+NQX76
   hLNGnpPxS/pWKF0tjt+qnDsFrQc2DtziPS2KDNtVFC09MlMRLKWSw8huA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261129828"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="261129828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="509755922"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 07:29:30 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngSNd-0004hG-E6;
        Mon, 18 Apr 2022 14:29:29 +0000
Date:   Mon, 18 Apr 2022 22:28:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [broonie-misc:arm64-sme 23/39] arch/arm64/kernel/fpsimd.c:1944:55:
 sparse: sparse: dereference of noderef expression
Message-ID: <202204182232.CJFTXSP9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-sme
head:   cf8de82f465a915e8c4d1f9d484dd8a08e08bbed
commit: 4dc0043dceb973f0f61c0f0ee047655aa73c2261 [23/39] arm64/sme: Save and restore streaming mode over EFI runtime calls
config: arm64-randconfig-s031-20220418 (https://download.01.org/0day-ci/archive/20220418/202204182232.CJFTXSP9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=4dc0043dceb973f0f61c0f0ee047655aa73c2261
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc arm64-sme
        git checkout 4dc0043dceb973f0f61c0f0ee047655aa73c2261
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
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
