Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD859F0DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiHXB0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiHXB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:26:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D55A158
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661304375; x=1692840375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xu4VVtueXMaHSDEe4yYtFLEzk4+U/4f/7RXVJQpv/tw=;
  b=EAIJJgrzEeLxgBLM4e4em//JfIMYFk4GO7cy7F01YLzqSfkIXp1e2FiY
   fdzqz4ULFs4NyKmUAy3c8uIFrMcQEqNMVwY/ABlbCsNzidACzWoUjpklj
   adzm8gNS62SIgkkTSbm+7BQbYKlOa4kR/x4id4h8g+O1CMQgk4U9b5HDW
   n2hNbQ4RNNK4qhEJF57Tt8STfWrVHevxrJ58Kd8OjEt70eXEAq21PKNT8
   /B2/ZULCgI7C8jjeptijNACQ7quUyIaiotQEfh3M5WbtoPn6pjKnHQtDz
   poNCUG4c23vzhtDxGjkvDE0vwaE0I3R1jzZzl6TZEiLsiwaDxqueJzlw/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="380128025"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="380128025"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 18:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="586222105"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2022 18:26:13 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQf9o-0000o5-2g;
        Wed, 24 Aug 2022 01:26:12 +0000
Date:   Wed, 24 Aug 2022 09:25:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 17/18]
 arch/arm64/kernel/alternative.c:146:6: warning: no previous prototype for
 'summarize_alternatives'
Message-ID: <202208240954.ZdCvNcRi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   fad62c713602c963008575fd972d316569a32d12
commit: 6f13524469effb9785e5692389b94113f994c100 [17/18] HACK: dump summary of alternatives
config: arm64-buildonly-randconfig-r005-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240954.ZdCvNcRi-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=6f13524469effb9785e5692389b94113f994c100
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout 6f13524469effb9785e5692389b94113f994c100
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:146:6: warning: no previous prototype for 'summarize_alternatives' [-Wmissing-prototypes]
     146 | void summarize_alternatives(const struct alt_region *region)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/alternative.c:330:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
     330 | noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
         |              ^~~~~~~~~~~~~~~~~


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
