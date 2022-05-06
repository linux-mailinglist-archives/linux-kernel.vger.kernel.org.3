Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3004B51DFF3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392501AbiEFUME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352661AbiEFUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:12:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A1B612BA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651867698; x=1683403698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KeePV7grCS31GCGUXKusKGjXKgqLvDMofR+069Wn03M=;
  b=UAC3p3f37zwZtzb0jmwkAFcfQfkbVcwBLtcajX/v7NqQ4D6kQ3lrQACF
   bsaEMgfm9Nsix779S7GC8a6l9g5ccTS6EbgZ2FQWnMjQexvx2TOdImE7W
   09KAF4qe0MHFAIrJObD8dEAlEc6ydQyDm1GRUOP5+TQo2mfB3bC6r84fl
   eyva72q+RCtRmTuDymUiWgU+FuPW84qoBefH1lj0BLqOOHA5JzgCfHo4r
   TGZkQWS4o44RaN3KgQkafxNqhB+QTCbkLLMxsanIdvCBgTONYhJW00AyD
   m6YeiTpFxsRvcfTy20KGEy0hOgGJHAS9TJNtajIyMLQ8hC1aejdje1HU2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="256047423"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="256047423"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="564000890"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2022 13:08:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn4FM-000Dqc-Af;
        Fri, 06 May 2022 20:08:16 +0000
Date:   Sat, 7 May 2022 04:07:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-cleanups-v2-drv-owner-wip 7/7]
 drivers/scsi/aic7xxx/aic7xxx_osm.c:776:10: error: 'struct
 scsi_host_template' has no member named 'module'
Message-ID: <202205070452.4ogRRvFk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
head:   17609caecd53df20f631703ea084a70e7735b5d7
commit: 17609caecd53df20f631703ea084a70e7735b5d7 [7/7] WIP
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220507/202205070452.4ogRRvFk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
        git checkout 17609caecd53df20f631703ea084a70e7735b5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/scsi/aic7xxx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/scsi/aic7xxx/aic7xxx_osm.c:776:10: error: 'struct scsi_host_template' has no member named 'module'
     776 |         .module                 = THIS_MODULE,
         |          ^~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/fs.h:5,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/scsi/aic7xxx/aic7xxx_osm.h:63,
                    from drivers/scsi/aic7xxx/aic7xxx_osm.c:123:
>> include/linux/export.h:17:21: warning: initialization of 'unsigned int' from 'struct module *' makes integer from pointer without a cast [-Wint-conversion]
      17 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/scsi/aic7xxx/aic7xxx_osm.c:776:35: note: in expansion of macro 'THIS_MODULE'
     776 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   include/linux/export.h:17:21: note: (near initialization for 'aic7xxx_driver_template.cmd_size')
      17 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/scsi/aic7xxx/aic7xxx_osm.c:776:35: note: in expansion of macro 'THIS_MODULE'
     776 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
>> include/linux/export.h:17:21: error: initializer element is not computable at load time
      17 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/scsi/aic7xxx/aic7xxx_osm.c:776:35: note: in expansion of macro 'THIS_MODULE'
     776 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   include/linux/export.h:17:21: note: (near initialization for 'aic7xxx_driver_template.cmd_size')
      17 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/scsi/aic7xxx/aic7xxx_osm.c:776:35: note: in expansion of macro 'THIS_MODULE'
     776 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~


vim +776 drivers/scsi/aic7xxx/aic7xxx_osm.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  774  
013791ee01754f Christoph Hellwig 2005-05-16  775  struct scsi_host_template aic7xxx_driver_template = {
^1da177e4c3f41 Linus Torvalds    2005-04-16 @776  	.module			= THIS_MODULE,
^1da177e4c3f41 Linus Torvalds    2005-04-16  777  	.name			= "aic7xxx",
dfd287f6ee9be1 Christoph Hellwig 2005-06-28  778  	.proc_name		= "aic7xxx",
6b3a8bbfd15ca8 Al Viro           2013-03-31  779  	.show_info		= ahc_linux_show_info,
6b3a8bbfd15ca8 Al Viro           2013-03-31  780  	.write_info		= ahc_proc_write_seeprom,
^1da177e4c3f41 Linus Torvalds    2005-04-16  781  	.info			= ahc_linux_info,
^1da177e4c3f41 Linus Torvalds    2005-04-16  782  	.queuecommand		= ahc_linux_queue,
^1da177e4c3f41 Linus Torvalds    2005-04-16  783  	.eh_abort_handler	= ahc_linux_abort,
^1da177e4c3f41 Linus Torvalds    2005-04-16  784  	.eh_device_reset_handler = ahc_linux_dev_reset,
^1da177e4c3f41 Linus Torvalds    2005-04-16  785  	.eh_bus_reset_handler	= ahc_linux_bus_reset,
^1da177e4c3f41 Linus Torvalds    2005-04-16  786  #if defined(__i386__)
^1da177e4c3f41 Linus Torvalds    2005-04-16  787  	.bios_param		= ahc_linux_biosparam,
^1da177e4c3f41 Linus Torvalds    2005-04-16  788  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  789  	.can_queue		= AHC_MAX_QUEUE,
^1da177e4c3f41 Linus Torvalds    2005-04-16  790  	.this_id		= -1,
80f1443c66de3e Hannes Reinecke   2006-10-06  791  	.max_sectors		= 8192,
^1da177e4c3f41 Linus Torvalds    2005-04-16  792  	.cmd_per_lun		= 2,
^1da177e4c3f41 Linus Torvalds    2005-04-16  793  	.slave_alloc		= ahc_linux_slave_alloc,
^1da177e4c3f41 Linus Torvalds    2005-04-16  794  	.slave_configure	= ahc_linux_slave_configure,
b1abb4d67f2a70 James Bottomley   2005-05-24  795  	.target_alloc		= ahc_linux_target_alloc,
b1abb4d67f2a70 James Bottomley   2005-05-24  796  	.target_destroy		= ahc_linux_target_destroy,
^1da177e4c3f41 Linus Torvalds    2005-04-16  797  };
^1da177e4c3f41 Linus Torvalds    2005-04-16  798  

:::::: The code at line 776 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
