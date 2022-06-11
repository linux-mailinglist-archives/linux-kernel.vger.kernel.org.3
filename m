Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988F85470E4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiFKBRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFKBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:17:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E27B1001
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654910219; x=1686446219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hxshhMDB7tsI1RW13+5wpLCz+J9Kkt4TLR1Bcn/0XzE=;
  b=Ac5LGSnyM36fvVjI7WtqLGOjtLUjElzoFofdcfke8jOdvWvg6vHId23V
   RdDYjF0kU2wQYE4RUQ77+j/sevq3O9JbJHrD2nETPQ+0DnmJ+gR0Y9VAv
   B5351L9ikrPlJq0qsRwPfE31YatzDBAwivvQ+zlz7/lxQbUfxMa/R0gDn
   dLY/wr99kwKEbAszbp2E/twwF69OunhuLhvuVuonzwpcJ0dDkOE3XC1+C
   bwHEacH5nfIwaM488p2XfgszFX0onrKzxcYPtBBvFYXv2SeP53VvMxZ5R
   voLx0TYkUzztMyYuaAOpusuUqcHg9DgScqKtw73m5qAeN+Cvutrwig9Wd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275327763"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="275327763"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 18:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="586494240"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2022 18:16:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzpkH-000IQH-BA;
        Sat, 11 Jun 2022 01:16:57 +0000
Date:   Sat, 11 Jun 2022 09:16:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mayuresh Chitale <mchitale@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 35/52]
 arch/riscv/kernel/setup.c:299:9: error: implicit declaration of function
 'riscv_tlbflush_init'
Message-ID: <202206110936.Fxp1OH6s-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: efaaec7bcbaf3346e07955be46d5e3c2bd662167 [35/52] riscv: mm: use svinval instructions instead of sfence.vma
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220611/202206110936.Fxp1OH6s-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/efaaec7bcbaf3346e07955be46d5e3c2bd662167
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout efaaec7bcbaf3346e07955be46d5e3c2bd662167
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/setup.c: In function 'setup_arch':
>> arch/riscv/kernel/setup.c:299:9: error: implicit declaration of function 'riscv_tlbflush_init' [-Werror=implicit-function-declaration]
     299 |         riscv_tlbflush_init();
         |         ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/riscv_tlbflush_init +299 arch/riscv/kernel/setup.c

   297	
   298		riscv_fill_hwcap();
 > 299		riscv_tlbflush_init();
   300		apply_boot_alternatives();
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
