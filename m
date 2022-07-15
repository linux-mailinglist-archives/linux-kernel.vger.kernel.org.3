Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BA57588C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiGOAM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiGOAMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:12:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4188D73922
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843974; x=1689379974;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=apxNuleYs8SjZamL6LzSNiFL++sx+oceqYSCLHkPmuY=;
  b=ellr6gbdvo8XMeMLi/6KPQp12L37esY0JsHWAaw1uBWQCiRcOuZvBTEL
   cYJ18tng4IRbBFM0ZmGH/zCXE9SVa4XvfpiI6CfObwrx0KreeBWaXgnuw
   UAfdaGjCLIyFQdidx8BAVugF5rW6a00qSvgjEZCoy4Fcl/nV5MOBXcR9m
   3x+xAAu/Jw8D0Cc0YDUnuz4udAzND3nDCm5Wwa3aThtojJun2S/Z5mnGs
   JtVUJ+yy21pwt0KXF6sC2SckiZfNB19CGR5LJmFo8OvGIOpEyOfSyM6Sh
   O+bT0/aW36ybAKQwyjfC35sjPhzkFQuN8CBQuPtLl41FAHud7j6dT5VlY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371979908"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371979908"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571306321"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 17:12:52 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC8wt-0001If-Mw;
        Fri, 15 Jul 2022 00:12:51 +0000
Date:   Fri, 15 Jul 2022 08:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: arch/x86/kernel/cpu/bugs.c:68:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202207150816.81pQSTa5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5d523f1ae8f2cef01f8e071aeee432654166708
commit: caa0ff24d5d0e02abce5e65c3d2b7f20a6617be5 x86/bugs: Keep a per-CPU IA32_SPEC_CTRL value
date:   3 weeks ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220715/202207150816.81pQSTa5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=caa0ff24d5d0e02abce5e65c3d2b7f20a6617be5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout caa0ff24d5d0e02abce5e65c3d2b7f20a6617be5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/cpu/bugs.c:57:1: sparse: sparse: symbol 'x86_spec_ctrl_current' was not declared. Should it be static?
>> arch/x86/kernel/cpu/bugs.c:68:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:68:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:68:13: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:71:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:71:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:71:9: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:794:12: sparse: sparse: symbol 'retbleed_strings' was not declared. Should it be static?

vim +68 arch/x86/kernel/cpu/bugs.c

    55	
    56	/* The current value of the SPEC_CTRL MSR with task-specific bits set */
  > 57	DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
    58	EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
    59	
    60	static DEFINE_MUTEX(spec_ctrl_mutex);
    61	
    62	/*
    63	 * Keep track of the SPEC_CTRL MSR value for the current task, which may differ
    64	 * from x86_spec_ctrl_base due to STIBP/SSB in __speculation_ctrl_update().
    65	 */
    66	void write_spec_ctrl_current(u64 val)
    67	{
  > 68		if (this_cpu_read(x86_spec_ctrl_current) == val)
    69			return;
    70	
    71		this_cpu_write(x86_spec_ctrl_current, val);
    72		wrmsrl(MSR_IA32_SPEC_CTRL, val);
    73	}
    74	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
