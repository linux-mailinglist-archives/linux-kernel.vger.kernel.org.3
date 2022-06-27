Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007555B564
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiF0CwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiF0CwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:52:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F23885;
        Sun, 26 Jun 2022 19:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656298322; x=1687834322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QrT5ao9preo/N4kReVsNvY5n6xqX0XIHa2T/Gy7NBMM=;
  b=XL4w5aJLArcRyQqexVpytIjVN/KtelkVBe8CHQNiUD5Lbani5g+QFcdr
   6qXaxXu2K68yDBSRtShVgTGXkUM7eHy3mlxCR2sKXoh9qcdU1ChbjBcK9
   0+TB39y/9wIpXgFmsyxM60qwGZ+nH9NKTejh5JnoS0eM1xw6LhfD1HifC
   oJ88SmtelGuKkzhiPKgi5IuczueYdOEMf5kQCkdNUF4Ad3/PqVhC7XphP
   sqjUUhcE21k8/pMCID98zUZ2tBzykMz9EnKSz+etnmlR6Tw+lYmTplgg7
   Et3zb8Uc5lNMtF0Oyh/UFUbU00pz56Ve+ehHqapKQ0kBoM00irO8+C6N7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="306811908"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="306811908"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 19:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="835997743"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2022 19:51:54 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5eqw-00088L-2J;
        Mon, 27 Jun 2022 02:51:54 +0000
Date:   Mon, 27 Jun 2022 10:51:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ash Logan <ash@heyquark.com>, paulus@samba.org, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, robh+dt@kernel.org,
        benh@kernel.crashing.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/12] powerpc: wiiu: latte interrupt controller
 support
Message-ID: <202206271019.YEn99lfz-lkp@intel.com>
References: <20220622131037.57604-9-ash@heyquark.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622131037.57604-9-ash@heyquark.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ash,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on robh/for-next]
[cannot apply to mpe/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ash-Logan/dt-bindings-wiiu-Document-the-Nintendo-Wii-U-devicetree/20220622-221056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-randconfig-c003-20220626 (https://download.01.org/0day-ci/archive/20220627/202206271019.YEn99lfz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/533a7cf49cc00c4eaafd2afee5ecd9e23bac99f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ash-Logan/dt-bindings-wiiu-Document-the-Nintendo-Wii-U-devicetree/20220622-221056
        git checkout 533a7cf49cc00c4eaafd2afee5ecd9e23bac99f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/wiiu/ drivers/usb/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/wiiu/latte-pic.c:155:14: warning: no previous prototype for function 'latte_pic_get_irq' [-Wmissing-prototypes]
   unsigned int latte_pic_get_irq(struct irq_domain *h)
                ^
   arch/powerpc/platforms/wiiu/latte-pic.c:155:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned int latte_pic_get_irq(struct irq_domain *h)
   ^
   static 
   1 warning generated.


vim +/latte_pic_get_irq +155 arch/powerpc/platforms/wiiu/latte-pic.c

   150	
   151	/*
   152	 * Determinate if there are interrupts pending
   153	 * Checks AHBALL (0-32) and AHBLT (32-64)
   154	 */
 > 155	unsigned int latte_pic_get_irq(struct irq_domain *h)
   156	{
   157		struct lt_pic *pic = *this_cpu_ptr(&lt_pic_cpu);
   158		u32 irq_status, irq;
   159	
   160		/* Check AHBALL first */
   161		irq_status = in_be32(&pic->ahball_icr) & in_be32(&pic->ahball_imr);
   162	
   163		if (irq_status == 0) {
   164			/* Try AHBLT */
   165			irq_status =
   166				in_be32(&pic->ahblt_icr) & in_be32(&pic->ahblt_imr);
   167			if (irq_status == 0)
   168				return 0; /* No IRQs pending */
   169	
   170			/* AHBLT is mapped above 32 (LATTE_AHBALL_NR_IRQS) */
   171			irq = __ffs(irq_status) + LATTE_AHBALL_NR_IRQS;
   172			return irq_linear_revmap(h, irq);
   173		}
   174	
   175		irq = __ffs(irq_status);
   176		return irq_linear_revmap(h, irq);
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
