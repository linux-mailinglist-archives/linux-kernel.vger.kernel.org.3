Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A444AEABA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiBIHEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiBIHEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:04:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED99C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644390282; x=1675926282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u8ruu3eizlEFYe7XXJfFj9y6REamWFcQJRgd8gx4IIk=;
  b=e74xy43L7H4smtS7V+F6O7tHV+goRgA+BANgb+MuR5dxyeAjnriL1iNo
   CsqosSdr7TXCMccMcYbEYHgNYx4KIV6pNQh6teOfBHapsymu195JyiQx5
   mzDKxeTL7jq66sLTX8l2BAqs5BceWISEdfh8L+DMrXy6bD4oqKCIg1CDc
   L+94VWeFavT/e6JA4V5aQncamkxO1we0ibJrYANkqrAoPMZAhztV3Y240
   o0sfsFeLIGAJHoRcyJdoIUtnWTjGz74VdZEHdS2bfjWrF/rMs6ECx+pI7
   f15QG13g21LOU4ydfaQ/3TT9Y6wXimYNLfOC7GpL8CHjMmIJwI2FNQPjs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249346239"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="249346239"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 23:04:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="525878820"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2022 23:04:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHh1i-0001Np-EK; Wed, 09 Feb 2022 07:04:30 +0000
Date:   Wed, 9 Feb 2022 15:04:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/fixes 6/6]
 arch/riscv/kernel/cpu-hotplug.c:43:9: error: implicit declaration of
 function 'numa_remove_cpu'; did you mean 'remove_cpu'?
Message-ID: <202202091500.dMNAJXAU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/fixes
head:   c3c94752087e789419be7024116c0a7b22883541
commit: c3c94752087e789419be7024116c0a7b22883541 [6/6] riscv: cpu-hotplug: clear cpu from numa map when teardown
config: riscv-randconfig-r042-20220209 (https://download.01.org/0day-ci/archive/20220209/202202091500.dMNAJXAU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/c3c94752087e789419be7024116c0a7b22883541
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/fixes
        git checkout c3c94752087e789419be7024116c0a7b22883541
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/cpu-hotplug.c: In function '__cpu_disable':
>> arch/riscv/kernel/cpu-hotplug.c:43:9: error: implicit declaration of function 'numa_remove_cpu'; did you mean 'remove_cpu'? [-Werror=implicit-function-declaration]
      43 |         numa_remove_cpu(cpu);
         |         ^~~~~~~~~~~~~~~
         |         remove_cpu
   cc1: some warnings being treated as errors


vim +43 arch/riscv/kernel/cpu-hotplug.c

    24	
    25	/*
    26	 * __cpu_disable runs on the processor to be shutdown.
    27	 */
    28	int __cpu_disable(void)
    29	{
    30		int ret = 0;
    31		unsigned int cpu = smp_processor_id();
    32	
    33		if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_stop)
    34			return -EOPNOTSUPP;
    35	
    36		if (cpu_ops[cpu]->cpu_disable)
    37			ret = cpu_ops[cpu]->cpu_disable(cpu);
    38	
    39		if (ret)
    40			return ret;
    41	
    42		remove_cpu_topology(cpu);
  > 43		numa_remove_cpu(cpu);
    44		set_cpu_online(cpu, false);
    45		irq_migrate_all_off_this_cpu();
    46	
    47		return ret;
    48	}
    49	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
