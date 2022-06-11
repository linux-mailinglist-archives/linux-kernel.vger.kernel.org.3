Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE24F547482
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiFKMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 08:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiFKMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:30:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F139D55
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654950615; x=1686486615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b2Xt/Zsldk/qA4EWkzfW2mGOztA4a1n6cXLBpgrBuiA=;
  b=bx7G/xDg2+mMReIA0kY3GD5EsOPpjjVsd96r02Y9P+smlJsfM68hFJl6
   DGaDY4Cuc3iPe+Gl6KpvQt9MlhYvTVelv8ZfOZ2r1SF/Cba5Fe/8Etg/r
   6tlNAQsrAmEMAYl/AvaWHfYkBufqP8Td4gcyJwIUr2qdRcRStnKqCXf0n
   /avOBDPh7FPC3keqOyPugHmCB+q2uP2smXxfgY+6lkFHQtDmva095DsUT
   LbxecCwDfE8UgWp/CCK14gwzy+qQDieqng+aysp85v8rD0VgoLaXtJFi+
   xkxJcvHU5rfF6EAXd+ZRwX6+SjgYsA7PE8lZO+Q2hdFrTJMcnGRHS0E4E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278986968"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="278986968"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 05:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="567250115"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2022 05:30:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o00Fo-000IsZ-Vc;
        Sat, 11 Jun 2022 12:30:12 +0000
Date:   Sat, 11 Jun 2022 20:29:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_csr_v1 22/22] arch/riscv/kvm/vcpu_insn.c:286:2-3:
 Unneeded semicolon
Message-ID: <202206112030.9yWPkDFu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_csr_v1
head:   12aed2cee9c843e0a9c8ab0d2db2b2d40ec46057
commit: 12aed2cee9c843e0a9c8ab0d2db2b2d40ec46057 [22/22] RISC-V: KVM: Add extensible CSR emulation framework
config: riscv-randconfig-c024-20220611 (https://download.01.org/0day-ci/archive/20220611/202206112030.9yWPkDFu-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/vcpu_insn.c:286:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
