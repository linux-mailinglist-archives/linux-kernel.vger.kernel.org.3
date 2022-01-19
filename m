Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC434933B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351370AbiASDmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:42:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:57556 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344436AbiASDmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642563740; x=1674099740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NAwBp31wWDOCorwPE8XIM9cOF+iPiy27m7wAtH+IrUQ=;
  b=jBBKEgjEZsMtnsLISF+P5Zce1aODaOJLqx8nyqWvFCKyN1ZH2B1b0Nlv
   zjHEHrb8A3m71VrUxt4UzHOCH7u+XNCKTOU1HKMLrDFCPt1I9j1euCpXI
   dfZquGxXhd1hyL+w9hSLJ4Vqm2dxotOMtnE1cUve3+As7mXxXAueAJrDy
   v6Y840V5CmtGravV9LFwCq89bPBQDeF0+n3zs/Cr+z0d9qhiOMft03cD8
   dpUThSnSeciq/Q+3xfeTGY/DdXudgN7Q+Csc0R1r5KSsXyrIv/1sBsmTJ
   1ZVbYhsnNheGSqPkmnbfuawWRApUCq8Peyj14F8mujkUUbLYeneDlWY6M
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244932263"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="244932263"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 19:42:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="518015993"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 19:42:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA1rT-000DDM-5u; Wed, 19 Jan 2022 03:42:15 +0000
Date:   Wed, 19 Jan 2022 11:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-sv48 7/9]
 arch/riscv/mm/init.c:48:11-16: WARNING: conversion to bool not needed here
Message-ID: <202201191124.6Gmmz1ir-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-sv48
head:   d87f3297c62644624bcb8efcb519a2e28d684b45
commit: dee563c628683ce1fab7d0267ad96fc7d8503965 [7/9] riscv: Implement sv48 support
config: riscv-randconfig-c004-20220117 (https://download.01.org/0day-ci/archive/20220119/202201191124.6Gmmz1ir-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/mm/init.c:48:11-16: WARNING: conversion to bool not needed here

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
