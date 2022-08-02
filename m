Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD55877D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiHBHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiHBHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:31:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33363E1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659425471; x=1690961471;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YfPZ9jGO8TGdyQe6z1+YCzrSqurJjWAFBq482Dhoc60=;
  b=h9cCeAC+vJYB9BFSnfTdoYrw0E42rLtv4rwb34JQDu0QESXr0hbfbqj6
   2elzzIDXqq2orNjzkQw0iuyUnRd+lIIV2LCJwNNcHLtFt+jOIPDhPAtL1
   UfjBBCmILUe2cDf0sGUoyXWrX9EIpN+eP14mDfDFzpts1mLw+HclkthCN
   PXYWoc8aVCubBwA11HWfO2hFinSSxGmJjrWsVAN9A6GdnsmChiky1/Db8
   W/NyaIW9WlC+X6lllsOko1l0p3qQ+JTvxqoZVbu5dowGEWHzj7VqQbG8V
   XKiqH5Gcd6EbbSUNbapNDstqbnp7DPBjfHtFNXXlbsBr6FlJUciL3VhLT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290558237"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="290558237"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="929865343"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 00:31:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oImMu-000Fox-2x;
        Tue, 02 Aug 2022 07:31:08 +0000
Date:   Tue, 2 Aug 2022 15:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongarch-cpu.c:66: undefined reference to
 `liointc_acpi_init'
Message-ID: <202208021528.FiUMZ8BX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9de1f9c8ca5100a02a2e271bdbde36202e251b4b
commit: b2d3e3354e2a0d0e912308618ea33d0337f405c3 irqchip: Add LoongArch CPU interrupt controller support
date:   13 days ago
config: loongarch-randconfig-s053-20220801 (https://download.01.org/0day-ci/archive/20220802/202208021528.FiUMZ8BX-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2d3e3354e2a0d0e912308618ea33d0337f405c3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b2d3e3354e2a0d0e912308618ea33d0337f405c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `liointc_parse_madt':
>> drivers/irqchip/irq-loongarch-cpu.c:66: undefined reference to `liointc_acpi_init'


vim +66 drivers/irqchip/irq-loongarch-cpu.c

    59	
    60	static int __init
    61	liointc_parse_madt(union acpi_subtable_headers *header,
    62			       const unsigned long end)
    63	{
    64		struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
    65	
  > 66		return liointc_acpi_init(irq_domain, liointc_entry);
    67	}
    68	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
