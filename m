Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79274C9B86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiCBCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiCBCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:53:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2016B7D5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189557; x=1677725557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qMY75gq36sQXYXYdRvaJvlG6yXaRQ6GyUvg91I0uQ/I=;
  b=erA9kqGhl0A/3bLqy3WUq/svjSOkXFXOrS/S3aHfjOG7mhQCPEq0Evq1
   8LKeuclUmPzJooM3vPiL6h4b4IQxbN5mS3+4AVfbrmd3dlp/T0YgG3b7k
   NO2huGhPLkuB84LUZiA5AtoXDYEn2BiwckkAseRAdHHCg/2VCkmK0XMU4
   0TV+uDxK4amOVn3toyEgrU9I9dLPqlz5sfYIMikr6C69NTkjhFulkl3gv
   zQeCfg5APBQRGbQ/fMyDP46jGmcfRt8M2L0tZrnULff8DEGDmSQOyWuDn
   Pz0BVLCVkrLz7ptJ1H3C8k9q16z1X723eTaKYlyqEMSeLXwCqqxkLgZxT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233910937"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233910937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709336243"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2022 18:52:34 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF6P-0000xT-Mb; Wed, 02 Mar 2022 02:52:33 +0000
Date:   Wed, 2 Mar 2022 10:52:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 106/106]
 mobility.c:undefined reference to `.vas_migration_handler'
Message-ID: <202203020911.R6SaDVQw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block powerpc/linux/next-test
head:   cb848c24e3dc532269b70f907ad6d51848039cf0
commit: cb848c24e3dc532269b70f907ad6d51848039cf0 [106/106] powerpc/pseries/vas: Add VAS migration handler
config: powerpc64-randconfig-c024-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020911.R6SaDVQw-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/cb848c24e3dc532269b70f907ad6d51848039cf0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block powerpc/linux/next-test
        git checkout cb848c24e3dc532269b70f907ad6d51848039cf0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `vas_migration_handler'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: arch/powerpc/platforms/pseries/mobility.o: in function `.pseries_migrate_partition.part.0':
>> mobility.c:(.text+0xb44): undefined reference to `.vas_migration_handler'
>> powerpc64-linux-ld: mobility.c:(.text+0xbc4): undefined reference to `.vas_migration_handler'
   powerpc64-linux-ld: mobility.c:(.text+0xc90): undefined reference to `.vas_migration_handler'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
