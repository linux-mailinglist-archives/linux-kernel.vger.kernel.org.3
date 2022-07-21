Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E357C702
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiGUI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiGUI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:59:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4180520
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658393985; x=1689929985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YiUldEXiIux+NnbSALsaBEfrACOlZkl4nBAllVDllVI=;
  b=LcYc9bTXQuRS/V2bQPX2BFWbUh8VaRGqJhmgP366W09vzNb2SRME5a1P
   q1f1AzQUmZs8scaJHxqzQ5HiNpWJRsScCWeqRcpZNFeLLX4Rze02A+9AU
   EuQjlXvJLfR7eHrVexuOxuGi4tp9wu9sps8l6UljkD2ZDE0YtciE55y0C
   HDCrmevhAuoy9QWRxYMoZlkbFZsQF+gs32vuzMtpf+8bXsb9wL5ZLQxvJ
   zPhTORjSM91JHHij7jOHI4g48PdISw88RWUfFkbxdqLkEN/l3EBKqnIWP
   CftouinyBfsI98+ZySwzxIFc8k5YYnAlxtYacNyTOlAEhpaYs7pJaLp5L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="373293980"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="373293980"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 01:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="740604965"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2022 01:59:43 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oES23-0001eh-3n;
        Thu, 21 Jul 2022 08:59:43 +0000
Date:   Thu, 21 Jul 2022 16:59:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 45/45]
 arch/x86/kernel/callthunks.c:419:11: warning: variable 'nthunks' set but not
 used
Message-ID: <202207211650.VwbgQSZR-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   714d29e3e7e3faac27142424ae2533163ddd3a46
commit: 714d29e3e7e3faac27142424ae2533163ddd3a46 [45/45] x06/callthunks: Put thunks into compiler provided padding area
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220721/202207211650.VwbgQSZR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0c1b32717bcffcf8edf95294e98933bd4c1e76ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/714d29e3e7e3faac27142424ae2533163ddd3a46
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 714d29e3e7e3faac27142424ae2533163ddd3a46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/callthunks.c:419:11: warning: variable 'nthunks' set but not used [-Wunused-but-set-variable]
           int gap, nthunks = 0, idx = 0, padsize;
                    ^
>> arch/x86/kernel/callthunks.c:416:5: warning: no previous prototype for function 'setup_padding_thunks' [-Wmissing-prototypes]
   int setup_padding_thunks(s32 *start, s32 *end, struct thunk_mem_area *area,
       ^
   arch/x86/kernel/callthunks.c:416:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int setup_padding_thunks(s32 *start, s32 *end, struct thunk_mem_area *area,
   ^
   static 
   arch/x86/kernel/callthunks.c:547:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
                   if (!vbuf)
                       ^~~~~
   arch/x86/kernel/callthunks.c:613:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   arch/x86/kernel/callthunks.c:547:3: note: remove the 'if' if its condition is always false
                   if (!vbuf)
                   ^~~~~~~~~~
   arch/x86/kernel/callthunks.c:512:9: note: initialize the variable 'ret' to silence this warning
           int ret, text_size, size;
                  ^
                   = 0
   3 warnings generated.


vim +/nthunks +419 arch/x86/kernel/callthunks.c

   415	
 > 416	int setup_padding_thunks(s32 *start, s32 *end, struct thunk_mem_area *area,
   417				 struct module_layout *layout)
   418	{
 > 419		int gap, nthunks = 0, idx = 0, padsize;
   420		s32 *s;
   421	
   422		padsize = 1 << CONFIG_FUNCTION_PADDING_ORDER;
   423		if (callthunk_desc.template_size > padsize)
   424			return 0;
   425	
   426		gap = padsize - callthunk_desc.template_size;
   427	
   428		for (s = start; s < end; s++) {
   429			void *thunk, *tp, *dest = (void *)s + *s;
   430			unsigned long key = (unsigned long)dest;
   431			int fail, i;
   432			u8 opcode;
   433	
   434			if (is_inittext(layout, dest)) {
   435				prdbg("Ignoring init dest: %pS %px\n", dest, dest);
   436				continue;
   437			}
   438	
   439			/* Multiple symbols can have the same location. */
   440			if (btree_lookup64(&call_thunks, key)) {
   441				prdbg("Ignoring duplicate dest: %pS %px\n", dest, dest);
   442				continue;
   443			}
   444	
   445			thunk = tp = dest - 16;
   446			prdbg("Probing dest: %pS %px at %px\n", dest, dest, tp);
   447			pagefault_disable();
   448			fail = 0;
   449			for (i = 0; !fail && i < 16; i++) {
   450				if (get_kernel_nofault(opcode, tp + i)) {
   451					fail = 1;
   452				} else if (opcode != 0xcc) {
   453					fail = 2;
   454				}
   455			}
   456			pagefault_enable();
   457			switch (fail) {
   458			case 1:
   459				prdbg("Faulted for dest: %pS %px\n", dest, dest);
   460				nthunks++;
   461				continue;
   462			case 2:
   463				prdbg("No padding for dest: %pS %px\n", dest, dest);
   464				nthunks++;
   465				continue;
   466			}
   467	
   468			prdbg("Thunk for dest: %pS %px at %px\n", dest, dest, tp);
   469			memcpy(tp, callthunk_desc.template, callthunk_desc.template_size);
   470			tp += callthunk_desc.template_size;
   471	
   472			switch (gap) {
   473			case 0: break;
   474			case 1:
   475			case 2:
   476			case 3:
   477			case 4:
   478			case 5:
   479			case 6:
   480			case 7:
   481			case 8:
   482				memcpy(tp, x86_nops[gap], gap);
   483				break;
   484			default:
   485				__text_gen_insn(tp, JMP32_INSN_OPCODE, tp, dest,
   486						JMP32_INSN_SIZE);
   487				tp += JMP32_INSN_SIZE;
   488				*(u8*)tp = 0xcc;
   489				break;
   490			}
   491	
   492			if (area->dests) {
   493				prdbg("Insert %px at index %d\n", dest, idx);
   494				area->dests[idx++] = key;
   495			}
   496	
   497			fail = btree_insert64(&call_thunks, key, (void *)thunk, GFP_KERNEL);
   498			if (fail)
   499				return fail;
   500	
   501			area->nthunks++;
   502		}
   503		return 0;
   504	}
   505	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
