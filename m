Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37257F198
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiGWU75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiGWU7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:59:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1585D183A6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658609993; x=1690145993;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E52PvFmuMP0pBiM/7n68o2XWCcWhH04ns2EBd0S99lo=;
  b=lqeZ+iMJyIAE3MQzUUMM1EsPCSC7+VadHrfbNMCdK9hkUb83rswNBAyS
   osL3Td6qms8g8T7/k4rPbTRh4I653kULOsOtoWuN9w+c841u1mVXnpDIf
   DWI2Jc+jKI8niVYbHlO0GWCaTVNHgoo2tA/3XDsrSOocuv0adrA09L1qW
   qhS+p2AVF7KKbGm09NnpNkZKeHCJBTeXdmZkAhplcWxQ2bVZRtOcvichu
   +eoo9JtjIg/hzyth0cCzqjFABIpyn+if/4ORDcQCWQy/fRDYp/zNWyp0G
   xe+XzdcwvaMDTOFs95ri8oZTJCVfhXzrnCsgNKTbcGMd/9JMY3Te0s1QK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="270529929"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="270529929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 13:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="667031214"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2022 13:59:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFME2-00037Q-1U;
        Sat, 23 Jul 2022 20:59:50 +0000
Date:   Sun, 24 Jul 2022 04:59:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:557:13: warning: no previous
 prototype for 'smccc_patch_fw_mitigation_conduit'
Message-ID: <202207240421.4mJ1IiTh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 1b33d4860deaecf1d8eec3061b7e7ed7ab0bae8d arm64: spectre: Rename spectre_v4_patch_fw_mitigation_conduit
date:   5 months ago
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20220724/202207240421.4mJ1IiTh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1b33d4860deaecf1d8eec3061b7e7ed7ab0bae8d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1b33d4860deaecf1d8eec3061b7e7ed7ab0bae8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

   arch/arm64/kernel/proton-pack.c:537:13: warning: no previous prototype for 'spectre_v4_patch_fw_mitigation_enable' [-Wmissing-prototypes]
     537 | void __init spectre_v4_patch_fw_mitigation_enable(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/proton-pack.c:557:13: warning: no previous prototype for 'smccc_patch_fw_mitigation_conduit' [-Wmissing-prototypes]
     557 | void __init smccc_patch_fw_mitigation_conduit(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/smccc_patch_fw_mitigation_conduit +557 arch/arm64/kernel/proton-pack.c

   532	
   533	/*
   534	 * Patch a branch over the Spectre-v4 mitigation code with a NOP so that
   535	 * we fallthrough and check whether firmware needs to be called on this CPU.
   536	 */
 > 537	void __init spectre_v4_patch_fw_mitigation_enable(struct alt_instr *alt,
   538							  __le32 *origptr,
   539							  __le32 *updptr, int nr_inst)
   540	{
   541		BUG_ON(nr_inst != 1); /* Branch -> NOP */
   542	
   543		if (spectre_v4_mitigations_off())
   544			return;
   545	
   546		if (cpus_have_final_cap(ARM64_SSBS))
   547			return;
   548	
   549		if (spectre_v4_mitigations_dynamic())
   550			*updptr = cpu_to_le32(aarch64_insn_gen_nop());
   551	}
   552	
   553	/*
   554	 * Patch a NOP in the Spectre-v4 mitigation code with an SMC/HVC instruction
   555	 * to call into firmware to adjust the mitigation state.
   556	 */
 > 557	void __init smccc_patch_fw_mitigation_conduit(struct alt_instr *alt,
   558						       __le32 *origptr,
   559						       __le32 *updptr, int nr_inst)
   560	{
   561		u32 insn;
   562	
   563		BUG_ON(nr_inst != 1); /* NOP -> HVC/SMC */
   564	
   565		switch (arm_smccc_1_1_get_conduit()) {
   566		case SMCCC_CONDUIT_HVC:
   567			insn = aarch64_insn_get_hvc_value();
   568			break;
   569		case SMCCC_CONDUIT_SMC:
   570			insn = aarch64_insn_get_smc_value();
   571			break;
   572		default:
   573			return;
   574		}
   575	
   576		*updptr = cpu_to_le32(insn);
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
