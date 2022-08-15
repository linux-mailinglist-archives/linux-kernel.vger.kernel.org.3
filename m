Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C015927D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiHOCec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiHOCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:34:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E713D4E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660530867; x=1692066867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9uZJso8ZoHC/eeAULx2p6mbgQbXca/lHp9jgPDpTsnM=;
  b=V+lRGos4B+6ojCnI29LMs0WqZrdrqXlBv3nf1XXI0kWFzS/yCYFq80jA
   fS3wJbsrg/hW45dQ7Z0HOZCGy6I8+yMgZ736QPxSd9NvMu7LV91I9cyrr
   wofy4bF+E3c5U6pDB+wF5XNWEjFa0h8key7xRlskeueG1WOAPoQWZVwze
   1h5tHy69isTkdf1i3S4XHs7bLtmkkEVJA3BW7HlyVd0BBUabEmoqnlulV
   6I9KjFiV3CN1zwNy4qZAcfsS+NmuyD9OUWmcnhG2WgJFoqPmzS6vBAIOx
   mIgUopjNhV7D5He0OZmcyIvpOlfvaWDvngcNe1MmS+tq5iAaOJpONpiV4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317856435"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="317856435"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="582724614"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 19:34:25 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNPvs-0000il-2P;
        Mon, 15 Aug 2022 02:34:24 +0000
Date:   Mon, 15 Aug 2022 10:33:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: drivers/soc/mediatek/mtk-svs.c:1287:34: warning: 'svs_of_match'
 defined but not used
Message-ID: <202208151010.OGn2ngmA-lkp@intel.com>
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
head:   568035b01cfb107af8d2e4bd2fb9aea22cf5b868
commit: 681a02e9500073cd8b9c25a04f06166254b5a879 soc: mediatek: SVS: introduce MTK SVS engine
date:   8 weeks ago
config: x86_64-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220815/202208151010.OGn2ngmA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=681a02e9500073cd8b9c25a04f06166254b5a879
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 681a02e9500073cd8b9c25a04f06166254b5a879
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/soc/mediatek/ drivers/usb/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/mediatek/mtk-svs.c:1287:34: warning: 'svs_of_match' defined but not used [-Wunused-const-variable=]
    1287 | static const struct of_device_id svs_of_match[] = {
         |                                  ^~~~~~~~~~~~
   drivers/soc/mediatek/mtk-svs.c:880:12: warning: 'svs_resume' defined but not used [-Wunused-function]
     880 | static int svs_resume(struct device *dev)
         |            ^~~~~~~~~~
   drivers/soc/mediatek/mtk-svs.c:853:12: warning: 'svs_suspend' defined but not used [-Wunused-function]
     853 | static int svs_suspend(struct device *dev)
         |            ^~~~~~~~~~~


vim +/svs_of_match +1287 drivers/soc/mediatek/mtk-svs.c

  1286	
> 1287	static const struct of_device_id svs_of_match[] = {
  1288		{
  1289			.compatible = "mediatek,mt8183-svs",
  1290			.data = &svs_mt8183_platform_data,
  1291		}, {
  1292			/* Sentinel */
  1293		},
  1294	};
  1295	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
