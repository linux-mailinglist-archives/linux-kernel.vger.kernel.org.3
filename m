Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817194AAD67
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 02:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381509AbiBFBtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 20:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381498AbiBFBtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 20:49:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF139C043188
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 17:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644112138; x=1675648138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xq2LzJSvo811LDbI9MQ1lwwYqF/DxjNmP8V+LrgKydg=;
  b=FEienwzFJS3VNc6LUZj0f7+dgkuMf6cDn6U2MpBN3FKS1035iEEfa0Zg
   +dbOcpmMcMh0f6PA1ViqDS4kOvis25QeTpuIG2G8H0BabZmiQcCjYgIwG
   sFjIaV9p9lg2omr3za5BSshNBPoXbCjewksn8LuB0lu5PIPHTlXB8cufd
   ajBCnfzPC/8VwDFOt9ePB7CmDyZVUynTWY/LsxQe6z16t4kpPZWAcgBLE
   eyF1yTg3+2CydkcC4mMZxcwjOeLKT76FW7tLkCbwbeevPgqAn5bu59m83
   ZGPfueGtB7TUT2uvXZb/euolHlDplRgCaaIH1TovCIbhz/4/QxsW20ozC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="273060451"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="273060451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 17:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="481200812"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2022 17:48:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGWff-000ZjN-QF; Sun, 06 Feb 2022 01:48:55 +0000
Date:   Sun, 6 Feb 2022 09:48:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>
Subject: drivers/pinctrl/pinctrl-starfive.c:1029:2-3: Unneeded semicolon
Message-ID: <202202060827.9dExlwbc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
commit: ec648f6b7686b716424e8e73eebb4c11ae199187 pinctrl: starfive: Add pinctrl driver for StarFive SoCs
date:   7 weeks ago
config: riscv-randconfig-c003-20220206 (https://download.01.org/0day-ci/archive/20220206/202202060827.9dExlwbc-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/pinctrl/pinctrl-starfive.c:1029:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
