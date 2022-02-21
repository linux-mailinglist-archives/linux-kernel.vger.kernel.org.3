Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668EC4BD482
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiBUDzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:55:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiBUDzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:55:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71C51E64
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645415708; x=1676951708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KFTnwmE//SWa+5V6IXwfZJO4sLv6cRluYfF3TUfQllM=;
  b=Uj4tvH8aFchPXr3+2FqDcrPF5I/ufjbYpZzg6q2nlgFxqyOk7RXptWc6
   IyoV/7V4NaAV9VeJbUlbxfSWWIisM1+/N1j7YA6Trl7wx847/xENpg/X4
   /L6Z2wwoDuKcXYCjXyW2OrDLMuh/yElg/O4lgBfwujmeEeML+2Jqm3Pmm
   2xRo6/S8uCZUi3m5/IEXVpTZu+cu+hGnBk2hzwGjNAtIwnq3m8mBcBHql
   AN0/g/0jcx/MYZjRE29HqOvTHkgmswlbSO9DonF0ugC1/899eRp+qgfRy
   P7AGfi5H89WOS4LyG//A0aPjoQshNnZjPFjcaRzUz3xXtsGK2tV/m+BX+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276020161"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="276020161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 19:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="706103179"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 19:55:05 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLzmz-0001Hu-6U; Mon, 21 Feb 2022 03:55:05 +0000
Date:   Mon, 21 Feb 2022 11:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/arm64/include/asm/kvm_emulate.h:439:32: sparse: sparse:
 incorrect type in return expression (different base types)
