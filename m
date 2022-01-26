Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA649C40F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiAZHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:09:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:58118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbiAZHJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643180978; x=1674716978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uJdno5EhURhWjzTEyrdAX2gBFzmNymNcAfENZ5BxDgc=;
  b=QyvryfK1P5L7cuPpB6cWTgFLavgmBAAXjStUdFDfFPdDY9oCmn3RFZrU
   LqEOT7SltCALgWwI22qdeZoY4m6uewNN0rie0TiETu+soguaEX79B3x5M
   T6y3ZSrRlcmc2gayKIOfR7VaK75bSUQdavCY0Y1IN2wtaAuoJZ8FXtn6N
   pPG5eMOkfwrJD1d/4MzO2inynlblP3ZW2B4LLfrfjm0tykHmEk7qAc8dU
   /aDFxw39/lgY4zRDlXqACBCXwYzEjC61Sg2n0QY0zCRuV3RPJZtPmyGWi
   kRUxejG4FMedPsGLPhp8A90OinKd7Lkv7UET1HVsFVeiUBgmksDQhkAW6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230069281"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="230069281"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="563327314"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 23:09:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCcQy-000KuN-DY; Wed, 26 Jan 2022 07:09:36 +0000
Date:   Wed, 26 Jan 2022 15:08:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Airlie <airlied@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [mlankhorst:xe 40/165] drivers/gpu/drm/xe/xe_mmio.h:28:9: error:
 implicit declaration of function 'readq'; did you mean 'readl'?
Message-ID: <202201261503.3tLspdsf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://people.freedesktop.org/~mlankhorst/linux xe
head:   4bc3039b4403c76a13d58f7ac1f7c07dca6f88d8
commit: b438fc88b386c9beafe4bfdce3986025b59ae64d [40/165] xe/mmio: add 64-bit register read
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201261503.3tLspdsf-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add mlankhorst git://people.freedesktop.org/~mlankhorst/linux
        git fetch --no-tags mlankhorst xe
        git checkout b438fc88b386c9beafe4bfdce3986025b59ae64d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_device.c:17:
   drivers/gpu/drm/xe/xe_mmio.h: In function 'xe_mmio_read64':
>> drivers/gpu/drm/xe/xe_mmio.h:28:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
      28 |  return readq(xe->mmio.regs + reg);
         |         ^~~~~
         |         readl
   cc1: all warnings being treated as errors
--
   In file included from drivers/gpu/drm/xe/xe_irq.c:9:
   drivers/gpu/drm/xe/xe_mmio.h: In function 'xe_mmio_read64':
>> drivers/gpu/drm/xe/xe_mmio.h:28:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
      28 |  return readq(xe->mmio.regs + reg);
         |         ^~~~~
         |         readl
   drivers/gpu/drm/xe/xe_irq.c: At top level:
   drivers/gpu/drm/xe/xe_irq.c:30:6: error: no previous prototype for 'gen11_gt_irq_reset' [-Werror=missing-prototypes]
      30 | void gen11_gt_irq_reset(struct xe_device *xe)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +28 drivers/gpu/drm/xe/xe_mmio.h

    25	
    26	static inline uint64_t xe_mmio_read64(struct xe_device *xe, uint32_t reg)
    27	{
  > 28		return readq(xe->mmio.regs + reg);
    29	}
    30	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
