Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDAA58E159
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiHIUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHIUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:50:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F874D10A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660078203; x=1691614203;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uviM2rRFSTTGO3UMsZJM0M5Z7obIQkn2Dk5IpBiGCew=;
  b=DyyKp/Zwy4gs61KR/8GPqxOKdnX7caiPZCeMDASwy87RRaxa9/d4KWTY
   7lKqlL9f2KInFNKc9INnFxhc9uGd1jv17BNB/hrofa7PHWL3b8phx7X68
   TB6pzw9OGsCn6fJ8zVcl4iMxGPN9aRXoEgI7w3abTDa4LgqgGVCBk2GFE
   nkQzSqaRfvtRrQLi8AdK1aNfq/z12s7uYrgqJvkXHSMOzFbZpDn1AdaCm
   6/FaYqdiJZmJaXfvm7aIKTUh6BPBUjK4W0G1e8b8zH77B7MfUt76yMDUY
   MhJXPuYfUoa/Few5fj+Goaw59zD/ZpoZ7U/wowqHCACOYTiMRRodN8sRb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="290934075"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="290934075"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 13:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="601577143"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2022 13:50:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLWAq-000NHV-0b;
        Tue, 09 Aug 2022 20:50:00 +0000
Date:   Wed, 10 Aug 2022 04:49:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: drivers/soc/mediatek/mtk-svs.c:1287:34: warning: unused variable
 'svs_of_match'
Message-ID: <202208100401.D7X9SFYs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15205c2829ca2cbb5ece5ceaafe1171a8470e62b
commit: 681a02e9500073cd8b9c25a04f06166254b5a879 soc: mediatek: SVS: introduce MTK SVS engine
date:   8 weeks ago
config: hexagon-randconfig-r006-20220810 (https://download.01.org/0day-ci/archive/20220810/202208100401.D7X9SFYs-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=681a02e9500073cd8b9c25a04f06166254b5a879
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 681a02e9500073cd8b9c25a04f06166254b5a879
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/mediatek/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/mediatek/mtk-svs.c:853:12: warning: unused function 'svs_suspend' [-Wunused-function]
   static int svs_suspend(struct device *dev)
              ^
   drivers/soc/mediatek/mtk-svs.c:880:12: warning: unused function 'svs_resume' [-Wunused-function]
   static int svs_resume(struct device *dev)
              ^
>> drivers/soc/mediatek/mtk-svs.c:1287:34: warning: unused variable 'svs_of_match' [-Wunused-const-variable]
   static const struct of_device_id svs_of_match[] = {
                                    ^
   3 warnings generated.


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
