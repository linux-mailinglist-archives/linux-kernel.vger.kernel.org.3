Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE95158E2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380878AbiD2XTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiD2XTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:19:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70048AAB6E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651274187; x=1682810187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xWrXkKzBxHzI98Sn3SC8uAd/QSmRGGEC5NdLnY/Ai4s=;
  b=TYAoSmpxzKfzHOXnQbAo/LHsp0AZSrV1CaOQohsoabN9qDspYZf8qI9E
   PTWJ6T1BNJv50iE1R/THCp0UNMcSKJHkQT4Z3yuPQglB099Dks5jsH3HB
   UexmLnyoSmOOhyFdAvrOmTX/CXgxZOnNTNu7z/B1SS0Eh2Dr/6zV0/vXc
   XFLcCfkWCUBqyjYQhBmrXY/WmlxFoveigczdU+JiE+SyJIh/7PpOyFB/o
   hvPxfG8DO5gBY23XZHZZXoTwIh7jXfL6OagVXP+wtbRysQx7RE1m0e36R
   P2eyGpROQKWlcezdeVsGnf0kDs3bvdzNj2wnLSaNHkm/aw70QVYdxZ/TA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="329744912"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="329744912"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 16:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="685610590"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2022 16:16:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkZqa-0006fr-N1;
        Fri, 29 Apr 2022 23:16:24 +0000
Date:   Sat, 30 Apr 2022 07:15:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/per-callsite-ops 4/6]
 include/acpi/actypes.h:525:42: warning: 'strncpy' specified bound 4 equals
 destination size
Message-ID: <202204300707.nx8b88Lb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
head:   2aaba224d039a36f7eca5ad68c77686d3546e4fa
commit: be98798b102a3e28fa0832c9c0473f42e14abe8b [4/6] HACK: arm64: ftrace: align pre-function literal pool
config: ia64-gensparse_defconfig (https://download.01.org/0day-ci/archive/20220430/202204300707.nx8b88Lb-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=be98798b102a3e28fa0832c9c0473f42e14abe8b
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/per-callsite-ops
        git checkout be98798b102a3e28fa0832c9c0473f42e14abe8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/acpi/acpica/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/acpi/acpi.h:24,
                    from drivers/acpi/acpica/tbfind.c:10:
   drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
>> include/acpi/actypes.h:525:42: warning: 'strncpy' specified bound 4 equals destination size [-Wstringop-truncation]
     525 | #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpica/tbfind.c:59:9: note: in expansion of macro 'ACPI_COPY_NAMESEG'
      59 |         ACPI_COPY_NAMESEG(header.signature, signature);
         |         ^~~~~~~~~~~~~~~~~
--
   In file included from include/acpi/acpi.h:24,
                    from drivers/acpi/acpica/utstring.c:8:
   drivers/acpi/acpica/utstring.c: In function 'acpi_ut_repair_name':
>> include/acpi/actypes.h:525:42: warning: 'strncpy' specified bound 4 equals destination size [-Wstringop-truncation]
     525 | #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpica/utstring.c:148:9: note: in expansion of macro 'ACPI_COPY_NAMESEG'
     148 |         ACPI_COPY_NAMESEG(&original_name, name);
         |         ^~~~~~~~~~~~~~~~~


vim +/strncpy +525 include/acpi/actypes.h

ff60027174cf94b Bob Moore 2012-10-31  519  
50df4d8b0f6e197 Bob Moore 2008-12-31  520  #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
5599fb69355d7a5 Bob Moore 2019-04-08  521  #define ACPI_COMPARE_NAMESEG(a,b)       (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
a3ce7a8e0dd9baa Bob Moore 2019-04-08  522  #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
50df4d8b0f6e197 Bob Moore 2008-12-31  523  #else
3278675567dfb90 Bob Moore 2019-04-08  524  #define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAMESEG_SIZE))
3278675567dfb90 Bob Moore 2019-04-08 @525  #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
50df4d8b0f6e197 Bob Moore 2008-12-31  526  #endif
50df4d8b0f6e197 Bob Moore 2008-12-31  527  

:::::: The code at line 525 was first introduced by commit
:::::: 3278675567dfb901d831d46849c386a4f932905e ACPICA: Rename nameseg length macro/define for clarity

:::::: TO: Bob Moore <robert.moore@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
