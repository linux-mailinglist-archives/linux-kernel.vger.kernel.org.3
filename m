Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19B4D71F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiCMAu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiCMAux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:50:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608654ECF0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647132587; x=1678668587;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QO/Wn+HIkDR75ViTn0x3jxwI/zlofZt4xewVcXICN0w=;
  b=L4Aq6zPVu/m8XN+0GgE/xL2i2uo0+EVukP9Khzw++agHokr6A4g+VVG2
   WNZ33fCCWY0AFbOtLL3XYmHajXB84/w8E4RoWZO/bgDHs4QjMYHV4XVlO
   x19Ali4PAiETwEBf+NCZ++X4dcZp9Lq2lwrLOIDVGkjMez5QpQoMDvLBY
   Hl7d5BQ4017I3/2slFDD0bGgpovN2/0zATA+ybwJ0hUSjYJTdmKac5/O0
   47igK7qvlzjlEbgUbKQ+MMVzfCMogW8MTQ+fNGvtr9Dsm7zO4yLuenuDv
   DWF23YaT77bSMZKiW82jmBZDaR3ZSsxjxFlrrHjRxp4RHo+8WemoRrW/O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="235779597"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="235779597"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 16:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="645364371"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 16:49:45 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTCQa-0008R8-KL; Sun, 13 Mar 2022 00:49:44 +0000
Date:   Sun, 13 Mar 2022 08:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-sun6i-r.c:215:79: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202203130814.1YMJ3vAC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: 4e34614636b31747b190488240a95647c227021f irqchip/sun6i-r: Use a stacked irqchip driver
date:   1 year, 2 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220313/202203130814.1YMJ3vAC-lkp@intel.com/config)
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
