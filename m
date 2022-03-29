Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC74EAF27
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiC2OZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiC2OZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:25:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435613E12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648563796; x=1680099796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B/mI38jzlU1f00eDjZ9lzNKZw+RbKTIw6WEAubkNXAg=;
  b=P6p6yD6l8Ozjl4hyK1HVGT4K6ItfuFwNux4ibxARz9ZjX5yGRg0NdN8K
   YIe2o1L2yynbyRDXKEEDdNx6IqvNT7G/LObJia0zBY2mDsO1ivD+w7x3S
   JNRC2BRnWR1uLZ8JgNVjSafd9m52v3HlznxmtZgDlF0a4K4l08sCULz91
   wy/QMRIDPwVVzcrMN2O9q1nIbKmbVcwCsQvj7gu/q9XmILsXcVrNm0fNv
   obohU2PvJzaTcQJ3Vu1FpcApYM52Q/rMlf6HNrFZhFma40AAii8Y/z0D2
   AHf1t8h1x1qvK1xu+QAJe/C2Hj+VrRoaZRxiUEuVBF0ZlZmWMOpwDv6SU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258975310"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="258975310"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 07:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="521456716"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 07:23:14 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZCkc-0000Jo-4m; Tue, 29 Mar 2022 14:23:14 +0000
Date:   Tue, 29 Mar 2022 22:23:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [ammarfaizi2-block:bp/bp/rc0+ 6/11]
 arch/x86/kernel/cpu/common.c:1415:10: error: 'x86_cap_flags' undeclared; did
 you mean 'x86_cap_flag'?
Message-ID: <202203292206.ICsY2RKX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bp/bp/rc0+
head:   2d784fc7295963360594f3de64446aa32841c694
commit: c3b9dcd01973935375ca9d0c67044bea7333d4ef [6/11] x86/cpu: Allow feature bit names from /proc/cpuinfo in clearcpuid=
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220329/202203292206.ICsY2RKX-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c3b9dcd01973935375ca9d0c67044bea7333d4ef
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bp/bp/rc0+
        git checkout c3b9dcd01973935375ca9d0c67044bea7333d4ef
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/common.c: In function 'cpu_parse_early_param':
>> arch/x86/kernel/cpu/common.c:1415:10: error: 'x86_cap_flags' undeclared (first use in this function); did you mean 'x86_cap_flag'?
    1415 |     if (!x86_cap_flags[bit])
         |          ^~~~~~~~~~~~~
         |          x86_cap_flag
   arch/x86/kernel/cpu/common.c:1415:10: note: each undeclared identifier is reported only once for each function it appears in


vim +1415 arch/x86/kernel/cpu/common.c

  1385	
  1386		if (cmdline_find_option_bool(boot_command_line, "noxsave"))
  1387			setup_clear_cpu_cap(X86_FEATURE_XSAVE);
  1388	
  1389		if (cmdline_find_option_bool(boot_command_line, "noxsaveopt"))
  1390			setup_clear_cpu_cap(X86_FEATURE_XSAVEOPT);
  1391	
  1392		if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
  1393			setup_clear_cpu_cap(X86_FEATURE_XSAVES);
  1394	
  1395		arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
  1396		if (arglen <= 0)
  1397			return;
  1398	
  1399		pr_info("Clearing CPUID bits:");
  1400	
  1401		while (argptr) {
  1402			bool found __maybe_unused = false;
  1403			unsigned int bit;
  1404	
  1405			opt = strsep(&argptr, ",");
  1406	
  1407			/*
  1408			 * Handle naked numbers first for feature flags which don't
  1409			 * have names.
  1410			 */
  1411			if (!kstrtouint(opt, 10, &bit)) {
  1412				if (bit < NCAPINTS * 32) {
  1413	
  1414					/* empty-string, i.e., ""-defined feature flags */
> 1415					if (!x86_cap_flags[bit])
  1416						pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
  1417					else
  1418						pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
  1419	
  1420					setup_clear_cpu_cap(bit);
  1421					taint++;
  1422				}
  1423				/*
  1424				 * The assumption is that there are no feature names with only
  1425				 * numbers in the name thus go to the next argument.
  1426				 */
  1427				continue;
  1428			}
  1429	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
