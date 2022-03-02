Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DADB4CA420
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiCBLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiCBLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:49:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A53980B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646221745; x=1677757745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nriaHvXmXCXHaDxFdxCs0pJlcGBwW7eHFRWo3MfCiiw=;
  b=HqJGCtuOHOMWIVdiVkY9yU9C4zN59gQGCRTCQ1yEpYgA+pFJtAZRDHGk
   qALJrnTJzZi9i5qHdaV8CzRetq888xIw4JaLJIE/lf7NOLTnDCh20Ybwu
   04J4UHI2kL2K3VJ7qYkrxKbcYD4FgYJ/y3/HkZQ3Jedr3vStAdaWAAPpp
   9gy0CWGy2ix5kGgVn2aZ+neU8Vzq33VEjyceoil+jPA7h2Iq3j8h3cfkS
   sb/bVxngAkol2oZBB47l0sMJ2lFpINz9SZjAmS3IRocfxeYPtWW/38jvO
   EfTC+ggct2rN+b7pPgBJSgkNenoXs3HH3lgD87kSTEcycvN2vCcbZ/q2F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252211310"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="252211310"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="510978972"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 03:49:03 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPNTa-0001Mf-BN; Wed, 02 Mar 2022 11:49:02 +0000
Date:   Wed, 2 Mar 2022 19:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [ammarfaizi2-block:powerpc/linux/next-test 106/106]
 mobility.c:(.text.pseries_migrate_partition.part.0+0x44): undefined
 reference to `.vas_migration_handler'
Message-ID: <202203021942.hESPBZ2b-lkp@intel.com>
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
config: powerpc64-randconfig-p002-20220301 (https://download.01.org/0day-ci/archive/20220302/202203021942.hESPBZ2b-lkp@intel.com/config)
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

   powerpc64-linux-ld: arch/powerpc/platforms/pseries/mobility.o: in function `.pseries_migrate_partition.part.0':
>> mobility.c:(.text.pseries_migrate_partition.part.0+0x44): undefined reference to `.vas_migration_handler'
>> powerpc64-linux-ld: mobility.c:(.text.pseries_migrate_partition.part.0+0xb8): undefined reference to `.vas_migration_handler'
   powerpc64-linux-ld: mobility.c:(.text.pseries_migrate_partition.part.0+0x180): undefined reference to `.vas_migration_handler'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
