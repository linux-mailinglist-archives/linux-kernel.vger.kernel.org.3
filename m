Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F824E6931
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352895AbiCXTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244338AbiCXTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:20:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C463D1FF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648149513; x=1679685513;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nV2QYb06yMmWHmomP/c6IwNmM1YquY+JN0zkguaM7fQ=;
  b=UCzSoXM6XN0cLjtNttR6XbMtjVlMCEDgXaQzbraMMAg/X6jn7WGD10kJ
   R98illoSizHTt1f7Vyi+zd38gmv0twKgFUIYynWNZz0Wx0lPnXJWTS7Y8
   nLdw+I7VzSn9DgEeCSDRQiQEIPzCBV2SDO0ThxAofIzsLs0wcrkWUY+I3
   VOctXwd3Ciu8Md9gWFHXd5gPM4LXd/gzFlJxctzdpwAqyLqDCdkUEWxSd
   9FPy9rycuu5n3tEZXo2NUorLBbtU4ACIq+z65xOS77wAVNKj5KnN3/3sA
   YA3JH8GM8AcxlkbFqRjqTnhbqIdSVixR0xaTmpj2gxUukockS7EguBuhh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="344906199"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="344906199"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 12:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="519916416"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2022 12:18:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXSya-000LLF-Gu; Thu, 24 Mar 2022 19:18:28 +0000
Date:   Fri, 25 Mar 2022 03:17:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:virtual_subsys 165/170]
 drivers/nvme/host/core.c:3759:30: error: passing argument 1 of
 'nvme_mpath_alloc_disk' from incompatible pointer type
Message-ID: <202203250302.1bKlpHC6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git virtual_subsys
head:   275f3eb0b76e4cbc9fddaf4187988481747bb456
commit: e55421ca442930c9cc7606d8aa695ca85d485039 [165/170] nvme: use subsystem as argument in nvme_alloc_ns_head()
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220325/202203250302.1bKlpHC6-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=e55421ca442930c9cc7606d8aa695ca85d485039
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel virtual_subsys
        git checkout e55421ca442930c9cc7606d8aa695ca85d485039
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_alloc_ns_head':
>> drivers/nvme/host/core.c:3759:30: error: passing argument 1 of 'nvme_mpath_alloc_disk' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3759 |  ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
         |                              ^~~~~~
         |                              |
         |                              struct nvme_subsystem *
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:819:59: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_subsystem *'
     819 | static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
         |                                         ~~~~~~~~~~~~~~~~~~^~~~
   drivers/nvme/host/core.c:3759:38: error: passing argument 2 of 'nvme_mpath_alloc_disk' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3759 |  ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
         |                                      ^~~~
         |                                      |
         |                                      struct nvme_ctrl *
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:820:24: note: expected 'struct nvme_ns_head *' but argument is of type 'struct nvme_ctrl *'
     820 |   struct nvme_ns_head *head)
         |   ~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/host/core.c:3759:8: error: too many arguments to function 'nvme_mpath_alloc_disk'
    3759 |  ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
         |        ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:819:19: note: declared here
     819 | static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
         |                   ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/nvme_mpath_alloc_disk +3759 drivers/nvme/host/core.c

  3735	
  3736		head = kzalloc(size, GFP_KERNEL);
  3737		if (!head)
  3738			goto out;
  3739		ret = ida_alloc_min(&subsys->ns_ida, 1, GFP_KERNEL);
  3740		if (ret < 0)
  3741			goto out_free_head;
  3742		head->instance = ret;
  3743		INIT_LIST_HEAD(&head->list);
  3744		ret = init_srcu_struct(&head->srcu);
  3745		if (ret)
  3746			goto out_ida_remove;
  3747		head->subsys = subsys;
  3748		head->ns_id = nsid;
  3749		head->ids = *ids;
  3750		kref_init(&head->ref);
  3751	
  3752		if (head->ids.csi) {
  3753			ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
  3754			if (ret)
  3755				goto out_cleanup_srcu;
  3756		} else
  3757			head->effects = ctrl->effects;
  3758	
> 3759		ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
  3760		if (ret)
  3761			goto out_cleanup_srcu;
  3762	
  3763		list_add_tail(&head->entry, &subsys->nsheads);
  3764	
  3765		kref_get(&subsys->ref);
  3766	
  3767		return head;
  3768	out_cleanup_srcu:
  3769		cleanup_srcu_struct(&head->srcu);
  3770	out_ida_remove:
  3771		ida_free(&subsys->ns_ida, head->instance);
  3772	out_free_head:
  3773		kfree(head);
  3774	out:
  3775		if (ret > 0)
  3776			ret = blk_status_to_errno(nvme_error_status(ret));
  3777		return ERR_PTR(ret);
  3778	}
  3779	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
