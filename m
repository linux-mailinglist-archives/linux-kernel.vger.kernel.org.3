Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC36E4B3EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiBNAgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:36:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiBNAga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:36:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D413522C4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644798983; x=1676334983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+MphsBjQd9Mx9ssh5ka9JkBfThVEfm9wyc0kFHGmOzs=;
  b=LHvRldXUTd/9pjbmg4OPe6Jzyii7o8Y2653LGJIMJfy8CVbSgWPCW/av
   Cw5e2TzSIWbDmIyFBrGZ5KZiYK1N9tiOMwQ4tJrOJjsyiIQwnz0NZnSgg
   ymKPhoGgpW8XmVXcNu/rBMnX2XB9UvCGhje40LAHmzzWeqgIJS0aCC7wN
   PvGBv9sdBhS7OGGuJqdDbOKbIOQinyEUlJHhMIJ57IQA929IaVo0/BXDj
   M5O5sej/9T2ebhF01TFCHW6uX9oW35xGVYfrcuo9dCv37d9tKieqzD4JJ
   PGAPUNbMksdpyzCMcZPJvdKmy6XMi06ryCfgVEexVwefNHctz81Hy7Byl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237395813"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="237395813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 16:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="586968101"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2022 16:36:21 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJPLp-00082X-7O; Mon, 14 Feb 2022 00:36:21 +0000
Date:   Mon, 14 Feb 2022 08:35:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fprobe_link_5 4/10]
 kernel/trace/bpf_trace.c:1043:15: error: no member named 'ip' in 'struct
 pt_regs'
Message-ID: <202202140858.R22HkKfR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link_5
head:   9149abfa25286fdf715525babec5150939c9ac96
commit: 6944d13cf0af8628c0b80eb90359d90cbba0d69c [4/10] bpf: Add bpf_get_func_ip kprobe helper for fprobe link
config: arm-aspeed_g4_defconfig (https://download.01.org/0day-ci/archive/20220214/202202140858.R22HkKfR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=6944d13cf0af8628c0b80eb90359d90cbba0d69c
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link_5
        git checkout 6944d13cf0af8628c0b80eb90359d90cbba0d69c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1043:15: error: no member named 'ip' in 'struct pt_regs'
           return regs->ip;
                  ~~~~  ^
   1 error generated.


vim +1043 kernel/trace/bpf_trace.c

  1039	
  1040	BPF_CALL_1(bpf_get_func_ip_fprobe, struct pt_regs *, regs)
  1041	{
  1042		/* This helper call is inlined by verifier. */
> 1043		return regs->ip;
  1044	}
  1045	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
