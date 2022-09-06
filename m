Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E485AF2F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIFRn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiIFRnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:43:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE42982E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662486234; x=1694022234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5iF0xvO5+zxC54GD3RNXt8NwwSu92AOXnvD6DAwWT+s=;
  b=YDYgzhWAw74MZNcvmTP3avOlo9yxZPerx7BR+DFyYPGVHAAjTwi5XqKN
   xFapKsVJc5K3AEqi8Bs62RnHBAyojLQ/UywlX802hapa5Tgor0qri6Sg3
   ob+1437o2gXpUXoj/561hfWiH18V4CbUtUYvmF4Xy6YdRsCM1FHLqXE8j
   yZbF41WTQ4gI8Sbfcp4RmGQsI2fPG4iMQq5N/WcchKmXgXngB4lCE8sZX
   KSaDkNAfqYMUurRY0ViWOum/kTZYOSLM0fQuGVSxfDGo1VpLTavBrr72E
   jOxtjhjLO764ag5yUtsiUYctl4sNYhoQL0fHTNV9tm5JmvPYrpLg7OtEj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297976011"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297976011"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 10:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942550394"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 10:43:36 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVcbn-0005PJ-1y;
        Tue, 06 Sep 2022 17:43:35 +0000
Date:   Wed, 7 Sep 2022 01:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 9/9]
 arch/arm64/kernel/alternative.c:144:6: warning: no previous prototype for
 function 'summarize_alternatives'
Message-ID: <202209070120.Nxra1oGA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   2d5c57125128db8b4934846ad39b00f79cd1637d
commit: 2d5c57125128db8b4934846ad39b00f79cd1637d [9/9] HACK: arm64: alternatives: dump summary of alternatives
config: arm64-randconfig-r031-20220906 (https://download.01.org/0day-ci/archive/20220907/202209070120.Nxra1oGA-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=2d5c57125128db8b4934846ad39b00f79cd1637d
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout 2d5c57125128db8b4934846ad39b00f79cd1637d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:144:6: warning: no previous prototype for function 'summarize_alternatives' [-Wmissing-prototypes]
   void summarize_alternatives(const struct alt_region *region)
        ^
   arch/arm64/kernel/alternative.c:144:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
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


vim +/summarize_alternatives +144 arch/arm64/kernel/alternative.c

   138	
   139	#define for_each_region_alt(region, alt)		\
   140		for (struct alt_instr *alt = (region)->begin;	\
   141		     (alt) < (region)->end;			\
   142		     (alt)++)
   143	
 > 144	void summarize_alternatives(const struct alt_region *region)
   145	{
   146		unsigned int entries[ARM64_NCAPS] = { 0 };
   147		unsigned int orig_len[ARM64_NCAPS] = { 0 };
   148		unsigned int repl_len[ARM64_NCAPS] = { 0 };
   149		unsigned int callbacks[ARM64_NCAPS] = { 0 };
   150	
   151		unsigned int total_entries = 0;
   152		unsigned int total_orig = 0;
   153		unsigned int total_repl = 0;
   154		unsigned int total_callbacks = 0;
   155	
   156		for_each_region_alt(region, alt) {
   157			int cap = ALT_CAP(alt);
   158	
   159			entries[cap]++;
   160			total_entries++;
   161	
   162			orig_len[cap] += alt->orig_len;
   163			total_orig += alt->orig_len;
   164	
   165			repl_len[cap] += alt->alt_len;
   166			total_repl += alt->alt_len;
   167	
   168			if (ALT_HAS_CB(alt)) {
   169				callbacks[cap]++;
   170				total_callbacks++;
   171			}
   172		}
   173	
   174		pr_info("Alternatives summary:\n"
   175			"    entries:      %6u (%6zu bytes)\n"
   176			"      regular:    %6d\n"
   177			"      callback:   %6d\n"
   178			"    instructions: %6u (%6u bytes)\n"
   179			"    replacements: %6u (%6u bytes)\n",
   180			total_entries,	total_entries * sizeof (struct alt_instr),
   181			total_entries - total_callbacks,
   182			total_callbacks,
   183			total_orig / AARCH64_INSN_SIZE, total_orig,
   184			total_repl / AARCH64_INSN_SIZE, total_repl);
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
