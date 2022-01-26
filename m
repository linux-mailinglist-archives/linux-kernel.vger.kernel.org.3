Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC249C91C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiAZLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:54:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:25937 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234430AbiAZLyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643198094; x=1674734094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OtleJA0WjwSEu06/vMfXDZLw24O+/fo4u1KPDp5Atls=;
  b=Fvh0YhijfPdAHPe+o+wNmm+Igd0bbJ/izWcaZoO2tEU39LErNlHHAPRz
   B64m0KSEfzEhYX7vt1zbnYEYDzX5AOZh5rL9SK2PK19ik4LOvL2etFAG7
   iwfk5y85W5qyipGTRP2JtxPtJ6m6nZhNU2Dh73OHvhN5yqsIdah+RFLkP
   BfqTgnqqMPeBB2EFdgf8iRIpECVdU0YxL4ZrHuIrdo45KwnNN4DFeIdBt
   FzgD5FbXQVvSVtVKlQVnl26WiQd//kE0Lomy+ol+dr5Z+aCSp5okVlpy5
   mIa8MLuXZR+L+FVdLvZQ3/Ijo1OQj5hVfXMq97z+4wqO1BYBiRpygHpuz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244133121"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244133121"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="696196279"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 03:54:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCgt2-000L9Z-5u; Wed, 26 Jan 2022 11:54:52 +0000
Date:   Wed, 26 Jan 2022 19:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 92/137]
 drivers/platform/mpam/mpam_devices.c:277:5: warning: no previous prototype
 for 'mpam_ris_get_affinity'
Message-ID: <202201261947.fXVOY521-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 14660e9725835a4ec28fbc00f4f5f742c673383f [92/137] arm_mpam: Add the class and component structures for ris firmware described
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201261947.fXVOY521-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=14660e9725835a4ec28fbc00f4f5f742c673383f
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 14660e9725835a4ec28fbc00f4f5f742c673383f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/platform/mpam/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mpam/mpam_devices.c:277:5: warning: no previous prototype for 'mpam_ris_get_affinity' [-Wmissing-prototypes]
     277 | int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/mpam/mpam_devices.c:310:5: warning: no previous prototype for 'mpam_ris_create_locked' [-Wmissing-prototypes]
     310 | int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:567:5: warning: no previous prototype for 'mpam_msc_drv_remove' [-Wmissing-prototypes]
     567 | int mpam_msc_drv_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/mpam_ris_get_affinity +277 drivers/platform/mpam/mpam_devices.c

   276	
 > 277	int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
   278				  enum mpam_class_types type, struct mpam_class *class,
   279				  struct mpam_component *comp)
   280	{
   281		int err;
   282	
   283		switch (type) {
   284		case MPAM_CLASS_CACHE:
   285			err = get_cpumask_from_cache_id(comp->comp_id, class->level,
   286							affinity);
   287			if (err)
   288				return err;
   289	
   290			if (cpumask_empty(affinity))
   291				pr_warn_once("%s no CPUs associated with cache node",
   292					     dev_name(&msc->pdev->dev));
   293	
   294			break;
   295		case MPAM_CLASS_MEMORY:
   296			*affinity = *cpumask_of_node(comp->comp_id);
   297			if (cpumask_empty(affinity))
   298				pr_warn_once("%s no CPUs associated with memory node",
   299					     dev_name(&msc->pdev->dev));
   300			break;
   301		case MPAM_CLASS_UNKNOWN:
   302			return 0;
   303		}
   304	
   305		cpumask_and(affinity, affinity, &msc->accessibility);
   306	
   307		return 0;
   308	}
   309	
 > 310	int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
   311				   enum mpam_class_types type, u8 class_id,
   312				   int component_id, gfp_t gfp)
   313	{
   314		int err;
   315		struct mpam_msc_ris *ris;
   316		struct mpam_class *class;
   317		struct mpam_component *comp;
   318	
   319		lockdep_assert_held(&mpam_list_lock);
   320	
   321		if (test_and_set_bit(ris_idx, msc->ris_idxs))
   322			return -EBUSY;
   323	
   324		ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), gfp);
   325		if (!ris)
   326			return -ENOMEM;
   327	
   328		class = mpam_class_get(class_id, type, true, gfp);
   329		if (IS_ERR(class))
   330			return PTR_ERR(class);
   331	
   332		comp = mpam_component_get(class, component_id, true, gfp);
   333		if (IS_ERR(comp)) {
   334			if (list_empty(&class->components))
   335				mpam_class_destroy(class);
   336			return PTR_ERR(comp);
   337		}
   338	
   339		err = mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
   340		if (err) {
   341			if (list_empty(&class->components))
   342				mpam_class_destroy(class);
   343			return err;
   344		}
   345	
   346		ris->ris_idx = ris_idx;
   347		INIT_LIST_HEAD_RCU(&ris->comp_list);
   348		INIT_LIST_HEAD_RCU(&ris->msc_list);
   349		ris->msc = msc;
   350		ris->comp = comp;
   351	
   352		cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
   353		cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
   354		list_add_rcu(&ris->comp_list, &comp->ris);
   355	
   356		return 0;
   357	}
   358	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
