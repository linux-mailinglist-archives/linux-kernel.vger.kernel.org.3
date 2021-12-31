Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC74823F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 13:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhLaMPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 07:15:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:21729 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhLaMPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 07:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640952954; x=1672488954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LKd+D52akhFhXjrKsO1jJ4sQVJPGl/N+ZDu1amsHgWE=;
  b=T3dtHSlWP+eSxjQ5/VBIkab28KCAaxRm0umTZuR7slcXplJXeEw6pZ2g
   CvOB0G66J6BSQT0LgHG0tKwXHy3AiBAH5boDinOJ9jQxLBQhTKtKKlvnE
   5eCXa38i6ojDNWK+JqoVPr4rrYvj05u4nBXmiOdGv+5CgMUlQkFK/gF1/
   VuXT1GDABqSx8Ay7hDoivraD/SirIHurWiOk37D8/Ldtih72qTmkm3qm0
   iXx18g1rauya7b9xpwZyJS9fwIPfh5XFRoWC1Ui+eaxCfQ8qWC0kNcboT
   nMJAi6qX3mw/sXZuyymAJBc7qD0X8WtcG1jwPenRkGK0beu9ZMtnV+FjH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="228628695"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="228628695"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 04:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="470936441"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 04:15:52 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Gp6-000BEM-9c; Fri, 31 Dec 2021 12:15:52 +0000
Date:   Fri, 31 Dec 2021 20:15:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 17/42] arch/riscv/kernel/smp.c:130:2-3:
 Unneeded semicolon
Message-ID: <202112312054.ZfoKGMHF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   6fa93cde61f5f84422bd3f97b9db6e2406a344dd
commit: dea7752f30104c9bb3c2c67ce2c56e5a5eb3c290 [17/42] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-c004-20211231 (https://download.01.org/0day-ci/archive/20211231/202112312054.ZfoKGMHF-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:130:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
