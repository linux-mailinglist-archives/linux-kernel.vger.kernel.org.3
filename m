Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39C527E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiEPHK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbiEPHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:10:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9FADFF4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652685048; x=1684221048;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=osVtCMIQYinX4FphV0D5a3TGESr9bXGCHbW430bzhC8=;
  b=AogQl1wrHkOlNUgWKSHxPoPdnaa2gUq3SF6mMWJia36tsupsUnPnhO2S
   S/GQMM5y/VjrhvKKC4f4+FXXl9QI2dYBH36v0ajr/Fn6ArFeNEO+0YO0s
   YOBJb4vy915BtB7vjcSJFAiXLjRiJHY/4WHpW29QWh3zi+SjDyg7yAukA
   RAKnUwm5cWiBhsu023w82pUauK8V3pyuOATYTUvf9kYU0qWFhPnLMAB4H
   qkxTZiiOPIpYK2pN0/ILFPCZyTV/YJ1KfdRG/efEm9kKgJZIP25SR/PjI
   zukVB08wilucOaTq8JrOJZIPtbsk/KoL8AupTmnBJQHrn1rvUQoy+OFuG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="269577251"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="269577251"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 00:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="555128297"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2022 00:10:43 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqUsM-0002EF-4u;
        Mon, 16 May 2022 07:10:42 +0000
Date:   Mon, 16 May 2022 15:09:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nsaenz-rpi:ct-work-defer-wip 22/25]
 kernel/context_tracking.c:719:47: error: 'struct context_tracking' has no
 member named 'active'
Message-ID: <202205161511.pldvqjB0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git ct-work-defer-wip
head:   ed63029652239a6befad96dd473b16332913f889
commit: 54d59ad9b9db31d840346a4196c3b83b5410a1bf [22/25] context-tracking: Introduce work deferral infrastructure
config: microblaze-randconfig-r036-20220512 (https://download.01.org/0day-ci/archive/20220516/202205161511.pldvqjB0-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git/commit/?id=54d59ad9b9db31d840346a4196c3b83b5410a1bf
        git remote add nsaenz-rpi https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git
        git fetch --no-tags nsaenz-rpi ct-work-defer-wip
        git checkout 54d59ad9b9db31d840346a4196c3b83b5410a1bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/context_tracking.c: In function 'context_tracking_set_cpu_work':
>> kernel/context_tracking.c:719:47: error: 'struct context_tracking' has no member named 'active'
     719 |         if (!context_tracking_enabled() || !ct->active)
         |                                               ^~


vim +719 kernel/context_tracking.c

   709	
   710	bool context_tracking_set_cpu_work(unsigned int cpu, unsigned int context,
   711					   unsigned int work)
   712	{
   713		struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
   714		unsigned int state;
   715	
   716		if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_WORK))
   717			return false;
   718	
 > 719		if (!context_tracking_enabled() || !ct->active)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
