Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3553A57F21E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 02:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiGXANS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiGXANQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 20:13:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4591F55
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 17:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658621595; x=1690157595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aBu3WK7sLRYDAkBIvDoRSK53/aZDTetFGtFZiFbRKLk=;
  b=ffvM2xmuYRuamgvxVlPGYGsUKVuNuG601nFHvsa3JiPE3DEc6gUCz2sa
   S3MnAihWIsUJOVvklfIB8stAHOMqlOaqklMWUSF+hmpTBTqFAOxOeEYQ9
   B4XnLos/LnRH8o8T9shm535SjeyInCRD8DQ9E0+Ww27gOBoK1SQS3hNa2
   CsD6EP/zfVnVrnYXtvNHHuNscVGldIhjMxXdJOMXgJeopvL8V5f2AJul+
   Q9xZNk+BKIND4YlNEGVcYVXpjhyenGYejt/cMAiZS0/Ppl0XesyxnqeHY
   PKswmNHj6CtS5eLrxrcgWNfSN+KdXtFlzBwt+5KQp5YQa7Thca0bBdbyk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="286262039"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="286262039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 17:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="725780197"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2022 17:13:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFPFA-0003Gq-3D;
        Sun, 24 Jul 2022 00:13:12 +0000
Date:   Sun, 24 Jul 2022 08:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:1054:14: warning: no previous
 prototype for 'spectre_bhb_patch_loop_iter'
Message-ID: <202207240834.nGEiT8tH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 558c303c9734af5a813739cd284879227f7297d2 arm64: Mitigate spectre style branch history side channels
date:   5 months ago
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20220724/202207240834.nGEiT8tH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=558c303c9734af5a813739cd284879227f7297d2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 558c303c9734af5a813739cd284879227f7297d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/proton-pack.c:564:13: warning: no previous prototype for 'spectre_v4_patch_fw_mitigation_enable' [-Wmissing-prototypes]
     564 | void __init spectre_v4_patch_fw_mitigation_enable(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:584:13: warning: no previous prototype for 'smccc_patch_fw_mitigation_conduit' [-Wmissing-prototypes]
     584 | void __init smccc_patch_fw_mitigation_conduit(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:1032:14: warning: no previous prototype for 'spectre_bhb_patch_loop_mitigation_enable' [-Wmissing-prototypes]
    1032 | void noinstr spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:1043:14: warning: no previous prototype for 'spectre_bhb_patch_fw_mitigation_enabled' [-Wmissing-prototypes]
    1043 | void noinstr spectre_bhb_patch_fw_mitigation_enabled(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/proton-pack.c:1054:14: warning: no previous prototype for 'spectre_bhb_patch_loop_iter' [-Wmissing-prototypes]
    1054 | void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/proton-pack.c:1075:14: warning: no previous prototype for 'spectre_bhb_patch_wa3' [-Wmissing-prototypes]
    1075 | void noinstr spectre_bhb_patch_wa3(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~


vim +/spectre_bhb_patch_loop_iter +1054 arch/arm64/kernel/proton-pack.c

  1052	
  1053	/* Patched to correct the immediate */
> 1054	void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
  1055					   __le32 *origptr, __le32 *updptr, int nr_inst)
  1056	{
  1057		u8 rd;
  1058		u32 insn;
  1059		u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
  1060	
  1061		BUG_ON(nr_inst != 1); /* MOV -> MOV */
  1062	
  1063		if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY))
  1064			return;
  1065	
  1066		insn = le32_to_cpu(*origptr);
  1067		rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
  1068		insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
  1069						 AARCH64_INSN_VARIANT_64BIT,
  1070						 AARCH64_INSN_MOVEWIDE_ZERO);
  1071		*updptr++ = cpu_to_le32(insn);
  1072	}
  1073	
  1074	/* Patched to mov WA3 when supported */
> 1075	void noinstr spectre_bhb_patch_wa3(struct alt_instr *alt,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
