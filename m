Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85B551DFF2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441861AbiEFUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392103AbiEFUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:12:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12BD6160E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651867698; x=1683403698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=36tOLME8tLydXyELJoXPs6Juu6fr2MpYy+50gIjcGTc=;
  b=E0DQw4HGHTEvlQHjPGrQACXhRHWjfeDQiQPZa3m58g9pxolCCvk+VUPA
   3O6OYlpl1hYC1td/pwlBGYRIuVHbp7FelAuBI6aGYg40UHfUPqTQi4ga+
   KwnissqhG8Ol6BDWdiAI7E9sOM+oxshs/PDR2BQ4C3BeVq40rV2KLymc7
   4JcprhQdnf21FJVnWFd99+ZxOUNH2cVlPo2nyGmAu2+Ed0vTLvV9RONTf
   vf6o9kthlTsRuBy+kPFDxbfk9x3OecYCryy5/AJfFPz6avSoeAr/WGQSi
   4VwUfNTVdsBGZ6jWUlsC7P3XAGo1+JDMryaO5tRcgg/fJpxlt1KaeUbjB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268183808"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="268183808"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="812532872"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2022 13:08:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn4FM-000DqZ-9w;
        Fri, 06 May 2022 20:08:16 +0000
Date:   Sat, 7 May 2022 04:07:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-cleanups-v2-drv-owner-wip 7/7]
 drivers/target/loopback/tcm_loop.c:314:3: error: field designator 'module'
 does not refer to any field in type 'struct scsi_host_template'
Message-ID: <202205070341.800VDMqg-lkp@intel.com>
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
config: hexagon-randconfig-r026-20220506 (https://download.01.org/0day-ci/archive/20220507/202205070341.800VDMqg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
        git checkout 17609caecd53df20f631703ea084a70e7735b5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/target/loopback/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/target/loopback/tcm_loop.c:314:3: error: field designator 'module' does not refer to any field in type 'struct scsi_host_template'
           .module                 = THIS_MODULE,
            ^
   1 error generated.


vim +314 drivers/target/loopback/tcm_loop.c

8f4a1fb0d029fe Hannes Reinecke    2013-10-16  300  
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  301  static struct scsi_host_template tcm_loop_driver_template = {
8946b077ca385a Al Viro            2013-03-31  302  	.show_info		= tcm_loop_show_info,
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  303  	.proc_name		= "tcm_loopback",
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  304  	.name			= "TCM_Loopback",
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  305  	.queuecommand		= tcm_loop_queuecommand,
db5ed4dfd5dd01 Christoph Hellwig  2014-11-13  306  	.change_queue_depth	= scsi_change_queue_depth,
969871cdc2d0f5 Hannes Reinecke    2013-10-16  307  	.eh_abort_handler = tcm_loop_abort_task,
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  308  	.eh_device_reset_handler = tcm_loop_device_reset,
8f4a1fb0d029fe Hannes Reinecke    2013-10-16  309  	.eh_target_reset_handler = tcm_loop_target_reset,
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  310  	.this_id		= -1,
2e88efd3aaafa0 Christoph Hellwig  2011-11-29  311  	.sg_tablesize		= 256,
2e88efd3aaafa0 Christoph Hellwig  2011-11-29  312  	.max_sectors		= 0xFFFF,
4af14d113bcf95 Christoph Hellwig  2018-12-13  313  	.dma_boundary		= PAGE_SIZE - 1,
3703b2c5d041a6 Nicholas Bellinger 2011-03-18 @314  	.module			= THIS_MODULE,
c40ecc12cfdb63 Christoph Hellwig  2014-11-13  315  	.track_queue_depth	= 1,
e0eb5d38b732b0 Mike Christie      2021-02-27  316  	.cmd_size		= sizeof(struct tcm_loop_cmd),
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  317  };
3703b2c5d041a6 Nicholas Bellinger 2011-03-18  318  

:::::: The code at line 314 was first introduced by commit
:::::: 3703b2c5d041a68095cdd22380c23ce27d449ad7 [SCSI] tcm_loop: Add multi-fabric Linux/SCSI LLD fabric module

:::::: TO: Nicholas Bellinger <nab@linux-iscsi.org>
:::::: CC: James Bottomley <James.Bottomley@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
