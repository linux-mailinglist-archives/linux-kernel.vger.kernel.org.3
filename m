Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E564C8F60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiCAPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiCAPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:46:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A6527E0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646149532; x=1677685532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yJOQ+UHnY8shUf635+u1oWoprslEA6t4CJY7JJ4XETA=;
  b=PfDFKeHYxnXATlMKadKJtcacaUElWm2244G4cqLJCi2WhS9sG7GsPYjs
   ZjkN8RE8lJif8FVx8heT/2MgJGI7gi/TMSI+enZArF1QTtRf0zqVtGNbG
   2+s3NGgIufNEFxWoHsnHPwCaPPd5yEPMcggpS9upoNDver3X71ETYYTl0
   pb8FplvOemd+dQdWzA9d9Pf0KKs/LLvnrCF5MItIeCTx2PHbhwz/A77ez
   hwLAjkckF86OPijP/wHusZDzNRfr6ybUXIY59SD0i3Gw0v1lxMUkCz8al
   h+aEkw0dm0zFj7YgMm6GtVW6WRmH/8t6PgLQJ78PYbRO2pnFyS0YB0BYe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233126723"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233126723"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:45:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="641305656"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 07:45:30 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP4gr-0000e0-I1; Tue, 01 Mar 2022 15:45:29 +0000
Date:   Tue, 1 Mar 2022 23:45:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luxis1999-iommufd:iommufd-v5.17-rc4 21/30] ERROR: modpost:
 "interval_tree_iter_next" [drivers/iommu/iommufd/iommufd.ko] undefined!
Message-ID: <202203012312.livRTcyQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/iommufd iommufd-v5.17-rc4
head:   2bca5fa75dad57f41002a93861a950d35d55e568
commit: e5b0b18da497e526cec5aad8c987ab9fd704adcd [21/30] vfio/pci: Add bind_iommufd() support
config: riscv-randconfig-r042-20220301 (https://download.01.org/0day-ci/archive/20220301/202203012312.livRTcyQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/luxis1999/iommufd/commit/e5b0b18da497e526cec5aad8c987ab9fd704adcd
        git remote add luxis1999-iommufd https://github.com/luxis1999/iommufd
        git fetch --no-tags luxis1999-iommufd iommufd-v5.17-rc4
        git checkout e5b0b18da497e526cec5aad8c987ab9fd704adcd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "interval_tree_iter_next" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_remove" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_insert" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_span_iter_next" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_span_iter_first" [drivers/iommu/iommufd/iommufd.ko] undefined!
>> ERROR: modpost: "interval_tree_iter_first" [drivers/iommu/iommufd/iommufd.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMUFD
   Depends on IOMMU_SUPPORT
   Selected by
   - VFIO_PCI_CORE && VFIO && PCI && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
