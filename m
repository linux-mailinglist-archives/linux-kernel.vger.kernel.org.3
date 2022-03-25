Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7174E7B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiCYVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiCYVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:15:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839FDD1CE7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648242812; x=1679778812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lovmrUvGggLJq+YRgpk98cb7621p8kSPHVa9Cne3B6E=;
  b=XCMA4OAjODMUsKs/Sy8PxxBQ4DEvFKt6a/jVAcoyR1GmiGnR3lPP1SNl
   XCOlUFQ5E7psFqFCLgstNQ5Xx587ptLH5RZhdwKwEA7qzi/OaEjoDHFoW
   8xugSJ6Mclkhkj2BiqrLcoN/9LBKJ5VBv/sZgn86D73IxbS59VGOts/h1
   yKGErc4oMxWIxU5+K3IMyeoWnwKrWnPbG3apQDEOCIFgMkXVWN0rM0Axj
   ZqMT5Eh6qWECC2AvweSTwwpQoVWy4vZaQO69BpOaft/UZIyV2EdU5/2X7
   QksST/9yrkbN6zKDVpRhfkz5icw+2XfD8xEPPAGse+Jt1kHSKGR6bu/9/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="238656077"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="238656077"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 14:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="545229140"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2022 14:13:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXrFP-000Mby-V4; Fri, 25 Mar 2022 21:13:27 +0000
Date:   Sat, 26 Mar 2022 05:12:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Becle Lee <becle.lee@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Aric Cyr <Aric.Cyr@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:1319:6:
 warning: no previous prototype for 'hubp1_wait_pipe_read_start'
Message-ID: <202203260538.PgS6ucUM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Becle,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aa5b537b0ecc16992577b013f11112d54c7ce869
commit: dd15640bcee5a5fa74fc52557dd6220f48b01116 drm/amd/display: Wait for hubp read line for Pollock
date:   10 days ago
config: powerpc64-randconfig-r015-20220325 (https://download.01.org/0day-ci/archive/20220326/202203260538.PgS6ucUM-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd15640bcee5a5fa74fc52557dd6220f48b01116
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd15640bcee5a5fa74fc52557dd6220f48b01116
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:1319:6: warning: no previous prototype for 'hubp1_wait_pipe_read_start' [-Wmissing-prototypes]
    1319 | void hubp1_wait_pipe_read_start(struct hubp *hubp)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hubp1_wait_pipe_read_start +1319 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c

  1313	
  1314	/**
  1315	 * hubp1_wait_pipe_read_start - wait for hubp ret path starting read.
  1316	 *
  1317	 * @hubp: hubp struct reference.
  1318	 */
> 1319	void hubp1_wait_pipe_read_start(struct hubp *hubp)
  1320	{
  1321		struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
  1322	
  1323		REG_WAIT(HUBPRET_READ_LINE_STATUS,
  1324			PIPE_READ_VBLANK, 0,
  1325			 1, 1000);
  1326	}
  1327	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
