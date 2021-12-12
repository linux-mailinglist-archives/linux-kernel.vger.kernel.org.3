Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7926447176F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 01:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhLLAi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 19:38:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:8360 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhLLAi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 19:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639269537; x=1670805537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o6eoygNvX23HVmicqdMj/32v2wVux1DNKXPtZNPQ+JU=;
  b=mJxK78xrq/LN/1V4G5hcyWMlFf024rZSavFq9C4ijyxiSafCODhJf7+S
   f4St/q9SrS6qhdrC9DUINFAkfKZDMENHsPSRBsli1VvsqrXPtW4oqRsWP
   hsWp3BSSyvS3uNqXdFrde3NyM7OR+02FW+3I9+2CDNrirNbjHe9DbULNr
   +aNij5kBx4HXDr1zerQjm8XHx8Kppq5eKVfI7OMGn/lmSRstsuvIttcRZ
   W8GxS2lcQBsRNff7e48UX896M9Afh9i9PZQJmuzPahqtOSz7PJNmmLePJ
   /TKarORKTG5XTM7v3nRDI9bFQA/A7Sjjgy+rjCE56rQsDLF6N16NHufyi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="324832311"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="324832311"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 16:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="504434967"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2021 16:38:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwCtD-0005Dx-00; Sun, 12 Dec 2021 00:38:55 +0000
Date:   Sun, 12 Dec 2021 08:38:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-sun6i-r.c:215:79: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202112120838.OtQsRmlP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bbdff6d583be718935b613ab2a966cddaadf661f
commit: 4e34614636b31747b190488240a95647c227021f irqchip/sun6i-r: Use a stacked irqchip driver
date:   11 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211212/202112120838.OtQsRmlP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-socfpga/ drivers/dma/ drivers/edac/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/irqchip/ drivers/net/ethernet/mediatek/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/staging/ fs/proc/

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
