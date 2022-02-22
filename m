Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11E24BF4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiBVJhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBVJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:36:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6624C13D45
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645522594; x=1677058594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=epDTGwXl0hnH02ZsDt1lDZBbtedZrOrSwE4ZeXvSN2A=;
  b=GniTl7ITRytyyjaWKFkMcDrAXpBNxTqIHxjEfP8rxm2gH7gEZmoVtc7P
   Rk1BD/IQJ6xCxUHmIL30VgUPflTuCkosJQHDeX41diOPvoKvFFwrxXXvz
   4Cm1sVDEGkmF95qszUlgZp9e8VpKbIoFHvFzrHsyUzTA6GoT0wJbX8Iuo
   yxZujRbzK8Yj01gcRp8jIeWmnDwGGFuIYmVvAIwexw8gEQ+BA4caLgjSw
   aF/MZH7SjUn3b7/d8T29DNk1b8J+389vwp+YiyWQElixLMzenLk3GQFkm
   zobHESJMXE18y1UiKsJ4ww9wIXBI5LGYzm/8U9ZQKbYVHQhwfw9xmIJjb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251603503"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251603503"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="542878849"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2022 01:36:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMRax-00005O-Ub; Tue, 22 Feb 2022 09:36:31 +0000
Date:   Tue, 22 Feb 2022 17:35:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-sun6i-r.c:215:79: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202202221714.fORO2j1w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
commit: 4e34614636b31747b190488240a95647c227021f irqchip/sun6i-r: Use a stacked irqchip driver
date:   1 year, 1 month ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220222/202202221714.fORO2j1w-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e34614636b31747b190488240a95647c227021f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4e34614636b31747b190488240a95647c227021f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/tegra/ drivers/gpu/host1x/ drivers/hid/ drivers/irqchip/ drivers/remoteproc/ drivers/scsi/hisi_sas/ security/integrity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-sun6i-r.c:215:79: sparse: sparse: Using plain integer as NULL pointer

vim +215 drivers/irqchip/irq-sun6i-r.c

   184	
   185	static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
   186					     unsigned int virq,
   187					     unsigned int nr_irqs, void *arg)
   188	{
   189		struct irq_fwspec *fwspec = arg;
   190		struct irq_fwspec gic_fwspec;
   191		unsigned long hwirq;
   192		unsigned int type;
   193		int i, ret;
   194	
   195		ret = sun6i_r_intc_domain_translate(domain, fwspec, &hwirq, &type);
   196		if (ret)
   197			return ret;
   198		if (hwirq + nr_irqs > SUN6I_NR_MUX_BITS)
   199			return -EINVAL;
   200	
   201		/* Construct a GIC-compatible fwspec from this fwspec. */
   202		gic_fwspec = (struct irq_fwspec) {
   203			.fwnode      = domain->parent->fwnode,
   204			.param_count = 3,
   205			.param       = { GIC_SPI, hwirq, type },
   206		};
   207	
   208		ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
   209		if (ret)
   210			return ret;
   211	
   212		for (i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
   213			if (hwirq == nmi_hwirq) {
   214				irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 > 215							      &sun6i_r_intc_nmi_chip, 0);
   216				irq_set_handler(virq, handle_fasteoi_ack_irq);
   217			} else {
   218				/* Only the NMI is currently supported. */
   219				return -EINVAL;
   220			}
   221		}
   222	
   223		return 0;
   224	}
   225	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
