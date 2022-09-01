Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444E75AA38C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiIAXPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiIAXPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:15:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53C3F333
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662074108; x=1693610108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=958TfpVMqbZzC4AomzOBgvNEflAaySmrY+TQAAa/1ao=;
  b=QZYtPxLaguOLEODGk1B8aFuMDqAz+N3OkbZna9ps5suzRm/pfKaSY673
   yFIwCOa9OhSzamHPhz9+SvvyhZ8Q9j1bgZWbahj6upCcEYUFAu66W/xyQ
   S5mUmsjBgUGQ8JqKY061H5BspNzijwMfz0MJrotpF2x0oC2Lz0sVR5uSS
   5hk2/SOG3fbTv5Y6if861BjCBp+0pp0iKLgd3Sn2ZGFJCOzQCJ4/JYtnf
   5VhTWw4m1xmYOnk+DCzeRmw5/11CcheE1v6+gptwoi8Qr2S8kBtuWK9Yo
   kLCWSn0OSeZ52+/lGmTO1WdrDL45g04oGVWK4POu21DTDRvEbDpD3wnp+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="293427477"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="293427477"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 16:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="642595310"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 16:15:06 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTtOr-0000sw-2J;
        Thu, 01 Sep 2022 23:15:05 +0000
Date:   Fri, 2 Sep 2022 07:14:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-ci:arm64-sysreg-gen-4 11/28] arch/arm64/kernel/head.S:102:
 Error: invalid operands (*ABS* and *UND* sections) for `<<'
Message-ID: <202209020726.LQkRe5MZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git arm64-sysreg-gen-4
head:   a36f79822ee101cdd921b1a8c5886019f14fdd33
commit: b6ea3648f4a364a4dd4df9606eba30e39aef219b [11/28] arm64/sysreg: Standardise naming for ID_AA64MMFR2_EL1.VARange
config: arm64-buildonly-randconfig-r001-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020726.LQkRe5MZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=b6ea3648f4a364a4dd4df9606eba30e39aef219b
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci arm64-sysreg-gen-4
        git checkout b6ea3648f4a364a4dd4df9606eba30e39aef219b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/head.S: Assembler messages:
>> arch/arm64/kernel/head.S:102: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/kernel/head.S:666: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/kernel/head.S:680: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/kernel/head.S:816: Error: invalid operands (*ABS* and *UND* sections) for `<<'
--
   arch/arm64/mm/proc.S: Assembler messages:
>> arch/arm64/mm/proc.S:191: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/mm/proc.S:193: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/mm/proc.S:290: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/mm/proc.S:291: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/mm/proc.S:308: Error: invalid operands (*ABS* and *UND* sections) for `<<'
   arch/arm64/mm/proc.S:371: Error: invalid operands (*ABS* and *UND* sections) for `<<'


vim +102 arch/arm64/kernel/head.S

