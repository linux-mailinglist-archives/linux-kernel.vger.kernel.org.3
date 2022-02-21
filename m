Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C84BD316
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiBUBL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 20:11:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBUBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 20:11:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F14517C0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645405863; x=1676941863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gu0KB9VXRNHDXPVaDd+q1xpKvG0dhmPbYusUW/kdCj0=;
  b=RAGqEEI5Ip8fUxw+IXTkV+MZvKIJ3PiqT4b83yyptLVBOczR25Kc3T2g
   U31NQPfKbNgFpSaf3aRrr576uXo8C/uvCHatsa+caA/lZxCJa2mAyyTnz
   /a777rnbualbWjjSSR4WR5mDNAGGK9wr3YJdzmWbX4z+eEH1vjVYBMx27
   wu3mkTgvHcjTRPAbDhcTDJxVO4FcoxQZAt48wJoH3qNFVBzHprRIAOhjp
   JLMENYrZK0h1hMP8AbIQzUaZt3vVesX+oXPyPzDS3CAxAakle8fnfBaKL
   czQKW9F9QAZ/T9Hxkb11MjgYmz46o0lg2+3QshSLRUDZ4hnj6ZHI2h77c
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238828137"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="238828137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 17:11:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="572937588"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2022 17:11:01 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLxEC-000184-Mh; Mon, 21 Feb 2022 01:11:00 +0000
Date:   Mon, 21 Feb 2022 09:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 413/2574] kernel/bpf/core.c:62:6: warning:
 no previous prototype for function 'bpf_jit_dump'
Message-ID: <202202210906.6oI53C71-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 693153354d8d8df0fd4fd0d81ca659ca9c96d2e9 [413/2574] headers/uninline: Uninline multi-use function: bpf_jit_dump()
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220221/202202210906.6oI53C71-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=693153354d8d8df0fd4fd0d81ca659ca9c96d2e9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 693153354d8d8df0fd4fd0d81ca659ca9c96d2e9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ arch/x86/pci/ kernel/bpf/ kernel/sched/ kernel/trace/ lib/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:62:6: warning: no previous prototype for function 'bpf_jit_dump' [-Wmissing-prototypes]
   void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
        ^
   kernel/bpf/core.c:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
   ^
   static 
   kernel/bpf/core.c:1378:12: warning: no previous prototype for function 'bpf_probe_read_kernel' [-Wmissing-prototypes]
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
              ^
   kernel/bpf/core.c:1378:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
   ^
   static 
   2 warnings generated.


vim +/bpf_jit_dump +62 kernel/bpf/core.c

    61	
  > 62	void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
    63	{
    64		pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
    65		       proglen, pass, image, current->comm, task_pid_nr(current));
    66	
    67		if (image)
    68			print_hex_dump(KERN_ERR, "JIT code: ", DUMP_PREFIX_OFFSET,
    69				       16, 1, image, proglen, false);
    70	}
    71	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
