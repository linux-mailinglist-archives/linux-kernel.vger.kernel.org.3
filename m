Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC07C4DC826
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiCQOBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiCQOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:01:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC031E31B6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647525614; x=1679061614;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sJRlwBorGmVgUb+Bjz+/sge3lqbo3wi9zXszNB/osmk=;
  b=YgnEPWZJUI/1T9O/ko0E+N4p3Yym1FFjH/XSD35jXK2Ya/iGAu8Qsyf6
   ssykuy4rtfYSJ8pt/rD72BHDoZdjdq77QuDX1GVdhS5g4SmabqSQKtvQW
   VA3uvDEZQ7IUO4ZZdc7FoInaiI0hiRKzaZM9UR4MlXXB+clcKr30mrlOS
   OSSArtCs9jtIHfV9as1NGIm5tuTP0ljdJdeMRAJQ8L8DSco5ihkX2zRu3
   RWBOfKhxowZBdRexPqtUY0Mdumlt3aZJitJcOBJqqvWNhGaGKRZ3/38G3
   EdJhAJKhacESp1JQr5PGj08ZMLAO3l9kZCubWs8mgtNonk+8Ek+9s7nwZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254428220"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254428220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="513435502"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Mar 2022 07:00:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUqfj-000Djk-6q; Thu, 17 Mar 2022 14:00:11 +0000
Date:   Thu, 17 Mar 2022 21:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 413/2335] kernel/bpf/core.c:62:6: warning: no
 previous prototype for function 'bpf_jit_dump'
Message-ID: <202203172148.CqeOGiiE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220317/202203172148.CqeOGiiE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=13afaa4b6ebba9ee9365fa7688a8d7f3fff97749
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 13afaa4b6ebba9ee9365fa7688a8d7f3fff97749
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/entry/vsyscall/ arch/x86/kernel/cpu/mtrr/ arch/x86/pci/ kernel/bpf/ kernel/trace/ lib/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:62:6: warning: no previous prototype for function 'bpf_jit_dump' [-Wmissing-prototypes]
   void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
        ^
   kernel/bpf/core.c:62:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
   ^
   static 
   kernel/bpf/core.c:1378:12: warning: no previous prototype for function 'bpf_probe_read_kernel' [-Wmissing-prototypes]
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
              ^
   kernel/bpf/core.c:1378:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
   ^
   static 
   2 warnings generated.


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
