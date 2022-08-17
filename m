Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C05967CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiHQDmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHQDmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:42:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7758275F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 20:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660707731; x=1692243731;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LcwTlDkn1EW8BqQe4YsiHcrdM+iTiHkk5Po5g5yZtJ8=;
  b=NPLO5lrkyjuF1WJhjAFDP86CvTKd2XoqB56g193uXXPp9f/xSB3z3umc
   J9J98N1hqeMCW7ttfE1J2zI0FdZoFR/HLpWz5mkTR+WF9m3j6QZSlbcS9
   x87tiWgN8y05capscz09PqWVjh5IU+zOnj7ItiIJ6OIqdq8RL8YppoK46
   uJbX7rY29QlbqcvSiUvX/zmuCbilgp+q4s0HpiY3yTMya6IRKbvC2f5sy
   8vOR2cIc7SmtqMnWt/yAxpmXAZwKB0wntXOOgtodz0hOpSz8+HWBk6vik
   tpfJHR78N/jsf2zIhA/94Kb3aKEQt4DCrnM+At8480UVTtE15WX5hoQs2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291144163"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291144163"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 20:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583586418"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2022 20:42:09 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO9wW-0000W0-2t;
        Wed, 17 Aug 2022 03:42:08 +0000
Date:   Wed, 17 Aug 2022 11:41:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-amx:init-fpstate 2/3] arch/x86/kernel/fpu/xstate.c:364:13:
 error: implicit declaration of function 'is_supported_xstate_size'
Message-ID: <202208171117.pKb8AOTV-lkp@intel.com>
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

tree:   https://github.com/intel/amx-linux.git init-fpstate
head:   ecaf24cb37353309ec194fa7e091eda041f962df
commit: 427beb3b420197545d034370ab76acf64b804ebc [2/3] x86/fpu: Do the init_fpstate size check with the actual size
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220817/202208171117.pKb8AOTV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/amx-linux/commit/427beb3b420197545d034370ab76acf64b804ebc
        git remote add intel-amx https://github.com/intel/amx-linux.git
        git fetch --no-tags intel-amx init-fpstate
        git checkout 427beb3b420197545d034370ab76acf64b804ebc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/fpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/fpu/xstate.c: In function 'setup_init_fpu_buf':
>> arch/x86/kernel/fpu/xstate.c:364:13: error: implicit declaration of function 'is_supported_xstate_size' [-Werror=implicit-function-declaration]
     364 |         if (is_supported_xstate_size(init_fpstate.size))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/fpu/xstate.c: At top level:
>> arch/x86/kernel/fpu/xstate.c:690:20: error: conflicting types for 'is_supported_xstate_size'; have 'bool(unsigned int)' {aka '_Bool(unsigned int)'}
     690 | static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/fpu/xstate.c:364:13: note: previous implicit declaration of 'is_supported_xstate_size' with type 'int()'
     364 |         if (is_supported_xstate_size(init_fpstate.size))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/fpu/xstate.c:690:20: warning: 'is_supported_xstate_size' defined but not used [-Wunused-function]
     690 | static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_supported_xstate_size +364 arch/x86/kernel/fpu/xstate.c

   328	
   329	/*
   330	 * All supported features have either init state all zeros or are
   331	 * handled in setup_init_fpu() individually. This is an explicit
   332	 * feature list and does not use XFEATURE_MASK*SUPPORTED to catch
   333	 * newly added supported features at build time and make people
   334	 * actually look at the init state for the new feature.
   335	 */
   336	#define XFEATURES_INIT_FPSTATE_HANDLED		\
   337		(XFEATURE_MASK_FP |			\
   338		 XFEATURE_MASK_SSE |			\
   339		 XFEATURE_MASK_YMM |			\
   340		 XFEATURE_MASK_OPMASK |			\
   341		 XFEATURE_MASK_ZMM_Hi256 |		\
   342		 XFEATURE_MASK_Hi16_ZMM	 |		\
   343		 XFEATURE_MASK_PKRU |			\
   344		 XFEATURE_MASK_BNDREGS |		\
   345		 XFEATURE_MASK_BNDCSR |			\
   346		 XFEATURE_MASK_PASID |			\
   347		 XFEATURE_MASK_XTILE)
   348	
   349	/*
   350	 * setup the xstate image representing the init state
   351	 */
   352	static int __init setup_init_fpu_buf(void)
   353	{
   354		BUILD_BUG_ON((XFEATURE_MASK_USER_SUPPORTED |
   355			      XFEATURE_MASK_SUPERVISOR_SUPPORTED) !=
   356			     XFEATURES_INIT_FPSTATE_HANDLED);
   357	
   358		if (!boot_cpu_has(X86_FEATURE_XSAVE))
   359			return -ENODEV;
   360	
   361		print_xstate_features();
   362	
   363		/* Ensure the space to record the scoped init state. */
 > 364		if (is_supported_xstate_size(init_fpstate.size))
   365			return -EINVAL;
   366	
   367		xstate_init_xcomp_bv(&init_fpstate.regs.xsave, init_fpstate.xfeatures);
   368	
   369		/*
   370		 * Init all the features state with header.xfeatures being 0x0
   371		 */
   372		os_xrstor_booting(&init_fpstate.regs.xsave);
   373	
   374		/*
   375		 * All components are now in init state. Read the state back so
   376		 * that init_fpstate contains all non-zero init state. This only
   377		 * works with XSAVE, but not with XSAVEOPT and XSAVEC/S because
   378		 * those use the init optimization which skips writing data for
   379		 * components in init state.
   380		 *
   381		 * XSAVE could be used, but that would require to reshuffle the
   382		 * data when XSAVEC/S is available because XSAVEC/S uses xstate
   383		 * compaction. But doing so is a pointless exercise because most
   384		 * components have an all zeros init state except for the legacy
   385		 * ones (FP and SSE). Those can be saved with FXSAVE into the
   386		 * legacy area. Adding new features requires to ensure that init
   387		 * state is all zeroes or if not to add the necessary handling
   388		 * here.
   389		 */
   390		fxsave(&init_fpstate.regs.fxsave);
   391		return 0;
   392	}
   393	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
