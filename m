Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7458554767A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiFKQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiFKQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:33:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C5205
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654965203; x=1686501203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KwPq23dgtcZBRYpy3d4B8Q7tdftpko7l4P7B0axTd0A=;
  b=UEXNvVOjb9KmcX29Mg6JfqnII0PCPHV1VQclSh168oDmkY2kjKZ9krZ9
   GvBPtXbgXapn14UKA/KXw7oywgN76WJ0pLwaAWOlZlle1O01Va5AAnSOq
   DsjlkmF6YgL71NeVLcEv4rHzLRdbCoaBbiaV33zfBZ19gtwEXlNbILGwl
   eLWcG5wsvl1rvGAp2MDzIo3OLi1gKNmARXJ/hj1k180UwVV1EafjW8+mp
   W8yQzf2dgg/DPs4qMfkUse9yck7S1XI36cz0eznhJwxFuasQE5eyhfAyz
   JqFBMhJyc5dtL8owWFAzKUGOrW8PY5URmfrKFsl+dvTbFWuNl05FpqB9k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="339631604"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="339631604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 09:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="586817907"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2022 09:33:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0437-000J57-9D;
        Sat, 11 Jun 2022 16:33:21 +0000
Date:   Sun, 12 Jun 2022 00:33:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 27/29]
 arch/riscv/kvm/aia_device.c:105:4-5: Unneeded semicolon
Message-ID: <202206120050.07VzCnCL-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   9c50a2eb51ca70ba23cf9bc8cef121e8765b2c01
commit: 30714da277239a512ab5f727f537c8ab4b2896f8 [27/29] RISC-V: KVM: Implement device interface for AIA irqchip
config: riscv-randconfig-c024-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120050.07VzCnCL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kvm/aia_device.c:105:4-5: Unneeded semicolon
   arch/riscv/kvm/aia_device.c:165:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
