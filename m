Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3EF567CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiGFD7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiGFD7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:59:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E8B1E3FB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657079977; x=1688615977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zhVfnI9C1A/6wqEdz1fBtht+ISwAyqH/ESJAK7cY2kY=;
  b=Uk1RDTkQ4hSS9p328B7BU0EHmX/SVVpPWBeyiMom5uY9urPYI2g+PXR8
   +PmRCFQ4/hDyfEHLlVteC2mq0Wc6filVXNkJAwivgomG91khSqjxYKzsj
   amQfut1rVviQ72/DOlAsVbxu+9h2AlnOvyVJvhREhSlsRFlgE6Fvpd0uB
   I9b/EKWSEpgtSujAMlHj+mp+kwa2Cu7jpu8W4rBBpMowr7nqEker+DlXW
   m+sVGWon18VeKsHXULef9Pq/i69azEYrRw+GWrk/tkk04cBBmYL753BjE
   2VePQM3/mKQRwdRrTJ1ErqlWzPBt1FWTCbiNRNd/qrxx/CXzGCFpYrncG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272418186"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272418186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="625709060"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2022 20:59:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8wC9-000JyT-Il;
        Wed, 06 Jul 2022 03:59:21 +0000
Date:   Wed, 6 Jul 2022 11:58:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 21/21] kernel/bpf/syscall.c:3137:22: error:
 implicit declaration of function 'bpf_trampoline_multi_detach'
Message-ID: <202207061138.sopuGQ2w-lkp@intel.com>
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220706/202207061138.sopuGQ2w-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1d891c46bb689a24985cea58f4eddb053d6b1331
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout 1d891c46bb689a24985cea58f4eddb053d6b1331
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/cpumask.h:14,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from kernel/bpf/syscall.c:4:
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_release':
>> kernel/bpf/syscall.c:3137:22: error: implicit declaration of function 'bpf_trampoline_multi_detach' [-Werror=implicit-function-declaration]
    3137 |         WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_attach':
   kernel/bpf/syscall.c:3307:14: error: implicit declaration of function 'bpf_tramp_id_alloc'; did you mean 'bpf_tramp_id_resolve'? [-Werror=implicit-function-declaration]
    3307 |         id = bpf_tramp_id_alloc(cnt);
         |              ^~~~~~~~~~~~~~~~~~
         |              bpf_tramp_id_resolve
   kernel/bpf/syscall.c:3307:12: warning: assignment to 'struct bpf_tramp_id *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3307 |         id = bpf_tramp_id_alloc(cnt);
         |            ^
>> kernel/bpf/syscall.c:3348:15: error: implicit declaration of function 'bpf_trampoline_multi_attach'; did you mean 'bpf_tracing_multi_attach'? [-Werror=implicit-function-declaration]
    3348 |         err = bpf_trampoline_multi_attach(&link->tp, id);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               bpf_tracing_multi_attach
   cc1: some warnings being treated as errors


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
