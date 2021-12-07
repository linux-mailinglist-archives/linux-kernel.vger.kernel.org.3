Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154BD46B881
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhLGKOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:14:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:54520 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbhLGKOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:14:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323801301"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="323801301"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="515214580"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2021 02:10:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muXQx-000MR3-Hk; Tue, 07 Dec 2021 10:10:51 +0000
Date:   Tue, 7 Dec 2021 18:10:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Chris Park <Chris.Park@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c:30:6:
 warning: no previous prototype for 'dcn303_hw_sequencer_construct'
Message-ID: <202112071852.mQxmAP3G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurabindo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
commit: cd6d421e3d1ad5926b74091254e345db730e7706 drm/amd/display: Initial DC support for Beige Goby
date:   7 months ago
config: i386-buildonly-randconfig-r002-20211205 (https://download.01.org/0day-ci/archive/20211207/202112071852.mQxmAP3G-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd6d421e3d1ad5926b74091254e345db730e7706
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cd6d421e3d1ad5926b74091254e345db730e7706
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c:30:6: warning: no previous prototype for 'dcn303_hw_sequencer_construct' [-Wmissing-prototypes]
      30 | void dcn303_hw_sequencer_construct(struct dc *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dcn303_hw_sequencer_construct +30 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c

    29	
  > 30	void dcn303_hw_sequencer_construct(struct dc *dc)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
