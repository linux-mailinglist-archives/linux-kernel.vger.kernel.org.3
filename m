Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E34DC5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiCQM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiCQM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:29:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D168119C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647520078; x=1679056078;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cw/m7jCM3UKk76lgGQDLtcnyG+Gpqo+DFD6TSOHi86Y=;
  b=dru8eotoDPBv4B2sgyWqoZ3msOLQcWF6mHhuS+f22lvdH3X0XDbIciMk
   lV1Ww4A+x6qWjl2TpdZsyI3iB8x9cBC8IPe7OFGNwvI9ltDZ3KwExddR8
   OgVccsXIW5q/dCo0TfbtyuZnYRKb7cxLGoNP1gPlUnX61Vz0jM6RHCcRp
   mQ8IjtWZQPtI23yQ7HSzoAGBv2vcgXMRQxrW25IwOHfrJkNbZDnWUh6Ya
   +jIpgGlK8RKVTFf+AKpJ003XQTz4eCNTMl3TKHtOAypQk0oj2I0VgBUzg
   WZ/04aQZBrIaBoBNugGtX4h/Y2+cEMaB3aNfCqjgUvrhi64RSvXvdX6Wi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244307004"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="244307004"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 05:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516746009"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 05:27:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUpE5-000Dfj-4Z; Thu, 17 Mar 2022 12:27:33 +0000
Date:   Thu, 17 Mar 2022 20:26:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 592/2335] kernel/kallsyms.c:88:3: warning:
 'strncpy' specified bound 128 equals destination size
Message-ID: <202203172007.S4q5m0Xm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 37139bbbb8552f3151a0344dc39d572fabbf4061 [592/2335] kallsyms/objtool: Utilize the kallsyms_syms[] table in kallsyms_expand_symbol() and kallsyms_sym_address()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220317/202203172007.S4q5m0Xm-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=37139bbbb8552f3151a0344dc39d572fabbf4061
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 37139bbbb8552f3151a0344dc39d572fabbf4061
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
