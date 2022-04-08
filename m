Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E54F8F67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiDHHU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDHHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:20:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798A21FF74
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649402306; x=1680938306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9LTlvbPaoYNE/G17yBNjMXG8Hs/vK2YIpRMxwYxU/94=;
  b=UwJyBDfllJ/guEATzpVsp9dD53s8TnvPK804MkBHfXTPYOl4IfaaGC3x
   ufuNI404Oksk2r1+AePZys8fjQOqnNnbXQU9IyQKRjnVa7+V5QopsAmA9
   Jexc7RyrSNLDsTwW7ox6GlXwnRsXGXoaUtPlTTUDv4GrfpOG+IaM0R3xc
   pVX7cFk99opYBv6RW/I2JYjL8qGH3rPXUW0AbssQ/4YGmV9KFlQqc9DuF
   BGP0+M6u31syBHaWjXAyylHs5Pq1stHYM9pGMl0CbC9AHnB5QxfIbcHgz
   W1ABIjdsICLF720kgIIE7rPH2VJ8cp/WsJXPkbbOx5cZqm5aZOnKunEpo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286521193"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="286521193"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="621540337"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 00:18:25 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncisy-00069t-HV;
        Fri, 08 Apr 2022 07:18:24 +0000
Date:   Fri, 8 Apr 2022 15:17:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 281/887]
 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1465:17: error: unknown type
 name 'compat_uptr_t'
Message-ID: <202204081500.XmYHs9n7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 56d0cd616fe11877854ad1b0768b3be67bb30349 [281/887] staging: vc04_services: Add new vc-sm-cma driver
config: sparc-randconfig-r012-20220408 (https://download.01.org/0day-ci/archive/20220408/202204081500.XmYHs9n7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/56d0cd616fe11877854ad1b0768b3be67bb30349
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 56d0cd616fe11877854ad1b0768b3be67bb30349
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/staging/vc04_services/vc-sm-cma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:731:1: warning: no previous prototype for 'vc_sm_cma_import_dmabuf_internal' [-Wmissing-prototypes]
     731 | vc_sm_cma_import_dmabuf_internal(struct vc_sm_privdata_t *private,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1114:5: warning: no previous prototype for 'vc_sm_cma_ioctl_alloc' [-Wmissing-prototypes]
    1114 | int vc_sm_cma_ioctl_alloc(struct vc_sm_privdata_t *private,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c: In function 'cache_op_to_func':
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1267:24: error: 'dmac_flush_range' undeclared (first use in this function)
    1267 |                 return dmac_flush_range;
         |                        ^~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1267:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c: At top level:
>> drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1465:17: error: unknown type name 'compat_uptr_t'
    1465 |                 compat_uptr_t start_address;
         |                 ^~~~~~~~~~~~~


vim +/compat_uptr_t +1465 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c

  1458	
  1459	#ifdef CONFIG_COMPAT
  1460	struct vc_sm_cma_ioctl_clean_invalid2_32 {
  1461		u32 op_count;
  1462		struct vc_sm_cma_ioctl_clean_invalid_block_32 {
  1463			u16 invalidate_mode;
  1464			u16 block_count;
> 1465			compat_uptr_t start_address;
  1466			u32 block_size;
  1467			u32 inter_block_stride;
  1468		} s[0];
  1469	};
  1470	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
