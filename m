Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56952300B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbiEKJ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242100AbiEKJ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:56:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC31129
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652262946; x=1683798946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SX0dEp+tLhnsLuHd+ayLflaXz08Ib7oj9qhBSJksrzw=;
  b=OnNjS5IRUPFoYB0YSf4uoV61nCQCisDqsbdlNa1/8RyZE6ES8UFbbBjy
   cnLqQ47WdUvzPLdTnAjDsPKykJHrEnztI28KjKL2pk+qZALKj03tI14r+
   F/MGunDUrHRqCo/esA6+qndP0n04qW1pf9+OxS9mEFhiPJA9FZLh/JAAA
   5Bx4ZSPZylqOZEX+AA3F2iO9mO/IZEBPJ+McQuksfV/ucl3dvv9IsluSb
   TR0pnZpUGeIs74reMB4XWMnmEHyitYMcAgxwHaEb8vKUHIROkcUE3siMH
   q6CU4KIDi8LxXFA0LQL45UrAhak+YJQut7RDZfnNQJX0Hzz/qn7LejhlU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269319024"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269319024"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 02:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="602880761"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2022 02:55:38 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noj4D-000Ixc-Mw;
        Wed, 11 May 2022 09:55:37 +0000
Date:   Wed, 11 May 2022 17:55:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Habets <habetsm.xilinx@gmail.com>
Cc:     kbuild-all@lists.01.org, alaa@dev.mellanox.co.il,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [alaahl:netdev-next 12/22]
 drivers/net/ethernet/sfc/siena/siena_sriov.c:1578:5: warning: no previous
 prototype for 'efx_init_sriov'
Message-ID: <202205111720.oJ7rmJle-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alaahl/linux.git netdev-next
head:   53a332f222c015cb82349fd4f6b58cb14f574e8d
commit: c5a13c319e10e795850b61bc7e3447b08024be2e [12/22] sfc: Add a basic Siena module
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220511/202205111720.oJ7rmJle-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alaahl/linux/commit/c5a13c319e10e795850b61bc7e3447b08024be2e
        git remote add alaahl https://github.com/alaahl/linux.git
        git fetch --no-tags alaahl netdev-next
        git checkout c5a13c319e10e795850b61bc7e3447b08024be2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/hwmon/ drivers/net/ethernet/sfc/siena/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/siena/siena_sriov.c:1578:5: warning: no previous prototype for 'efx_init_sriov' [-Wmissing-prototypes]
    1578 | int efx_init_sriov(void)
         |     ^~~~~~~~~~~~~~
>> drivers/net/ethernet/sfc/siena/siena_sriov.c:1590:6: warning: no previous prototype for 'efx_fini_sriov' [-Wmissing-prototypes]
    1590 | void efx_fini_sriov(void)
         |      ^~~~~~~~~~~~~~


vim +/efx_init_sriov +1578 drivers/net/ethernet/sfc/siena/siena_sriov.c

cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1577  
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14 @1578  int efx_init_sriov(void)
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1579  {
327c685eb745e3 drivers/net/ethernet/sfc/siena_sriov.c Shradha Shah  2014-11-05  1580  	/* A single threaded workqueue is sufficient. efx_siena_sriov_vfdi() and
327c685eb745e3 drivers/net/ethernet/sfc/siena_sriov.c Shradha Shah  2014-11-05  1581  	 * efx_siena_sriov_peer_work() spend almost all their time sleeping for
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1582  	 * MCDI to complete anyway
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1583  	 */
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1584  	vfdi_workqueue = create_singlethread_workqueue("sfc_vfdi");
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1585  	if (!vfdi_workqueue)
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1586  		return -ENOMEM;
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1587  	return 0;
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1588  }
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1589  
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14 @1590  void efx_fini_sriov(void)
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1591  {
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1592  	destroy_workqueue(vfdi_workqueue);
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1593  }
cd2d5b529cdb9b drivers/net/ethernet/sfc/siena_sriov.c Ben Hutchings 2012-02-14  1594  

:::::: The code at line 1578 was first introduced by commit
:::::: cd2d5b529cdb9bd274f3e4bc68d37d4d63b7f383 sfc: Add SR-IOV back-end support for SFC9000 family

:::::: TO: Ben Hutchings <bhutchings@solarflare.com>
:::::: CC: Ben Hutchings <bhutchings@solarflare.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
