Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B74F4E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587366AbiDFAIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356598AbiDELPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:15:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F27F239
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649154964; x=1680690964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LDJjU9zCF2yUo6JmrZW5kQUAHhzbUQYV3bIsKsJG9dQ=;
  b=EMfXiqVZYVJrKpm9UqePJXBzXGl2VE42g9GY6xJOIYLD4kyPSr7vCYTc
   CjlfPPk3tOupB2yDsO8bPCueLb2ZmAIOubXOTi4Mq2zVBhcDaVC+2TQgS
   M3SY1c5ccgvZ9278o5ebX96FYEekD8mouTzQFMs+B+rn5mhGNvbwgU8dW
   lvoCvkr/Kp62fw82ics5qsiOAZIx4CR66HyMlxLSh9nCit+DqORI+uz/u
   JcV2m6Mt940rPcXJIe+7iUPFP4wO3D4jCGYGsYHm/9JiRvPgwnr2THgjH
   9DaUaeavonyYYOOH8BIJ3/IxUF4+mAdGRi+6/4a0Aq46eOCpAOzYBUClI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260413920"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260413920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569824757"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2022 03:36:02 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbgXZ-00034B-Up;
        Tue, 05 Apr 2022 10:36:01 +0000
Date:   Tue, 5 Apr 2022 18:35:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 9/29] arch/riscv/kernel/smp.c:120:2-3:
 Unneeded semicolon
Message-ID: <202204051806.SNUnP4eo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   dab41b5c8f55fb8e864a5e10fd181dd0d4443778
commit: 9951f846b51d68f916cfa08140171cbcc8c0d02b [9/29] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220405/202204051806.SNUnP4eo-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:120:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
