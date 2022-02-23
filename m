Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62C4C1FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbiBWXeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiBWXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:34:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6359382
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645659233; x=1677195233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7nh6eKh6I0z2qOX/grTcoEZEGXLN9IcBvF2QumexE4A=;
  b=lnb4NTeGzX6zJ8M0deuGhxm+vXHxPZ4ORFcMFEPRPdbmh8U3iEusCbiP
   XI2TZBXWRQU9hCRJglUCP70K66HVTST+Cvg3iSU0G6k4G27NMwHKPiKh2
   x34AM3qQq2hpfPda5lEtueVQ17nbDLhUKjHzJTPQzf7QBBa/HqGdy2D1k
   xhTPtP+rseEoZb6de1xys+8YzeOCf0Lk3XUGQa4J26ZNJafA4ugbu0PRF
   OC1uFeGbOemxz3bOx36wv06ivG9MFYVY+/rpPsqh8gs7U6whORqBgf6nZ
   yqgmY+QYFDSWAfpxE9WJq4QMGJgwxHcx9YWppYHz6DOKeHtattIS55d1Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315333452"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315333452"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508640918"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 15:33:52 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN18p-0001xF-IR; Wed, 23 Feb 2022 23:33:51 +0000
Date:   Thu, 24 Feb 2022 07:32:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 605/2340] kernel/kallsyms.c:88:3: warning:
 'strncpy' specified bound 128 equals destination size
Message-ID: <202202240701.bZqYmp7l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 0368017257bd4ac64c10d6e64612256d5141d581 [605/2340] kallsyms/objtool: Utilize the kallsyms_syms[] table in kallsyms_expand_symbol() and kallsyms_sym_address()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220224/202202240701.bZqYmp7l-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=0368017257bd4ac64c10d6e64612256d5141d581
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 0368017257bd4ac64c10d6e64612256d5141d581
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/kallsyms.c:636:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     636 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   In function 'kallsyms_expand_symbol',
       inlined from 'kallsyms_lookup_name' at kernel/kallsyms.c:256:9:
>> kernel/kallsyms.c:88:3: warning: 'strncpy' specified bound 128 equals destination size [-Wstringop-truncation]
      88 |   strncpy(result, sym->name, maxlen);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +88 kernel/kallsyms.c

    68	
    69	/*
    70	 * Expand a compressed symbol data into the resulting uncompressed string,
    71	 * if uncompressed string is too long (>= maxlen), it will be truncated,
    72	 * given the offset to where the symbol is in the compressed stream.
    73	 */
    74	static unsigned int kallsyms_expand_symbol(unsigned int off,
    75						   char *result, size_t maxlen)
    76	{
    77		int len, skipped_first = 0;
    78		const char *tptr;
    79		const u8 *data;
    80	
    81		if (WARN_ON_ONCE(!result || !maxlen))
    82			return 0;
    83	
    84	#ifdef CONFIG_KALLSYMS_FAST
    85		{
    86			struct kallsyms_sym *sym = kallsyms_syms + off;
    87	
  > 88			strncpy(result, sym->name, maxlen);
    89	
    90			return off + 1;
    91		}
    92	#endif
    93		/* Get the compressed symbol length from the first symbol byte. */
    94		data = &kallsyms_names[off];
    95		len = *data;
    96		data++;
    97	
    98		/*
    99		 * Update the offset to return the offset for the next symbol on
   100		 * the compressed stream.
   101		 */
   102		off += len + 1;
   103	
   104		/*
   105		 * For every byte on the compressed symbol data, copy the table
   106		 * entry for that byte.
   107		 */
   108		while (len) {
   109			tptr = &kallsyms_token_table[kallsyms_token_index[*data]];
   110			data++;
   111			len--;
   112	
   113			while (*tptr) {
   114				if (skipped_first) {
   115					if (maxlen <= 1)
   116						goto tail;
   117					*result = *tptr;
   118					result++;
   119					maxlen--;
   120				} else
   121					skipped_first = 1;
   122				tptr++;
   123			}
   124		}
   125	
   126	tail:
   127		if (maxlen)
   128			*result = '\0';
   129	
   130		/* Return to offset to the next symbol. */
   131		return off;
   132	}
   133	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
