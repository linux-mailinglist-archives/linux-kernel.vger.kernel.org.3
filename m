Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A089B4D3CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiCIWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiCIWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:19:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597D119426
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646864317; x=1678400317;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LMYXIk4MjXMgXwTZBMBZP0Nx9oN/bI0jc1AhN9mqdNc=;
  b=N2h48pdL3Km2/gaIMhx87n5xRjo09kZGO1s4l6PPUNMt5FX6lF6hY1KN
   0vSjFXHehTpEzUf9YafchGkd3nKb/nczrLKCsqFvoMdAoM8tnd/pBb6Tw
   JY2xrGOCaODnTw340H0AoTre7ImlRM0PyxDLHPwUHfneQzNQBXimbIebG
   yhpNd8Jz/dYeCH19IK9iUrKfe9VR3nAEAlB4hZV0+89SPAdbE533xg7v3
   RqgXsLMrorDDEQdeCmE7mxFciPLnCe9Sba7QdtWZbSTNqbKvS6SewSoSy
   GFfaItS3vZ9r3+5z6xguDTVecx7lDCsjeSvsOXn3BZyT/8iCofTx6KcOC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="237272565"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="237272565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="496008917"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2022 14:18:36 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS4df-0003tJ-F0; Wed, 09 Mar 2022 22:18:35 +0000
Date:   Thu, 10 Mar 2022 06:17:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/kprobe_multi_4 6/11]
 kernel/trace/bpf_trace.c:1058:64: error: 'struct pt_regs' has no member
 named 'ip'; did you mean 'sp'?
Message-ID: <202203100634.hZ3lL2Gt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/kprobe_multi_4
head:   02731d567ee31d7c7f012e9c5930f114ed1e2478
commit: 651116687aeb66c22fec5e59d02674e66c0f2587 [6/11] bpf: Add cookie support to programs attached with kprobe multi link
config: riscv-randconfig-s032-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100634.hZ3lL2Gt-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=651116687aeb66c22fec5e59d02674e66c0f2587
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/kprobe_multi_4
        git checkout 651116687aeb66c22fec5e59d02674e66c0f2587
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/bpf_trace.c: In function '____bpf_get_attach_cookie_kprobe_multi':
>> kernel/trace/bpf_trace.c:1058:64: error: 'struct pt_regs' has no member named 'ip'; did you mean 'sp'?
    1058 |         return bpf_kprobe_multi_cookie(current->bpf_ctx, regs->ip);
         |                                                                ^~
         |                                                                sp
   kernel/trace/bpf_trace.c:1059:1: error: control reaches end of non-void function [-Werror=return-type]
    1059 | }
         | ^
   cc1: some warnings being treated as errors


vim +1058 kernel/trace/bpf_trace.c

  1055	
  1056	BPF_CALL_1(bpf_get_attach_cookie_kprobe_multi, struct pt_regs *, regs)
  1057	{
> 1058		return bpf_kprobe_multi_cookie(current->bpf_ctx, regs->ip);
  1059	}
  1060	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
