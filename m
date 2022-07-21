Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6232957CB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiGUNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiGUNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:14:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0E3C8CD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658409272; x=1689945272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sCXCtv41801LvQGsNVUf9c540aOtmE9BQ1Ccw7AXtVU=;
  b=ENacTCU4/vVDf+rUddnuW50upcB7AcFkMWMj03+o1Ace5YKqxSyGfSrF
   8XcaKXRKiN5Z0JKCj+r9n+JdtZYWDMFznTK47yTLI74GommjjNaY9CmgN
   R8dm7xsVuVSahv53bP3byGwwXpIKYU/+Mff/81dLF0M67bk5HjsXSzoaV
   QpvtdCfN0FPguqKk9Ji7LWOG6Cont2OOq5RtiTJ+ZI0tHyproSgOnxWmP
   hvOlzK5CF+67Mv4KvnfdGqOUSb08cBLwjSM3C31QBvp2knBoL8y60W2yB
   3r2Cy3G5s+eVDa76r03dCEmST8fM/zi1rHB97cH2iw34M5JooQC7Fmk9X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285803474"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="285803474"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 06:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="666282654"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2022 06:14:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEW0b-00008o-2d;
        Thu, 21 Jul 2022 13:14:29 +0000
Date:   Thu, 21 Jul 2022 21:13:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, build@wireguard.com,
        linux-kernel@vger.kernel.org
Subject: [zx2c4-wireguard:jd/new-archs 1/3] ERROR: modpost:
 "schedule_hrtimeout_range_clock" [drivers/net/wireguard/wireguard.ko]
 undefined!
Message-ID: <202207212115.Dutn6aMv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git jd/new-archs
head:   627fef82b5cfcb865fd8cf67d2d18f17c8c2b2a2
commit: 82c472126eb825e1e5ed42599a5e78fd69eac274 [1/3] wireguard: ratelimiter: use hrtimer in selftest
config: microblaze-randconfig-r012-20220718 (https://download.01.org/0day-ci/archive/20220721/202207212115.Dutn6aMv-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git/commit/?id=82c472126eb825e1e5ed42599a5e78fd69eac274
        git remote add zx2c4-wireguard https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git
        git fetch --no-tags zx2c4-wireguard jd/new-archs
        git checkout 82c472126eb825e1e5ed42599a5e78fd69eac274
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "schedule_hrtimeout_range_clock" [drivers/net/wireguard/wireguard.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
