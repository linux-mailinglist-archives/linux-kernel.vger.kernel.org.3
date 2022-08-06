Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93958B4BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiHFJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHFJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:18:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7F13E02
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659777532; x=1691313532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+4jzH8uwkeuvghW0R6V47JMeju2qnevm/4nLRxxQ2hQ=;
  b=ZXipMx+qWy9U9aqXuddpZyeQvi/xREHlTZva7NBhBVhqWBzrUYk1CLqi
   OlO8tLEjdlQvXupxe2tQEqpygO4BuuoMtRqg5JIzMtgtqA56nUUj+twjU
   rK7xrePS2ZvUmz46SHvRE4j6IbnnVuo67ZrAEvQaslWkXT3r+tTdPdsfw
   sxiLmzX3aYTdRZSRBhbDW5C72Xo6GJ2D53oFWwrZaXTwSQxpvb8xpZZ99
   HiMUEH7vdp0YdDLk89porox903eai3ggbZCOh59xGZZQgcMJ+eiWug8NZ
   L3HOsoG0reo7jMf7HAkboUwHBS2oeI5kuCIfRgCM1FHyivpP83pEVYHin
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287917491"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="287917491"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 02:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="931502579"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2022 02:18:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKFxK-000KED-1t;
        Sat, 06 Aug 2022 09:18:50 +0000
Date:   Sat, 6 Aug 2022 17:18:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rui Wang <wangrui@loongson.cn>
Subject: [chenhuacai-loongson:loongarch-next 7/8]
 arch/loongarch/vdso/vgetcpu.c:27:5: warning: no previous prototype for
 '__vdso_getcpu'
Message-ID: <202208061729.Fvk2QdaS-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git loongarch-next
head:   2c25940dedb153b88fdd06c41bcfa78040383fbf
commit: b25f1337fbb7fa52c5da21c7a829c0f9a488026c [7/8] LoongArch: Add vDSO syscall __vdso_getcpu()
config: loongarch-randconfig-r015-20220805 (https://download.01.org/0day-ci/archive/20220806/202208061729.Fvk2QdaS-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/commit/?id=b25f1337fbb7fa52c5da21c7a829c0f9a488026c
        git remote add chenhuacai-loongson https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git
        git fetch --no-tags chenhuacai-loongson loongarch-next
        git checkout b25f1337fbb7fa52c5da21c7a829c0f9a488026c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/loongarch/vdso/vgetcpu.c:27:5: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
      27 | int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
         |     ^~~~~~~~~~~~~
--
   arch/loongarch/kernel/asm-offsets.c:16:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      16 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:63:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      63 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:75:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      75 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:91:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
      91 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:132:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     132 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:172:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     172 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:210:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     210 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:218:6: warning: no previous prototype for 'output_signal_defines' [-Wmissing-prototypes]
     218 | void output_signal_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c:256:6: warning: no previous prototype for 'output_smpboot_defines' [-Wmissing-prototypes]
     256 | void output_smpboot_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
   arch/loongarch/vdso/vgettimeofday.c:9:5: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
       9 | int __vdso_clock_gettime(clockid_t clock,
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/vdso/vgettimeofday.c:15:5: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
      15 | int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
         |     ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/vdso/vgettimeofday.c:21:5: warning: no previous prototype for '__vdso_clock_getres' [-Wmissing-prototypes]
      21 | int __vdso_clock_getres(clockid_t clock_id,
         |     ^~~~~~~~~~~~~~~~~~~
>> arch/loongarch/vdso/vgetcpu.c:27:5: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
      27 | int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
         |     ^~~~~~~~~~~~~


vim +/__vdso_getcpu +27 arch/loongarch/vdso/vgetcpu.c

    26	
  > 27	int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
