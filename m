Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00A25A3EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiH1RcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH1RcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:32:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9CF9FEB
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661707942; x=1693243942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O2dR0BW2PeqIsrT4eW3b9WtboL5iwk7ul0IK/THKWAM=;
  b=TaxZ418p2yrOjrj43riQS5OHXs4g3CHiZrcXXvWgN7KILBF/37SrKBaE
   EyXe6WXZCLE7BYvbjBMB2y3v8UW9if/+TkSC5sw6WSmdBWrOBHZclxBAM
   /OXhW/Z9UIMAynQi0qyiAGzKPdI20CS34R5vkI9Lbi1HSmiiYymV0dXIr
   7HLJeIToldh9+23s9HYnFJllq9LrVJA6NTDgroMJGXGYbioSWzPeePoG6
   dybVTvGDWeRj3HKhy6TVaRlU3HI0aUw+1STJ9MMFFvuZcnjhe83i7GSyV
   uzuy6pxTLaHH4LD0WJCZyAY0R7khmy0NRKRWydgNs4N/oQWW8p4z7za3W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="356471398"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="356471398"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 10:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="939325715"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2022 10:32:21 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSM8y-0001RD-25;
        Sun, 28 Aug 2022 17:32:20 +0000
Date:   Mon, 29 Aug 2022 01:32:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_pmem_v1 23/40] arch/riscv/kvm/aia.c:204:36: sparse:
 sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202208290123.UHD6rzKM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_pmem_v1
head:   b93a90a0cf40bdff2e68b0d1c6ed27f5e7310ec9
commit: b06e7bdfd87f2fbee3c3a0860c3cdc99d5a33386 [23/40] RISC-V: KVM: Implement guest external interrupt line management
config: riscv-randconfig-s032-20220828 (https://download.01.org/0day-ci/archive/20220829/202208290123.UHD6rzKM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/avpatel/linux/commit/b06e7bdfd87f2fbee3c3a0860c3cdc99d5a33386
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_pmem_v1
        git checkout b06e7bdfd87f2fbee3c3a0860c3cdc99d5a33386
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
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
