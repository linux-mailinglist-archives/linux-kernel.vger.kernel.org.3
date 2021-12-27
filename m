Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1E480531
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 23:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhL0Wyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 17:54:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:36366 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhL0Wym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 17:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640645682; x=1672181682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PIfAtJa48Ey6lFqPKBM3x+QVyuNqrNsMmDvsdisnj8I=;
  b=a/Wzjt7PdNl3VCRxGPWz0ctoHRwDxt6gJDxZIzKSiSgZO1cdhK+lH/Po
   MX3dvmRrB7KAyF8+QSckkizpR2nZTBE07eGRZTD7ozcM/eULLtQzNMO1R
   3+B4RdLcIJJphK6JIhCRF46Kz7FwUGnkVGEkSaxqm5LA2bLkih/bk9bbw
   kQAOhva1nwxInmFi49Hb2kq3H6gGlPo/MV3PW9n4oWcZxSGaNq/qzQcuh
   5fzAcuJG3w1+ohPrnVF5iXmiTWPTf0uBECEz5Tg+m/92xO1ndzG33P+4n
   Zx0K3YqmSSEXqppACCVYrKnNbSza/7K/s4O1STl4VtKXRicZtU2S/Koz8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="265505432"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="265505432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 14:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="486138359"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2021 14:54:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1yt5-0006wz-CT; Mon, 27 Dec 2021 22:54:39 +0000
Date:   Tue, 28 Dec 2021 06:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 6/13] kernel/trace/bpf_trace.c:1032:22:
 error: implicit declaration of function 'kprobe_ftrace_multi_addr'
Message-ID: <202112280625.ZNZllxQ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   bc59262730d5cfc95d6cae84f247d2e8690a309b
commit: a1974e6769e507428f52729967e6670a1548c239 [6/13] kprobe: Allow to get traced function address for multi ftrace kprobes
config: x86_64-randconfig-a003-20211227 (https://download.01.org/0day-ci/archive/20211228/202112280625.ZNZllxQ6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=a1974e6769e507428f52729967e6670a1548c239
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout a1974e6769e507428f52729967e6670a1548c239
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/trace/bpf_trace.c:14:
   include/linux/kprobes.h:76:21: error: field has incomplete type 'struct ftrace_ops'
                   struct ftrace_ops ops;
                                     ^
   include/linux/ftrace.h:332:8: note: forward declaration of 'struct ftrace_ops'
   struct ftrace_ops;
          ^
>> kernel/trace/bpf_trace.c:1032:22: error: implicit declaration of function 'kprobe_ftrace_multi_addr' [-Werror,-Wimplicit-function-declaration]
                   return (uintptr_t) kprobe_ftrace_multi_addr();
                                      ^
   kernel/trace/bpf_trace.c:1032:22: note: did you mean 'kprobe_ftrace_multi'?
   include/linux/kprobes.h:144:20: note: 'kprobe_ftrace_multi' declared here
   static inline bool kprobe_ftrace_multi(struct kprobe *p)
                      ^
   2 errors generated.


vim +/kprobe_ftrace_multi_addr +1032 kernel/trace/bpf_trace.c

  1024	
  1025	BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
  1026	{
  1027		struct kprobe *kp = kprobe_running();
  1028	
  1029		if (!kp)
  1030			return 0;
  1031		if (kprobe_ftrace_multi(kp))
> 1032			return (uintptr_t) kprobe_ftrace_multi_addr();
  1033		else
  1034			return (uintptr_t) kp->func_addr;
  1035	}
  1036	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
