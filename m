Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA14D7526
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiCMMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:33:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286F8F9A8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647174719; x=1678710719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f8gSQSwAk/Xbukpcak/rPaOSl18o/vcQ08CWSdnQMX8=;
  b=jfYXnSElnzla7sls/63aB18hb13w26MvyRa+Ue85jFXrFKao30QMdRg/
   i+xEOADHpAKXdTGTHYLcxUVsJcrdqE20o4TgCkvq5t1YRpCvszOYKlXQ0
   4kZU7P0bsr6nvVLTk5ybiqC1mI4acHk5htI3TxaOA0zU9bCh4IsSXp7of
   aEFD84r24wpRyGcKRqrXzP+4baeQf9Dq7/s16AyaUOY6AkCuyrUpXZNse
   +oNoCoMWlnLqEiHRW4GYpev76fbKGGHOCSRB2YNy/WfUn0wXG0hOIZAPI
   E+YPnSGv19M2uqZFTluQ8b5z87pE6DCUs3Ide6QbWed9IyJ4yJubKdAKs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="342291348"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="342291348"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="645463210"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2022 05:31:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTNO8-0008wg-Kg; Sun, 13 Mar 2022 12:31:56 +0000
Date:   Sun, 13 Mar 2022 20:31:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 133/156]
 drivers/nvme/host/core.c:4946: undefined reference to `nvme_keyring_exit'
Message-ID: <202203132014.0xK2u0OO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 5c012a33316168af9ff3a20ee1ae0edc60c745ae [133/156] nvme: register .nvme keyring
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220313/202203132014.0xK2u0OO-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=5c012a33316168af9ff3a20ee1ae0edc60c745ae
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 5c012a33316168af9ff3a20ee1ae0edc60c745ae
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
>> drivers/nvme/host/core.c:4946: undefined reference to `nvme_keyring_exit'
   ld: drivers/nvme/host/core.o: in function `nvme_core_init':
>> drivers/nvme/host/core.c:4918: undefined reference to `nvme_keyring_init'


vim +4946 drivers/nvme/host/core.c

  4866	
  4867	
  4868	static int __init nvme_core_init(void)
  4869	{
  4870		int result = -ENOMEM;
  4871	
  4872		_nvme_check_size();
  4873	
  4874		nvme_wq = alloc_workqueue("nvme-wq",
  4875				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
  4876		if (!nvme_wq)
  4877			goto out;
  4878	
  4879		nvme_reset_wq = alloc_workqueue("nvme-reset-wq",
  4880				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
  4881		if (!nvme_reset_wq)
  4882			goto destroy_wq;
  4883	
  4884		nvme_delete_wq = alloc_workqueue("nvme-delete-wq",
  4885				WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
  4886		if (!nvme_delete_wq)
  4887			goto destroy_reset_wq;
  4888	
  4889		result = alloc_chrdev_region(&nvme_ctrl_base_chr_devt, 0,
  4890				NVME_MINORS, "nvme");
  4891		if (result < 0)
  4892			goto destroy_delete_wq;
  4893	
  4894		nvme_class = class_create(THIS_MODULE, "nvme");
  4895		if (IS_ERR(nvme_class)) {
  4896			result = PTR_ERR(nvme_class);
  4897			goto unregister_chrdev;
  4898		}
  4899		nvme_class->dev_uevent = nvme_class_uevent;
  4900	
  4901		nvme_subsys_class = class_create(THIS_MODULE, "nvme-subsystem");
  4902		if (IS_ERR(nvme_subsys_class)) {
  4903			result = PTR_ERR(nvme_subsys_class);
  4904			goto destroy_class;
  4905		}
  4906	
  4907		result = alloc_chrdev_region(&nvme_ns_chr_devt, 0, NVME_MINORS,
  4908					     "nvme-generic");
  4909		if (result < 0)
  4910			goto destroy_subsys_class;
  4911	
  4912		nvme_ns_chr_class = class_create(THIS_MODULE, "nvme-generic");
  4913		if (IS_ERR(nvme_ns_chr_class)) {
  4914			result = PTR_ERR(nvme_ns_chr_class);
  4915			goto unregister_generic_ns;
  4916		}
  4917	
> 4918		result = nvme_keyring_init();
  4919		if (result)
  4920			goto destroy_ns_chr_class;
  4921	
  4922		return 0;
  4923	
  4924	destroy_ns_chr_class:
  4925		class_destroy(nvme_ns_chr_class);
  4926	unregister_generic_ns:
  4927		unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
  4928	destroy_subsys_class:
  4929		class_destroy(nvme_subsys_class);
  4930	destroy_class:
  4931		class_destroy(nvme_class);
  4932	unregister_chrdev:
  4933		unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
  4934	destroy_delete_wq:
  4935		destroy_workqueue(nvme_delete_wq);
  4936	destroy_reset_wq:
  4937		destroy_workqueue(nvme_reset_wq);
  4938	destroy_wq:
  4939		destroy_workqueue(nvme_wq);
  4940	out:
  4941		return result;
  4942	}
  4943	
  4944	static void __exit nvme_core_exit(void)
  4945	{
> 4946		nvme_keyring_exit();
  4947		class_destroy(nvme_ns_chr_class);
  4948		class_destroy(nvme_subsys_class);
  4949		class_destroy(nvme_class);
  4950		unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
  4951		unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
  4952		destroy_workqueue(nvme_delete_wq);
  4953		destroy_workqueue(nvme_reset_wq);
  4954		destroy_workqueue(nvme_wq);
  4955		ida_destroy(&nvme_ns_chr_minor_ida);
  4956		ida_destroy(&nvme_instance_ida);
  4957	}
  4958	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
