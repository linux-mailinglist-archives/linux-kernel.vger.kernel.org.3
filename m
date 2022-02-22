Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5386C4C0289
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiBVT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiBVT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:57:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B48D6E282
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559814; x=1677095814;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=82yB985+AKBkWSUrHonoGkU/PPQIGUpBLW/3jx5KV+M=;
  b=fR9QdO5V84brn6H7bqMmMekNg+pF8w4ClbADyzUzlJGVMGSr27jm8nER
   nGWo04NkeAFVpky/HYYtT6WhFhKldW8D2fBvLD92WaKlACbjlj6DO2JCq
   rq0o3XW8p5V5Q8KSc5V3lvonuglGnYmLw3HAkdyt7Lz8Eijk+sCreblCI
   9fEjh6+UTPjchnbDcRl/j7D/ksjtBbnaqtF5YEkIix4fuDddHfuw/72kC
   kVsptAJOnphGsdFFQwEOa5QyReRsS9rRJazf7rit4UVYrtrgkx/OKlGpr
   X3luoKlecjaQqoMVALssSwFOybhnL6eZpJyG8fxZ01pvT0jPWf/0PRRzk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231772980"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231772980"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="543066586"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2022 11:56:53 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMbHI-0000Z6-FE; Tue, 22 Feb 2022 19:56:52 +0000
Date:   Wed, 23 Feb 2022 03:56:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [nbd168-wireless:mtk-flow-offload 5/14] ERROR: Input tree has
 errors, aborting (use -f to force output)
Message-ID: <202202230356.HxgGrXil-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mtk-flow-offload
head:   c5c9c022de79aa26f88a358954a868d8bbc2af11
commit: ad070cb96f71f13aa6fde0e13fba0a87c1cc91bf [5/14] arm64: dts: mediatek: mt7622: introduce nodes for Wireless Ethernet Dispatch
config: arm64-buildonly-randconfig-r001-20220221 (https://download.01.org/0day-ci/archive/20220223/202202230356.HxgGrXil-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/ad070cb96f71f13aa6fde0e13fba0a87c1cc91bf
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mtk-flow-offload
        git checkout ad070cb96f71f13aa6fde0e13fba0a87c1cc91bf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   also defined at arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts:103.6-174.3
>> ERROR: Input tree has errors, aborting (use -f to force output)
--
   also defined at arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts:117.6-197.3
>> ERROR: Input tree has errors, aborting (use -f to force output)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