9703d9d7f77ce1 Catalin Marinas 2012-03-05   43  
9703d9d7f77ce1 Catalin Marinas 2012-03-05   44  /*
9703d9d7f77ce1 Catalin Marinas 2012-03-05   45   * Kernel startup entry point.
9703d9d7f77ce1 Catalin Marinas 2012-03-05   46   * ---------------------------
9703d9d7f77ce1 Catalin Marinas 2012-03-05   47   *
9703d9d7f77ce1 Catalin Marinas 2012-03-05   48   * The requirements are:
9703d9d7f77ce1 Catalin Marinas 2012-03-05   49   *   MMU = off, D-cache = off, I-cache = on or off,
9703d9d7f77ce1 Catalin Marinas 2012-03-05   50   *   x0 = physical address to the FDT blob.
9703d9d7f77ce1 Catalin Marinas 2012-03-05   51   *
9703d9d7f77ce1 Catalin Marinas 2012-03-05   52   * Note that the callee-saved registers are used for storing variables
9703d9d7f77ce1 Catalin Marinas 2012-03-05   53   * that are useful before the MMU is enabled. The allocations are described
9703d9d7f77ce1 Catalin Marinas 2012-03-05   54   * in the entry routines.
9703d9d7f77ce1 Catalin Marinas 2012-03-05   55   */
9703d9d7f77ce1 Catalin Marinas 2012-03-05   56  	__HEAD
9703d9d7f77ce1 Catalin Marinas 2012-03-05   57  	/*
9703d9d7f77ce1 Catalin Marinas 2012-03-05   58  	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
9703d9d7f77ce1 Catalin Marinas 2012-03-05   59  	 */
7919385b9fb3ce Ard Biesheuvel  2020-11-17   60  	efi_signature_nop			// special NOP to identity as PE/COFF executable
348a625deef13d Ard Biesheuvel  2020-03-26   61  	b	primary_entry			// branch to kernel start, magic
120dc60d0bdbad Ard Biesheuvel  2020-08-25   62  	.quad	0				// Image load offset from start of RAM, little-endian
6ad1fe5d9077a1 Ard Biesheuvel  2015-12-26   63  	le64sym	_kernel_size_le			// Effective size of kernel image, little-endian
6ad1fe5d9077a1 Ard Biesheuvel  2015-12-26   64  	le64sym	_kernel_flags_le		// Informative flags, little-endian
4370eec05a887b Roy Franz       2013-08-15   65  	.quad	0				// reserved
4370eec05a887b Roy Franz       2013-08-15   66  	.quad	0				// reserved
4370eec05a887b Roy Franz       2013-08-15   67  	.quad	0				// reserved
f56063c51f9fb3 AKASHI Takahiro 2018-11-15   68  	.ascii	ARM64_IMAGE_MAGIC		// Magic number
7919385b9fb3ce Ard Biesheuvel  2020-11-17   69  	.long	.Lpe_header_offset		// Offset to the PE header.
3c7f255039a2ad Mark Salter     2014-04-15   70  
b5f4a214b802a7 Ard Biesheuvel  2017-03-23   71  	__EFI_PE_HEADER
9703d9d7f77ce1 Catalin Marinas 2012-03-05   72  
546c8c44f092b2 Ard Biesheuvel  2016-03-30   73  	__INIT
546c8c44f092b2 Ard Biesheuvel  2016-03-30   74  
a9be2ee0938538 Ard Biesheuvel  2016-08-31   75  	/*
a9be2ee0938538 Ard Biesheuvel  2016-08-31   76  	 * The following callee saved general purpose registers are used on the
a9be2ee0938538 Ard Biesheuvel  2016-08-31   77  	 * primary lowlevel boot path:
a9be2ee0938538 Ard Biesheuvel  2016-08-31   78  	 *
a9be2ee0938538 Ard Biesheuvel  2016-08-31   79  	 *  Register   Scope                      Purpose
005e12676af09a Ard Biesheuvel  2022-06-24   80  	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
348a625deef13d Ard Biesheuvel  2020-03-26   81  	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
f70b3a23324a2d Ard Biesheuvel  2022-06-24   82  	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
348a625deef13d Ard Biesheuvel  2020-03-26   83  	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
aacd149b62382c Ard Biesheuvel  2022-06-24   84  	 *  x24        __primary_switch()                       linear map KASLR seed
0aaa68532e9da5 Ard Biesheuvel  2022-07-01   85  	 *  x25        primary_entry() .. start_kernel()        supported VA size
c3cee924bd8551 Ard Biesheuvel  2022-06-24   86  	 *  x28        create_idmap()                           callee preserved temp register
a9be2ee0938538 Ard Biesheuvel  2016-08-31   87  	 */
348a625deef13d Ard Biesheuvel  2020-03-26   88  SYM_CODE_START(primary_entry)
da9c177de88679 Ard Biesheuvel  2015-03-17   89  	bl	preserve_boot_args
ecbb11ab3ebc02 Mark Rutland    2020-11-13   90  	bl	init_kernel_el			// w0=cpu_boot_mode
005e12676af09a Ard Biesheuvel  2022-06-24   91  	mov	x20, x0
e42ade29e3bcb3 Ard Biesheuvel  2022-06-24   92  	bl	create_idmap
e42ade29e3bcb3 Ard Biesheuvel  2022-06-24   93  
9703d9d7f77ce1 Catalin Marinas 2012-03-05   94  	/*
a591ede4cd1cac Marc Zyngier    2015-03-18   95  	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
a591ede4cd1cac Marc Zyngier    2015-03-18   96  	 * details.
9703d9d7f77ce1 Catalin Marinas 2012-03-05   97  	 * On return, the CPU will be ready for the MMU to be turned on and
9703d9d7f77ce1 Catalin Marinas 2012-03-05   98  	 * the TCR will have been set.
9703d9d7f77ce1 Catalin Marinas 2012-03-05   99  	 */
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  100  #if VA_BITS > 48
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  101  	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
884f3c14eb173b Mark Brown      2022-07-28 @102  	tst	x0, #0xf << ID_AA64MMFR2_EL1_LVA_SHIFT
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  103  	mov	x0, #VA_BITS
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  104  	mov	x25, #VA_BITS_MIN
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  105  	csel	x25, x25, x0, eq
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  106  	mov	x0, x25
0aaa68532e9da5 Ard Biesheuvel  2022-07-01  107  #endif
0cd3defe0af415 Ard Biesheuvel  2016-04-18  108  	bl	__cpu_setup			// initialise processor
3c5e9f238bc475 Ard Biesheuvel  2016-08-31  109  	b	__primary_switch
348a625deef13d Ard Biesheuvel  2020-03-26  110  SYM_CODE_END(primary_entry)
9703d9d7f77ce1 Catalin Marinas 2012-03-05  111  

:::::: The code at line 102 was first introduced by commit
:::::: 884f3c14eb173b288f6cd0c3a288ceccd0f57930 arm64/sysreg: Add _EL1 into ID_AA64MMFR2_EL1 definition names

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
