Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70865677EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiGETj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiGETjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:39:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8451A39F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657049994; x=1688585994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0jhN9smmYcHL+HKNyyevo5yxW9sIoYha95RCr441IL8=;
  b=ZPvgr2GQe2k2sYggVwqS8z8nzCBVP5dYxu282lHVBsb3vB5Mq9B6a7dJ
   VrJQnf+EI85OQBC+4cL9zbArx9XBSChdgsV94ZqN7IpELVEGkOFyuCu4E
   Wn9TN06l4g57CnkWpwaIJedTLzx3zMckP5AzBthjyvLEcUV/DPHdNcV7d
   7S7UyESIunaRWxI47a7Y4O63NNW9Qo/HNnD2cM59U20VO6jNUO6Zzn9y1
   IjtjJg98jK6OMNuMrQYm5ZvEDx2Erq8t60jUwVji4ys0gPM+0AAKEGnxb
   HVR3MS6c/LRXPJWBsLn4fBvXXjDNChaBvRJeLwwYfNWr3ijj9WHQnQEwL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281020342"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="281020342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 12:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="650318075"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2022 12:39:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8oOm-000JWT-Eg;
        Tue, 05 Jul 2022 19:39:52 +0000
Date:   Wed, 6 Jul 2022 03:39:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 28/32] arch/riscv/kvm/aia.c:204:36:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202207060355.6VaTkLVp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   25efea788788c9750502faf4bee88cdd48418ba2
commit: 286d3fbfb03511fabb0a2d3408a7e8491d688a60 [28/32] RISC-V: KVM: Implement guest external interrupt line management
config: riscv-randconfig-s031-20220703 (https://download.01.org/0day-ci/archive/20220706/202207060355.6VaTkLVp-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/avpatel/linux/commit/286d3fbfb03511fabb0a2d3408a7e8491d688a60
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 286d3fbfb03511fabb0a2d3408a7e8491d688a60
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/aia.c:204:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct aia_hgei_control [noderef] __percpu * @@
   arch/riscv/kvm/aia.c:204:36: sparse:     expected void *
   arch/riscv/kvm/aia.c:204:36: sparse:     got struct aia_hgei_control [noderef] __percpu *

vim +204 arch/riscv/kvm/aia.c

   200	
   201	static void aia_hgei_exit(void)
   202	{
   203		/* Free per-CPU SGEI interrupt */
 > 204		free_irq(hgei_parent_irq, &aia_hgei);
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
