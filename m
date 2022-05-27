Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47C536682
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352736AbiE0RVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiE0RVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:21:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B21127194
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653672109; x=1685208109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=biZmE1/hW9vvHUZ9KMiOrvWecthB+M7gCl1Q1Z6JsFg=;
  b=cXePtCbiNaRNdkxWoAOSFGjgOyLllWjDUUJrEtj1rlBnFWWTM1RkJXQH
   S0UZ8Rl2dygUEDgj1HkopNXg6LgeErLHsNzgDCaO3yTZc8GM5LhRP3SCE
   HC1bdf3sSqm/xMMlb4OKFz+oLAaCjYldmkij6hBwCb1M7XSHo5oNzT6k3
   kt9WsyzdQR3TgcKOVRk8gtyJIY2qFs13NuiytBbnH24PoD3vS7EJl9jHv
   +fR2/aND1HNhfAB/nGMBE3voATF9viQCDz/Fokurmvn6M/Yc/Iw5jOndb
   JfwH97Jz1Edn9PXzUK3WV60wZerNZxPRQMiXLsF7mbeP+SQZM3kY2Hr8Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="256605726"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="256605726"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 10:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="631694004"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2022 10:21:47 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nudek-0004yr-PP;
        Fri, 27 May 2022 17:21:46 +0000
Date:   Sat, 28 May 2022 01:21:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_app.c:1230: warning: expecting prototype
 for adapter_state_show(). Prototype was for adp_state_show() instead
Message-ID: <202205280136.fIV879pm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 986d6bad2103fb24bd886aad455245ace168c984 scsi: mpi3mr: Expose adapter state to sysfs
date:   4 weeks ago
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220528/202205280136.fIV879pm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=986d6bad2103fb24bd886aad455245ace168c984
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 986d6bad2103fb24bd886aad455245ace168c984
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/mpi3mr/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/mpi3mr/mpi3mr_app.c:641: warning: Function parameter or member 'reply_payload_rcv_len' not described in 'mpi3mr_bsg_process_mpt_cmds'
   drivers/scsi/mpi3mr/mpi3mr_app.c:1147: warning: Function parameter or member 'mrioc' not described in 'mpi3mr_bsg_exit'
   drivers/scsi/mpi3mr/mpi3mr_app.c:1181: warning: Function parameter or member 'mrioc' not described in 'mpi3mr_bsg_init'
>> drivers/scsi/mpi3mr/mpi3mr_app.c:1230: warning: expecting prototype for adapter_state_show(). Prototype was for adp_state_show() instead


vim +1230 drivers/scsi/mpi3mr/mpi3mr_app.c

  1218	
  1219	/**
  1220	 * adapter_state_show - SysFS callback for adapter state show
  1221	 * @dev: class device
  1222	 * @attr: Device attributes
  1223	 * @buf: Buffer to copy
  1224	 *
  1225	 * Return: snprintf() return after copying adapter state
  1226	 */
  1227	static ssize_t
  1228	adp_state_show(struct device *dev, struct device_attribute *attr,
  1229		char *buf)
> 1230	{
  1231		struct Scsi_Host *shost = class_to_shost(dev);
  1232		struct mpi3mr_ioc *mrioc = shost_priv(shost);
  1233		enum mpi3mr_iocstate ioc_state;
  1234		uint8_t adp_state;
  1235	
  1236		ioc_state = mpi3mr_get_iocstate(mrioc);
  1237		if (ioc_state == MRIOC_STATE_UNRECOVERABLE)
  1238			adp_state = MPI3MR_BSG_ADPSTATE_UNRECOVERABLE;
  1239		else if ((mrioc->reset_in_progress) || (mrioc->stop_bsgs))
  1240			adp_state = MPI3MR_BSG_ADPSTATE_IN_RESET;
  1241		else if (ioc_state == MRIOC_STATE_FAULT)
  1242			adp_state = MPI3MR_BSG_ADPSTATE_FAULT;
  1243		else
  1244			adp_state = MPI3MR_BSG_ADPSTATE_OPERATIONAL;
  1245	
  1246		return snprintf(buf, PAGE_SIZE, "%u\n", adp_state);
  1247	}
  1248	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
