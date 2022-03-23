Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C904E548E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiCWOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiCWOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:52:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2317CDED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648047034; x=1679583034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WV8okRWkFfUATtL0PFt20LTbSkGfJRSp6aQFdn9eOFw=;
  b=CjC6GK5URR0vjZTDh7jBMa3ZNpgx8Y7+HdUCgux60QXwMV41I/QHxtgN
   jLU9+froEF0W0YnT/1eKRxzBl41yKd2E0cqlECb2Y8AQ3P/UuVaGSXmt6
   5Ykz8d54kl8S/2MUhKORKh7ywC8COsuGTCXWOnR7oadl2RCb9YmQZqCvd
   8eNoipJoKLk6bLXzBj/O7DMAXTbYR0qeFAl3gM9lnNUqLVJ1Ui2Ld/oZi
   JcqYOGDbzf3f4wIf61kSTvAEmUXI021fC1PK2sFEZGnIplzHVaQd7vc+s
   EM/zE28LkMAEquPxhwJYlYMsmv1S4yY8xABSNCULbyrNzxZBX40T4QbcG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="282974015"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="282974015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="519385138"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 07:50:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX2Jj-000K9F-Qp; Wed, 23 Mar 2022 14:50:31 +0000
Date:   Wed, 23 Mar 2022 22:49:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 18/38] arch/riscv/kernel/smp.c:166:50:
 sparse: sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202203232238.QlIbLTI5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   bafeaefb38960799e1f7ac9b6707a22e5be067d0
commit: f6066acf07ddc4838b1115af3af24bb05ecf40dd [18/38] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-s032-20220323 (https://download.01.org/0day-ci/archive/20220323/202203232238.QlIbLTI5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/avpatel/linux/commit/f6066acf07ddc4838b1115af3af24bb05ecf40dd
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout f6066acf07ddc4838b1115af3af24bb05ecf40dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
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
