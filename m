Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3E51DFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392186AbiEFUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352249AbiEFUBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:01:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654C5AECB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651867038; x=1683403038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ujPzMQlsgtyIkXLvesiz7KFNXn2wm3EPCKXAhVER8p8=;
  b=Ppmpi8bEpDh0Ao4c00MEXWEqaU3sYMRdQ4kwL2gu6cw1RvxGwGwxEHPO
   yWSSCmY+pmWPQ2HeBVX1P4zS9AamvY7uxZ4+HWBIlE+GtnPOmyXCqAKsT
   HHya98KoR7S9MpUa0My903/svnz7+dXnCZTle4D3DUYm0Ho40dRIMstxg
   pGLzREG8SHk5fAicOyZ91A/Mww6Z+u4vEIvCmGBdmpPQ+nXZwcTrWZ3bE
   LuhSQb4WXXNPOGXYsjLZ3i+iec7o6ZxlGXaviebtRgIgZmVqD362OD/+O
   j0Un1jW7BZ2ZlhZQe+xXkvWjn3u0sJtcS8NrGysDdgKzgHcX5rtDn0+m1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="331551063"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="331551063"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 12:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="563996693"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2022 12:57:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn44g-000DpQ-T0;
        Fri, 06 May 2022 19:57:14 +0000
Date:   Sat, 7 May 2022 03:56:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-cleanups-v2-drv-owner-wip 7/7]
 drivers/scsi/ufs/ufshcd.c:8267:10: error: 'struct scsi_host_template' has no
 member named 'module'
Message-ID: <202205070312.tniIfReM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
head:   17609caecd53df20f631703ea084a70e7735b5d7
commit: 17609caecd53df20f631703ea084a70e7735b5d7 [7/7] WIP
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220507/202205070312.tniIfReM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
        git checkout 17609caecd53df20f631703ea084a70e7735b5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/scsi/ufs/ufshcd.c:8267:10: error: 'struct scsi_host_template' has no member named 'module'
    8267 |         .module                 = THIS_MODULE,
         |          ^~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/async.h:14,
                    from drivers/scsi/ufs/ufshcd.c:12:
   include/linux/export.h:19:21: warning: initialization of 'unsigned int' from 'struct module *' makes integer from pointer without a cast [-Wint-conversion]
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/ufs/ufshcd.c:8267:35: note: in expansion of macro 'THIS_MODULE'
    8267 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'ufshcd_driver_template.cmd_size')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/ufs/ufshcd.c:8267:35: note: in expansion of macro 'THIS_MODULE'
    8267 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~


vim +8267 drivers/scsi/ufs/ufshcd.c

90b8491c003391 Stanley Chu        2020-05-09  8265  
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8266  static struct scsi_host_template ufshcd_driver_template = {
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29 @8267  	.module			= THIS_MODULE,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8268  	.name			= UFSHCD,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8269  	.proc_name		= UFSHCD,
eaab9b57305496 Bart Van Assche    2021-12-03  8270  	.map_queues		= ufshcd_map_queues,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8271  	.queuecommand		= ufshcd_queuecommand,
eaab9b57305496 Bart Van Assche    2021-12-03  8272  	.mq_poll		= ufshcd_poll,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8273  	.slave_alloc		= ufshcd_slave_alloc,
eeda47499f0187 Akinobu Mita       2014-07-01  8274  	.slave_configure	= ufshcd_slave_configure,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8275  	.slave_destroy		= ufshcd_slave_destroy,
4264fd613a6a4b Sujit Reddy Thumma 2014-06-29  8276  	.change_queue_depth	= ufshcd_change_queue_depth,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8277  	.eh_abort_handler	= ufshcd_abort,
3441da7ddbdedf Sujit Reddy Thumma 2014-05-26  8278  	.eh_device_reset_handler = ufshcd_eh_device_reset_handler,
3441da7ddbdedf Sujit Reddy Thumma 2014-05-26  8279  	.eh_host_reset_handler   = ufshcd_eh_host_reset_handler,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8280  	.this_id		= -1,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8281  	.sg_tablesize		= SG_ALL,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8282  	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8283  	.can_queue		= UFSHCD_CAN_QUEUE,
552a990ca16688 Christoph Hellwig  2019-06-17  8284  	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
1ab27c9cf8b63d Sahitya Tummala    2014-09-25  8285  	.max_host_blocked	= 1,
c40ecc12cfdb63 Christoph Hellwig  2014-11-13  8286  	.track_queue_depth	= 1,
d829fc8a105885 Stanislav Nijnikov 2018-02-15  8287  	.sdev_groups		= ufshcd_driver_groups,
4af14d113bcf95 Christoph Hellwig  2018-12-13  8288  	.dma_boundary		= PAGE_SIZE - 1,
49615ba144a092 Stanley Chu        2019-09-16  8289  	.rpm_autosuspend_delay	= RPM_AUTOSUSPEND_DELAY_MS,
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8290  };
7a3e97b0dc4bba Santosh Yaraganavi 2012-02-29  8291  

:::::: The code at line 8267 was first introduced by commit
:::::: 7a3e97b0dc4bbac2ba7803564ab0057722689921 [SCSI] ufshcd: UFS Host controller driver

:::::: TO: Santosh Yaraganavi <santoshsy@gmail.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
