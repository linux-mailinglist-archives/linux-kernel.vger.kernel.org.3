Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDC547702
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiFKSFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFKSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:05:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C0B6B7F8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654970726; x=1686506726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/VlIlvTfSGywLWQgQEq2StR6JfxihETKYtXLN4/4eLM=;
  b=Ijb9Y4DZYaoRAv8Sh1ogyjigo1oAESRtRf07pMzEH1nlRiLXB5qwk3mG
   SRpFgwo/VU8HZkq7THnT8uQHa+PxbpBE5G/RxaXUGM804RW6rZBoM4DVW
   YUrdDsPV+erU4ISDco3K4a7N9XpSmi2DBLCreli2qYTo9c/435aJLPEm1
   LYuBMSPA98wrFQC+cWEFHAeXB0nC80CrC8fQ6zE18ziYPBuHklrwWj6eg
   F3yfD/PjghJvjDMiGRUz7/zse8XSgaDgt7XmOesp/hiSqhfcUPOPJe6MS
   xoDOIaBW5zZVH1GPyiZPKHAIPftSemok/Ishrk0T5iaiiiue68SiX/mhA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="277958155"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="277958155"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 11:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="638790562"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2022 11:05:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o05UC-000JA2-6v;
        Sat, 11 Jun 2022 18:05:24 +0000
Date:   Sun, 12 Jun 2022 02:04:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 29/29] arch/riscv/kvm/aia_imsic.c:166:2-3:
 Unneeded semicolon
Message-ID: <202206120248.mJ38gK4l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   9c50a2eb51ca70ba23cf9bc8cef121e8765b2c01
commit: 9c50a2eb51ca70ba23cf9bc8cef121e8765b2c01 [29/29] RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC
config: riscv-randconfig-c024-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120248.mJ38gK4l-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/aia_imsic.c:166:2-3: Unneeded semicolon
   arch/riscv/kvm/aia_imsic.c:90:2-3: Unneeded semicolon
   arch/riscv/kvm/aia_imsic.c:129:2-3: Unneeded semicolon
   arch/riscv/kvm/aia_imsic.c:663:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
