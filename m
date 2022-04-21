Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EBA509866
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385291AbiDUGtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385169AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0651E15717;
        Wed, 20 Apr 2022 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523433; x=1682059433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ljGAKqIpbRmSST7I3qc4W5awgSwI6u3NtnyPHd/EEUU=;
  b=InV7vHW4hAi52LP4mww6AYjk0vlJihzhaStf13c8bJbbzMrwey/etrFL
   /Pl5gvlgWAEzxR+S+OJEhnCyl2c/WPZ9tqaphi8/gz74mFEHCkMOGgb9Q
   Gizl+zR/McImHqoPzDVo6YHOZMeyG4BPkhNWa/zKtGyVuGyc8eyhy//Gw
   gKZzQz7nchbJC1wnZ887EMjeYUWeCfGLIn0JXVjGI6iLWm1FgeGsTHYQC
   55+w4WNXz2lMd8AzzBlHqwYxJZqAyGh1qQOkx5x8zRCupWz9xGAQCbZX9
   MLYgy2MNvrVwFvt3K93W23OLgG5CbwTj0KHqy0keLgEqvcj9RVeMBHpdE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264429361"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264429361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="865403325"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXf-00081A-8P;
        Thu, 21 Apr 2022 06:43:51 +0000
Date:   Thu, 21 Apr 2022 14:43:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Chen <po-tchen@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, linux-doc@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:231:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202204210704.BOBjQ2pT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: e5dfcd272722fe3948837e7f1ca7aafb471037b1 drm/amd/display: dc_link_set_psr_allow_active refactoring
date:   6 months ago
config: s390-randconfig-c005-20220420 (https://download.01.org/0day-ci/archive/20220421/202204210704.BOBjQ2pT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5dfcd272722fe3948837e7f1ca7aafb471037b1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5dfcd272722fe3948837e7f1ca7aafb471037b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/display/dc/ drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:231: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set PSR power optimization flags.


vim +231 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c

   229	
   230	/**
 > 231	 * Set PSR power optimization flags.
   232	 */
   233	static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt)
   234	{
   235		union dmub_rb_cmd cmd;
   236		struct dc_context *dc = dmub->ctx;
   237	
   238		memset(&cmd, 0, sizeof(cmd));
   239		cmd.psr_set_power_opt.header.type = DMUB_CMD__PSR;
   240		cmd.psr_set_power_opt.header.sub_type = DMUB_CMD__SET_PSR_POWER_OPT;
   241		cmd.psr_set_power_opt.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_power_opt_data);
   242		cmd.psr_set_power_opt.psr_set_power_opt_data.power_opt = power_opt;
   243	
   244		dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
   245		dc_dmub_srv_cmd_execute(dc->dmub_srv);
   246		dc_dmub_srv_wait_idle(dc->dmub_srv);
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
