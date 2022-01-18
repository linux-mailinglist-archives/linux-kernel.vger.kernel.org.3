Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46A0492475
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiARLP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:15:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:40146 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239077AbiARLOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504477; x=1674040477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l3Pv/EgkwWzdmGEFFj57mnEtSwZiwM1n2TdYMJE10Yw=;
  b=QDCIvit5tiNPhOY86kXQLV/AManCGx532XJdx89LwR7oboPhyFfChHND
   irnWI1B2YWZIwoZzpqOqxmsFQe7zYWJauCE21hihRkXeMNLtJvaXQ1yby
   uY+NwgUfSUNR77iBO/JZvg/l5w7ufnp4t46ehhoBPAGZxwefidqStSTto
   gvkEwLtRbqTvqpUH0PLSqmEPzp5lKsjv7xJedblLbNAILqbEiQWWOM6pu
   onPuUR1ozBqUGOzEa7H1i0DaE2nVTe8lWXqdsEjBGFL5FHab5VxYrGG/V
   aKIGjZbpkzmOWL1NPqiD/LCoZtBjeNYzU590cDcU6b1ebb+xSGt/G5pQG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244988499"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="244988499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="492634216"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2022 03:14:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mRZ-000CV1-Tc; Tue, 18 Jan 2022 11:14:29 +0000
Date:   Tue, 18 Jan 2022 19:13:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arthur Heymans <arthur.heymans@9elements.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/pmbus/ir38064.c:54:34: warning: unused variable
 'ir38064_of_match'
Message-ID: <202201181742.A2Dm08zD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
commit: e65de225ef2f7eade2888b00970eec37aeca0044 hwmon/pmbus: (ir38064) Add of_match_table
date:   3 weeks ago
config: hexagon-randconfig-r041-20220116 (https://download.01.org/0day-ci/archive/20220118/202201181742.A2Dm08zD-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c10cbb243cafc0cf42c3e922cb29183279444432)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e65de225ef2f7eade2888b00970eec37aeca0044
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e65de225ef2f7eade2888b00970eec37aeca0044
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/ir38064.c:54:34: warning: unused variable 'ir38064_of_match' [-Wunused-const-variable]
   static const struct of_device_id ir38064_of_match[] = {
                                    ^
   1 warning generated.


vim +/ir38064_of_match +54 drivers/hwmon/pmbus/ir38064.c

    53	
  > 54	static const struct of_device_id ir38064_of_match[] = {
    55		{ .compatible = "infineon,ir38060" },
    56		{ .compatible = "infineon,ir38064" },
    57		{ .compatible = "infineon,ir38164" },
    58		{ .compatible = "infineon,ir38263" },
    59		{}
    60	};
    61	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
