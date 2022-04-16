Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499EC50342E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiDPClS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiDPClQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:41:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECF5FAB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650076726; x=1681612726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GKVEggq5ZRJNyTM5MZu33LkwSh12SsTFfmrQhoZ5KhM=;
  b=d5mkVu1SouReb1u9t48tLHALjw7q/0AiZcXCllLnZPE7+omjWKpUY2bR
   rL4RGDF3a+6QTrcDszDKOHJJtvZ9jAYCEyxnvib7sqgxvAQ89WTGp8r2K
   r4YYoOhcQSuSq4enBV+HWS/EtGaibqBS8jVipO7VmPgGorVxcuh/MCA6+
   VYm3IzppqngJe/anX01xBGLs7Sg6hK/ja/8l94TPc37b/dkW15ZIfBdei
   ght8lUX7xPSPxNHKY/Cqtvl60ebSfgqmqnW2S8L94zlLWzH1fYCIIrGrp
   nsFgvg5/u1qYXtnVviH+BRUANKdXrKhktrN/608dNYfYhWE7CX8xAg2HT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="260859900"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="260859900"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 19:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="591819248"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2022 19:38:44 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfYKh-0002gL-OI;
        Sat, 16 Apr 2022 02:38:43 +0000
Date:   Sat, 16 Apr 2022 10:38:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_ipi_imp_v6 22/25] arch/riscv/kernel/smp.c:166:50:
 sparse: sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202204161023.uhBiZbYE-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git riscv_ipi_imp_v6
head:   e487c9bc7306965b9292bbf33f2803873c8469df
commit: 4036f0abdcb31af010a56029747a02a7b21874d2 [22/25] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-s031-20220414 (https://download.01.org/0day-ci/archive/20220416/202204161023.uhBiZbYE-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/avpatel/linux/commit/4036f0abdcb31af010a56029747a02a7b21874d2
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_ipi_imp_v6
        git checkout 4036f0abdcb31af010a56029747a02a7b21874d2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ kernel/

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
