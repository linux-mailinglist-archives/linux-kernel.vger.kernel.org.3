Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53ED4BCFFF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiBTQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:55:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBTQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:55:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C1424A8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645376084; x=1676912084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c+21qTPmbpB+gx2aJ/R3yEGsTi43OA9LWJDfydwlWxo=;
  b=mLe4/mfcQZtnXXYXIcnyHbUGhhKyKBfZgVUpDcROYYeb6YsKoJu6vPdr
   6IFiOk7pDU4hPS15/bBpVIeVZdA9ZAT/XkzfuO1j7xwDpzyw1rUcw9ks4
   F3OfAiejnZPQb045knbwJlu7Ah9aZV+goHh8Wt87bp4LWuPJqrgR+9kzz
   Q83x74jOJD/faqhGMJ7Ui0VqZ/ZCC+fThqsf9sSsBml739FMzGOUishY4
   Zf0+VxiEPb6FxsG9SzHEhDGuLUFcku19s95GCOgfP+/EGS6YgQl2bugrJ
   0x846Op83saRyRxMizX08nzQJHLj6Reui72C4gQId4H49Y3PiiLfZg11d
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337819882"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="337819882"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 08:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="531561627"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2022 08:54:43 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLpTu-0000U3-GO; Sun, 20 Feb 2022 16:54:42 +0000
Date:   Mon, 21 Feb 2022 00:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: powerpc64-linux-ld: warning: orphan section `.ftrace.tramp' from
 `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
Message-ID: <202202210005.bC3uU5Ox-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
commit: a1867f85e06edacd82956d3422caa2b9074f4321 mfd: Add Renesas Synchronization Management Unit (SMU) support
date:   7 months ago
config: powerpc64-randconfig-r022-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210005.bC3uU5Ox-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1867f85e06edacd82956d3422caa2b9074f4321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1867f85e06edacd82956d3422caa2b9074f4321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
   powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'
   powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/mfd/rsmu_core.o' being placed in section `.ftrace.tramp'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
