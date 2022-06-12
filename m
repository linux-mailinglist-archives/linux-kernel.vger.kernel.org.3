Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3906E547A11
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiFLMTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiFLMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:19:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE428E3D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655036349; x=1686572349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NxdNaA6iePKqw1Tm06Mu8JSX5fw8crmcTXhuJcCdJoQ=;
  b=IaWdt1Gy9kJoRrUeiOoyMqoD0V0eTkM1h32s7vdwyjioJT24VIbkkJpO
   q8BdNxuYnP5Ld0wqDlfjjX0IPqSTQbl6Gv7naUHC0wDHv6LKffoOgISui
   n6e31Dnm7qYadBV70XUDE0AK0JCyjh+GD47z2Z5DK+F1Ha15tWqdsBISV
   UbHRNZbl2B+dvV/HlSm7+24qfp0tpY04Zni3gO256vFcduREaE+4aGnOn
   FK+aRGMgZ3K2MvKcOzGihDZidFOUzBexHpkzbrNIL3ZwEf57DDxR+sZ4A
   QJYklm65G6aQ4+R40Pmzrblq88MaXCSxcS6cn7b2ysxSGo39H8YLrfFx8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258475576"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="258475576"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 05:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="534728940"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2022 05:19:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0MYc-000Ju7-CN;
        Sun, 12 Jun 2022 12:19:06 +0000
Date:   Sun, 12 Jun 2022 20:18:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [drm-misc:for-linux-next 1/10] include/drm/drm_of.h:123:8: error:
 expected ')'
Message-ID: <202206122036.5x6mBsak-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   d643daaf1694b7565fbe3982b630e1c7b95f1600
commit: fc801750b197d0f00c09e01e59a7dcd240fddcb5 [1/10] drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
config: hexagon-randconfig-r041-20220612 (https://download.01.org/0day-ci/archive/20220612/202206122036.5x6mBsak-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout fc801750b197d0f00c09e01e59a7dcd240fddcb5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_bridge.c:31:
>> include/drm/drm_of.h:115:5: warning: no previous prototype for function 'drm_of_get_data_lanes_count' [-Wmissing-prototypes]
   int drm_of_get_data_lanes_count(const struct device_node *endpoint,
       ^
   include/drm/drm_of.h:115:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int drm_of_get_data_lanes_count(const struct device_node *endpoint,
   ^
   static 
>> include/drm/drm_of.h:123:8: error: expected ')'
                                      const unsigned int min,
                                      ^
   include/drm/drm_of.h:121:35: note: to match this '('
   int drm_of_get_data_lanes_count_ep(const struct device_node *port,
                                     ^
>> include/drm/drm_of.h:121:5: warning: no previous prototype for function 'drm_of_get_data_lanes_count_ep' [-Wmissing-prototypes]
   int drm_of_get_data_lanes_count_ep(const struct device_node *port,
       ^
   include/drm/drm_of.h:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int drm_of_get_data_lanes_count_ep(const struct device_node *port,
   ^
   static 
   2 warnings and 1 error generated.


vim +123 include/drm/drm_of.h

   114	
 > 115	int drm_of_get_data_lanes_count(const struct device_node *endpoint,
   116					const unsigned int min, const unsigned int max)
   117	{
   118		return -EINVAL;
   119	}
   120	
 > 121	int drm_of_get_data_lanes_count_ep(const struct device_node *port,
   122					   int port_reg, int reg
 > 123					   const unsigned int min,
   124					   const unsigned int max)
   125	{
   126		return -EINVAL;
   127	}
   128	#endif
   129	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
