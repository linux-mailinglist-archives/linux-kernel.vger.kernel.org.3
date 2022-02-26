Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E734C54E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiBZJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 04:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBZJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 04:30:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01560292EE2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645867787; x=1677403787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aMLlJIdLHd5i9yiuNGg3R4D6MIquWUN9F2dRs7n82f0=;
  b=ReTwyJlMIC8VpljlKIZ0hBVCkhRuVNVEtqYRtpRbRf5+bAzCsOiY0B1u
   h1+sF5aDXGjcIzKhPHRqso1LugTxXYn/xtXNFVkYz5IbpTL+PcUIbC/Fn
   H9lknsBjW7jRDntUGeHrHBAqkzp5C/UxDyIStqTPoo8pCdmomvXMehgN8
   86pPeaS5Q1wEmOcbq2ITx7zAtFAkLK3G0noONXsnAxGqyVJnm0s2hY3I+
   N6ditb4nqkdcBPDNryqI0Ww1NtrCT9AWuYvw0NbrihxWhuX9YT6KM0V8U
   cMQ33tfN45/1jO375FQAA1Ccv62YdOfYkYUJDvWODLkV08q/lfvzl2wxo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="277286999"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="277286999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 01:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="684884464"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2022 01:29:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNtOb-0005Lf-Hs; Sat, 26 Feb 2022 09:29:45 +0000
Date:   Sat, 26 Feb 2022 17:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:next/linux-next/akpm-base 54/86]
 drivers/scsi/aacraid/aachba.c:841:26: warning: array subscript 12 is outside
 array bounds of 'struct scsi_cmnd[1]'
Message-ID: <202202261717.NzgEagBk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/akpm-base
head:   96e1561b10f208e7e599796f3dc3717d357ab4a1
commit: 4d3f3f514ee62c43ee39f5596408b95cccb46fbb [54/86] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
config: microblaze-buildonly-randconfig-r003-20220225 (https://download.01.org/0day-ci/archive/20220226/202202261717.NzgEagBk-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4d3f3f514ee62c43ee39f5596408b95cccb46fbb
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/akpm-base
        git checkout 4d3f3f514ee62c43ee39f5596408b95cccb46fbb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/scsi/aacraid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/aacraid/aachba.c: In function 'aac_probe_container':
>> drivers/scsi/aacraid/aachba.c:841:26: warning: array subscript 12 is outside array bounds of 'struct scsi_cmnd[1]' [-Warray-bounds]
     841 |         status = cmd_priv->status;
         |                          ^~
   drivers/scsi/aacraid/aachba.c:821:37: note: referencing an object of size 196 allocated by 'kzalloc.constprop'
     821 |         struct scsi_cmnd *scsicmd = kzalloc(sizeof(*scsicmd), GFP_KERNEL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +841 drivers/scsi/aacraid/aachba.c

779dfcf6435b9a Phong Tran      2020-03-09  818  
fe76df4235986c Mark Haverkamp  2007-03-15  819  int aac_probe_container(struct aac_dev *dev, int cid)
fe76df4235986c Mark Haverkamp  2007-03-15  820  {
7afdb863799749 Bart Van Assche 2021-10-07  821  	struct scsi_cmnd *scsicmd = kzalloc(sizeof(*scsicmd), GFP_KERNEL);
76a3451b64c6d1 Bart Van Assche 2022-02-18  822  	struct aac_cmd_priv *cmd_priv = aac_priv(scsicmd);
7afdb863799749 Bart Van Assche 2021-10-07  823  	struct scsi_device *scsidev = kzalloc(sizeof(*scsidev), GFP_KERNEL);
fe76df4235986c Mark Haverkamp  2007-03-15  824  	int status;
fe76df4235986c Mark Haverkamp  2007-03-15  825  
fe76df4235986c Mark Haverkamp  2007-03-15  826  	if (!scsicmd || !scsidev) {
fe76df4235986c Mark Haverkamp  2007-03-15  827  		kfree(scsicmd);
fe76df4235986c Mark Haverkamp  2007-03-15  828  		kfree(scsidev);
fe76df4235986c Mark Haverkamp  2007-03-15  829  		return -ENOMEM;
fe76df4235986c Mark Haverkamp  2007-03-15  830  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  831  
fe76df4235986c Mark Haverkamp  2007-03-15  832  	scsicmd->device = scsidev;
fe76df4235986c Mark Haverkamp  2007-03-15  833  	scsidev->sdev_state = 0;
fe76df4235986c Mark Haverkamp  2007-03-15  834  	scsidev->id = cid;
fe76df4235986c Mark Haverkamp  2007-03-15  835  	scsidev->host = dev->scsi_host_ptr;
fe76df4235986c Mark Haverkamp  2007-03-15  836  
fe76df4235986c Mark Haverkamp  2007-03-15  837  	if (_aac_probe_container(scsicmd, aac_probe_container_callback1) == 0)
fe76df4235986c Mark Haverkamp  2007-03-15  838  		while (scsicmd->device == scsidev)
fe76df4235986c Mark Haverkamp  2007-03-15  839  			schedule();
802ae2f05b646c Salyzyn, Mark   2007-03-21  840  	kfree(scsidev);
76a3451b64c6d1 Bart Van Assche 2022-02-18 @841  	status = cmd_priv->status;
fe76df4235986c Mark Haverkamp  2007-03-15  842  	kfree(scsicmd);
^1da177e4c3f41 Linus Torvalds  2005-04-16  843  	return status;
^1da177e4c3f41 Linus Torvalds  2005-04-16  844  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  845  

:::::: The code at line 841 was first introduced by commit
:::::: 76a3451b64c6d1718a651697670bd5dc557ed148 scsi: aacraid: Move the SCSI pointer to private command data

:::::: TO: Bart Van Assche <bvanassche@acm.org>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
