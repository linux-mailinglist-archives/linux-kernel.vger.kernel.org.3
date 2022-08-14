Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47C5925AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiHNQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiHNQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:58:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50120FD2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660495987; x=1692031987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nvRBaRe8qT12XWZKpkgqF+rZc01mFH5iUSCDVfwRCwY=;
  b=e8FMqCAFyM5uul6wfPGx0FlhP1FNKJX2w9wcE7s45VJBxjiEhmn0zY82
   tFXvLKUQCVl1+mtKC5H7tMN2ZDoH1NSdnZIwpqfsfhXC7H//Kko5O4nGk
   CD4WjC0VRK/ilbdmLoGuzvLrSxq1unHeUb5hoENk3tL7P1V6m++S45LiQ
   lQ4NSlw/t1ETV8262C1S7eeCnvNMn+oOaEDRw+T2gDtyxr1kqnAgvhPkY
   Iqw55Ig9S0MPCjo338zSt7B+WyBAj+gBzkjnd2ARs0qxS/ASu9yKLdbSM
   W8U9md6FZ6GVM4Bh7juTcIs/IpTlYe6PVtWzph7Ghbzkh2okDDiKhKsY4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317818075"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="317818075"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 09:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="582626941"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 09:53:05 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNGrI-0000KX-30;
        Sun, 14 Aug 2022 16:53:04 +0000
Date:   Mon, 15 Aug 2022 00:52:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/host1x/fence.c:102:28: sparse: sparse: symbol
 'host1x_syncpt_fence_ops' was not declared. Should it be static?
Message-ID: <202208150053.eWHhHZa0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 687db2207b1bc94ca34743871167923a6de78d85 gpu: host1x: Add DMA fence implementation
date:   1 year ago
config: arm-randconfig-s033-20220728 (https://download.01.org/0day-ci/archive/20220815/202208150053.eWHhHZa0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=687db2207b1bc94ca34743871167923a6de78d85
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 687db2207b1bc94ca34743871167923a6de78d85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/host1x/ lib/xz/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/host1x/fence.c:102:28: sparse: sparse: symbol 'host1x_syncpt_fence_ops' was not declared. Should it be static?

vim +/host1x_syncpt_fence_ops +102 drivers/gpu/host1x/fence.c

   101	
 > 102	const struct dma_fence_ops host1x_syncpt_fence_ops = {
   103		.get_driver_name = host1x_syncpt_fence_get_driver_name,
   104		.get_timeline_name = host1x_syncpt_fence_get_timeline_name,
   105		.enable_signaling = host1x_syncpt_fence_enable_signaling,
   106		.release = host1x_syncpt_fence_release,
   107	};
   108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
