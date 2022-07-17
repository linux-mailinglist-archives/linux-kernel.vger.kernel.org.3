Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA457731E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiGQCFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:05:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92391A052
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658023506; x=1689559506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8rWFgtJiZC/VszlNwDsi3IyktDeb8RFvUjol+PvIpto=;
  b=TGbpfRyHSdwpX5cmGEKYcH76lI+4tcPGx0G3O2GHeD46hlAEWxsHHJZ0
   VekxXHkHFoXRCnqY8Nh59zxRGjfPOI3Up3iCaVmPPuzjk9yy1XyY4m+FB
   LQlhLXeSx7U8LYFJ3883sc7AT+87n6lM8igbf0V8TRXMeZTGSGGLgvb2E
   uplkOpEcsysuXhDQvv/hlUrV5x3ZFIqasUumStSmswQpvXrUu5R4gDQM2
   DtSYGVoslrYEUtp7bFJcYXAaBFX1fpTGBqS+qIi6cI1K4s68tmSUWK4yT
   aUAh4VoERlEKdUKwySU6YWDVuEso33DHW6mH+C+NImE859aSnttZUKeX2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="372330868"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="372330868"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 19:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="547080250"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2022 19:05:04 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCtea-0002UZ-6M;
        Sun, 17 Jul 2022 02:05:04 +0000
Date:   Sun, 17 Jul 2022 10:04:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: arch/arm/include/asm/system_misc.h:29:9: error: implicit declaration
 of function 'preempt_enable_no_resched_notrace'; did you mean
 'preempt_enable_notrace'?
Message-ID: <202207170947.p1AZIs0b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220717-000210/Tetsuo-Handa/ARM-spectre-v2-fix-smp_processor_id-warning/20220622-145116
head:   7c8920bd674d371b04dc1ee0e0c6b8af89e55987
commit: 7c8920bd674d371b04dc1ee0e0c6b8af89e55987 ARM: spectre-v2: fix smp_processor_id() warning
date:   10 hours ago
config: arm-omap2plus_defconfig (https://download.01.org/0day-ci/archive/20220717/202207170947.p1AZIs0b-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7c8920bd674d371b04dc1ee0e0c6b8af89e55987
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220717-000210/Tetsuo-Handa/ARM-spectre-v2-fix-smp_processor_id-warning/20220622-145116
        git checkout 7c8920bd674d371b04dc1ee0e0c6b8af89e55987
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/ti/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/soc/ti/pm33xx.c:33:
   arch/arm/include/asm/system_misc.h: In function 'harden_branch_predictor':
>> arch/arm/include/asm/system_misc.h:29:9: error: implicit declaration of function 'preempt_enable_no_resched_notrace'; did you mean 'preempt_enable_notrace'? [-Werror=implicit-function-declaration]
      29 |         preempt_enable_no_resched_notrace();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         preempt_enable_notrace
   cc1: some warnings being treated as errors


vim +29 arch/arm/include/asm/system_misc.h

    17	
    18	#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
    19	typedef void (*harden_branch_predictor_fn_t)(void);
    20	DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
    21	static inline void harden_branch_predictor(void)
    22	{
    23		harden_branch_predictor_fn_t fn;
    24	
    25		preempt_disable_notrace();
    26		fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
    27		if (fn)
    28			fn();
  > 29		preempt_enable_no_resched_notrace();
    30	}
    31	#else
    32	#define harden_branch_predictor() do { } while (0)
    33	#endif
    34	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
