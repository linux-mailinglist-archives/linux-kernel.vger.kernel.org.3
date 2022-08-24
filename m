Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A761C59F1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiHXDS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiHXDST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:18:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E3880E98
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661311098; x=1692847098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DWQv2ElRIStja53Rqc2aCuX3gUp5VawiT44lzrf1/p4=;
  b=oAML/XdxXPD9uPLYks7S7TADpu0g+OloEh8K82aJZEF/A7uajrQyZdDh
   piccM1Xta0aDgj2JlcNCRjCzfECWhfwGAONYZiwxDjRNgWIe4YyAE6ufd
   OUNps3noR46y0JB3jPGGYoncchdhnTgIMENHsH5Rzf9KfS7cc89Tps+Zn
   HJFIrSowY6FWax55E1Lzm+QfNoiu6SS8L1QRdxWuF5iirFkfKB2RutpM4
   ga3gsDTDJ7aS33zlE1Ht/Pstrz7EYOCkqbUnEjG4Kr26ureNM+GeYkFKg
   eTshqAgSJn2fj7Nj6h6+26CS9o0BjN+1pwnJaLzxoo9gq4NaA5/QPZbkN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="280828493"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="280828493"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 20:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="937729954"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2022 20:18:16 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQguF-0000up-2u;
        Wed, 24 Aug 2022 03:18:15 +0000
Date:   Wed, 24 Aug 2022 11:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 17/18]
 arch/arm64/kernel/alternative.c:146:6: warning: no previous prototype for
 function 'summarize_alternatives'
Message-ID: <202208241125.5Pk8b711-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   fad62c713602c963008575fd972d316569a32d12
commit: 6f13524469effb9785e5692389b94113f994c100 [17/18] HACK: dump summary of alternatives
config: arm64-randconfig-r022-20220823 (https://download.01.org/0day-ci/archive/20220824/202208241125.5Pk8b711-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project b04d01c009d7f66bcca9138d2ce40999eedf104d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=6f13524469effb9785e5692389b94113f994c100
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout 6f13524469effb9785e5692389b94113f994c100
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ arch/arm64/mm/ kernel/events/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:146:6: warning: no previous prototype for function 'summarize_alternatives' [-Wmissing-prototypes]
   void summarize_alternatives(const struct alt_region *region)
        ^
   arch/arm64/kernel/alternative.c:146:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void summarize_alternatives(const struct alt_region *region)
   ^
   static 
   arch/arm64/kernel/alternative.c:330:14: warning: no previous prototype for function 'alt_cb_patch_nops' [-Wmissing-prototypes]
   noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
                ^
   arch/arm64/kernel/alternative.c:330:9: note: declare 'static' if the function is not intended to be used outside of this translation unit
   noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
           ^
           static 
   2 warnings generated.


vim +/summarize_alternatives +146 arch/arm64/kernel/alternative.c

   140	
   141	#define for_each_region_alt(region, alt)		\
   142		for (struct alt_instr *alt = (region)->begin;	\
   143		     (alt) < (region)->end;			\
   144		     (alt)++)
   145	
 > 146	void summarize_alternatives(const struct alt_region *region)
   147	{
   148		unsigned int entries[ARM64_NCAPS] = { 0 };
   149		unsigned int orig_len[ARM64_NCAPS] = { 0 };
   150		unsigned int repl_len[ARM64_NCAPS] = { 0 };
   151		unsigned int callbacks[ARM64_NCAPS] = { 0 };
   152	
   153		unsigned int total_entries = 0;
   154		unsigned int total_orig = 0;
   155		unsigned int total_repl = 0;
   156		unsigned int total_callbacks = 0;
   157	
   158		for_each_region_alt(region, alt) {
   159			int cap = ALT_CAP(alt);
   160	
   161			entries[cap]++;
   162			total_entries++;
   163	
   164			orig_len[cap] += alt->orig_len;
   165			total_orig += alt->orig_len;
   166	
   167			repl_len[cap] += alt->alt_len;
   168			total_repl += alt->alt_len;
   169	
   170			if (ALT_HAS_CB(alt)) {
   171				callbacks[cap]++;
   172				total_callbacks++;
   173			}
   174		}
   175	
   176		pr_info("Alternatives summary:\n"
   177			"    entries:      %5d\n"
   178			"    instructions: %5d\n"
   179			"    replacements: %5d\n"
   180			"    callbacks:    %5d\n",
   181			total_entries,
   182			total_orig / AARCH64_INSN_SIZE,
   183			total_repl / AARCH64_INSN_SIZE,
   184			total_callbacks);
   185	
   186		for (int i = 0; i < ARM64_NCAPS; i++) {
   187			if (!entries[i])
   188				continue;
   189	
   190			pr_info("cpucap %2d => entries: %5d orig: %5d, repl: %5d, cb: %5d\n",
   191				i,
   192				entries[i],
   193				orig_len[i] / AARCH64_INSN_SIZE,
   194				repl_len[i] / AARCH64_INSN_SIZE,
   195				callbacks[i]);
   196		}
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
