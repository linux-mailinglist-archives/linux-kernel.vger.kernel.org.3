Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E0C57F0FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiGWSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiGWSrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:47:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394A18B34
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658602067; x=1690138067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1ECav4HtFYudvaPmMRZzsXGwrk6uv8N6nqaCKwqx/q8=;
  b=NeEa8+ygOYilEwBHRoPEac99hEnzfHrtxY036rfRTuvCTRXiL2j+ChGE
   vVfYiHeKoMY5y552+JYONzCFJhfp7Tx4yg1ocB9luC31RaSU39Turru1e
   m5hGaF8MverueVN7ZAHJ4I+a24BF4Hi2fX6476QPqvvB/AuPM603Am84q
   Sv867sS2jb4DQHKKgy488ZBVR7AthLUYsGMTJf4223Q4Y6nfZ28Yp9rrx
   n8BpBTSjgZCSJmbT6LJPMnDMlzKCm6JZj8JPguFHI7CWlF3BkQZdBM5to
   Q7FgUglk5yc8pGIdY/fvAhegIKh2TUxB/Q9NerlHc9+wXdt2T59UdXwv+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313225880"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="313225880"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 11:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="574532180"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2022 11:47:46 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFKAD-00030T-17;
        Sat, 23 Jul 2022 18:47:45 +0000
Date:   Sun, 24 Jul 2022 02:47:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_sbi_dbcn_v1 20/44] arch/riscv/kernel/smp.c:120:2-3:
 Unneeded semicolon
Message-ID: <202207240221.tWRs90jw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_sbi_dbcn_v1
head:   1b3aaa127f01dc1a35b6595c628a38b92832488d
commit: 5cbf32460e4d1f3876930e54e0b4599310c84ea4 [20/44] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-c041-20220722 (https://download.01.org/0day-ci/archive/20220724/202207240221.tWRs90jw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:120:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
