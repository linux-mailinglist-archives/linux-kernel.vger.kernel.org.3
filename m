Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343FA502046
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348554AbiDOCJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiDOCJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:09:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B7B193F3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649988393; x=1681524393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Awyr725UZAI8FTXsrb+MwtwKfF/cERrxUkbIXF3VrjE=;
  b=kejIoOy/Yl3D8r211MeFxh7G9iwukT6t/h9reOzZocYFzdNtXwagiHe4
   bnUj+iVnHbhvppSpaM+a9cU6GnR0RPb4wq0IA8gdKXmFXxp3gzhCgDlHx
   EcKRNziMNToJ9H2vPlQn7Mvv59CvgS/Mut70KCbfLueyOh+y2kGq6/8n9
   x9RXEM18pO+T5oADULyv+YTjwi7SOuGIIg/rWCLPQRyTxu2FggJpuNMwK
   Kpzk8ER+rl881kVhpTWGDEUsYvJZavAerR8z2M+HwCxKBdqvOSHJnIHjO
   sPyX39sxgHZo5sB3x4OKEndmzxQJfXdD1546tyAYgUAOF/2WbDaft/Wj7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243660375"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="243660375"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="591405344"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2022 19:06:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfBLy-0001PV-JQ;
        Fri, 15 Apr 2022 02:06:30 +0000
Date:   Fri, 15 Apr 2022 10:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bean Huo <beanhuo@micron.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: drivers/scsi/ufs/ufshpb.c:335:25: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202204150904.vrT7zPxT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a19944809fe9942e6a96292490717904d0690c21
commit: 63522bf3aced0a782b59f0314dbad5cdc8b14c59 scsi: ufs: core: Add L2P entry swap quirk for Micron UFS
date:   8 months ago
config: powerpc-randconfig-s032-20220414 (https://download.01.org/0day-ci/archive/20220415/202204150904.vrT7zPxT-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63522bf3aced0a782b59f0314dbad5cdc8b14c59
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63522bf3aced0a782b59f0314dbad5cdc8b14c59
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/scsi/ufs/ufshpb.c:335:27: sparse: sparse: cast from restricted __be64
>> drivers/scsi/ufs/ufshpb.c:335:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] ppn_tmp @@     got unsigned long long [usertype] @@
   drivers/scsi/ufs/ufshpb.c:335:25: sparse:     expected restricted __be64 [usertype] ppn_tmp
   drivers/scsi/ufs/ufshpb.c:335:25: sparse:     got unsigned long long [usertype]

vim +335 drivers/scsi/ufs/ufshpb.c

   324	
   325	static void
   326	ufshpb_set_hpb_read_to_upiu(struct ufs_hba *hba, struct ufshpb_lu *hpb,
   327				    struct ufshcd_lrb *lrbp, u32 lpn, __be64 ppn,
   328				    u8 transfer_len, int read_id)
   329	{
   330		unsigned char *cdb = lrbp->cmd->cmnd;
   331		__be64 ppn_tmp = ppn;
   332		cdb[0] = UFSHPB_READ;
   333	
   334		if (hba->dev_quirks & UFS_DEVICE_QUIRK_SWAP_L2P_ENTRY_FOR_HPB_READ)
 > 335			ppn_tmp = swab64(ppn);
   336	
   337		/* ppn value is stored as big-endian in the host memory */
   338		memcpy(&cdb[6], &ppn_tmp, sizeof(__be64));
   339		cdb[14] = transfer_len;
   340		cdb[15] = read_id;
   341	
   342		lrbp->cmd->cmd_len = UFS_CDB_SIZE;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
