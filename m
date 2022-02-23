Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC84C0D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiBWHYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiBWHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:24:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023E6F484
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645601062; x=1677137062;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RIwYUnhJVWEZbje5WJoxA7WqiILid6HTMdMOVSXHzag=;
  b=nvFzV4GwDJBBl3mUX92Pa5fVVeRA7ji3zlc0Ufi1l77e0zgwf2z0EvT+
   XDIWWn2xaOvuo9PX6dSUNmQ43qhtsoqm2yewtjfSZmMt6ErsxJMDoicYM
   JgMPkegLpcu6BrpH/+6/6JRAJAQqP3ymlW7Xyq+79i7VgkuuBQ+90h3Vb
   O6n6mEnOu3b8YfWfMRosR2VpCOj+c6Ir/V10erdrUoh8uSQV9dWX13XQY
   5o/0+y9+63rzPHBYjeoCaPr3VDeyrEHvQhrXH5orwok4draMgi8aKl1cz
   41VcZzsQxfkpYtjao2eKRq/RS20tk66MSls8zHQuf44ZhZSpG6PyOZL3x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231876207"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="231876207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 23:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="706927577"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Feb 2022 23:24:19 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMm0Z-00017u-3j; Wed, 23 Feb 2022 07:24:19 +0000
Date:   Wed, 23 Feb 2022 15:23:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Imre Deak <imre.deak@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:next/linux-next/master 97/182]
 drivers/gpu/drm/dp/drm_dp.c:210:4: warning: no previous prototype for
 'drm_dp_get_adjust_request_post_cursor'
Message-ID: <202202231535.7QHMYyoH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   196d330d7fb1e7cc0d85641c89ce4602cb36f12e
commit: b885fbed0eb9d79d96a1f8145dc430e14fb33808 [97/182] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm-intel
config: i386-randconfig-s002-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231535.7QHMYyoH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/b885fbed0eb9d79d96a1f8145dc430e14fb33808
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout b885fbed0eb9d79d96a1f8145dc430e14fb33808
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/dp/drm_dp.c:210:4: warning: no previous prototype for 'drm_dp_get_adjust_request_post_cursor' [-Wmissing-prototypes]
     210 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_dp_get_adjust_request_post_cursor +210 drivers/gpu/drm/dp/drm_dp.c

0192c25c03cd2f drivers/gpu/drm/drm_dp_helper.c Jani Nikula    2022-02-03  209  
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21 @210  u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  211  					 unsigned int lane)
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  212  {
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  213  	unsigned int offset = DP_ADJUST_REQUEST_POST_CURSOR2;
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  214  	u8 value = dp_link_status(link_status, offset);
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  215  
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  216  	return (value >> (lane << 1)) & 0x3;
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  217  }
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  218  EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
79465e0ffeb9e4 drivers/gpu/drm/drm_dp_helper.c Thierry Reding 2019-10-21  219  

:::::: The code at line 210 was first introduced by commit
:::::: 79465e0ffeb9e4866939ea562bc55367be91e595 drm/dp: Add helper to get post-cursor adjustments

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
