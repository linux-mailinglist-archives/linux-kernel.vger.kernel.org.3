Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725414804E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 22:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhL0VXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 16:23:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:22225 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhL0VXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 16:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640640219; x=1672176219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IVYymYxM9fZnyNSLXRb2FO9QLm87mN74CTshC/jzBeo=;
  b=PQIbnWQM/oTEkuLvRge658U1ewsXNAugeqKf/oQpNA3Y9kGfRjTAUFfT
   YDFYgu7JsrjOKlWIeU11NrlLO4U0uEg0Ihm1D4hwG8TxT3NAVLMM6pFcJ
   yZqsipSHn4ok8I+2ftD97Rz1bKUP1uWh15XQsivWw69Qk0R409SybgdNT
   RHqnBpA5FDMXEbJ/EYNXEwTqqjROs3T3rV6feazXIly+yRjmTHpWPaItq
   XxNNTDmGDW/UQom5gV1Ot8kMBn7HifeZu4rF84kECOWrZmDXFSmJLFiOJ
   cazsshap34odOhpgWxOayD0TJwKmwrou2YPH3yEWNAGD6JWC9CfOMRk0S
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="221270888"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="221270888"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 13:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="509971991"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Dec 2021 13:23:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1xSz-0006sH-CN; Mon, 27 Dec 2021 21:23:37 +0000
Date:   Tue, 28 Dec 2021 05:23:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 6/13] kernel/trace/bpf_trace.c:1032:22:
 error: implicit declaration of function 'kprobe_ftrace_multi_addr'; did you
 mean 'kprobe_ftrace_multi'?
Message-ID: <202112280519.3qcLUyCw-lkp@intel.com>
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
config: i386-randconfig-a016-20211227 (https://download.01.org/0day-ci/archive/20211228/202112280519.3qcLUyCw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=a1974e6769e507428f52729967e6670a1548c239
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout a1974e6769e507428f52729967e6670a1548c239
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function '____bpf_get_func_ip_kprobe':
>> kernel/trace/bpf_trace.c:1032:22: error: implicit declaration of function 'kprobe_ftrace_multi_addr'; did you mean 'kprobe_ftrace_multi'? [-Werror=implicit-function-declaration]
    1032 |   return (uintptr_t) kprobe_ftrace_multi_addr();
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
         |                      kprobe_ftrace_multi
   cc1: some warnings being treated as errors


vim +1032 kernel/trace/bpf_trace.c

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
