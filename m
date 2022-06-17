Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF254FC46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382675AbiFQRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiFQRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:36:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2134338B0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655487365; x=1687023365;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lA5mdH0BpFlRdgsECKtZzk+FKp3pXBuHL20fQbsJFYM=;
  b=kJjc2p0Zl8l7gGu0gAmefm5zGW9t0HsrEGn6HhOZ2mOdrHLKmJtWY+GB
   cRE0f4utOOjKdcL3FZr2AQNmGEkZoE0GPSA1fiwe+LqBKsAkV+4zWbqEm
   Pt4wC54tFXm6FG+usasOyQxzhTnVsqHY9E4jsDJqSqdnqX7IafWVEq7wh
   7ur1FJKq5f9tS3xYcP462joFzkCM101FVHLdzA46jOIrVLLGz3AwdOzmb
   0eyKPH0D1yTo8Vuhxgcd9qiIxw6vjktKcNIDwbDzuUo3213G0Fg8p5XFd
   hLLxhh3s41FAHknUXELsnEvO2/YUzpTRx/tPHmUQtt7VT3s066KKwe4oD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280249940"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280249940"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 08:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584057467"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2022 08:55:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2EK1-000PZB-Hi;
        Fri, 17 Jun 2022 15:55:45 +0000
Date:   Fri, 17 Jun 2022 23:55:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Brian Norris <briannorris@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14 8447/9354] kernel/panic.c:591:6:
 warning: no previous declaration for '__warn_printk'
Message-ID: <202206172352.f6AzDAj9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: c4256ec7a28ebcf4371230422dceae6befc40836 [8447/9354] UPSTREAM: bug: fix "cut here" location for __WARN_TAINT architectures
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220617/202206172352.f6AzDAj9-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/c4256ec7a28ebcf4371230422dceae6befc40836
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout c4256ec7a28ebcf4371230422dceae6befc40836
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/panic.c:61:13: warning: no previous declaration for 'panic_smp_self_stop' [-Wmissing-declarations]
    void __weak panic_smp_self_stop(void)
                ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:71:13: warning: no previous declaration for 'nmi_panic_self_stop' [-Wmissing-declarations]
    void __weak nmi_panic_self_stop(struct pt_regs *regs)
                ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:82:13: warning: no previous declaration for 'crash_smp_send_stop' [-Wmissing-declarations]
    void __weak crash_smp_send_stop(void)
                ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:516:6: warning: no previous declaration for '__warn' [-Wmissing-declarations]
    void __warn(const char *file, int line, void *caller, unsigned taint,
         ^~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:533:3: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      vprintk(args->fmt, args->args);
      ^~~~~~~
   kernel/panic.c: At top level:
>> kernel/panic.c:591:6: warning: no previous declaration for '__warn_printk' [-Wmissing-declarations]
    void __warn_printk(const char *fmt, ...)
         ^~~~~~~~~~~~~
   kernel/panic.c: In function '__warn_printk':
   kernel/panic.c:598:2: warning: function '__warn_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     vprintk(fmt, args);
     ^~~~~~~


vim +/__warn_printk +591 kernel/panic.c

   583	
   584	void warn_slowpath_null(const char *file, int line)
   585	{
   586		pr_warn(CUT_HERE);
   587		__warn(file, line, __builtin_return_address(0), TAINT_WARN, NULL, NULL);
   588	}
   589	EXPORT_SYMBOL(warn_slowpath_null);
   590	#else
 > 591	void __warn_printk(const char *fmt, ...)
   592	{
   593		va_list args;
   594	
   595		pr_warn(CUT_HERE);
   596	
   597		va_start(args, fmt);
   598		vprintk(fmt, args);
   599		va_end(args);
   600	}
   601	EXPORT_SYMBOL(__warn_printk);
   602	#endif
   603	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
