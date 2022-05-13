Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719A526CC2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384824AbiEMWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384812AbiEMWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:01:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9335A2DA;
        Fri, 13 May 2022 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652479278; x=1684015278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6W9kIUxVEytkIlePIUvHWEfOUUtB7d0gmWYOO/wGDro=;
  b=aP2t8BWuwkeAcPC7AcyyWSJRv87h0bYuTsPbdZ7klNzaL/th89pvjCc6
   2aGOUGVSHmjvoTQZ2QohpS+0QHQFTXGhy+8v0BysRYV1IgZ9OHuig3qP2
   ZF8S/lrQ0wo3Juxb6FMApSd8+7wiHuLd9Kga79tD7KM1BP7KuDXSuxD9m
   UC31ioGh++HqSmOJpyT1cUmgj2jnr0nl8+qubYcTz/G2FOop3jDGlEbtE
   EvYjahQGAlOLDhQ0vNJF3oJnrNB0d6YJhBXMB3ErxJxv2GQ5apdIudQrp
   o0cEDTxcDEAJqZ4tv4Kso9eLBb70fyd4QmQyclDq7gQCjBCXrBIjfGFLe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270355995"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270355995"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="625042653"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2022 15:01:10 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npdLS-000M9U-0W;
        Fri, 13 May 2022 22:01:10 +0000
Date:   Sat, 14 May 2022 06:00:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 5/5] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
Message-ID: <202205140535.hQjmJtwR-lkp@intel.com>
References: <20220513165050.500831-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513165050.500831-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on next-20220513]
[cannot apply to clk/clk-next pza/reset/next mbgg-mediatek/for-next v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/MediaTek-Helio-X10-MT6795-Clock-drivers/20220514-005314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-buildonly-randconfig-r004-20220512 (https://download.01.org/0day-ci/archive/20220514/202205140535.hQjmJtwR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/991f92f26cc545a1836a3120408ce27ba7ddadab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/MediaTek-Helio-X10-MT6795-Clock-drivers/20220514-005314
        git checkout 991f92f26cc545a1836a3120408ce27ba7ddadab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt6795-infracfg.c:14:10: fatal error: 'reset.h' file not found
   #include "reset.h"
            ^~~~~~~~~
   1 error generated.
--
>> drivers/clk/mediatek/clk-mt6795-pericfg.c:13:10: fatal error: 'reset.h' file not found
   #include "reset.h"
            ^~~~~~~~~
   1 error generated.


vim +14 drivers/clk/mediatek/clk-mt6795-infracfg.c

  > 14	#include "reset.h"
    15	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
