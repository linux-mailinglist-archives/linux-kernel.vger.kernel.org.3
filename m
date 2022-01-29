Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743BB4A2B22
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbiA2CAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:00:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:17567 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344749AbiA2CAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643421617; x=1674957617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zk/EhGuLGQZuABPr01o4taF9X2R/H/Bo5ThpAPze9Jw=;
  b=bTkHcsaaaNzYRcQnzNkDES29xsoWroWdoKuRT1rByYGt4726adnjb+8P
   1/taMYPMQX0jsqNbr1qzJ3entXeWTYzxakBpOysBpMTy3jP24uOtKqa3s
   vDMd1FOo5qevyz+9/i7SL2/NEtdwaXEUOlE33jpdjfAyNE38eytCGn2An
   iOGAXr7LiKK3lXolLYYFYhjhr6tkVLGb15sZ+nHd3zxprNt0IOjCSG7In
   sBwiT1IuYDcz/4FKMcNj881wY39Amm1wl/R+ZsPF/uOXIHk6sqLmi0n42
   gmnLb4OWWW8vTLlAUyImIPjPVtJCBl/JN2rUnSShit1bhlISJYoAgiFSM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247180180"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247180180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 18:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="536364826"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2022 18:00:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDd2F-000Ocw-Cu; Sat, 29 Jan 2022 02:00:15 +0000
Date:   Sat, 29 Jan 2022 10:00:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm64-ro-page-tables-pkvm-v5.17 15/26]
 arch/arm64/kvm/hyp/nvhe/pgtable_protect.c:21:17: warning: suggest braces
 around empty body in an 'if' statement
Message-ID: <202201290900.iZd18OR6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm64-ro-page-tables-pkvm-v5.17
head:   b38f2df95cbf61e70bc32017da5318d1cb03e3e3
commit: fd08c6c28e7fe82f8ee86abb3d1a0e1dd8c704d8 [15/26] arm64: kvm: use HYP helpers to perform page table updates
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220129/202201290900.iZd18OR6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=fd08c6c28e7fe82f8ee86abb3d1a0e1dd8c704d8
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm64-ro-page-tables-pkvm-v5.17
        git checkout fd08c6c28e7fe82f8ee86abb3d1a0e1dd8c704d8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/pgtable_protect.c: In function 'inject_external_abort':
>> arch/arm64/kvm/hyp/nvhe/pgtable_protect.c:21:17: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
      21 |                 ; // TODO
         |                 ^


vim +/if +21 arch/arm64/kvm/hyp/nvhe/pgtable_protect.c

    15	
    16	static void inject_external_abort(struct kvm_cpu_context *host_ctxt)
    17	{
    18		struct kvm_vcpu *vcpu = host_ctxt->__hyp_running_vcpu;
    19	
    20		if (vcpu)
  > 21			; // TODO
    22	
    23		write_sysreg_el2(read_sysreg_el2(SYS_ELR) - 1, SYS_ELR);
    24	}
    25	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