Message-ID: <202202211117.LxmkwF42-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: 63b3f96e1a989846a5a521d4fbef4bc86406929d kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT
date:   10 months ago
config: arm64-randconfig-s032-20220220 (https://download.01.org/0day-ci/archive/20220221/202202211117.LxmkwF42-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63b3f96e1a989846a5a521d4fbef4bc86406929d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63b3f96e1a989846a5a521d4fbef4bc86406929d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm64/kvm/mmio.c: note: in included file:
>> arch/arm64/include/asm/kvm_emulate.h:439:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long @@     got restricted __be16 [usertype] @@
   arch/arm64/include/asm/kvm_emulate.h:439:32: sparse:     expected unsigned long
   arch/arm64/include/asm/kvm_emulate.h:439:32: sparse:     got restricted __be16 [usertype]
>> arch/arm64/include/asm/kvm_emulate.h:441:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long @@     got restricted __be32 [usertype] @@
   arch/arm64/include/asm/kvm_emulate.h:441:32: sparse:     expected unsigned long
   arch/arm64/include/asm/kvm_emulate.h:441:32: sparse:     got restricted __be32 [usertype]
>> arch/arm64/include/asm/kvm_emulate.h:443:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long @@     got restricted __be64 [usertype] @@
   arch/arm64/include/asm/kvm_emulate.h:443:32: sparse:     expected unsigned long
   arch/arm64/include/asm/kvm_emulate.h:443:32: sparse:     got restricted __be64 [usertype]
>> arch/arm64/include/asm/kvm_emulate.h:450:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long @@     got restricted __le16 [usertype] @@
   arch/arm64/include/asm/kvm_emulate.h:450:32: sparse:     expected unsigned long
   arch/arm64/include/asm/kvm_emulate.h:450:32: sparse:     got restricted __le16 [usertype]
>> arch/arm64/include/asm/kvm_emulate.h:452:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long @@     got restricted __le32 [usertype] @@
   arch/arm64/include/asm/kvm_emulate.h:452:32: sparse:     expected unsigned long
   arch/arm64/include/asm/kvm_emulate.h:452:32: sparse:     got restricted __le32 [usertype]
>> arch/arm64/include/asm/kvm_emulate.h:454:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long @@     got restricted __le64 [usertype] @@
   arch/arm64/include/asm/kvm_emulate.h:454:32: sparse:     expected unsigned long
   arch/arm64/include/asm/kvm_emulate.h:454:32: sparse:     got restricted __le64 [usertype]
>> arch/arm64/include/asm/kvm_emulate.h:408:32: sparse: sparse: cast to restricted __be16
>> arch/arm64/include/asm/kvm_emulate.h:410:32: sparse: sparse: cast to restricted __be32
>> arch/arm64/include/asm/kvm_emulate.h:412:32: sparse: sparse: cast to restricted __be64
>> arch/arm64/include/asm/kvm_emulate.h:419:32: sparse: sparse: cast to restricted __le16
>> arch/arm64/include/asm/kvm_emulate.h:419:32: sparse: sparse: cast to restricted __le16
>> arch/arm64/include/asm/kvm_emulate.h:419:32: sparse: sparse: cast to restricted __le16
>> arch/arm64/include/asm/kvm_emulate.h:419:32: sparse: sparse: cast to restricted __le16
>> arch/arm64/include/asm/kvm_emulate.h:421:32: sparse: sparse: cast to restricted __le32
>> arch/arm64/include/asm/kvm_emulate.h:421:32: sparse: sparse: cast to restricted __le32
>> arch/arm64/include/asm/kvm_emulate.h:421:32: sparse: sparse: cast to restricted __le32
>> arch/arm64/include/asm/kvm_emulate.h:421:32: sparse: sparse: cast to restricted __le32
>> arch/arm64/include/asm/kvm_emulate.h:421:32: sparse: sparse: cast to restricted __le32
>> arch/arm64/include/asm/kvm_emulate.h:421:32: sparse: sparse: cast to restricted __le32
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
>> arch/arm64/include/asm/kvm_emulate.h:423:32: sparse: sparse: cast to restricted __le64
--
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/pvtime.c:27:25: sparse: sparse: cast to restricted __le64
--
>> arch/arm64/kvm/arch_timer.c:1016:66: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *vcpu_info @@     got struct kvm_vcpu *[noderef] __percpu * @@
   arch/arm64/kvm/arch_timer.c:1016:66: sparse:     expected void *vcpu_info
   arch/arm64/kvm/arch_timer.c:1016:66: sparse:     got struct kvm_vcpu *[noderef] __percpu *
   arch/arm64/kvm/arch_timer.c:1049:74: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *vcpu_info @@     got struct kvm_vcpu *[noderef] __percpu * @@
   arch/arm64/kvm/arch_timer.c:1049:74: sparse:     expected void *vcpu_info
   arch/arm64/kvm/arch_timer.c:1049:74: sparse:     got struct kvm_vcpu *[noderef] __percpu *
--
>> arch/arm64/kvm/vgic/vgic-mmio.c:854:24: sparse: sparse: cast to restricted __le16
>> arch/arm64/kvm/vgic/vgic-mmio.c:854:24: sparse: sparse: cast to restricted __le16
>> arch/arm64/kvm/vgic/vgic-mmio.c:854:24: sparse: sparse: cast to restricted __le16
>> arch/arm64/kvm/vgic/vgic-mmio.c:854:24: sparse: sparse: cast to restricted __le16
>> arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
>> arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
>> arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
>> arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
>> arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
>> arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-mmio.c:878:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long data @@     got restricted __le16 [usertype] @@
   arch/arm64/kvm/vgic/vgic-mmio.c:878:22: sparse:     expected unsigned long data
   arch/arm64/kvm/vgic/vgic-mmio.c:878:22: sparse:     got restricted __le16 [usertype]
>> arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long data @@     got restricted __le32 [usertype] @@
   arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse:     expected unsigned long data
   arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse:     got restricted __le32 [usertype]
>> arch/arm64/kvm/vgic/vgic-mmio.c:884:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long data @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-mmio.c:884:22: sparse:     expected unsigned long data
   arch/arm64/kvm/vgic/vgic-mmio.c:884:22: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-mmio.c:88:17: sparse: sparse: context imbalance in 'vgic_mmio_write_group' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:124:9: sparse: sparse: context imbalance in 'vgic_mmio_write_senable' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:195:9: sparse: sparse: context imbalance in 'vgic_uaccess_write_senable' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:278:9: sparse: sparse: context imbalance in 'vgic_mmio_write_spending' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:320:9: sparse: sparse: context imbalance in 'vgic_uaccess_write_spending' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:565:9: sparse: sparse: context imbalance in 'vgic_mmio_change_active' - wrong count at exit
   arch/arm64/kvm/vgic/vgic-mmio.c:773:30: sparse: sparse: context imbalance in 'vgic_write_irq_line_level_info' - different lock contexts for basic block
--
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:824:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:955:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:2133:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] val @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-its.c:2133:13: sparse:     expected unsigned long long [assigned] [usertype] val
   arch/arm64/kvm/vgic/vgic-its.c:2133:13: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2159:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2280:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] val @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-its.c:2280:13: sparse:     expected unsigned long long [assigned] [usertype] val
   arch/arm64/kvm/vgic/vgic-its.c:2280:13: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2306:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2404:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2460:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] val @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-its.c:2460:13: sparse:     expected unsigned long long [assigned] [usertype] val
   arch/arm64/kvm/vgic/vgic-its.c:2460:13: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2476:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:280:12: sparse: sparse: context imbalance in 'update_lpi_config' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-its.c:443:9: sparse: sparse: context imbalance in 'its_sync_lpi_pending_table' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-its.c:730:12: sparse: sparse: context imbalance in 'vgic_its_trigger_msi' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-its.c:752:5: sparse: sparse: context imbalance in 'vgic_its_inject_cached_translation' - wrong count at exit

