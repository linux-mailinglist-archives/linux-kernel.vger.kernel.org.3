Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302B5475DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiFKPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiFKPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:00:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866CF5A095
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654959618; x=1686495618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/sGcbr6Om4nizcD1B7N2v+rlnT2Bo4o8raxiJd14DwU=;
  b=OAN6UGNalZqX5oKu1+WW/cEXQpBtnMHhsClrGyUFiUKllrljEs1oz2i2
   d+8HtW6D9J70Cw1Jmyp9HLhwjgcN0ELbPS9TII0aBOZOFqmmOD07sesoD
   BEAZeMt42FRhv93Qnjs8z0fKtJbfeLafINTAlCMNTb+SQt5EjclQWIZCX
   lhrbZEc89XtqjPzoSxc4N5fWlz19mZEkvZfZZswfg6RjI7z/dXkFljv9f
   dYvWMArJ3vnVQR375o5nt2PalOT5y7aRgb3yiUO7wA0olQrzWIOcWWt8U
   XZoopLh2OcmeElwD9cE1WcExZC6nY84LDxArOcWUMaR1yNzL0g/3C5ubV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="257727943"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="257727943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 08:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="586796321"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2022 08:00:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o02b2-000IzN-Pg;
        Sat, 11 Jun 2022 15:00:16 +0000
Date:   Sat, 11 Jun 2022 22:59:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 26/29] arch/riscv/kvm/aia.c:324:2-3:
 Unneeded semicolon
Message-ID: <202206112231.Oz0t7IEP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   9c50a2eb51ca70ba23cf9bc8cef121e8765b2c01
commit: 4b5db34c607d39e59bdd3b0f37864643f5c31924 [26/29] RISC-V: KVM: Virtualize per-HART AIA CSRs
config: riscv-randconfig-c024-20220611 (https://download.01.org/0day-ci/archive/20220611/202206112231.Oz0t7IEP-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/aia.c:324:2-3: Unneeded semicolon
   arch/riscv/kvm/aia.c:357:2-3: Unneeded semicolon
   arch/riscv/kvm/aia.c:383:2-3: Unneeded semicolon
   arch/riscv/kvm/aia.c:235:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
