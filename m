Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CA520361
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiEIRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiEIRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:18:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB42D86B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652116492; x=1683652492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yDYZUzAIBQmbl1t48yAu1kdYhisZF0SvLGWJlDrxgD8=;
  b=TV8Qkn20tNmiGb1qEcqk1YDmzYYfSbfO0myzD43c7AqU19b+j+JjtyOg
   Mu8TJIAdyFgC4fSl5M53cQU5qnNO93tgDoxTt9hfkAWn1rwXqK28MPiEw
   bU2xaCQAxI368D4m5OqBiwXNhR2dSAuyCJ3381EqrFeiSrClFWTTP7xuT
   M5xiPAlxgVpwlk7IMZ3XDlNnHOKh5GMKObtM/yMNCfK2Z2+CIRGBFBjbh
   ww3IA5IHrwEcbmyyeeQHR77vzR/X62XuFyn6HW16DqXCF3xW1qrJxkipQ
   wJEmkb6TEavwEWKIyroua8btwSb7bbVnsch4ApMjz+BjVPQY3x+YLL6Pa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268777978"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="268777978"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="657221890"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 10:14:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no6y9-000Gig-B8;
        Mon, 09 May 2022 17:14:49 +0000
Date:   Tue, 10 May 2022 01:14:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tal Cohen <talcohen@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 47/47]
 drivers/misc/habanalabs/common/habanalabs_drv.c:138:41: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202205100106.LlBrBvTd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   20c59ac5d71e766235e74f353b74e60facd733c8
commit: 20c59ac5d71e766235e74f353b74e60facd733c8 [47/47] habanalabs: add support for notification via eventfd
config: alpha-randconfig-s031-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100106.LlBrBvTd-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=20c59ac5d71e766235e74f353b74e60facd733c8
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 20c59ac5d71e766235e74f353b74e60facd733c8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/common/habanalabs_drv.c:138:41: sparse: sparse: Using plain integer as NULL pointer
   drivers/misc/habanalabs/common/habanalabs_drv.c:250:41: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/misc/habanalabs/common/habanalabs_ioctl.c:650:49: sparse: sparse: Using plain integer as NULL pointer
   drivers/misc/habanalabs/common/habanalabs_ioctl.c:668:41: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/misc/habanalabs/common/device.c:291:49: sparse: sparse: Using plain integer as NULL pointer
   drivers/misc/habanalabs/common/device.c:369:49: sparse: sparse: Using plain integer as NULL pointer

vim +138 drivers/misc/habanalabs/common/habanalabs_drv.c

   104	
   105	/*
   106	 * hl_device_open - open function for habanalabs device
   107	 *
   108	 * @inode: pointer to inode structure
   109	 * @filp: pointer to file structure
   110	 *
   111	 * Called when process opens an habanalabs device.
   112	 */
   113	int hl_device_open(struct inode *inode, struct file *filp)
   114	{
   115		enum hl_device_status status;
   116		struct hl_device *hdev;
   117		struct hl_fpriv *hpriv;
   118		int rc;
   119	
   120		mutex_lock(&hl_devs_idr_lock);
   121		hdev = idr_find(&hl_devs_idr, iminor(inode));
   122		mutex_unlock(&hl_devs_idr_lock);
   123	
   124		if (!hdev) {
   125			pr_err("Couldn't find device %d:%d\n",
   126				imajor(inode), iminor(inode));
   127			return -ENXIO;
   128		}
   129	
   130		hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
   131		if (!hpriv)
   132			return -ENOMEM;
   133	
   134		hpriv->hdev = hdev;
   135		filp->private_data = hpriv;
   136		hpriv->filp = filp;
   137		hpriv->notifier_event.events_mask = 0;
 > 138		hpriv->notifier_event.eventfd = 0;
   139	
   140		mutex_init(&hpriv->notifier_event.lock);
   141		mutex_init(&hpriv->restore_phase_mutex);
   142		kref_init(&hpriv->refcount);
   143		nonseekable_open(inode, filp);
   144	
   145		hl_ctx_mgr_init(&hpriv->ctx_mgr);
   146		hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr);
   147	
   148		hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
   149	
   150		mutex_lock(&hdev->fpriv_list_lock);
   151	
   152		if (!hl_device_operational(hdev, &status)) {
   153			dev_err_ratelimited(hdev->dev,
   154				"Can't open %s because it is %s\n",
   155				dev_name(hdev->dev), hdev->status[status]);
   156	
   157			if (status == HL_DEVICE_STATUS_IN_RESET)
   158				rc = -EAGAIN;
   159			else
   160				rc = -EPERM;
   161	
   162			goto out_err;
   163		}
   164	
   165		if (hdev->is_in_dram_scrub) {
   166			dev_dbg_ratelimited(hdev->dev,
   167				"Can't open %s during dram scrub\n",
   168				dev_name(hdev->dev));
   169			rc = -EAGAIN;
   170			goto out_err;
   171		}
   172	
   173		if (hdev->compute_ctx_in_release) {
   174			dev_dbg_ratelimited(hdev->dev,
   175				"Can't open %s because another user is still releasing it\n",
   176				dev_name(hdev->dev));
   177			rc = -EAGAIN;
   178			goto out_err;
   179		}
   180	
   181		if (hdev->is_compute_ctx_active) {
   182			dev_dbg_ratelimited(hdev->dev,
   183				"Can't open %s because another user is working on it\n",
   184				dev_name(hdev->dev));
   185			rc = -EBUSY;
   186			goto out_err;
   187		}
   188	
   189		rc = hl_ctx_create(hdev, hpriv);
   190		if (rc) {
   191			dev_err(hdev->dev, "Failed to create context %d\n", rc);
   192			goto out_err;
   193		}
   194	
   195		list_add(&hpriv->dev_node, &hdev->fpriv_list);
   196		mutex_unlock(&hdev->fpriv_list_lock);
   197	
   198		hl_debugfs_add_file(hpriv);
   199	
   200		atomic_set(&hdev->last_error.cs_write_disable, 0);
   201		atomic_set(&hdev->last_error.razwi_write_disable, 0);
   202	
   203		hdev->open_counter++;
   204		hdev->last_successful_open_jif = jiffies;
   205		hdev->last_successful_open_ktime = ktime_get();
   206	
   207		return 0;
   208	
   209	out_err:
   210		mutex_unlock(&hdev->fpriv_list_lock);
   211		hl_mem_mgr_fini(&hpriv->mem_mgr);
   212		hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
   213		filp->private_data = NULL;
   214		mutex_destroy(&hpriv->restore_phase_mutex);
   215		mutex_destroy(&hpriv->notifier_event.lock);
   216		put_pid(hpriv->taskpid);
   217	
   218		kfree(hpriv);
   219	
   220		return rc;
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
