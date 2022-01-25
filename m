Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7349BBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiAYTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:18:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:31075 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbiAYTST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138298; x=1674674298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K/j6XRNTOLO48GdgQl/mZ2ocSXIsz3VxBJ/m2H19PAc=;
  b=SXuDX5iXv69NDhk+/x1ahWhslHElbE1gmqeWulRA+VXl2bczzTrW2yax
   E/nTRujuoNAgRS2N8V/tPMriAGNh8UwK70dm9qivTB622xzajce9BjlOl
   txX10Pjxmxj/fXMOAUSx5h+lRpp5jDGV7XYYHEzEjRGcqXeNai/mNttR9
   Q7wqpNgV61qPejXHcEDqDOClpouct+szsvvgaJRJU3+mTWHnnXF3XmX1g
   pev2YIlBs44Xf2yS2lsPVLRHboJ7abDPl2a5MkOt5gzRDqE94kc/hIWND
   Z6/RIlMpdKPvXr61leEWPfCChP6F8pu47lx6MjiVDCyuvf4dF6xpAEWmS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245226601"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="245226601"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="628049206"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2022 11:18:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRKZ-000KLs-RE; Tue, 25 Jan 2022 19:18:15 +0000
Date:   Wed, 26 Jan 2022 03:17:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 9/137]
 arch/x86/kernel/cpu/resctrl/core.c:400:6: warning: no previous prototype for
 'setup_default_ctrlval'
Message-ID: <202201260259.D09DY2rL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 1763d5f108c2b9e4fd2e055884b8e290b75fa5f0 [9/137] x86/resctrl: Remove architecture copy of mbps_val
config: i386-randconfig-m021-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260259.D09DY2rL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=1763d5f108c2b9e4fd2e055884b8e290b75fa5f0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 1763d5f108c2b9e4fd2e055884b8e290b75fa5f0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/cpu/resctrl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/core.c:400:6: warning: no previous prototype for 'setup_default_ctrlval' [-Wmissing-prototypes]
     400 | void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/resctrl/core.c:414:6: warning: no previous prototype for 'domain_free' [-Wmissing-prototypes]
     414 | void domain_free(struct rdt_hw_domain *hw_dom)
         |      ^~~~~~~~~~~


vim +/setup_default_ctrlval +400 arch/x86/kernel/cpu/resctrl/core.c

   399	
 > 400	void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
   401	{
   402		struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
   403		int i;
   404	
   405		/*
   406		 * Initialize the Control MSRs to having no control.
   407		 * For Cache Allocation: Set all bits in cbm
   408		 * For Memory Allocation: Set b/w requested to 100%
   409		 */
   410		for (i = 0; i < hw_res->num_closid; i++, dc++)
   411			*dc = r->default_ctrl;
   412	}
   413	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
