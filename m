Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E34E53BF23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiFBTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiFBTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:50:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5225597
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654199445; x=1685735445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gh4Oc+dW4r861fz5iBXTIDXpyRj9he8A2pABkdQIz8I=;
  b=joGEB9Esa2Ieo6Ko8gdynBWPcJ4RDZHq+bdRhTrpXStcYWSCQKU4K2hA
   2jZ6CX7EfpZy+tWBFu5fxmoI68K+frDyFbEnS3gdwfQW91yOUlNqF+mQQ
   T0Bou3IJW8YILJDJldem97iGR2/y3fmKixK4HMubYXL/VEcCufhCIOX/7
   vrilJzaJQnWzdT5VJpfYuq2VpkWsiEV5ouEtXEKadyLnTEnyTfb0LNtqO
   BrQS4zgt26xecJSF+yQiZaDmK24cAqKW5rvNBopyLJXaHv8OQXzJpbvXt
   GhLHEiSzneJF2qdNhbOYgNh3OFrnXlXtb7A6MJ3ozkYd87DYaaXjarEwI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="255928538"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="255928538"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 12:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="530721601"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 12:50:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwqqB-0005OX-0A;
        Thu, 02 Jun 2022 19:50:43 +0000
Date:   Fri, 3 Jun 2022 03:50:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm64/kernel/proton-pack.c:302:5: warning: Redundant assignment
 of 'cb' to itself. [selfAssignment]
Message-ID: <202206030359.rPhMZQTy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17d8e3d90b6989419806c1926b894d7d7483a25b
commit: ea8f8c99a28199f6e067581b8626d192b07750f2 arm64: spectre-v2: Favour CPU-specific mitigation at EL2
date:   1 year, 7 months ago
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout ea8f8c99a28199f6e067581b8626d192b07750f2
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/proton-pack.c:302:5: warning: Redundant assignment of 'cb' to itself. [selfAssignment]
    cb = spectre_v2_get_sw_mitigation_cb() ?: cb;
       ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/arm64/mm/hugetlbpage.c:104:14: warning: Parameter 'ptep' can be declared with const [constParameter]
         pte_t *ptep, size_t *pgsize)
                ^
--
>> arch/arm64/mm/mmu.c:558:74: warning: Parameter 'va_end' can be declared with const [constParameter]
   static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
                                                                            ^
>> arch/arm64/mm/mmu.c:1441:41: warning: Parameter 'pgdir' can be declared with const [constParameter]
   static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
                                           ^

vim +/cb +302 arch/arm64/kernel/proton-pack.c

   272	
   273	static enum mitigation_state spectre_v2_enable_fw_mitigation(void)
   274	{
   275		bp_hardening_cb_t cb;
   276		enum mitigation_state state;
   277	
   278		state = spectre_v2_get_cpu_fw_mitigation_state();
   279		if (state != SPECTRE_MITIGATED)
   280			return state;
   281	
   282		if (spectre_v2_mitigations_off())
   283			return SPECTRE_VULNERABLE;
   284	
   285		switch (arm_smccc_1_1_get_conduit()) {
   286		case SMCCC_CONDUIT_HVC:
   287			cb = call_hvc_arch_workaround_1;
   288			break;
   289	
   290		case SMCCC_CONDUIT_SMC:
   291			cb = call_smc_arch_workaround_1;
   292			break;
   293	
   294		default:
   295			return SPECTRE_VULNERABLE;
   296		}
   297	
   298		/*
   299		 * Prefer a CPU-specific workaround if it exists. Note that we
   300		 * still rely on firmware for the mitigation at EL2.
   301		 */
 > 302		cb = spectre_v2_get_sw_mitigation_cb() ?: cb;
   303		install_bp_hardening_cb(cb);
   304		return SPECTRE_MITIGATED;
   305	}
   306	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
