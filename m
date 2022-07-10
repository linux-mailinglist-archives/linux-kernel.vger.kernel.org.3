Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA72056D11A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGJTl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:41:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17C12AC9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657482086; x=1689018086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OLLSePAlcksAVoSxv2ud3tiGxluhBiH6TPyR5x8FGnI=;
  b=cVKIh4qH1UyjJT5uJDaiuxxAjlFSIjaTQJQ4naVvEiRg0r2SBVTPikxn
   D03ZX9Nrq3B4ArXjJDK0k4mViy+yDI3LX9fgUHhxlh0Oe8eF9TvuNegM4
   UWHZmy1SzdiDWZL6mjOcTW3yNAFjLRroQGFpKI9qYSospNV9+06dq65AU
   kcZqESiIjer3i3w1XUvFtx7W3E/R3fB8kOfGtF4my5+kreF4Ofjg5AF3O
   wmRKQL68DTp3g2ySm1wn9MOKsBv7y9xqrVbsAE1Tb4PXG9Mqf5YygxVBr
   XwSPicb9eizTxwnJHyn3Qy8ZZQpX3IUwbTWGul+8zFkuCZapG5432w91g
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284556423"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="284556423"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 12:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="684175141"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2022 12:41:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAco0-000Q96-H3;
        Sun, 10 Jul 2022 19:41:24 +0000
Date:   Mon, 11 Jul 2022 03:40:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_27 25/33] kernel/bpf/syscall.c:3145:9: error:
 implicit declaration of function 'bpf_tramp_id_put'; did you mean
 'bpf_trampoline_put'?
Message-ID: <202207110306.PVeAPeww-lkp@intel.com>
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220711/202207110306.PVeAPeww-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=09c2a865c50223e0a31377f51bd567e5d5943e73
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_27
        git checkout 09c2a865c50223e0a31377f51bd567e5d5943e73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_load':
   kernel/bpf/syscall.c:2503:22: error: implicit declaration of function 'is_tracing_multi' [-Werror=implicit-function-declaration]
    2503 |         multi_func = is_tracing_multi(attr->expected_attach_type);
         |                      ^~~~~~~~~~~~~~~~
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
   kernel/bpf/syscall.c:3137:22: error: implicit declaration of function 'bpf_trampoline_multi_detach' [-Werror=implicit-function-declaration]
    3137 |         WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->tp, tr_link->id));
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_link_dealloc':
>> kernel/bpf/syscall.c:3145:9: error: implicit declaration of function 'bpf_tramp_id_put'; did you mean 'bpf_trampoline_put'? [-Werror=implicit-function-declaration]
    3145 |         bpf_tramp_id_put(tr_link->id);
         |         ^~~~~~~~~~~~~~~~
         |         bpf_trampoline_put
   kernel/bpf/syscall.c: In function 'bpf_tracing_multi_attach':
   kernel/bpf/syscall.c:3308:14: error: implicit declaration of function 'bpf_tramp_id_alloc'; did you mean 'bpf_tramp_id_resolve'? [-Werror=implicit-function-declaration]
    3308 |         id = bpf_tramp_id_alloc(cnt);
         |              ^~~~~~~~~~~~~~~~~~
         |              bpf_tramp_id_resolve
   kernel/bpf/syscall.c:3308:12: warning: assignment to 'struct bpf_tramp_id *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3308 |         id = bpf_tramp_id_alloc(cnt);
         |            ^
   kernel/bpf/syscall.c:3349:15: error: implicit declaration of function 'bpf_trampoline_multi_attach'; did you mean 'bpf_tracing_multi_attach'? [-Werror=implicit-function-declaration]
    3349 |         err = bpf_trampoline_multi_attach(&link->tp, id);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               bpf_tracing_multi_attach
   cc1: some warnings being treated as errors


vim +3145 kernel/bpf/syscall.c

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
