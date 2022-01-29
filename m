Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257EF4A3223
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353266AbiA2V6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:58:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:27968 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353251AbiA2V6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643493480; x=1675029480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3yO4Wbt2b5XcGXvuSkb5dGDuvjLk8V7TZRd/d7g/EA=;
  b=SyVqutczue8MY6Tc88FaZY3hzAu0xUhoJnGOfpI8gWI9drntx/w0ysla
   OIyC+uDZ+jAQRQJ99U3mvvcNxVq4qcOXxn5LDbHB3AwtCZfXXF418jx/L
   8654thGJcIMa2CcNGTns7ZiIjDnCCxCcEV66Y1VzjxD4n+bRPO/TONWKt
   qhDLqypQnU75kG48/uApfVtj7bSACsoUAG1np+1O5ofStAml1qycLvCm8
   0qe9zyTjQU9uiXUuUngxI8p4KKNPzILOdifHYUy4xQ7T4jU2XI8WXyN1u
   v+IFuFTzkEpZh4CQTQDKRAOv50p3jPODI01A6LwRnpJRcqguRYJaYS/Fd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="308029274"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="308029274"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 13:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="564553849"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2022 13:57:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDvjJ-000Pgi-PN; Sat, 29 Jan 2022 21:57:57 +0000
Date:   Sun, 30 Jan 2022 05:57:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_aia_v1 3/21] arch/riscv/kernel/smp.c:120:2-3:
 Unneeded semicolon
Message-ID: <202201300500.BuB28g96-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_aia_v1
head:   c0d96c2f57e644a9ec0819785541e033f8ce5e6b
commit: bbfd82cb293e2c4fe309a1c9bf59d3a4d9459d26 [3/21] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-c024-20220129 (https://download.01.org/0day-ci/archive/20220130/202201300500.BuB28g96-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:120:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
