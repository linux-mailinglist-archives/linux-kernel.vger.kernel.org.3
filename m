Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65A44DB99A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356490AbiCPUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiCPUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:42:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1FDE8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647463252; x=1678999252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r19zuMYqIMDnuCyWOijWhVUayxbhysyUD/iRsXuP/6c=;
  b=VhEJTna/N+pghJJF8CbFvJ00Jq0ztYTK+4svFLj0jhsmBX08bJCZF7tG
   hM/QRij7HGAmY0Kri6k2XmbYOOr5oEEFdZqJRKK4abR4Ewy7cmvpFnqNq
   LbmW8r0fVWUKXnVALA5wjZeP55fSBPaPmvPHHAIfes96nYk5vcpTRPwmZ
   KKdMcftkpw++DItNLVNRXo8jLwjHrA5iZhLOZFXfw4/BrZkgza6o003jL
   NnlHhLMXaLXJ0rlUx+lmRtjAeAmMO3L5W4GVQUBVj8ocwQ32VjiPjLgDP
   esZzkKgNzwCmcGnEfCMshGCea4MsqXTGeM2/CdgGtW3TJFVpHCMXTenWM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255538002"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255538002"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516489395"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 13:40:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUaRY-000CtU-Ud; Wed, 16 Mar 2022 20:40:28 +0000
Date:   Thu, 17 Mar 2022 04:39:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 413/2335] kernel/bpf/core.c:62:6: warning: no
 previous prototype for 'bpf_jit_dump'
Message-ID: <202203170410.uapuR37c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 13afaa4b6ebba9ee9365fa7688a8d7f3fff97749 [413/2335] headers/uninline: Uninline multi-use function: bpf_jit_dump()
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170410.uapuR37c-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=13afaa4b6ebba9ee9365fa7688a8d7f3fff97749
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 13afaa4b6ebba9ee9365fa7688a8d7f3fff97749
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/pci/ kernel/bpf/ kernel/trace/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:62:6: warning: no previous prototype for 'bpf_jit_dump' [-Wmissing-prototypes]
      62 | void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
         |      ^~~~~~~~~~~~
   kernel/bpf/core.c:1378:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1378 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/bpf_jit_dump +62 kernel/bpf/core.c

    61	
  > 62	void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
    63	{
    64		pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
    65		       proglen, pass, image, current->comm, task_pid_nr(current));
    66	
    67		if (image)
    68			print_hex_dump(KERN_ERR, "JIT code: ", DUMP_PREFIX_OFFSET,
    69				       16, 1, image, proglen, false);
    70	}
    71	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
