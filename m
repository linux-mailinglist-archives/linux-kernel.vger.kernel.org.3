Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F1598E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbiHRUxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHRUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:53:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3F2660
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660855992; x=1692391992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YrNYd89I75ogQoqgUkQzdp/5jWBsIPZROGWBLOJO+aE=;
  b=nvH1EX5ICuROjeGEt9L8J4wMDt+SXwewFO1GA4W1SfOolefAOFXd0gxo
   3tmyClLsU/86yR+1IJ7ejk4MtFHGHHO540S2HIep4e72ZsLfitCfRxR3O
   cum4hpIEio0uxgA0QgKcXRmm/oCI6I1bDdmNFfMWpTCNTETIr0ArtPh9q
   BWOY1+LazboMidlI9vA8CaTP9N262Q0iBAbKZTnT22j9HNFJfuMWbz2V5
   LqeUmA1fEjcm2CHMGDuED3oehv/yltw4eK292yf6APDNxZVJhqRFoNB+Z
   4eDpYDo8rpNiOg3rQkGLnSsypVYyOYPp9zTwPfHHkXibYCl2tg7u91HME
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="318891251"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="318891251"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 13:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="750263050"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Aug 2022 13:53:10 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOmVp-0000b9-2c;
        Thu, 18 Aug 2022 20:53:09 +0000
Date:   Fri, 19 Aug 2022 04:52:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>
Subject: [hverkuil-media-tree:for-v6.1c 3/3] kismet: WARNING: unmet direct
 dependencies detected for VIDEO_MEDIATEK_VPU when selected by
 VIDEO_MEDIATEK_MDP3
Message-ID: <202208190456.D8LrBfIE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v6.1c
head:   b2273b84e1291c52279edf13b08744833c1faaab
commit: b2273b84e1291c52279edf13b08744833c1faaab [3/3] media: platform: mtk-mdp3: add MediaTek MDP3 driver
config: x86_64-kismet-CONFIG_VIDEO_MEDIATEK_VPU-CONFIG_VIDEO_MEDIATEK_MDP3-0-0 (https://download.01.org/0day-ci/archive/20220819/202208190456.D8LrBfIE-lkp@intel.com/config)
reproduce:
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v6.1c
        git checkout b2273b84e1291c52279edf13b08744833c1faaab
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_VIDEO_MEDIATEK_VPU --selectors CONFIG_VIDEO_MEDIATEK_MDP3 -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU when selected by VIDEO_MEDIATEK_MDP3
   
   WARNING: unmet direct dependencies detected for MTK_SCP
     Depends on [n]: REMOTEPROC [=n] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
     Selected by [y]:
     - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && (MTK_IOMMU [=n] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && MTK_MMSYS [=y] && HAS_DMA [=y]
   
   WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
     Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] && VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y])
     Selected by [y]:
     - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && (MTK_IOMMU [=n] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && MTK_MMSYS [=y] && HAS_DMA [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
