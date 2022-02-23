Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72AB4C0B36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiBWEkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiBWEko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:40:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251D060DBA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645591218; x=1677127218;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L+2Qr8V6KUyJCrvg3kEW5Q15nQ2Fw9Yx3P2tGHF4ZQ0=;
  b=FIUrd4+nvg6DObrVczpKv2k/f2NiVGjXC9nfPVCyvqLW4OLSEVzOUoRr
   F0ilQmgedn99zPJV3sVfCrWU4jGUOebsLQpv9D1x35bPfDfI7cY7TSgS5
   4RV0QzQC/n/662O3vC9/znWT1yHZ78fqAtg+bcXglek8p+lE8GanBoigA
   kEtjH2esuehPAfnjFeuKGdclYSVwcq3wKPNfp4km4W4qxMHtrtcTMRkcT
   Vq2XrMQtYzNhQqi33fe9CWuT/FpEMdCWmyDixHgAR7kxmC8kyqPWB5o/0
   tkJ50e2v3LdGJ/7dhT8V+v2P6u5caRkxZKlaw5w3XxEJOcH8Yi1kEgUm+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315111369"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="315111369"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 20:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="508278615"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 20:40:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMjRm-0000z4-VL; Wed, 23 Feb 2022 04:40:14 +0000
Date:   Wed, 23 Feb 2022 12:39:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Imre Deak <imre.deak@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:next/linux-next/master 97/182]
 drivers/gpu/drm/dp/drm_dp.c:210:4: warning: no previous prototype for
 function 'drm_dp_get_adjust_request_post_cursor'
Message-ID: <202202231250.VkvwGjL3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   196d330d7fb1e7cc0d85641c89ce4602cb36f12e
commit: b885fbed0eb9d79d96a1f8145dc430e14fb33808 [97/182] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm-intel
config: i386-randconfig-a011-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231250.VkvwGjL3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b885fbed0eb9d79d96a1f8145dc430e14fb33808
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout b885fbed0eb9d79d96a1f8145dc430e14fb33808
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/dp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/dp/drm_dp.c:210:4: warning: no previous prototype for function 'drm_dp_get_adjust_request_post_cursor' [-Wmissing-prototypes]
   u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
      ^
   drivers/gpu/drm/dp/drm_dp.c:210:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
   ^
   static 
   1 warning generated.


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