vim +439 arch/arm64/include/asm/kvm_emulate.h

6d89d2d9b5bac9 Marc Zyngier    2013-02-12  398  
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  399  static inline unsigned long vcpu_data_guest_to_host(struct kvm_vcpu *vcpu,
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  400  						    unsigned long data,
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  401  						    unsigned int len)
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  402  {
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  403  	if (kvm_vcpu_is_be(vcpu)) {
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  404  		switch (len) {
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  405  		case 1:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  406  			return data & 0xff;
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  407  		case 2:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12 @408  			return be16_to_cpu(data & 0xffff);
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  409  		case 4:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12 @410  			return be32_to_cpu(data & 0xffffffff);
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  411  		default:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12 @412  			return be64_to_cpu(data);
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  413  		}
b30070862edbdb Victor Kamensky 2014-06-12  414  	} else {
b30070862edbdb Victor Kamensky 2014-06-12  415  		switch (len) {
b30070862edbdb Victor Kamensky 2014-06-12  416  		case 1:
b30070862edbdb Victor Kamensky 2014-06-12  417  			return data & 0xff;
b30070862edbdb Victor Kamensky 2014-06-12  418  		case 2:
b30070862edbdb Victor Kamensky 2014-06-12 @419  			return le16_to_cpu(data & 0xffff);
b30070862edbdb Victor Kamensky 2014-06-12  420  		case 4:
b30070862edbdb Victor Kamensky 2014-06-12 @421  			return le32_to_cpu(data & 0xffffffff);
b30070862edbdb Victor Kamensky 2014-06-12  422  		default:
b30070862edbdb Victor Kamensky 2014-06-12 @423  			return le64_to_cpu(data);
b30070862edbdb Victor Kamensky 2014-06-12  424  		}
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  425  	}
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  426  
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  427  	return data;		/* Leave LE untouched */
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  428  }
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  429  
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  430  static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  431  						    unsigned long data,
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  432  						    unsigned int len)
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  433  {
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  434  	if (kvm_vcpu_is_be(vcpu)) {
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  435  		switch (len) {
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  436  		case 1:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  437  			return data & 0xff;
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  438  		case 2:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12 @439  			return cpu_to_be16(data & 0xffff);
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  440  		case 4:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12 @441  			return cpu_to_be32(data & 0xffffffff);
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  442  		default:
6d89d2d9b5bac9 Marc Zyngier    2013-02-12 @443  			return cpu_to_be64(data);
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  444  		}
b30070862edbdb Victor Kamensky 2014-06-12  445  	} else {
b30070862edbdb Victor Kamensky 2014-06-12  446  		switch (len) {
b30070862edbdb Victor Kamensky 2014-06-12  447  		case 1:
b30070862edbdb Victor Kamensky 2014-06-12  448  			return data & 0xff;
b30070862edbdb Victor Kamensky 2014-06-12  449  		case 2:
b30070862edbdb Victor Kamensky 2014-06-12 @450  			return cpu_to_le16(data & 0xffff);
b30070862edbdb Victor Kamensky 2014-06-12  451  		case 4:
b30070862edbdb Victor Kamensky 2014-06-12 @452  			return cpu_to_le32(data & 0xffffffff);
b30070862edbdb Victor Kamensky 2014-06-12  453  		default:
b30070862edbdb Victor Kamensky 2014-06-12 @454  			return cpu_to_le64(data);
b30070862edbdb Victor Kamensky 2014-06-12  455  		}
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  456  	}
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  457  
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  458  	return data;		/* Leave LE untouched */
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  459  }
6d89d2d9b5bac9 Marc Zyngier    2013-02-12  460  

:::::: The code at line 439 was first introduced by commit
:::::: 6d89d2d9b5bac9dbe40ee106ceda9307b6265234 arm/arm64: KVM: MMIO support for BE guest

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
