Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1039249BF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiAYXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:03:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:2730 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234582AbiAYXCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643151766; x=1674687766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c7U1oexDbl/SlmK7PbtMWHCKv4u7m75odnW2SzZd0Rc=;
  b=WWSOrJlyNsaT2RLmXIGgQGHzzgbGLYf7FHH1jrM17V4oehQ0pHzFiX3q
   dHQ3D+WK35Jgq6tJLAJBxTo9hVvdnZbuOX6dYSaVjw3AsMzAqnDE8LyNZ
   RYLPbd4PWSy9ExQFK4P8AUXmhRo+lINqJrKvE5hdKZTNudparNrwBxZwD
   KsA2ojv2IeF33Zc80z0OCsV35N/xkhyMDG1e4CndIkisH2IVMoDIo2pP/
   AlWyKHLFgGYrofMLu2v6nNv0xezCtoHmvBjAJaxlskQotijVmZfsRulX7
   B91RiA9HAviDAXSPN3XdadTJu7joHt61WewhF08G7T9TnkkEMpmRBaXWh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227108404"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="227108404"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477289996"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 15:02:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCUpU-000KXX-FH; Tue, 25 Jan 2022 23:02:24 +0000
Date:   Wed, 26 Jan 2022 07:01:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 37/165] drivers/gpu/drm/xe/xe_irq.c:30:6: error: no
 previous prototype for 'gen11_gt_irq_reset'
Message-ID: <202201260746.o0wAH4uG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: 0fc4361f4fc10e980acdb7328ad17d66aa1c3644 [37/165] MOAR
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201260746.o0wAH4uG-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout 0fc4361f4fc10e980acdb7328ad17d66aa1c3644
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xe/xe_irq.c:30:6: error: no previous prototype for 'gen11_gt_irq_reset' [-Werror=missing-prototypes]
      30 | void gen11_gt_irq_reset(struct xe_device *xe)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/gen11_gt_irq_reset +30 drivers/gpu/drm/xe/xe_irq.c

    29	
  > 30	void gen11_gt_irq_reset(struct xe_device *xe)
    31	{
    32		/* Disable RCS, BCS, VCS and VECS class engines. */
    33		xe_mmio_write32(xe, GEN11_RENDER_COPY_INTR_ENABLE.reg, 0);
    34		xe_mmio_write32(xe, GEN11_VCS_VECS_INTR_ENABLE.reg,	  0);
    35	
    36		/* Restore masks irqs on RCS, BCS, VCS and VECS engines. */
    37		xe_mmio_write32(xe, GEN11_RCS0_RSVD_INTR_MASK.reg,	~0);
    38		xe_mmio_write32(xe, GEN11_BCS_RSVD_INTR_MASK.reg,	~0);
    39		xe_mmio_write32(xe, GEN11_VCS0_VCS1_INTR_MASK.reg,	~0);
    40		xe_mmio_write32(xe, GEN11_VCS2_VCS3_INTR_MASK.reg,	~0);
    41	//	if (HAS_ENGINE(gt, VCS4) || HAS_ENGINE(gt, VCS5))
    42	//		xe_mmio_write32(xe, GEN12_VCS4_VCS5_INTR_MASK.reg,   ~0);
    43	//	if (HAS_ENGINE(gt, VCS6) || HAS_ENGINE(gt, VCS7))
    44	//		xe_mmio_write32(xe, GEN12_VCS6_VCS7_INTR_MASK.reg,   ~0);
    45		xe_mmio_write32(xe, GEN11_VECS0_VECS1_INTR_MASK.reg,	~0);
    46	//	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
    47	//		xe_mmio_write32(xe, GEN12_VECS2_VECS3_INTR_MASK.reg, ~0);
    48	
    49		xe_mmio_write32(xe, GEN11_GPM_WGBOXPERF_INTR_ENABLE.reg, 0);
    50		xe_mmio_write32(xe, GEN11_GPM_WGBOXPERF_INTR_MASK.reg,  ~0);
    51		xe_mmio_write32(xe, GEN11_GUC_SG_INTR_ENABLE.reg, 0);
    52		xe_mmio_write32(xe, GEN11_GUC_SG_INTR_MASK.reg,  ~0);
    53	}
    54	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
