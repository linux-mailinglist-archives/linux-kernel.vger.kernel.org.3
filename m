Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31292526D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiEMXnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiEMXnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:43:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44327357FBD;
        Fri, 13 May 2022 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652484747; x=1684020747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FCrz6FYGGtdt+XMMNM0b9J3ZxN7NlsNQNnoSDhr74C4=;
  b=Z735PrAMnJfx90DSGGlbAxcaSfvBK4ajujT2xi/SdLs0XdjFbvoS2gbr
   9Xq8RPqwlb/t5p6OX6G28UBNDu2aDHmgyBvbLGFFGmmCtwm8kF1FIaDRs
   bZMTlWfXYl8Ft6RdDs+rk1FLOsonFZdBXrC1r7LQxVB2HxdDuGIIZvcKk
   VnPiZ8F2qDc93xmLbrngJPfAhY9mgs4nBHneZm1YGcZxIdhHk1+gbJD/J
   LRch2ms9blcR7PPGXNOq4iKvZ08tBN/qbChG1bDZNExn/9fR8hLC8HNcL
   2E+Yk1NEdsGsdG66wkxDFwBqmyiZtLmsnKf4EkcRQBealg0rIRE6L05JA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270566852"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270566852"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="554426409"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2022 16:32:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npelj-000MDY-N7;
        Fri, 13 May 2022 23:32:23 +0000
Date:   Sat, 14 May 2022 07:31:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] kbuild: copy scripts/atomic/atomic-*.h to
 include/generated/atomic-*.h
Message-ID: <202205140754.YHGZFvAQ-lkp@intel.com>
References: <20220513185340.239753-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513185340.239753-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on linux/master linus/master v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-copy-scripts-atomic-atomic-h-to-include-generated-atomic-h/20220514-025623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220514/202205140754.YHGZFvAQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3f6dd60121830fdd3733dd804d9ae163d88acc98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-copy-scripts-atomic-atomic-h-to-include-generated-atomic-h/20220514-025623
        git checkout 3f6dd60121830fdd3733dd804d9ae163d88acc98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      17 | void foo(void)
         |      ^~~
   In file included from include/linux/atomic.h:80,
                    from include/linux/jump_label.h:256,
                    from arch/x86/include/asm/string_64.h:6,
                    from arch/x86/include/asm/string.h:5,
                    from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from scripts/mod/devicetable-offsets.c:3:
>> include/linux/atomic/atomic-arch-fallback.h:2:10: fatal error: generated/atomic-arch-fallback.h: No such file or directory
       2 | #include <generated/atomic-arch-fallback.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +2 include/linux/atomic/atomic-arch-fallback.h

   > 2	#include <generated/atomic-arch-fallback.h>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
