Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC404F5777
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiDFH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379448AbiDFHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 03:44:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110111D4C35
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649224015; x=1680760015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pbIUUIp4nErbnC5xtpVwWODtGAIkDFdiIoa2L9mPj1k=;
  b=GokX/BHFoMokhqYqxGGTh61HKs1bzcL1/7hlqFjHga1tNYGykrmo04B4
   IPpkKTh933US8jiWLD9H9ISbPDS5HTDu2HQwCE9dlD+ieycEQPkH0LqKN
   65T3pNbix/9Ju1lP/anVFG3YhGBEreiAyFhnY4aqRyF4JAmxc4+/Tvj2i
   UZWbKxJR/1FiW7g49mB79fpUAHWlL3275Dbd5uDfzY6rsw88AXK4kaVGq
   J46YSi13TPc1RnmVW2B4inhCTuS0YI2AqVzE/FqKT5dY/tfV/GQcf4R5M
   Ey1z874aeKUEuDceagKgoU3mpj630ZzIn844L88pAJOvP+ryplwCAQLdW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241541789"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="241541789"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 22:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="549392063"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 22:46:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbyVF-00047N-Bj;
        Wed, 06 Apr 2022 05:46:49 +0000
Date:   Wed, 6 Apr 2022 13:46:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:virtual-subsys 177/184]
 drivers/nvme/host/core.c:3778:44: error: too many arguments to function
 call, expected 2, have 3
Message-ID: <202204061335.Gk6dBO36-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git virtual-subsys
head:   13007630535ac7896532316b4e7d2c1fe868d2fc
commit: 35b5f4108aa1c4f0b2322682b5c6aa3a09314a53 [177/184] nvme: use subsystem as argument in nvme_alloc_ns_head()
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220406/202204061335.Gk6dBO36-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=35b5f4108aa1c4f0b2322682b5c6aa3a09314a53
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel virtual-subsys
        git checkout 35b5f4108aa1c4f0b2322682b5c6aa3a09314a53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/host/core.c:3778:44: error: too many arguments to function call, expected 2, have 3
           ret = nvme_mpath_alloc_disk(subsys, ctrl, head);
                 ~~~~~~~~~~~~~~~~~~~~~               ^~~~
   drivers/nvme/host/nvme.h:839:19: note: 'nvme_mpath_alloc_disk' declared here
   static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
                     ^
   1 error generated.


vim +3778 drivers/nvme/host/core.c

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
