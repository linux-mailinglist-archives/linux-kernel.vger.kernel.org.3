Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583BF56A118
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiGGLer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiGGLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:34:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C62F65E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657193682; x=1688729682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JKbCMUeQVy78kPkl4YfJ97Wr4SpG3UV/hAMkI54+8SI=;
  b=M8DeFWWhzyRmNQnZTVOuiDRdbbaAKsIWpU6P2o7EPVHpY9DwOLU+KJ50
   cMtzxz9J35zjlxP1XlSw2ryld2c4yCtrV3OqQf/+rzu3DQ/Emd9qm32vz
   NtMHnJzEVBHhQv9JZcuYCvg/yBBqds8siHI+avn7BFuT9zDQ4INgNgSjt
   GXctD8PVFcmIUmd2bymRWByh3KPC79FGYosZm4JtKWNw023sL+AXE1pt1
   QQzQu5DYEbI6/G80i6q5bPZjxmiVtTcDLYxagO2TFCiL0Ph/hbeGg+hRD
   NtAVcfAwePjRGIcNeyIKqZ7t1ClqIx1uqHURgmv2cuGjdxdhXeraMSFXl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370318217"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="370318217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 04:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="735938846"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2022 04:34:40 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9PmK-000Lw7-0h;
        Thu, 07 Jul 2022 11:34:40 +0000
Date:   Thu, 7 Jul 2022 19:34:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbingham-rcar:kbingham/vsp1/debugfs 6/7]
 drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:52:15: error: return type
 defaults to 'int'
Message-ID: <202207071954.8vAac5gl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git kbingham/vsp1/debugfs
head:   73e1dae0c0afd4ccbe318e1bc9881b3e800226ba
commit: eda5de49ca65531ae1fa75f31300cdaacb112125 [6/7] v4l: vsp1: Provide video node debugfs entries
config: m68k-randconfig-r021-20220707 (https://download.01.org/0day-ci/archive/20220707/202207071954.8vAac5gl-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?id=eda5de49ca65531ae1fa75f31300cdaacb112125
        git remote add kbingham-rcar https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
        git fetch --no-tags kbingham-rcar kbingham/vsp1/debugfs
        git checkout eda5de49ca65531ae1fa75f31300cdaacb112125
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/media/platform/renesas/vsp1/vsp1_drv.c:27:
>> drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:52:15: error: return type defaults to 'int' [-Werror=implicit-int]
      52 | static inline vsp1_debugfs_create_video_stats(struct vsp1_video *video,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:54:15: error: return type defaults to 'int' [-Werror=implicit-int]
      54 | static inline vsp1_debugfs_cleanup_video_stats(struct vsp1_video *video) { };
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/media/platform/renesas/vsp1/vsp1_video.c:28:
>> drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:52:15: error: return type defaults to 'int' [-Werror=implicit-int]
      52 | static inline vsp1_debugfs_create_video_stats(struct vsp1_video *video,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:54:15: error: return type defaults to 'int' [-Werror=implicit-int]
      54 | static inline vsp1_debugfs_cleanup_video_stats(struct vsp1_video *video) { };
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/renesas/vsp1/vsp1_debugfs.h: In function 'vsp1_debugfs_create_video_stats':
   drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:53:37: error: control reaches end of non-void function [-Werror=return-type]
      53 |                 const char *name) { };
         |                                     ^
   drivers/media/platform/renesas/vsp1/vsp1_debugfs.h: In function 'vsp1_debugfs_cleanup_video_stats':
   drivers/media/platform/renesas/vsp1/vsp1_debugfs.h:54:76: error: control reaches end of non-void function [-Werror=return-type]
      54 | static inline vsp1_debugfs_cleanup_video_stats(struct vsp1_video *video) { };
         |                                                                            ^
   cc1: some warnings being treated as errors


vim +/int +52 drivers/media/platform/renesas/vsp1/vsp1_debugfs.h

    51	
  > 52	static inline vsp1_debugfs_create_video_stats(struct vsp1_video *video,
    53			const char *name) { };
    54	static inline vsp1_debugfs_cleanup_video_stats(struct vsp1_video *video) { };
    55	#endif /* CONFIG_DEBUG_FS */
    56	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
