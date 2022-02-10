Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418D4B192C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbiBJXLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:11:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345101AbiBJXLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:11:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C359266C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644534679; x=1676070679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1DcXpIvfkdXgEoN4gqoOn2laBEN3YOEBZFpUnim6c7Y=;
  b=K82gKaOUJbhBpjbe+LKFGLCB8KPdXCDXdgNSuB0C6X12SJZj2mF0UwhB
   hIgGjNXc8FnqZ9JndM8iWrD9C1QZXWH+3MrMjfXtLx4biEX3KziAcCJyv
   +T4DWbxAV6gHRoMr72fES4AHgEPrDxq8xYcQaIfMNMn7Vh6RsVIFgpxop
   w3z4SWeL7rQY4rFRH1XZo4iSrIMdR8DSmfw9m1gGR/W4OfrlyR5qTpcoY
   AT4jcq5+wSPmL/ix7l7L9FkleyrhPBuSml5Yx3gAC0NmaaYEZV1hdJUR0
   F51NUi5Md4qNU92PHMbLXKT14w3G3HfCektdNY7SEjzEz6CMCbmvuFrOo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="237016209"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="237016209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701881449"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 15:11:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIIaq-0003rs-IE; Thu, 10 Feb 2022 23:11:16 +0000
Date:   Fri, 11 Feb 2022 07:10:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 41/56]
 powerpc64-linux-ld: arch/powerpc/kernel/trace/ftrace.o:undefined reference
 to `_mcount'
Message-ID: <202202110717.hZrWu55Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   14cc509e7b686ce5db7175d0fb084cacae046d96
commit: 3a1a8f078670c24a1c0c7fef172ea5c0e2385b61 [41/56] powerpc/ftrace: Remove ftrace_32.S
config: powerpc64-randconfig-r012-20220210 (https://download.01.org/0day-ci/archive/20220211/202202110717.hZrWu55Z-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/3a1a8f078670c24a1c0c7fef172ea5c0e2385b61
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout 3a1a8f078670c24a1c0c7fef172ea5c0e2385b61
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/i2c/busses/i2c-pasemi-core.o' being placed in section `.stubs'
   powerpc64-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/i2c/busses/i2c-pasemi-core.o' being placed in section `.ftrace.tramp'
   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `_mcount'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: init/main.o: in function `.__traceiter_initcall_level':
>> (.text+0x18): undefined reference to `._mcount'
   powerpc64-linux-ld: init/main.o: in function `.__traceiter_initcall_start':
   (.text+0x88): undefined reference to `._mcount'
   powerpc64-linux-ld: init/main.o: in function `.__traceiter_initcall_finish':
   (.text+0xf4): undefined reference to `._mcount'
   powerpc64-linux-ld: init/main.o: in function `.trace_initcall_finish_cb':
>> main.c:(.text+0x16c): undefined reference to `._mcount'
   powerpc64-linux-ld: init/main.o: in function `.initcall_blacklisted':
   main.c:(.text+0x4cc): undefined reference to `._mcount'
   powerpc64-linux-ld: init/main.o:(.text+0x5bc): more undefined references to `._mcount' follow
>> powerpc64-linux-ld: arch/powerpc/kernel/trace/ftrace.o:(.toc+0x0): undefined reference to `_mcount'
>> powerpc64-linux-ld: arch/powerpc/kernel/trace/ftrace.o:(.toc+0x8): undefined reference to `ftrace_tramp_text'
>> powerpc64-linux-ld: arch/powerpc/kernel/trace/ftrace.o:(.toc+0x10): undefined reference to `ftrace_tramp_init'
   powerpc64-linux-ld: arch/powerpc/kernel/iomap.o: in function `.ioport_map':
   (.text+0x14): undefined reference to `._mcount'
   powerpc64-linux-ld: arch/powerpc/kernel/iomap.o: in function `.pci_iounmap':
   (.text+0x48): undefined reference to `._mcount'
   powerpc64-linux-ld: arch/powerpc/kernel/compat_audit.o: in function `.ppc32_classify_syscall':
>> compat_audit.c:(.text+0x14): undefined reference to `._mcount'
   powerpc64-linux-ld: arch/powerpc/mm/fault.o: in function `.__bad_area_nosemaphore':
>> fault.c:(.text+0x5c): undefined reference to `._mcount'
   powerpc64-linux-ld: arch/powerpc/mm/fault.o: in function `.bad_area_nosemaphore':
   fault.c:(.text+0xb0): undefined reference to `._mcount'
   powerpc64-linux-ld: arch/powerpc/mm/fault.o:fault.c:(.text+0x2bc): more undefined references to `._mcount' follow
>> powerpc64-linux-ld: kernel/trace/ftrace.o:(.toc+0x0): undefined reference to `_mcount'
   powerpc64-linux-ld: kernel/bpf/core.o: in function `.bpf_adj_delta_to_imm':
>> core.c:(.text+0x24): undefined reference to `._mcount'
   powerpc64-linux-ld: kernel/bpf/core.o: in function `.bpf_adj_branches':
   core.c:(.text+0xdc): undefined reference to `._mcount'
   powerpc64-linux-ld: kernel/bpf/core.o: in function `.__bpf_call_base':
   (.text+0x250): undefined reference to `._mcount'
   powerpc64-linux-ld: kernel/bpf/core.o: in function `.__bpf_prog_ret1':
   core.c:(.text+0x278): undefined reference to `._mcount'
   powerpc64-linux-ld: kernel/bpf/core.o: in function `.bpf_prog_array_copy_core':
   core.c:(.text+0x2ac): undefined reference to `._mcount'
   powerpc64-linux-ld: kernel/bpf/core.o:(.text+0x31c): more undefined references to `._mcount' follow
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pasemi-core.o:(.toc+0x0): undefined reference to `__this_module'
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pasemi-platform.o: in function `.pasemi_platform_i2c_remove':
>> i2c-pasemi-platform.c:(.text+0xc): undefined reference to `._mcount'
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pasemi-platform.o: in function `.pasemi_platform_i2c_probe':
   i2c-pasemi-platform.c:(.text+0x44): undefined reference to `._mcount'
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pasemi-platform.o: in function `.pasemi_platform_i2c_driver_init':
>> i2c-pasemi-platform.c:(.init.text+0x14): undefined reference to `._mcount'
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pca-platform.o: in function `.i2c_pca_pf_readbyte8':
>> i2c-pca-platform.c:(.text+0x34): undefined reference to `._mcount'
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pca-platform.o: in function `.i2c_pca_pf_readbyte16':
   i2c-pca-platform.c:(.text+0x70): undefined reference to `._mcount'
   powerpc64-linux-ld: drivers/i2c/busses/i2c-pca-platform.o:i2c-pca-platform.c:(.text+0xb4): more undefined references to `._mcount' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
