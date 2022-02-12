Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD834B3446
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiBLKju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:39:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiBLKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:39:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460782654C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644662383; x=1676198383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ohpl2YLMkTPpe66l5xhTo65vy9eYhsI4fppU+fx/y9s=;
  b=iYdsMFYUYlauj4vkvN1tinOPOxAjz+NWgTlQ3vbqC+KV9PAB97UE7gJk
   8cyGt2z6dI66a8Q8VWLSzSGrohxGQ1wOACsM4wCABdEPihivNLk7f4tqP
   FF2L/WkcgZ4zVfgob/8qGpggwEVOKUMzFdrvXUyd+X2hCs6RPOszaPfxQ
   xpTSISOpCvIG3XxOHMYpFkGdi7bMft/xzaiwUuMQPJpKAeyMr8tOybXyu
   pD1ME6QKme3km0TadnnvX717D334lB2Z4+vIg+xtvrP03ogDQQRYGgt1b
   cgR3IbowccTk+FYSB/SEiAXtAtFPf83Uh4J+sVcQ82yIvG/KUvegsGX+g
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237277581"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="237277581"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 02:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="634352929"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Feb 2022 02:39:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIpob-00061I-0J; Sat, 12 Feb 2022 10:39:41 +0000
Date:   Sat, 12 Feb 2022 18:39:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mkp:5.18/discovery2 64/67] drivers/scsi/sd.c:1093:25: warning:
 suggest explicit braces to avoid ambiguous 'else'
Message-ID: <202202121644.TOit65Ia-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git 5.18/discovery2
head:   7c371ec158614870d9c9c5d1a9e0f0c35f9198d7
commit: 56db0eb9f48930efde746c3cb9af11524102dc76 [64/67] scsi: sd: Implement support for NDOB flag in WRITE SAME(16)
config: arc-axs103_smp_defconfig (https://download.01.org/0day-ci/archive/20220212/202202121644.TOit65Ia-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/commit/?id=56db0eb9f48930efde746c3cb9af11524102dc76
        git remote add mkp https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git
        git fetch --no-tags mkp 5.18/discovery2
        git checkout 56db0eb9f48930efde746c3cb9af11524102dc76
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/sd.c: In function 'sd_config_write_zeroes':
>> drivers/scsi/sd.c:1093:25: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
    1093 |                 else if (sdkp->max_ws_blocks)
         |                         ^


vim +/else +1093 drivers/scsi/sd.c

e339c1a7c09ef73 Martin K. Petersen 2009-11-26  1076  
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1077  static void sd_config_write_zeroes(struct scsi_disk *sdkp,
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1078  				   enum sd_zeroing_mode mode)
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1079  {
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1080  	struct request_queue *q = sdkp->disk->queue;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1081  	unsigned int logical_block_size = sdkp->device->sector_size;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1082  
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1083  	if (mode == SD_ZERO_DEFAULT && !sdkp->zeroing_override) {
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1084  		mode = SD_ZERO_WRITE;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1085  
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1086  		if (sdkp->lbprz && sdkp->lbpws)
56db0eb9f48930e Martin K. Petersen 2019-02-27  1087  			if (sdkp->ndob)
56db0eb9f48930e Martin K. Petersen 2019-02-27  1088  				mode = SD_ZERO_WS16_NDOB;
56db0eb9f48930e Martin K. Petersen 2019-02-27  1089  			else
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1090  				mode = SD_ZERO_WS16_UNMAP;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1091  		else if (sdkp->lbprz && sdkp->lbpws10)
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1092  			mode = SD_ZERO_WS10_UNMAP;
e65ad69ab003e66 Martin K. Petersen 2022-01-03 @1093  		else if (sdkp->max_ws_blocks)
56db0eb9f48930e Martin K. Petersen 2019-02-27  1094  			if (sdkp->ndob)
56db0eb9f48930e Martin K. Petersen 2019-02-27  1095  				mode = SD_ZERO_WS16_NDOB;
56db0eb9f48930e Martin K. Petersen 2019-02-27  1096  			else
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1097  				mode = SD_ZERO_WS;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1098  	}
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1099  
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1100  	if (mode == SD_ZERO_DISABLE)
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1101  		sdkp->zeroing_override = true;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1102  
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1103  	sdkp->zeroing_mode = mode;
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1104  	blk_queue_max_write_zeroes_sectors(q, sdkp->max_ws_blocks *
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1105  					   (logical_block_size >> 9));
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1106  }
e65ad69ab003e66 Martin K. Petersen 2022-01-03  1107  

:::::: The code at line 1093 was first introduced by commit
:::::: e65ad69ab003e66d2055130bfc4c17e2d92cb7c3 scsi: sd: Move WRITE_ZEROES configuration to a separate function

:::::: TO: Martin K. Petersen <martin.petersen@oracle.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
