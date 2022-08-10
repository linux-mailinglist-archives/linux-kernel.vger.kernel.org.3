Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DBC58F4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiHJXqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHJXqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:46:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74951EAD3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660175172; x=1691711172;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vSEwmW4+TDnMXMhJIOivQsDE/zLtPrGURz+W2RcOC3E=;
  b=T2RxZaYLpHIFBda+ndVHbfF7cphIOLP6SgFfNF4xTAeSbFh0HMpckwY0
   PxNuL7WZdK3vX0OebAFzu5HpzsHy3GXhSHpqUNVDXfnZ9gnBYnfJ5OD+U
   JLQxeZuzHitLUg1Lq/xROFwe5gBDoZdumPsdLrxz8y+5qP9LiP/0MHLcl
   Yswg8bYKniyYejKubA1t/2sCRcokx0F+vP5tE7uNY33/GCrBqytvLone+
   ViBWV8DwxJUvm90sVGnR7bjfe8FrEY6lsXYYBO67Rr2OlJAY3Zl+yUi6C
   ttJkh5WG+JI8VBHMvwqSTYjXiwz3qe5vaJXZo+fCRct5VSeOzdKzS8Nih
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="270995929"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="270995929"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="638292859"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 16:46:11 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLvOs-0000qs-1V;
        Wed, 10 Aug 2022 23:46:10 +0000
Date:   Thu, 11 Aug 2022 07:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-const-host-template 12/88]
 drivers/ata/pata_platform.c:221:48: warning: passing argument 7 of
 '__pata_platform_probe' discards 'const' qualifier from pointer target type
Message-ID: <202208110734.Ink9FfL5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-const-host-template
head:   13249cc58dd0478af230234f124ec75b5331c348
commit: 21962245b3c73a5e7c9b7b3c129a83f5c1c31608 [12/88] ata
config: m68k-randconfig-r035-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110734.Ink9FfL5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/21962245b3c73a5e7c9b7b3c129a83f5c1c31608
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-const-host-template
        git checkout 21962245b3c73a5e7c9b7b3c129a83f5c1c31608
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/pata_platform.c: In function 'pata_platform_probe':
>> drivers/ata/pata_platform.c:221:48: warning: passing argument 7 of '__pata_platform_probe' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     221 |                                      pio_mask, &pata_platform_sht, false);
         |                                                ^~~~~~~~~~~~~~~~~~
   drivers/ata/pata_platform.c:100:54: note: expected 'struct scsi_host_template *' but argument is of type 'const struct scsi_host_template *'
     100 |                           struct scsi_host_template *sht, bool use16bit)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +221 drivers/ata/pata_platform.c

a20c9e820864e18 Paul Mundt         2006-10-27  184  
0ec24914675c482 Greg Kroah-Hartman 2012-12-21  185  static int pata_platform_probe(struct platform_device *pdev)
cf03613e9662c28 Anton Vorontsov    2008-01-09  186  {
cf03613e9662c28 Anton Vorontsov    2008-01-09  187  	struct resource *io_res;
cf03613e9662c28 Anton Vorontsov    2008-01-09  188  	struct resource *ctl_res;
cf03613e9662c28 Anton Vorontsov    2008-01-09  189  	struct resource *irq_res;
61b8c345aa8c50c Jingoo Han         2013-07-30  190  	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
cf03613e9662c28 Anton Vorontsov    2008-01-09  191  
cf03613e9662c28 Anton Vorontsov    2008-01-09  192  	/*
cf03613e9662c28 Anton Vorontsov    2008-01-09  193  	 * Simple resource validation ..
cf03613e9662c28 Anton Vorontsov    2008-01-09  194  	 */
cf03613e9662c28 Anton Vorontsov    2008-01-09  195  	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
cf03613e9662c28 Anton Vorontsov    2008-01-09  196  		dev_err(&pdev->dev, "invalid number of resources\n");
cf03613e9662c28 Anton Vorontsov    2008-01-09  197  		return -EINVAL;
cf03613e9662c28 Anton Vorontsov    2008-01-09  198  	}
cf03613e9662c28 Anton Vorontsov    2008-01-09  199  
cf03613e9662c28 Anton Vorontsov    2008-01-09  200  	/*
cf03613e9662c28 Anton Vorontsov    2008-01-09  201  	 * Get the I/O base first
cf03613e9662c28 Anton Vorontsov    2008-01-09  202  	 */
8818a5342cb499b Lad Prabhakar      2022-01-17  203  	io_res = platform_get_mem_or_io(pdev, 0);
8818a5342cb499b Lad Prabhakar      2022-01-17  204  	if (!io_res)
cf03613e9662c28 Anton Vorontsov    2008-01-09  205  		return -EINVAL;
cf03613e9662c28 Anton Vorontsov    2008-01-09  206  
cf03613e9662c28 Anton Vorontsov    2008-01-09  207  	/*
cf03613e9662c28 Anton Vorontsov    2008-01-09  208  	 * Then the CTL base
cf03613e9662c28 Anton Vorontsov    2008-01-09  209  	 */
8818a5342cb499b Lad Prabhakar      2022-01-17  210  	ctl_res = platform_get_mem_or_io(pdev, 1);
8818a5342cb499b Lad Prabhakar      2022-01-17  211  	if (!ctl_res)
cf03613e9662c28 Anton Vorontsov    2008-01-09  212  		return -EINVAL;
cf03613e9662c28 Anton Vorontsov    2008-01-09  213  
cf03613e9662c28 Anton Vorontsov    2008-01-09  214  	/*
cf03613e9662c28 Anton Vorontsov    2008-01-09  215  	 * And the IRQ
cf03613e9662c28 Anton Vorontsov    2008-01-09  216  	 */
cf03613e9662c28 Anton Vorontsov    2008-01-09  217  	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
cf03613e9662c28 Anton Vorontsov    2008-01-09  218  
cf03613e9662c28 Anton Vorontsov    2008-01-09  219  	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
cf03613e9662c28 Anton Vorontsov    2008-01-09  220  				     pp_info ? pp_info->ioport_shift : 0,
f3d5e4f18dba18d Alexander Shiyan   2019-01-19 @221  				     pio_mask, &pata_platform_sht, false);
cf03613e9662c28 Anton Vorontsov    2008-01-09  222  }
cf03613e9662c28 Anton Vorontsov    2008-01-09  223  

:::::: The code at line 221 was first introduced by commit
:::::: f3d5e4f18dba18d7c2303dda68b9dbcf5ccc05cd ata: pata_of_platform: Allow to use 16-bit wide data transfer

:::::: TO: Alexander Shiyan <shc_work@mail.ru>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
