Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566505649E4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGCVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiGCVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:16:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB512DF6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656882988; x=1688418988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GkRyGvNZVtUc2r1EYQAaaERIoWcsWusdoPDd88qSy3w=;
  b=gsKDauwYCvmcqEQzPf4LgfLsTz9HWoklvky76EgSi3RDEn16ncVWV1iT
   fzbkJPAD+NI/PfM7ljRytJX11yOLQIXydrIo+wDLmbIdvTG5WNUO6KKkE
   kFu4PdqCmF74tFrJ36I7DxtTaqvOKEmFgACsK6EqnWpShusCvmtqShHxl
   gH7iToewoO6ELnflLotwcJOd3dzA0MaPe3xMvX+z6du6k3qVkLYee0j11
   585KmLtZTZAYSee6Npc6wy+r+ewDwXwUYRTqTaJNzdX/lYd9VrmCDRrLl
   uTWbBXAgmFlyv76To2MWXgddMOT1WFLkw+bSJkBQGoasIl2fS+KPSxaXI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283014396"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="283014396"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 14:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="719192469"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2022 14:16:26 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o86x8-000Gz5-6R;
        Sun, 03 Jul 2022 21:16:26 +0000
Date:   Mon, 4 Jul 2022 05:16:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 97/147] kismet: WARNING: unmet direct
 dependencies detected for RESCTRL_RMID_DEPENDS_ON_CLOSID when selected by
 ARM_CPU_RESCTRL
Message-ID: <202207040552.lzeUnyUb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   9d1850bbdc3c9b2b9b6fce8963cde5b0a38fb2d7
commit: 49e55977a0ed88794b6abe4c959e3e28ccd54913 [97/147] arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
config: (https://download.01.org/0day-ci/archive/20220704/202207040552.lzeUnyUb-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=49e55977a0ed88794b6abe4c959e3e28ccd54913
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout 49e55977a0ed88794b6abe4c959e3e28ccd54913
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID --selectors CONFIG_ARM_CPU_RESCTRL -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for RESCTRL_RMID_DEPENDS_ON_CLOSID when selected by ARM_CPU_RESCTRL
   
   WARNING: unmet direct dependencies detected for RESCTRL_RMID_DEPENDS_ON_CLOSID
     Depends on [n]: MISC_FILESYSTEMS [=n]
     Selected by [y]:
     - ARM_CPU_RESCTRL [=y] && ARM64 [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
