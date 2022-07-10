Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7784B56D134
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:12:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CAC10551
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657483950; x=1689019950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DuvJKWQMOsOv4JHDhAPjJM6MbkGKUQVSg/N2L8HXuGA=;
  b=feZ3orZ+s8fsVv1T/HqYa4RoXYBtdxApo73UYSamWfarwb3opFhI5rGq
   no3Ad7d0XTJ+yBFW/6hPEc0VSaeWju+7qVyD73T+YLSORnl/WketFaNbS
   fO2D2dn+FyiJEBGfoZ5dDyRzXZ0kwwGkdMqkpEDmGIUIfzWqvLA8ziRef
   4U6KMHuEyubtVlj0iYNmy87em7X9ILc42usJXglj2pldhIRLkMpwQL34M
   sGtVLllpGZuWjY56XIN6S05P3HK3LIrcVd0nOSjVcK/hROUQhoOeoQwSA
   dmPf1nsNKI8ZdWZ4cGV3SQv37wo1HhzNbr9sUHb+9aBms2IqnwdORH5lQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282087549"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="282087549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 13:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="569534151"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2022 13:12:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAdI3-000QAi-5j;
        Sun, 10 Jul 2022 20:12:27 +0000
Date:   Mon, 11 Jul 2022 04:11:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_27 25/33] kernel/bpf/syscall.c:3145:2: error:
 call to undeclared function 'bpf_tramp_id_put'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202207110453.fdFb8WAD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_27
head:   08201713df8992b94d140b43fd4f20f1ad4aedb3
commit: 09c2a865c50223e0a31377f51bd567e5d5943e73 [25/33] bpf: Add support for tracing multi link
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220711/202207110453.fdFb8WAD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=09c2a865c50223e0a31377f51bd567e5d5943e73
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_27
        git checkout 09c2a865c50223e0a31377f51bd567e5d5943e73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c:2503:15: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           multi_func = is_tracing_multi(attr->expected_attach_type);
                        ^
   kernel/bpf/syscall.c:3137:15: error: call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
                        ^
>> kernel/bpf/syscall.c:3145:2: error: call to undeclared function 'bpf_tramp_id_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           bpf_tramp_id_put(tr_link->id);
           ^
   kernel/bpf/syscall.c:3145:2: note: did you mean 'bpf_trampoline_put'?
   include/linux/bpf.h:1013:20: note: 'bpf_trampoline_put' declared here
   static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
                      ^
   kernel/bpf/syscall.c:3308:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc(cnt);
                ^
   kernel/bpf/syscall.c:3308:5: warning: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc(cnt);
              ^ ~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:3349:8: error: call to undeclared function 'bpf_trampoline_multi_attach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = bpf_trampoline_multi_attach(&link->tp, id);
                 ^
   kernel/bpf/syscall.c:3349:8: note: did you mean 'bpf_tracing_multi_attach'?
   kernel/bpf/syscall.c:3293:12: note: 'bpf_tracing_multi_attach' declared here
   static int bpf_tracing_multi_attach(struct bpf_prog *prog,
              ^
   kernel/bpf/syscall.c:4821:12: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   else if (is_tracing_multi(prog->expected_attach_type))
                            ^
   1 warning and 6 errors generated.


vim +/bpf_tramp_id_put +3145 kernel/bpf/syscall.c

  3139	
  3140	static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
  3141	{
  3142		struct bpf_tracing_multi_link *tr_link =
  3143			container_of(link, struct bpf_tracing_multi_link, link);
  3144	
> 3145		bpf_tramp_id_put(tr_link->id);
  3146		kfree(tr_link);
  3147	}
  3148	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
