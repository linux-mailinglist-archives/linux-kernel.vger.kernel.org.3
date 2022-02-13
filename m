Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC24B3E09
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiBMWdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:33:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiBMWdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:33:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BA5468F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644791592; x=1676327592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=anAmdRO+Fl8wj9js2NrtNp3iEW0WJbdAZQsjIgUIz1A=;
  b=dgn6++DT8ueJSlym5rh1uaLiLWwlx+/6kiBq4MyW6G5TLVr3RvMXf4YG
   xup+HX2YFTSQPhrmCE48cnC9j8dTOBUjDyvDwUm3y8YE4/jr96aaRV9Tj
   BUMO06s+PXDrZePsJnW+nFQ1g1acht3+jMDSUQMIZrJvnnr0gwj7UfKuD
   I22wCJp6etjPtbBx9xImCPDni6G0+mqbbyoDx72GEYlySjT8boMz5V/7O
   TjfC9vfdwTmIFjx15vjnYZuMwiF5NyXyWRZcEJZWtpM406C3T0JlXTUsQ
   rfoqkqgSTmPQvdseMV8K/yMB6xBBO8wmKMYjf/xqeW4iNvRTLTmHGviu8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249726368"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249726368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 14:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="494856292"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Feb 2022 14:33:11 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJNQc-0007v7-IR; Sun, 13 Feb 2022 22:33:10 +0000
Date:   Mon, 14 Feb 2022 06:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fprobe_link_5 4/10]
 kernel/trace/bpf_trace.c:1043:22: error: 'struct pt_regs' has no member
 named 'ip'; did you mean 'sp'?
Message-ID: <202202140631.G10tOwU5-lkp@intel.com>
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
config: riscv-randconfig-m031-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140631.G10tOwU5-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=6944d13cf0af8628c0b80eb90359d90cbba0d69c
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link_5
        git checkout 6944d13cf0af8628c0b80eb90359d90cbba0d69c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash kernel/bpf/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function '____bpf_get_func_ip_fprobe':
>> kernel/trace/bpf_trace.c:1043:22: error: 'struct pt_regs' has no member named 'ip'; did you mean 'sp'?
    1043 |         return regs->ip;
         |                      ^~
         |                      sp
   kernel/trace/bpf_trace.c:1044:1: error: control reaches end of non-void function [-Werror=return-type]
    1044 | }
         | ^
   cc1: some warnings being treated as errors


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
