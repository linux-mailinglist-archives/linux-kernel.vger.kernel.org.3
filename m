Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06654550E31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbiFTAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiFTAyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:54:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA76562
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655686458; x=1687222458;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QmBce5JrFncnZ4bmvD1o0Irg3NdV7p4KqJoxQVl0DTM=;
  b=CFa/vdkOReUH4PRIRGNtGvCFsOmJXtZGdw2HTqbO1gy1qPbP0Dy8KF+s
   RtcAAdcwVxR5URRhlmkcabbVBiuGcWcpQ9IHMvcFytes0SxbMnbip0RY2
   MXvDPV33TYTcDOKWgoA+Ya1I5+ahH6SNcW4v2cYcncFQH8N2rX03jpN7q
   9qk9FVZWRfFTDXQB2ilib5amj9JN80PIuoF94pLu2dA2wS3PCnJojWKWk
   5NkqiWnM/4DMicsGeD9sQeGBw33w6GZXo6Johcs3fHdO0fixYNLuNLSl/
   QOi4Rm0b1qirew8AsXybldhH5zVZr2731hhsvm+uAivWEmvk4CXItS3Mk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343767163"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343767163"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584313661"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2022 17:54:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o35gF-000Rin-Ep;
        Mon, 20 Jun 2022 00:54:15 +0000
Date:   Mon, 20 Jun 2022 08:53:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 139/146]
 drivers/platform/mpam/mpam_resctrl.c:226:6: warning: variable 'partid' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202206200833.sGQrZPBe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   bac90d25cbdee0fc233b9b1c47d5b6f44101a384
commit: fcd8f8da43dcd27b641fb9a297094ff95113a977 [139/146] arm_mpam: resctrl: Add iommu helpers to get/set the partid and pmg
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220620/202206200833.sGQrZPBe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=fcd8f8da43dcd27b641fb9a297094ff95113a977
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout fcd8f8da43dcd27b641fb9a297094ff95113a977
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/ drivers/platform/mpam/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/mpam/mpam_resctrl.c:226:6: warning: variable 'partid' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (cdp_enabled)
               ^~~~~~~~~~~
   drivers/platform/mpam/mpam_resctrl.c:229:42: note: uninitialized use occurs here
           return ops->set_group_qos_params(group, partid, rmid);
                                                   ^~~~~~
   drivers/platform/mpam/mpam_resctrl.c:226:2: note: remove the 'if' if its condition is always true
           if (cdp_enabled)
           ^~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_resctrl.c:219:12: note: initialize the variable 'partid' to silence this warning
           u16 partid;
                     ^
                      = 0
   drivers/platform/mpam/mpam_resctrl.c:381:25: warning: variable 'dom' is uninitialized when used here [-Wuninitialized]
                   mpam_msmon_reset_mbwu(dom->comp, &cfg);
                                         ^~~
   drivers/platform/mpam/mpam_resctrl.c:370:30: note: initialize the variable 'dom' to silence this warning
           struct mpam_resctrl_dom *dom;
                                       ^
                                        = NULL
   2 warnings generated.


vim +226 drivers/platform/mpam/mpam_resctrl.c

   215	
   216	int resctrl_arch_set_iommu_closid_rmid(struct iommu_group *group, u32 closid,
   217						u32 rmid)
   218	{
   219		u16 partid;
   220		const struct iommu_ops *ops;
   221	
   222		ops = iommu_group_get_ops(group);
   223		if (!ops || !ops->set_group_qos_params)
   224			return -EOPNOTSUPP;
   225	
 > 226		if (cdp_enabled)
   227			partid = closid << 1;
   228	
   229		return ops->set_group_qos_params(group, partid, rmid);
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
