Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAE4901C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiAQFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:53:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:8453 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234453AbiAQFxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642398810; x=1673934810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tpT5VmVxWjbvY4z2KyJN0ZNH+4f1u3S7Bwh/lcv5a0M=;
  b=NoJMxRp5tPGTKMYlAxzUv6cdpXw0rzQrtgdtfzBV0xx5ZprVEraUT5qk
   a+YZPuSrF4f/nsC9zZF+al/LbfrinrMX4qmhkxgCREPAL34yoOGYqdQml
   p9JDIjEbbaSQtKArUOkhqiJavaY+TkV+vd429BgF19Vi7JWlxaVZQ1vI0
   cYKAaV6+6+4XXsvhwNUWPhItDNaXl8qFGd7CSG5/sDHH109r3mQG0SqKT
   pWO4cI06JELtdxIw31bP+zeD7YkvFCYSpXYsxWrJ37ayls/xlzRziPdMV
   GcyKg885Tta9pJOeHFp2V1fzKqJW71SKVXtbUSEjRTG40U8DlVXlwUr3Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244754870"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="244754870"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="517286464"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2022 21:53:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9KxI-000BI6-Pp; Mon, 17 Jan 2022 05:53:24 +0000
Date:   Mon, 17 Jan 2022 13:52:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/renesas-nand-controller.c:1405:34: warning:
 unused variable 'rnandc_id_table'
Message-ID: <202201171330.2qRTJyxi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   35ce8ae9ae2e471f92759f9d6880eab42cc1c3b6
commit: d8701fe890ecbab239086e7053d62d0f08587d7c mtd: rawnand: renesas: Add new NAND controller driver
date:   4 weeks ago
config: hexagon-randconfig-r014-20220117 (https://download.01.org/0day-ci/archive/20220117/202201171330.2qRTJyxi-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8701fe890ecbab239086e7053d62d0f08587d7c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8701fe890ecbab239086e7053d62d0f08587d7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/renesas-nand-controller.c:1405:34: warning: unused variable 'rnandc_id_table' [-Wunused-const-variable]
   static const struct of_device_id rnandc_id_table[] = {
                                    ^
   1 warning generated.


vim +/rnandc_id_table +1405 drivers/mtd/nand/raw/renesas-nand-controller.c

  1404	
> 1405	static const struct of_device_id rnandc_id_table[] = {
  1406		{ .compatible = "renesas,rcar-gen3-nandc" },
  1407		{ .compatible = "renesas,rzn1-nandc" },
  1408		{} /* sentinel */
  1409	};
  1410	MODULE_DEVICE_TABLE(of, rnandc_id_table);
  1411	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
