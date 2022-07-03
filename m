Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7755648AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiGCQwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiGCQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 12:52:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6096315
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656867122; x=1688403122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cP/0Fsxio3K1+RJNipDDMsxZZwRQCXNoH3rPZtSX6GA=;
  b=WmR2RWQbHQ4O9MZRK+K02RCNKA3bJH4tkuOtgq+QJ2ihbwLiEbDAaZ/o
   RZnZYIPkn5zJ5oceOzMEgw8/CcjdZZpSIl3tapGbfzdYtLsUz60PrKTnm
   lkoNF3kLAozcffCINyTgV6kARkVJPhytGGjTLijGj8OoNHmcpzUHELhIS
   2sFVGZYcBrQKPLcEeikhvS5wjmmC9kayK3V5PGtf7awnHwLn6v9ioVXSw
   B3sEtqvs9g91gwL1hr6HcS24b+imHgr3q0JwcgRbn+uq8TduFELhwEU50
   T+y5d4A1nnhnAI8EIlatUQrSGZrdYCfEffkI8KufQU1fyyBnXhONC25KL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="346945781"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="346945781"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 09:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="734577408"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2022 09:52:00 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o82pD-000GiC-LX;
        Sun, 03 Jul 2022 16:51:59 +0000
Date:   Mon, 4 Jul 2022 00:51:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 131/147] kismet: WARNING: unmet direct
 dependencies detected for RESCTRL_FS when selected by ARM64_MPAM
Message-ID: <202207040014.dB1KTsoy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   9d1850bbdc3c9b2b9b6fce8963cde5b0a38fb2d7
commit: f6b210f219ae4d7f5e18979ef80ecbc9c41c15f0 [131/147] arm64: mpam: Select ARCH_HAS_CPU_RESCTRL
config: (https://download.01.org/0day-ci/archive/20220704/202207040014.dB1KTsoy-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=f6b210f219ae4d7f5e18979ef80ecbc9c41c15f0
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout f6b210f219ae4d7f5e18979ef80ecbc9c41c15f0
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_RESCTRL_FS --selectors CONFIG_ARM64_MPAM -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for RESCTRL_FS when selected by ARM64_MPAM
   
   WARNING: unmet direct dependencies detected for RESCTRL_FS
     Depends on [n]: MISC_FILESYSTEMS [=n] && ARCH_HAS_CPU_RESCTRL [=y]
     Selected by [y]:
     - ARM64_MPAM [=y]
   
   WARNING: unmet direct dependencies detected for IIO_BUFFER_CB
     Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
     Selected by [y]:
     - JOYSTICK_ADC [=y] && INPUT [=y] && INPUT_JOYSTICK [=y] && IIO [=y]
   
   WARNING: unmet direct dependencies detected for RESCTRL_RMID_DEPENDS_ON_CLOSID
     Depends on [n]: MISC_FILESYSTEMS [=n]
     Selected by [y]:
     - ARM_CPU_RESCTRL [=y] && ARM64 [=y] && ARCH_HAS_CPU_RESCTRL [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
