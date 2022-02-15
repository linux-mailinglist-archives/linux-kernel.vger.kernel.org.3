Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6104B6A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiBOLYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiBOLX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:23:58 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFDE10819F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644924228; x=1676460228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iZgAE0TK8uW8bFjvBAKwl1c+nKhdG4FK+XOowi1kxz4=;
  b=lsZSugvzD9+TqMzN9u8++Azfxj2wM+ULD4M7t8GDvmzXTGL4ecySlO04
   5p/dl5c8DvpvPkXYbDBOjeXNFe9qqGSS62k6/hrY2+lgll7H3EmXC4Ihn
   5MYwNFiMUyXI7jjGgXXnd5rQhjEfkohMQU6OnXjuPwx4fLkIVYo/CL1Eq
   ZsK1aHcqf80ciZk8zHlOZxAhQmmj0T4hRJCPsZ0rOCvap2IftgCp18acL
   wSa5mX0NvD7jeH2sF69SWNjt+bkp+Dwhew/NssytKraGpCx38CWkcexTt
   CliY6n6CQVhJtpjir0LW0ZKrx11AL2dbghc2liDOl5g7ZAoL303Etmztj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="311067941"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="311067941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 03:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="603763767"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Feb 2022 03:23:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJvvu-0009av-1F; Tue, 15 Feb 2022 11:23:46 +0000
Date:   Tue, 15 Feb 2022 19:23:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 25/34]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:991:3: error: implicit
 declaration of function 'DC_FP_START'
Message-ID: <202202151850.04BAOxth-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   076172cdc7ab4983ed7596a53b95851849269e5a
commit: af45a5fe4f0af159db23e8bf851115b61031c648 [25/34] drm/amd/display: Protect update_bw_bounding_box FPU code.
config: riscv-randconfig-r033-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151850.04BAOxth-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout af45a5fe4f0af159db23e8bf851115b61031c648
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:64:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
                   uint64_t temp;
                            ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:991:3: error: implicit declaration of function 'DC_FP_START' [-Werror,-Wimplicit-function-declaration]
                   DC_FP_START();
                   ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:993:3: error: implicit declaration of function 'DC_FP_END' [-Werror,-Wimplicit-function-declaration]
                   DC_FP_END();
                   ^
   1 warning and 2 errors generated.


vim +/DC_FP_START +991 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c

   989	
   990		if (dc->res_pool->funcs->update_bw_bounding_box) {
 > 991			DC_FP_START();
   992			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 > 993			DC_FP_END();
   994		}
   995	
   996		/* Creation of current_state must occur after dc->dml
   997		 * is initialized in dc_create_resource_pool because
   998		 * on creation it copies the contents of dc->dml
   999		 */
  1000	
  1001		dc->current_state = dc_create_state(dc);
  1002	
  1003		if (!dc->current_state) {
  1004			dm_error("%s: failed to create validate ctx\n", __func__);
  1005			goto fail;
  1006		}
  1007	
  1008		if (!create_links(dc, init_params->num_virtual_links))
  1009			goto fail;
  1010	
  1011		/* Create additional DIG link encoder objects if fewer than the platform
  1012		 * supports were created during link construction.
  1013		 */
  1014		if (!create_link_encoders(dc))
  1015			goto fail;
  1016	
  1017		dc_resource_state_construct(dc, dc->current_state);
  1018	
  1019		return true;
  1020	
  1021	fail:
  1022		return false;
  1023	}
  1024	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
