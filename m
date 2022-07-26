Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180C4580AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiGZFFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 01:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiGZFFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 01:05:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87265D8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658811944; x=1690347944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JURCIT2wOE/1awGN+dZeb2sxMB9scD/uiWwfcI3mE/Q=;
  b=QHxevlvxR98z1bjf9DoQLZ/ziN5M+RLULhWzv0UwkuoTTys6JXtKBEJW
   viSdKNc8dXmAFZKqoAISEZFXvu+1x2Rlo6eaisL11OQgVp6S2Z2jtbx3G
   GzOULjfOdYf8YSeIu9i8GS7uHr359xNQ0BI0J6JhGGlnZsdmktx7Y8ZQh
   jhUz6n59FlFJXiS8mySsRYijKtMDgH4et6qe72WtUP90XMTsMfU7Tx9kW
   uHkoLhLrm6TmE1Aeh1VwniX67KRU/A9fDBeHNbkhGoVUG2XSlzHZ9qKaD
   t7DDtVX1mClt6Z3Y3q5kxYqUKsSTakg8SUOvMUNLRg7TQvgHv53KTI9A6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="313619094"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="313619094"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 22:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="599853101"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2022 22:05:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGClJ-00064q-0T;
        Tue, 26 Jul 2022 05:05:41 +0000
Date:   Tue, 26 Jul 2022 13:05:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 176/176]
 arch/x86/mm/extable.c:200:9: error: duplicate case value
Message-ID: <202207261212.h1KDeJ11-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   9780829ed8d15de556424bed96704c95dfc357f6
commit: 9780829ed8d15de556424bed96704c95dfc357f6 [176/176] x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220726/202207261212.h1KDeJ11-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/9780829ed8d15de556424bed96704c95dfc357f6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 9780829ed8d15de556424bed96704c95dfc357f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/asm.h:125,
                    from arch/x86/include/asm/alternative.h:7,
                    from arch/x86/include/asm/bitops.h:17,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/uaccess.h:8,
                    from arch/x86/mm/extable.c:3:
   arch/x86/include/asm/extable_fixup_types.h:49: warning: "EX_TYPE_DEFAULT_MCE_SAFE" redefined
      49 | #define EX_TYPE_DEFAULT_MCE_SAFE        12
         | 
   arch/x86/include/asm/extable_fixup_types.h:42: note: this is the location of the previous definition
      42 | #define EX_TYPE_DEFAULT_MCE_SAFE        14
         | 
   arch/x86/include/asm/extable_fixup_types.h:50: warning: "EX_TYPE_FAULT_MCE_SAFE" redefined
      50 | #define EX_TYPE_FAULT_MCE_SAFE          13
         | 
   arch/x86/include/asm/extable_fixup_types.h:43: note: this is the location of the previous definition
      43 | #define EX_TYPE_FAULT_MCE_SAFE          15
         | 
   arch/x86/mm/extable.c: In function 'fixup_exception':
>> arch/x86/mm/extable.c:200:9: error: duplicate case value
     200 |         case EX_TYPE_WRMSR_IN_MCE:
         |         ^~~~
   arch/x86/mm/extable.c:177:9: note: previously used here
     177 |         case EX_TYPE_DEFAULT_MCE_SAFE:
         |         ^~~~
   arch/x86/mm/extable.c:203:9: error: duplicate case value
     203 |         case EX_TYPE_RDMSR_IN_MCE:
         |         ^~~~
   arch/x86/mm/extable.c:180:9: note: previously used here
     180 |         case EX_TYPE_FAULT_MCE_SAFE:
         |         ^~~~


vim +200 arch/x86/mm/extable.c

