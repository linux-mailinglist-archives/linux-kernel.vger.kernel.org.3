Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061214EB77F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiC3AqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiC3AqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:46:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E3182AE3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648601076; x=1680137076;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k0WJV+wQxL1oipMcGM7eD6BwEm/VitRunljixoP6PLY=;
  b=XChAAgtA8HurZNxdgBjNOk9TH4jUuWikMsXc0t3ZBanhDpcKr1hhopkF
   AEHGmOPLsufVI+MVrJ5cnrdqATpTAhSeu61voOwEPbyB3LBdCWbjppSVn
   dskoeodglydBBVAmSg+LfshFxImubxD7SfCUOC9REv3nGh2CIqTkU4tOP
   Rw3ooi75xhQZbLYxvG7y/iIuRvKR5AYeZWIYMjDAsL0OioKdXCANtdQLU
   Vngp3pxFSZLSAuqES/MFAMXxFRDURrYV4E4Lf/9YQGMFjt+aAr4gxBxgh
   8YBCXe5BqsMuq6NpnSqRKxo0eNhqZ8ddw1/73nRR4TJoYqywjlPNuAb87
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322594810"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322594810"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 17:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="503116647"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2022 17:44:34 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZMRt-0000og-Fu; Wed, 30 Mar 2022 00:44:33 +0000
Date:   Wed, 30 Mar 2022 08:44:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220301-take2 5/27] ERROR: modpost:
 "typec_mux_get_drvdata" [drivers/gpu/drm/msm/msm.ko] undefined!
Message-ID: <202203300817.85Fl2EbD-lkp@intel.com>
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

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220301-take2
head:   4e9e94d03691fd0820dcff8d0877ddb280b01f88
commit: e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771 [5/27] drm/msm/dp: Add typec_mux implementation
config: hexagon-randconfig-r005-20220329 (https://download.01.org/0day-ci/archive/20220330/202203300817.85Fl2EbD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220301-take2
        git checkout e4014b0e8a0a46349e91bfb9ef44a59d5a4a2771
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "typec_mux_get_drvdata" [drivers/gpu/drm/msm/msm.ko] undefined!
>> ERROR: modpost: "typec_mux_unregister" [drivers/gpu/drm/msm/msm.ko] undefined!
>> ERROR: modpost: "typec_mux_register" [drivers/gpu/drm/msm/msm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
