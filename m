Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1711C58B2C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiHEXfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiHEXfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:35:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B0DF2D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742538; x=1691278538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uDXxiDElBPbImf4mIORm4Inhv8LEScQQfXKpMcCxE2c=;
  b=fQrn+UkyLSGOfrfri+m2WKAGu6NpE1Wod2cu3lXwOPExYQgsff+lM2YA
   RKmSzbQ6b0EDcU7yUi2aJ27JGUMyaV0YDdZ4m0Ek90bc87Nyw5wnSeBbj
   sqjD/aLQfUqFwjiQAwKPrMCpgwTrwMkmy/cui2ZUJKNDzvEPKjXE6164L
   6lJIdOW29nUpdUPQPOd/8+Tq5M1uyV7vhCa1J7lYB/Ko20LDLv+tt2e15
   W2XH06qgeu+IoRUGBOw7DqGSHXFBhv69NL/XlLxO2n59CYRRGM9Csov/E
   PXLagYxAaqleMvfyZL9UIxfEDu5j19v7XAeOvl/8koJTwMUhblnMQ5Z5d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270084790"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="270084790"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="554278036"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2022 16:35:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK6qt-000JpH-1v;
        Fri, 05 Aug 2022 23:35:35 +0000
Date:   Sat, 6 Aug 2022 07:35:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: kismet: WARNING: unmet direct dependencies detected for
 SERIAL_SUNPLUS when selected by SOC_SP7021
Message-ID: <202208060747.XUWqMQwR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   74cae210a335d159f2eb822e261adee905b6951a
commit: 0aa94eea8d955c82014e5368a843da93f1dc58f8 ARM: sunplus: Add initial support for Sunplus SP7021 SoC
date:   4 weeks ago
config: arm-kismet-CONFIG_SERIAL_SUNPLUS-CONFIG_SOC_SP7021-0-0 (https://download.01.org/0day-ci/archive/20220806/202208060747.XUWqMQwR-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0aa94eea8d955c82014e5368a843da93f1dc58f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0aa94eea8d955c82014e5368a843da93f1dc58f8
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_SERIAL_SUNPLUS --selectors CONFIG_SOC_SP7021 -a=arm
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS when selected by SOC_SP7021
   
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=n])
     Selected by [y]:
     - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
   
   WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
     Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
     Selected by [y]:
     - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
