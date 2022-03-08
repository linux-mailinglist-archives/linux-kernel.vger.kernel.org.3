Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE64D1BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiCHPl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCHPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:41:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C824ECC6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646754030; x=1678290030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jnkYFkLex+M6IWhUg0D9eerewUXo7eiqKU63ziTCpyY=;
  b=TUvjLp87LIG6dK+uwUsg7UoHt6XAfVSdUmJJqOwb3bcLCaw2s3OohB2x
   ySrHPMpILt45MgibWcwVOgIZFGeJc93WH9q106uTA0E8dUpYax+QdT0GT
   UMGv1iBG4awJvtPEwvvWlOTMLJp6LFtp3ZUK2Hb0mjt2hw+55PUfNcLjB
   /Wv8XunTiU6/MjnpL+l0HEl6zOu1TrqM160xGcic2I5BmoJ/USJdc/VMm
   9E22XEhvknTJG2s5VwE6LXZDpJwfFEy8I/fY8wcau6H0M0UUlxKhEbnqp
   qaenN69jpUOZA1+0DoRnsiHl6QfGKmJ0bdwBIIlM1+xIV+ohoju/Xhq5v
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254905259"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254905259"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="578027095"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 07:40:28 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRbwq-0001cY-2T; Tue, 08 Mar 2022 15:40:28 +0000
Date:   Tue, 8 Mar 2022 23:39:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-d1 12/12]
 arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
Message-ID: <202203082302.eZ9h0xp5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-d1
head:   b3cda759adb0111b5b3efd3a0b986864b647a94a
commit: b3cda759adb0111b5b3efd3a0b986864b647a94a [12/12] riscv: add memory-type errata for T-Head
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220308/202203082302.eZ9h0xp5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b3cda759adb0111b5b3efd3a0b986864b647a94a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-d1
        git checkout b3cda759adb0111b5b3efd3a0b986864b647a94a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/include/asm/pgtable.h: Assembler messages:
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable.h: Assembler messages:
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
--
   arch/riscv/mm/init.c:724:13: warning: no previous prototype for 'pt_ops_set_early' [-Wmissing-prototypes]
     724 | void __init pt_ops_set_early(void)
         |             ^~~~~~~~~~~~~~~~
   arch/riscv/mm/init.c:744:13: warning: no previous prototype for 'pt_ops_set_fixmap' [-Wmissing-prototypes]
     744 | void __init pt_ops_set_fixmap(void)
         |             ^~~~~~~~~~~~~~~~~
   arch/riscv/mm/init.c:760:13: warning: no previous prototype for 'pt_ops_set_late' [-Wmissing-prototypes]
     760 | void __init pt_ops_set_late(void)
         |             ^~~~~~~~~~~~~~~
   arch/riscv/include/asm/pgtable.h: Assembler messages:
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
   arch/riscv/include/asm/pgtable.h:280: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable-64.h: Assembler messages:
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
   arch/riscv/include/asm/pgtable.h:280: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable.h: Assembler messages:
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable.h: Assembler messages:
   arch/riscv/include/asm/pgtable.h:436: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable.h: Assembler messages:
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable.h: Assembler messages:
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable.h: Assembler messages:
   arch/riscv/include/asm/pgtable.h:436: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable-64.h: Assembler messages:
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
--
   arch/riscv/include/asm/pgtable-64.h: Assembler messages:
>> arch/riscv/include/asm/pgtable-64.h:214: Error: attempt to move .org backwards
>> arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
..


vim +323 arch/riscv/include/asm/pgtable.h

08f051eda33b51 Andrew Waterman 2017-10-25  319  
07037db5d479f9 Palmer Dabbelt  2017-07-10  320  static inline int pte_huge(pte_t pte)
07037db5d479f9 Palmer Dabbelt  2017-07-10  321  {
f5397c3ee0a3e2 Nanyong Sun     2021-04-30  322  	return pte_present(pte) && (pte_val(pte) & _PAGE_LEAF);
07037db5d479f9 Palmer Dabbelt  2017-07-10 @323  }
07037db5d479f9 Palmer Dabbelt  2017-07-10  324  

:::::: The code at line 323 was first introduced by commit
:::::: 07037db5d479f90377c998259a4f9a469c404edf RISC-V: Paging and MMU

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
