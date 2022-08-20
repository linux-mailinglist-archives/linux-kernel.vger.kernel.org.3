Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1100F59B089
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiHTVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHTVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 17:09:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56B399C1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661029757; x=1692565757;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I4ZuB+H/pFT6QiWj50ar0KybQCw8UrZf3PMKBmATy5o=;
  b=Yj8JTF/bTWYu6cNcwssQQ6gXQkoFvnK3EdAP1cYBi6UxIxUwonHVXfj2
   mxArjDrnPnBto8B8Uspvfr9XH/GeMGVTAEpD3QwPua8Cqqp0j/ObHaX0M
   Z3sG3l75V5L6o7XRJ3Amc96IUDkEpy61kDNh8IzIhLEpnDdlxYvp6+uDC
   bOpci0KYCTozbSUagQC4xHeIWQwiGj/qX+OIzonpwbxV4OSlclnvraH+3
   ENNmVFXMwi9CW8aNuJdNgzYzmZxig5J2ZpnygOQ3T+Qs/ONgWpvRhLkPV
   l4AFhU0OuvAhlCarbSUrjhsYPSPJh+qlUuLUtPs9UfqpcaJRHypj6CcAT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="379496263"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="379496263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 14:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="676787383"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2022 14:09:15 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPViU-0003D7-1R;
        Sat, 20 Aug 2022 21:09:14 +0000
Date:   Sun, 21 Aug 2022 05:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>
Subject: [hverkuil-media-tree:for-v6.1c 3/3] ERROR: modpost: "rproc_boot"
 [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
Message-ID: <202208210559.yROHzZ83-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v6.1c
head:   b2273b84e1291c52279edf13b08744833c1faaab
commit: b2273b84e1291c52279edf13b08744833c1faaab [3/3] media: platform: mtk-mdp3: add MediaTek MDP3 driver
config: s390-randconfig-s052-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210559.yROHzZ83-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v6.1c
        git checkout b2273b84e1291c52279edf13b08744833c1faaab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rproc_boot" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_get_rproc" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_mapping_dm_addr" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_ipi_register" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_get_vdec_hw_capa" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_get" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_put" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_ipi_send" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "scp_get_venc_hw_capa" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-common.ko] undefined!
>> ERROR: modpost: "rproc_boot" [drivers/media/platform/mediatek/mdp3/mtk-mdp3.ko] undefined!
   WARNING: modpost: suppressed 6 unresolved symbol warnings because there were too many)

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MTK_SCP
   Depends on [n]: REMOTEPROC [=n] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
   Selected by [m]:
   - VIDEO_MEDIATEK_MDP3 [=m] && MEDIA_SUPPORT [=m] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && (MTK_IOMMU [=y] || COMPILE_TEST [=y]) && VIDEO_DEV [=m] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && MTK_MMSYS [=y] && HAS_DMA [=y]

sparse warnings: (new ones prefixed by >>)
>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:21:5: sparse: sparse: symbol 'mdp_comp_alias_id' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
