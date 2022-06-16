Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5642C54DFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376751AbiFPLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376718AbiFPLLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:11:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76285C86F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655377863; x=1686913863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ElqTQA2q3JJdVEoPTlRhlCy86mX4DEjMIOBabJdatbE=;
  b=dkA5RvRjwjMYW6Rc13TKek+yej6iFta8v07ZMUo5UNhY+xo0WauNkxWM
   FsgU3CVDveZEmO7q7TacNN5IuRd8UZaSEMvzsGC5CgINbuLEz4qSlZ7x7
   +fozZjHdYUXn9PMWsp7bC1yp0vQ+xZub2uoNjpoiPyjNqkbMivDsW3Qbb
   s2aNExQBVLfj5E9Kwi6tGiESzN+6muKX2GWooK2fC6G4J36HDOF4whs5G
   099VFm8WvTHZxlnCZBFlJMXacre+RJVfUIpUjNh5rcWd9T+FbkZypL39P
   mmiIrvq0nWFL7kACqky/44/KLjsl8Ma3kInyYxWSdlf1QX0Y3CuI39UFp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280258051"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="280258051"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 04:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="583594878"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 04:11:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1nOq-000OJf-Og;
        Thu, 16 Jun 2022 11:10:56 +0000
Date:   Thu, 16 Jun 2022 19:10:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 7/29] arch/riscv/kernel/smp.c:166:50:
 sparse: sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202206161946.96McdGxQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   00790a8b765d864a8a1d0be2f7985954cb719031
commit: 018fd952c6dfbad5bd2abd914c5b955a0bffb3b9 [7/29] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-s032-20220616 (https://download.01.org/0day-ci/archive/20220616/202206161946.96McdGxQ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/avpatel/linux/commit/018fd952c6dfbad5bd2abd914c5b955a0bffb3b9
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 018fd952c6dfbad5bd2abd914c5b955a0bffb3b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:166:50: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __percpu *percpu_dev_id @@     got int * @@
   arch/riscv/kernel/smp.c:166:50: sparse:     expected void [noderef] __percpu *percpu_dev_id
   arch/riscv/kernel/smp.c:166:50: sparse:     got int *

vim +166 arch/riscv/kernel/smp.c

   151	
   152	void riscv_ipi_set_virq_range(int virq, int nr)
   153	{
   154		int i, err;
   155	
   156		if (WARN_ON(ipi_virq_base))
   157			return;
   158	
   159		WARN_ON(nr < IPI_MAX);
   160		nr_ipi = min(nr, IPI_MAX);
   161		ipi_virq_base = virq;
   162	
   163		/* Request IPIs */
   164		for (i = 0; i < nr_ipi; i++) {
   165			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
 > 166						 "IPI", &ipi_virq_base);
   167			WARN_ON(err);
   168	
   169			ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
   170			irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
   171		}
   172	
   173		/* Enabled IPIs for boot CPU immediately */
   174		riscv_ipi_enable();
   175	}
   176	EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
   177	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