6d48583ba9ade6 Harvey Harrison 2008-01-30  166  
548acf19234dbd Tony Luck       2016-02-17  167  	e = search_exception_tables(regs->ip);
548acf19234dbd Tony Luck       2016-02-17  168  	if (!e)
6d48583ba9ade6 Harvey Harrison 2008-01-30  169  		return 0;
548acf19234dbd Tony Luck       2016-02-17  170  
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  171  	type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  172  	reg  = FIELD_GET(EX_DATA_REG_MASK,  e->data);
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  173  	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  174  
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  175  	switch (type) {
f6647d25769d7d Thomas Gleixner 2021-09-08  176  	case EX_TYPE_DEFAULT:
fd96c41f8fa7b6 Thomas Gleixner 2021-09-08  177  	case EX_TYPE_DEFAULT_MCE_SAFE:
f6647d25769d7d Thomas Gleixner 2021-09-08  178  		return ex_handler_default(e, regs);
f6647d25769d7d Thomas Gleixner 2021-09-08  179  	case EX_TYPE_FAULT:
fd96c41f8fa7b6 Thomas Gleixner 2021-09-08  180  	case EX_TYPE_FAULT_MCE_SAFE:
f6647d25769d7d Thomas Gleixner 2021-09-08  181  		return ex_handler_fault(e, regs, trapnr);
f6647d25769d7d Thomas Gleixner 2021-09-08  182  	case EX_TYPE_UACCESS:
f6647d25769d7d Thomas Gleixner 2021-09-08  183  		return ex_handler_uaccess(e, regs, trapnr);
f6647d25769d7d Thomas Gleixner 2021-09-08  184  	case EX_TYPE_COPY:
f6647d25769d7d Thomas Gleixner 2021-09-08  185  		return ex_handler_copy(e, regs, trapnr);
f6647d25769d7d Thomas Gleixner 2021-09-08  186  	case EX_TYPE_CLEAR_FS:
f6647d25769d7d Thomas Gleixner 2021-09-08  187  		return ex_handler_clear_fs(e, regs);
f6647d25769d7d Thomas Gleixner 2021-09-08  188  	case EX_TYPE_FPU_RESTORE:
f6647d25769d7d Thomas Gleixner 2021-09-08  189  		return ex_handler_fprestore(e, regs);
f6647d25769d7d Thomas Gleixner 2021-09-08  190  	case EX_TYPE_BPF:
f6647d25769d7d Thomas Gleixner 2021-09-08  191  		return ex_handler_bpf(e, regs);
67cae747a093a8 Peter Zijlstra  2021-11-10  192  	case EX_TYPE_WRMSR:
67cae747a093a8 Peter Zijlstra  2021-11-10  193  		return ex_handler_msr(e, regs, true, false, reg);
67cae747a093a8 Peter Zijlstra  2021-11-10  194  	case EX_TYPE_RDMSR:
67cae747a093a8 Peter Zijlstra  2021-11-10  195  		return ex_handler_msr(e, regs, false, false, reg);
67cae747a093a8 Peter Zijlstra  2021-11-10  196  	case EX_TYPE_WRMSR_SAFE:
67cae747a093a8 Peter Zijlstra  2021-11-10  197  		return ex_handler_msr(e, regs, true, true, reg);
67cae747a093a8 Peter Zijlstra  2021-11-10  198  	case EX_TYPE_RDMSR_SAFE:
67cae747a093a8 Peter Zijlstra  2021-11-10  199  		return ex_handler_msr(e, regs, false, true, reg);
f6647d25769d7d Thomas Gleixner 2021-09-08 @200  	case EX_TYPE_WRMSR_IN_MCE:
f6647d25769d7d Thomas Gleixner 2021-09-08  201  		ex_handler_msr_mce(regs, true);
f6647d25769d7d Thomas Gleixner 2021-09-08  202  		break;
67cae747a093a8 Peter Zijlstra  2021-11-10  203  	case EX_TYPE_RDMSR_IN_MCE:
67cae747a093a8 Peter Zijlstra  2021-11-10  204  		ex_handler_msr_mce(regs, false);
67cae747a093a8 Peter Zijlstra  2021-11-10  205  		break;
54ad742e5119ea Peter Zijlstra  2021-11-10  206  	case EX_TYPE_POP_ZERO:
54ad742e5119ea Peter Zijlstra  2021-11-10  207  		return ex_handler_pop_zero(e, regs);
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  208  	case EX_TYPE_IMM_REG:
d00a02f6f57ef8 Peter Zijlstra  2021-11-10  209  		return ex_handler_imm_reg(e, regs, reg, imm);
f6647d25769d7d Thomas Gleixner 2021-09-08  210  	}
f6647d25769d7d Thomas Gleixner 2021-09-08  211  	BUG();
6d48583ba9ade6 Harvey Harrison 2008-01-30  212  }
6a1ea279c210e7 H. Peter Anvin  2012-04-19  213  

:::::: The code at line 200 was first introduced by commit
:::::: f6647d25769d7dc7c50b9bbd6fd364bb148743b5 x86/extable: Rework the exception table mechanics

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Sasha Levin <sashal@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
