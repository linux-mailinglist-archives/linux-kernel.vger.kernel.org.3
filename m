Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0357577688
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiGQOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiGQOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:01:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FDA15705
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658066511; x=1689602511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iyOzKAUhOadH0m9kdJ3so1jF1AEZfB9VPoKY5YUM1z4=;
  b=ZHyHqlOda/qlxtvt7/2UyO6ciE6oY5XuPFrSxoPY41W5ZffkcovTsJ09
   TkiPq0QUSC0OtFRs0vuAiWsUaowORhQV7gj6J1IPJEO3oSpFnJxiRcgXs
   19TCqlyFHHs9MK8TOxAsiaaxu2/bNvTv1z8T9XrnxQ8RQAkVwtaAlKzJi
   pRrv9EkinR9WBqrbnUSoow3MLxVFW/u+xcLsF2kOawJbPWlMwR27/NkwC
   NHZglp3PxzvCMAykM3rRy/B3185oRf1bH763+WHx4ZBA/Lgk0EFZzIq9a
   jQXrF6z7a3Qj0mLQfPe0rIRBvxfXHRoo2pdNpZF4njPlKRKNzdXUPQDEs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347752561"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="347752561"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 07:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="547187510"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2022 07:01:49 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD4qC-0003L8-Qz;
        Sun, 17 Jul 2022 14:01:48 +0000
Date:   Sun, 17 Jul 2022 22:00:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:for-next 56/92]
 drivers/platform/surface/surface_aggregator_tabletsw.c:425:9: sparse:
 sparse: restricted __le32 degrades to integer
Message-ID: <202207172113.nx0S1Njc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git for-next
head:   5c8b3f11565e64366d53295e8004edaa1fcf1ec9
commit: 9f794056db5bb1e1add83ed553b6aec57298358c [56/92] platform/surface: Add KIP/POS tablet-mode switch driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220717/202207172113.nx0S1Njc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=9f794056db5bb1e1add83ed553b6aec57298358c
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 for-next
        git checkout 9f794056db5bb1e1add83ed553b6aec57298358c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/lkdtm/ drivers/platform/surface/ drivers/platform/x86/intel/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/surface/surface_aggregator_tabletsw.c:425:9: sparse: sparse: restricted __le32 degrades to integer

vim +425 drivers/platform/surface/surface_aggregator_tabletsw.c

   403	
   404	static int ssam_pos_get_source(struct ssam_tablet_sw *sw, u32 *source_id)
   405	{
   406		struct ssam_sources_list sources = {};
   407		int status;
   408	
   409		status = ssam_pos_get_sources_list(sw, &sources);
   410		if (status)
   411			return status;
   412	
   413		if (sources.count == 0) {
   414			dev_err(&sw->sdev->dev, "no posture sources found\n");
   415			return -ENODEV;
   416		}
   417	
   418		/*
   419		 * We currently don't know what to do with more than one posture
   420		 * source. At the moment, only one source seems to be used/provided.
   421		 * The WARN_ON() here should hopefully let us know quickly once there
   422		 * is a device that provides multiple sources, at which point we can
   423		 * then try to figure out how to handle them.
   424		 */
 > 425		WARN_ON(sources.count > 1);
   426	
   427		*source_id = get_unaligned_le32(&sources.id[0]);
   428		return 0;
   429	}
   430	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
