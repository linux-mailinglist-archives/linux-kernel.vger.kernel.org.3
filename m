Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAB4DB3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbiCPPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiCPPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:05:06 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E343E0F7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647443032; x=1678979032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=72ryhfEZk3onftW2RR713oe1Qef1DtYB9K7FvQu9Wzc=;
  b=fiHmiWivQGN78596AauwvRLS79jjA19fJ1iSNET7ovv6OOk0R4ULO8KM
   BzzjnRe+g70xg08EVNaVMbBQ+1UVoBatcUMbGR2eNosB+e8aO8WdDIe/d
   aRW/5KEItyQ3QW5E2lo0xMDP3QNPpYBJWVSQA5/KK78gsGsywVSEmry15
   tGtYnuI57FzmoRzekIhuzgt8znkw8gMbY2MaK41cEsACJFTqr4JLv0o81
   n2dO0NlEizY8/tX3cTM5ZJ8AH6hKv1LdhBbjFUZShNv3iMPOU6dp10pnD
   1DFtC+6O2UrjQy5i4SFe4Vq3fO9Wc/urWXlb/z1tI4h3J4383hnUqFJTo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317344196"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="317344196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="598746218"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2022 08:01:05 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUV96-000CWm-Sn; Wed, 16 Mar 2022 15:01:04 +0000
Date:   Wed, 16 Mar 2022 23:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Becle Lee <becle.lee@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Aric Cyr <Aric.Cyr@amd.com>
Subject: [agd5f:drm-next 48/65]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hubp.c:1319:6: warning:
 no previous prototype for 'hubp1_wait_pipe_read_start'
Message-ID: <202203162243.lsr37uYW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   426c89aa203bcec9d9cf6eea36735eafa1b1f099
commit: dd15640bcee5a5fa74fc52557dd6220f48b01116 [48/65] drm/amd/display: Wait for hubp read line for Pollock
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203162243.lsr37uYW-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout dd15640bcee5a5fa74fc52557dd6220f48b01116
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

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

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
