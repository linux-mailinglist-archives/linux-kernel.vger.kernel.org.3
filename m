Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA52544B21
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbiFIL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiFIL6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:58:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82014D1D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654775915; x=1686311915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zl1pfpL1wUggkXludigL5TwIsEDn0JoTiHEU69wclNs=;
  b=FpuQ7uGo+hl1d43xTiGi8ZtB7Q1BeA+Pt6ng5nwXvwgLoKqgjc46JQdj
   ktXw2KPEcU4h5erof940uwa648SoE1+HCAo5kfgKS9dGhbSvxWT3LvR3b
   7rsdWZ43fGrrdlJwgKIpf6MfYWOdpruHr8uxmGvI1no7r1sKfWunHG+df
   IeSnqoMgu7u6GK2GeIymedeIs0aTnMzThF1k8sI4rii1rR3pFUbnDw2+y
   b/OuJQn0rUkbc5p0ubKsrj+5Kj7BXDN7736sZMelX04XqJNAnbCU+wkeE
   vzTz3WZgB+nIwKNjffTX8Fvh/TgDAbsWsahPQt2XAWkyrnPvZzcWtB6O3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277278952"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277278952"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 04:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="710393246"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2022 04:58:32 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzGo3-000Fx1-KF;
        Thu, 09 Jun 2022 11:58:31 +0000
Date:   Thu, 9 Jun 2022 19:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>
Subject: kexec_core.c:undefined reference to `machine_kexec'
Message-ID: <202206091916.0xLwCTGT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: 6261586e0c91db14c34f894f4bc48f2300cff1d4 RISC-V: Add kexec_file support
date:   3 weeks ago
config: riscv-buildonly-randconfig-r002-20220608 (https://download.01.org/0day-ci/archive/20220609/202206091916.0xLwCTGT-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6261586e0c91db14c34f894f4bc48f2300cff1d4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6261586e0c91db14c34f894f4bc48f2300cff1d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/kexec_core.o: in function `.L1364':
>> kexec_core.c:(.text+0x3568): undefined reference to `machine_kexec_cleanup'
   riscv64-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
>> (.text+0x3b08): undefined reference to `machine_crash_shutdown'
   riscv64-linux-ld: (.text+0x3b14): undefined reference to `machine_kexec'
   riscv64-linux-ld: (.text+0x3b68): undefined reference to `riscv_crash_save_regs'
   riscv64-linux-ld: kernel/kexec_core.o: in function `.L1553':
>> kexec_core.c:(.text+0x44a4): undefined reference to `machine_shutdown'
   riscv64-linux-ld: kernel/kexec_core.o: in function `.L1528':
>> kexec_core.c:(.text+0x44bc): undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_file.o: in function `.L440':
>> kexec_file.c:(.text+0x15d4): undefined reference to `machine_kexec_prepare'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
