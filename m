Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF838567CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiGFDud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiGFDt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:49:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887FAE4A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657079304; x=1688615304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BB74kNCn1H0ZUogSQH8rxo8EKrnpqfYmnsJGGMCkQ2o=;
  b=QpuUoAnv8l3wjTA7i0YIwG6EaPCKdlDMx66jAP2wTowrg+5VuYK6uvrm
   s56TJeETI7pG0Cpl0ybjBLc+JSU6I2cD8BQMT33+2oVyv6KyaYpFabvr2
   zHATD6HfDdyhzmjoyVJZNmtR6CWGARndBmJp5tH/aQCniPLtUV0tDKkGM
   N+mP7IyBi8Tm1DuRhOG0Li4HY8YGa5sjpEuiaytyABLqukPnoNCag8kME
   wl84U/1f0PGSIw0oLOfPHjhLCOeVQ2p6CXuCZChfBMfxuiSZUk025GeXM
   FkV1PVVlygDgx4iJ69ilvrIHajA6Q4F2gBm4Pg8NX1goR/rBuTsS561Dj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284368327"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284368327"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="919977049"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 20:48:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8w1V-000JyD-Cd;
        Wed, 06 Jul 2022 03:48:21 +0000
Date:   Wed, 6 Jul 2022 11:48:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 21/21] kernel/bpf/syscall.c:3137:15: error:
 call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later
 do not support implicit function declarations
Message-ID: <202207061102.sgu5KQzw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: 1d891c46bb689a24985cea58f4eddb053d6b1331 [21/21] bpf: Add support to attach multi trampolines
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220706/202207061102.sgu5KQzw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 142aca7741d5b06207e87bf4880fbe308c8d6823)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1d891c46bb689a24985cea58f4eddb053d6b1331
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout 1d891c46bb689a24985cea58f4eddb053d6b1331
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/syscall.c:3137:15: error: call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
                        ^
   kernel/bpf/syscall.c:3307:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc(cnt);
                ^
   kernel/bpf/syscall.c:3307:5: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc(cnt);
              ^ ~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/syscall.c:3348:8: error: call to undeclared function 'bpf_trampoline_multi_attach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = bpf_trampoline_multi_attach(&link->tp, id);
                 ^
   kernel/bpf/syscall.c:3348:8: note: did you mean 'bpf_tracing_multi_attach'?
   kernel/bpf/syscall.c:3292:12: note: 'bpf_tracing_multi_attach' declared here
   static int bpf_tracing_multi_attach(struct bpf_prog *prog,
              ^
   1 warning and 3 errors generated.


vim +/bpf_trampoline_multi_detach +3137 kernel/bpf/syscall.c

  3131	
  3132	static void bpf_tracing_multi_link_release(struct bpf_link *link)
  3133	{
  3134		struct bpf_tracing_multi_link *tr_link =
  3135			container_of(link, struct bpf_tracing_multi_link, link);
  3136	
> 3137		WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
  3138	}
  3139	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
