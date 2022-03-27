Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF594E88A7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiC0QHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiC0QGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:06:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560412617;
        Sun, 27 Mar 2022 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648397115; x=1679933115;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4kVnz1StqYwtIiK0sGUtMho1ruRvS+EEC0bWGTQBMMI=;
  b=Jh8ORDWMcOHHKywwbscWr+A85Hb38m3zJDPpJPNLf1T83QJrtT52Y1JN
   NHBAyOAqiiRckPN7rwZNmvF6zevzaHZ0niIi7QkZSFNHQoZg7ELso3i7+
   MCfK5NiGz/gWALYWKU10s+JzycygbmvZMUhU12qtKMJ3USbioSVO9y4QX
   Suy0nILFwlUGNkfypdPz4S2aGkZICE3Ga4gvHDQoeZ+MLQnVS5Grn3osj
   zn6UwcKESoQJjfOuHttQABoPzO+wREVUTFbSAlQkdUx1fGMtyMevKaXTi
   cNs/izEemF05RJIWB22DbzyyxV7SzeR8Y/6KJpWTCMnwA0k6Yuhw1x6fN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="241014017"
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="241014017"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 09:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,215,1643702400"; 
   d="scan'208";a="520723351"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2022 09:05:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYVOB-0001D7-Aj; Sun, 27 Mar 2022 16:05:11 +0000
Date:   Mon, 28 Mar 2022 00:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>, linux-doc@vger.kernel.org
Subject: arch/riscv/kernel/cpu.c:113: warning: This comment starts with
 '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203272341.NC73YmTW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f022814633e1c600507b3a99691b4d624c2813f0
commit: a9b202606c69312cdaa4db187837820ebf7213b2 RISC-V: Improve /proc/cpuinfo output for ISA extensions
date:   10 days ago
config: riscv-randconfig-r042-20220327 (https://download.01.org/0day-ci/archive/20220327/202203272341.NC73YmTW-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9b202606c69312cdaa4db187837820ebf7213b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a9b202606c69312cdaa4db187837820ebf7213b2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/cpu.c:89: warning: cannot understand function prototype: 'struct riscv_isa_ext_data isa_ext_arr[] = '
>> arch/riscv/kernel/cpu.c:113: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * These are the only valid base (single letter) ISA extensions as per the spec.


vim +113 arch/riscv/kernel/cpu.c

    65	
    66	#ifdef CONFIG_PROC_FS
    67	#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
    68		{							\
    69			.uprop = #UPROP,				\
    70			.isa_ext_id = EXTID,				\
    71		}
    72	/**
    73	 * Here are the ordering rules of extension naming defined by RISC-V
    74	 * specification :
    75	 * 1. All extensions should be separated from other multi-letter extensions
    76	 *    from other multi-letter extensions by an underscore.
    77	 * 2. The first letter following the 'Z' conventionally indicates the most
    78	 *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
    79	 *    If multiple 'Z' extensions are named, they should be ordered first
    80	 *    by category, then alphabetically within a category.
    81	 * 3. Standard supervisor-level extensions (starts with 'S') should be
    82	 *    listed after standard unprivileged extensions.  If multiple
    83	 *    supervisor-level extensions are listed, they should be ordered
    84	 *    alphabetically.
    85	 * 4. Non-standard extensions (starts with 'X') must be listed after all
    86	 *    standard extensions. They must be separated from other multi-letter
    87	 *    extensions by an underscore.
    88	 */
  > 89	static struct riscv_isa_ext_data isa_ext_arr[] = {
    90		__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
    91	};
    92	
    93	static void print_isa_ext(struct seq_file *f)
    94	{
    95		struct riscv_isa_ext_data *edata;
    96		int i = 0, arr_sz;
    97	
    98		arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
    99	
   100		/* No extension support available */
   101		if (arr_sz <= 0)
   102			return;
   103	
   104		for (i = 0; i <= arr_sz; i++) {
   105			edata = &isa_ext_arr[i];
   106			if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
   107				continue;
   108			seq_printf(f, "_%s", edata->uprop);
   109		}
   110	}
   111	
   112	/**
 > 113	 * These are the only valid base (single letter) ISA extensions as per the spec.
   114	 * It also specifies the canonical order in which it appears in the spec.
   115	 * Some of the extension may just be a place holder for now (B, K, P, J).
   116	 * This should be updated once corresponding extensions are ratified.
   117	 */
   118	static const char base_riscv_exts[13] = "imafdqcbkjpvh";
   119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
