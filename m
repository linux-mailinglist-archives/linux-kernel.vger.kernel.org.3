Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FB53EE95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiFFT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiFFT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:26:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2872F02C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654543588; x=1686079588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I59ZioF6ftkeKF9BWFVRlPxcwwrWxaAGZj/i74sOpGo=;
  b=J3Y09+dhdm6r+4XkMuNJRQJSqz9G/HUUZRnAqUsTbWSUklwfddg97ea/
   0b02bdKhe91ZAfdm9zWdaHOeOtPVbn2EO0LgDEa8w4K6toFyHGr8bnfMi
   LOiEgEhBINaTZU9YRWdnv2JR/IcHGXw3pXXaoVowMLv0pDG/7/ps+mxyP
   ZdXHfPby4nhwfOZ029JqH87dWebRJr5BH6OAcclLaaaK8Yq9zhcLZTOuX
   9PgCiRQRrlxTn4xS4YCy+DDV5tkcg2lVgUTFYSVrV9XPe0Bj7KTl8/+9l
   6K+nz1Iu5Wa9/Hjhonfa8lEh0ne691yRsXm1gf8XjKHcT3TfhzEjVp1ne
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="276725950"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276725950"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 12:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="647704472"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2022 12:26:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyIMs-000Czt-Iq;
        Mon, 06 Jun 2022 19:26:26 +0000
Date:   Tue, 7 Jun 2022 03:25:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/per-callsite-ops 2/4]
 arch/riscv/kernel/setup.c:318:1: warning: 'text_section' attribute directive
 ignored
Message-ID: <202206070358.Tnsgqt6p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
head:   7f0d1ffaab77795e4ca97db4a901cc347c850ff7
commit: efc001292934b744fa4c8147668fa4bd0ee909bf [2/4] WIP: incomplete alignment hacks
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220607/202206070358.Tnsgqt6p-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=efc001292934b744fa4c8147668fa4bd0ee909bf
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/per-callsite-ops
        git checkout efc001292934b744fa4c8147668fa4bd0ee909bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/setup.c:318:1: warning: 'text_section' attribute directive ignored [-Wattributes]
     318 | subsys_initcall(topology_init);
         | ^~~~~~~~~~~~~~~


vim +/text_section +318 arch/riscv/kernel/setup.c

f1e58583b9c7ce Atish Patra 2020-03-17  301  
f1e58583b9c7ce Atish Patra 2020-03-17  302  static int __init topology_init(void)
f1e58583b9c7ce Atish Patra 2020-03-17  303  {
4f0e8eef772ee4 Atish Patra 2020-11-18  304  	int i, ret;
4f0e8eef772ee4 Atish Patra 2020-11-18  305  
f1e58583b9c7ce Atish Patra 2020-03-17  306  	for_each_possible_cpu(i) {
f1e58583b9c7ce Atish Patra 2020-03-17  307  		struct cpu *cpu = &per_cpu(cpu_devices, i);
f1e58583b9c7ce Atish Patra 2020-03-17  308  
f1e58583b9c7ce Atish Patra 2020-03-17  309  		cpu->hotpluggable = cpu_has_hotplug(i);
4f0e8eef772ee4 Atish Patra 2020-11-18  310  		ret = register_cpu(cpu, i);
4f0e8eef772ee4 Atish Patra 2020-11-18  311  		if (unlikely(ret))
4f0e8eef772ee4 Atish Patra 2020-11-18  312  			pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
4f0e8eef772ee4 Atish Patra 2020-11-18  313  			       __func__, i, ret);
f1e58583b9c7ce Atish Patra 2020-03-17  314  	}
f1e58583b9c7ce Atish Patra 2020-03-17  315  
f1e58583b9c7ce Atish Patra 2020-03-17  316  	return 0;
f1e58583b9c7ce Atish Patra 2020-03-17  317  }
f1e58583b9c7ce Atish Patra 2020-03-17 @318  subsys_initcall(topology_init);
19a00869028f4a Atish Patra 2020-11-04  319  

:::::: The code at line 318 was first introduced by commit
:::::: f1e58583b9c7ceae7f11646e9edf2561d67f29c9 RISC-V: Support cpu hotplug

:::::: TO: Atish Patra <atish.patra@wdc.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
