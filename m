Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F44F1F53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbiDDWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiDDWtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:49:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A55EBCE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649109758; x=1680645758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f3aUY8VWtCtPPO75paDxdZ+k3UL8z8cSAIdhYWxANt8=;
  b=YkLUY05s+l94XKVLaczRDZdFdkHn/Zhujo4EJ9RejEWgxILfq1w3/23V
   eHtF4hAOpiWEF99zWLprvEIl0pGr24kAEL156Q6dY0cnq95Ktqvx2T1Rk
   cYs9if9CdhVLODvK7YJR55PCkJc5iabKmYOJRX8xPNLj8ri69KTrww0Rn
   +zy08SnHsjVEwfeJ0X2DEloVz3i1EklN6XRSL/rzAzL6j8uMY3Sv40rl8
   OSExdVgTWSatcSBhUU1KwFMghoPuNq8Ubi1MCZIxBQ2BVIBU9SwQnIu1P
   g0zE+uuCshP/jHrsbm4mfiSkgNvaaDAffCP8RNMQjWbZ0k/vGGm3zNYv8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258201714"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="258201714"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 15:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="721809578"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 15:02:35 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbUmR-0002OQ-5x;
        Mon, 04 Apr 2022 22:02:35 +0000
Date:   Tue, 5 Apr 2022 06:02:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Becle Lee <becle.lee@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Aric Cyr <Aric.Cyr@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:1319:6:
 warning: no previous prototype for function 'hubp1_wait_pipe_read_start'
Message-ID: <202204050538.gofpqsjw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: dd15640bcee5a5fa74fc52557dd6220f48b01116 drm/amd/display: Wait for hubp read line for Pollock
date:   3 weeks ago
config: x86_64-buildonly-randconfig-r004-20220404 (https://download.01.org/0day-ci/archive/20220405/202204050538.gofpqsjw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd15640bcee5a5fa74fc52557dd6220f48b01116
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd15640bcee5a5fa74fc52557dd6220f48b01116
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:1319:6: warning: no previous prototype for function 'hubp1_wait_pipe_read_start' [-Wmissing-prototypes]
   void hubp1_wait_pipe_read_start(struct hubp *hubp)
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:1319:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hubp1_wait_pipe_read_start(struct hubp *hubp)
   ^
   static 
   1 warning generated.


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
