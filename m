Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF34EEE91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbiDAN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbiDAN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:56:00 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FF31DC985
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648821251; x=1680357251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xdla0raErXghEbcfCJ4QRQ8OlymQ7+m3tSFDmdSEhqU=;
  b=AAPJt59kUcnjLqm3dj31hK8YKUaFe7X/0RKTnLvb9rf7Q7Cwf8qQchiq
   +3gQQhybU7tyB1sCI3Ma+YGN1GzVNA/zWsyG3VUrpvWwzPvsr5OFAhjAe
   DaAqMxFq6vWzo54WjbQsgVEub9mP6z1PgluSpm3GqO+m7CvPNxNrUe73z
   yDW3CyoiS1PGB+G1Gn6UG5qWGQwVesfR1zzGEEB0uyMl3Ix9JCRYGEOul
   EIDr3nQBE3lje1+odSwmp7iQJ5yinLN2UELpQsY2PXk12SpsPPWQ2MfWK
   B3SgV8iKOtMWX/B0RlvimVCAPkqo2v0wmYsDHlqzokpbwnzqLqyerbr+U
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320828034"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="320828034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="522782082"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2022 06:54:09 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naHj7-0001I8-9Y;
        Fri, 01 Apr 2022 13:54:09 +0000
Date:   Fri, 1 Apr 2022 21:54:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:virtual-subsys 177/184]
 drivers/nvme/host/core.c:3778:37: error: passing argument 1 of
 'nvme_mpath_alloc_disk' from incompatible pointer type
Message-ID: <202204012127.blulfoKP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git virtual-subsys
head:   13007630535ac7896532316b4e7d2c1fe868d2fc
commit: 35b5f4108aa1c4f0b2322682b5c6aa3a09314a53 [177/184] nvme: use subsystem as argument in nvme_alloc_ns_head()
config: powerpc64-randconfig-r034-20220331 (https://download.01.org/0day-ci/archive/20220401/202204012127.blulfoKP-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=35b5f4108aa1c4f0b2322682b5c6aa3a09314a53
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel virtual-subsys
        git checkout 35b5f4108aa1c4f0b2322682b5c6aa3a09314a53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_alloc_ns_head':
>> drivers/nvme/host/core.c:3778:37: error: passing argument 1 of 'nvme_mpath_alloc_disk' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3778 |         ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
         |                                     ^~~~~~
         |                                     |
         |                                     struct nvme_subsystem *
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:839:59: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_subsystem *'
     839 | static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
         |                                         ~~~~~~~~~~~~~~~~~~^~~~
   drivers/nvme/host/core.c:3778:45: error: passing argument 2 of 'nvme_mpath_alloc_disk' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3778 |         ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
         |                                             ^~~~
         |                                             |
         |                                             struct nvme_ctrl *
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:840:38: note: expected 'struct nvme_ns_head *' but argument is of type 'struct nvme_ctrl *'
     840 |                 struct nvme_ns_head *head)
         |                 ~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/host/core.c:3778:15: error: too many arguments to function 'nvme_mpath_alloc_disk'
    3778 |         ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
         |               ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/nvme/host/core.c:25:
   drivers/nvme/host/nvme.h:839:19: note: declared here
     839 | static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
         |                   ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LEDS_TRIGGER_DISK
   Depends on NEW_LEDS && LEDS_TRIGGERS && ATA
   Selected by
   - ADB_PMU_LED_DISK && MACINTOSH_DRIVERS && ADB_PMU_LED && LEDS_CLASS


vim +/nvme_mpath_alloc_disk +3778 drivers/nvme/host/core.c

  3754	
  3755		head = kzalloc(size, GFP_KERNEL);
  3756		if (!head)
  3757			goto out;
  3758		ret = ida_alloc_min(&subsys->ns_ida, 1, GFP_KERNEL);
  3759		if (ret < 0)
  3760			goto out_free_head;
  3761		head->instance = ret;
  3762		INIT_LIST_HEAD(&head->list);
  3763		ret = init_srcu_struct(&head->srcu);
  3764		if (ret)
  3765			goto out_ida_remove;
  3766		head->subsys = subsys;
  3767		head->ns_id = nsid;
  3768		head->ids = *ids;
  3769		kref_init(&head->ref);
  3770	
  3771		if (head->ids.csi) {
  3772			ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
  3773			if (ret)
  3774				goto out_cleanup_srcu;
  3775		} else
  3776			head->effects = ctrl->effects;
  3777	
> 3778		ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
  3779		if (ret)
  3780			goto out_cleanup_srcu;
  3781	
  3782		list_add_tail(&head->entry, &subsys->nsheads);
  3783	
  3784		kref_get(&subsys->ref);
  3785	
  3786		return head;
  3787	out_cleanup_srcu:
  3788		cleanup_srcu_struct(&head->srcu);
  3789	out_ida_remove:
  3790		ida_free(&subsys->ns_ida, head->instance);
  3791	out_free_head:
  3792		kfree(head);
  3793	out:
  3794		if (ret > 0)
  3795			ret = blk_status_to_errno(nvme_error_status(ret));
  3796		return ERR_PTR(ret);
  3797	}
  3798	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
