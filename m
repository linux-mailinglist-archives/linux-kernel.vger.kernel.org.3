Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA67545B87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbiFJFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243933AbiFJFSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:18:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66F3527E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654838283; x=1686374283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2uppYKBlCkbOS4RaY9vH3basVDJnUK0ivIxfR8Xn/j4=;
  b=iUAfCSzAmA0ClbL8auw35/WVqJIH+dltTWilALVrGOQN7n6gA7xmaFeE
   dLDZYdOeTuh+xEbHZqrlTyz6aurPtVHh53jX/QtXGDY+dFb1upWMpfOw9
   TPx24+wCTXr0GkjLlTG1p+lr31aOvPA3JWnyjoitd0NukePy/Kc8gTqgo
   DqBHIVaxkOTVX4QDH4dqKFbJtufkOjdNyThb1BIzplnMTAfpES6+Sk2UZ
   jDcywMPcJ/M7Gix80dwELvsC7UmOaZ4L/K9AhY5Ot/MTOygtV4WItwUNx
   d/8NCAv1mk7VlFA+9mC6jW6v83R7plIEpRbuK19wAvIxdjD0DCwNF0dxh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276290456"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276290456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 22:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="586017018"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 22:18:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzX21-000Gj3-7Y;
        Fri, 10 Jun 2022 05:18:01 +0000
Date:   Fri, 10 Jun 2022 13:17:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 45/52]
 arch/riscv/kernel/setup.c:268: undefined reference to `riscv_tlbflush_init'
Message-ID: <202206101303.u6fcumYC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: 3485f5450237db107c3601d2b726458fb98027a6 [45/52] riscv: Implement Zicbom-based cache management operations
config: riscv-randconfig-r025-20220608 (https://download.01.org/0day-ci/archive/20220610/202206101303.u6fcumYC-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/3485f5450237db107c3601d2b726458fb98027a6
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout 3485f5450237db107c3601d2b726458fb98027a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/kernel/setup.o: in function `setup_arch':
>> arch/riscv/kernel/setup.c:268: undefined reference to `riscv_tlbflush_init'
--
>> arch/riscv/mm/dma-noncoherent.c:65:6: warning: no previous prototype for 'riscv_init_cbom_blocksize' [-Wmissing-prototypes]
      65 | void riscv_init_cbom_blocksize(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +268 arch/riscv/kernel/setup.c

76d2a0493a17d4 Palmer Dabbelt  2017-07-10  264  
76d2a0493a17d4 Palmer Dabbelt  2017-07-10  265  void __init setup_arch(char **cmdline_p)
76d2a0493a17d4 Palmer Dabbelt  2017-07-10  266  {
8f3a2b4a96dc01 Anup Patel      2020-09-17  267  	parse_dtb();
723a42f4f6b2e0 Kefeng Wang     2021-07-07 @268  	setup_initial_init_mm(_stext, _etext, _edata, _end);
76d2a0493a17d4 Palmer Dabbelt  2017-07-10  269  
680f9b8e6c5641 Anup Patel      2019-01-07  270  	*cmdline_p = boot_command_line;
680f9b8e6c5641 Anup Patel      2019-01-07  271  
6262f661ff5d7d Atish Patra     2020-09-17  272  	early_ioremap_setup();
6134b110f97178 Anup Patel      2020-11-06  273  	jump_label_init();
680f9b8e6c5641 Anup Patel      2019-01-07  274  	parse_early_param();
680f9b8e6c5641 Anup Patel      2019-01-07  275  
b91540d52a08b6 Atish Patra     2020-09-17  276  	efi_init();
76d2a0493a17d4 Palmer Dabbelt  2017-07-10  277  	paging_init();
2d2682512f0faf Palmer Dabbelt  2020-04-14  278  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
2d2682512f0faf Palmer Dabbelt  2020-04-14  279  	unflatten_and_copy_device_tree();
2d2682512f0faf Palmer Dabbelt  2020-04-14  280  #else
44c922572952d8 Vitaly Wool     2021-04-13  281  	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
76d2a0493a17d4 Palmer Dabbelt  2017-07-10  282  		unflatten_device_tree();
8f3a2b4a96dc01 Anup Patel      2020-09-17  283  	else
8f3a2b4a96dc01 Anup Patel      2020-09-17  284  		pr_err("No DTB found in kernel mappings\n");
2d2682512f0faf Palmer Dabbelt  2020-04-14  285  #endif
cbd34f4bb37d62 Atish Patra     2020-11-18  286  	misc_mem_init();
51858aaf9bea3d Zong Li         2018-10-02  287  
e53d28180d4d0f Nick Kossifidis 2021-04-19  288  	init_resources();
62149f3564c5a5 Atish Patra     2020-11-04  289  	sbi_init();
62149f3564c5a5 Atish Patra     2020-11-04  290  

:::::: The code at line 268 was first introduced by commit
:::::: 723a42f4f6b2e032910885d389c6d9bdb0ef6eeb riscv: convert to setup_initial_init_mm()

:::::: TO: Kefeng Wang <wangkefeng.wang@huawei.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
