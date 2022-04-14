Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5C50182F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbiDNQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359705AbiDNPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:47:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD31F47F1;
        Thu, 14 Apr 2022 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649950342; x=1681486342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GWVpvaE0Wgi4ximav1D+j4xQUb5aXMCEWIKwKCiRekw=;
  b=NN5lTotRp2E3kICcbgCn/ZT2/4mNousau/SHXN4rct5JJFopQ1LzmtO9
   LTrNLvhw+fvaL0tnd+1AO+7QSNaKUbrFcNcNq/R77Vl6wcewBwMJOub3z
   SbHubD0DW6cUIKgJ1epwymVG3nWmm3OZU66VS/OZDWJGV3YJpyYubVIlU
   CFuginx557Hyedq09Jy0U2RLCkLRA1MV8bLSqZbyvN2oU7jvqUPgkRYPR
   9cryaVjml1bQxmTncU7+5J1uBx2hedgou0l9xnV/0NjJeIPz0FZTOow5n
   xTwy1ZOCR35YdHFQtrKDf4j+CDIvutb4zV5sdh6OjL5zFh+1lhiuUmdt3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262400218"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262400218"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="552728132"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2022 08:32:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nf1SA-00014v-Sw;
        Thu, 14 Apr 2022 15:32:14 +0000
Date:   Thu, 14 Apr 2022 23:31:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, fshao@chromium.org,
        David Airlie <airlied@linux.ie>, singo.chang@mediatek.com,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-stm32@st-md-mailman.stormreply.com, roy-cw.yeh@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        devicetree@vger.kernel.org, nancy.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        linux-kernel@vger.kernel.org, moudy.ho@mediatek.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v18 07/10] drm/mediatek: add mediatek-drm of vdosys0
 support for mt8195
Message-ID: <202204142333.qXgcGMI1-lkp@intel.com>
References: <20220412103114.19922-8-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412103114.19922-8-jason-jh.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "jason-jh.lin",

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on robh/for-next krzk/for-next linus/master v5.18-rc2 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/jason-jh-lin/Add-Mediatek-Soc-DRM-vdosys0-support-for-mt8195/20220412-183359
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: arm64-buildonly-randconfig-r001-20220413 (https://download.01.org/0day-ci/archive/20220414/202204142333.qXgcGMI1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7c175317aa80bbc885609a730214448147a46b47
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review jason-jh-lin/Add-Mediatek-Soc-DRM-vdosys0-support-for-mt8195/20220412-183359
        git checkout 7c175317aa80bbc885609a730214448147a46b47
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_drm_drv.c:707:15: warning: cast to smaller integer type 'enum mtk_ddp_comp_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   comp_type = (enum mtk_ddp_comp_type)of_id->data;
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:203:42: warning: unused variable 'mt2701_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt2701_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:218:42: warning: unused variable 'mt7623_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt7623_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:234:42: warning: unused variable 'mt2712_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt2712_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:246:42: warning: unused variable 'mt8167_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt8167_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:260:42: warning: unused variable 'mt8173_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt8173_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:274:42: warning: unused variable 'mt8183_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt8183_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:288:42: warning: unused variable 'mt8192_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt8192_mmsys_match_data = {
                                            ^
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:305:42: warning: unused variable 'mt8195_mmsys_match_data' [-Wunused-const-variable]
   static const struct mtk_mmsys_match_data mt8195_mmsys_match_data = {
                                            ^
   9 warnings generated.


vim +/mt2701_mmsys_match_data +203 drivers/gpu/drm/mediatek/mtk_drm_drv.c

   202	
 > 203	static const struct mtk_mmsys_match_data mt2701_mmsys_match_data = {
   204		.num_drv_data = 1,
   205		.drv_data = {
   206			&mt2701_mmsys_driver_data,
   207		},
   208	};
   209	
   210	static const struct mtk_mmsys_driver_data mt7623_mmsys_driver_data = {
   211		.main_path = mt7623_mtk_ddp_main,
   212		.main_len = ARRAY_SIZE(mt7623_mtk_ddp_main),
   213		.ext_path = mt7623_mtk_ddp_ext,
   214		.ext_len = ARRAY_SIZE(mt7623_mtk_ddp_ext),
   215		.shadow_register = true,
   216	};
   217	
 > 218	static const struct mtk_mmsys_match_data mt7623_mmsys_match_data = {
   219		.num_drv_data = 1,
   220		.drv_data = {
   221			&mt7623_mmsys_driver_data,
   222		},
   223	};
   224	
   225	static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
   226		.main_path = mt2712_mtk_ddp_main,
   227		.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
   228		.ext_path = mt2712_mtk_ddp_ext,
   229		.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
   230		.third_path = mt2712_mtk_ddp_third,
   231		.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
   232	};
   233	
 > 234	static const struct mtk_mmsys_match_data mt2712_mmsys_match_data = {
   235		.num_drv_data = 1,
   236		.drv_data = {
   237			&mt2712_mmsys_driver_data,
   238		},
   239	};
   240	
   241	static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
   242		.main_path = mt8167_mtk_ddp_main,
   243		.main_len = ARRAY_SIZE(mt8167_mtk_ddp_main),
   244	};
   245	
 > 246	static const struct mtk_mmsys_match_data mt8167_mmsys_match_data = {
   247		.num_drv_data = 1,
   248		.drv_data = {
   249			&mt8167_mmsys_driver_data,
   250		},
   251	};
   252	
   253	static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
   254		.main_path = mt8173_mtk_ddp_main,
   255		.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
   256		.ext_path = mt8173_mtk_ddp_ext,
   257		.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
   258	};
   259	
 > 260	static const struct mtk_mmsys_match_data mt8173_mmsys_match_data = {
   261		.num_drv_data = 1,
   262		.drv_data = {
   263			&mt8173_mmsys_driver_data,
   264		},
   265	};
   266	
   267	static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
   268		.main_path = mt8183_mtk_ddp_main,
   269		.main_len = ARRAY_SIZE(mt8183_mtk_ddp_main),
   270		.ext_path = mt8183_mtk_ddp_ext,
   271		.ext_len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
   272	};
   273	
 > 274	static const struct mtk_mmsys_match_data mt8183_mmsys_match_data = {
   275		.num_drv_data = 1,
   276		.drv_data = {
   277			&mt8183_mmsys_driver_data,
   278		},
   279	};
   280	
   281	static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
   282		.main_path = mt8192_mtk_ddp_main,
   283		.main_len = ARRAY_SIZE(mt8192_mtk_ddp_main),
   284		.ext_path = mt8192_mtk_ddp_ext,
   285		.ext_len = ARRAY_SIZE(mt8192_mtk_ddp_ext),
   286	};
   287	
 > 288	static const struct mtk_mmsys_match_data mt8192_mmsys_match_data = {
   289		.num_drv_data = 1,
   290		.drv_data = {
   291			&mt8192_mmsys_driver_data,
   292		},
   293	};
   294	
   295	static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
   296		.io_start = 0x1c01a000,
   297		.main_path = mt8195_mtk_ddp_main,
   298		.main_len = ARRAY_SIZE(mt8195_mtk_ddp_main),
   299	};
   300	
   301	static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
   302		.io_start = 0x1c100000,
   303	};
   304	
 > 305	static const struct mtk_mmsys_match_data mt8195_mmsys_match_data = {
   306		.num_drv_data = 1,
   307		.drv_data = {
   308			&mt8195_vdosys0_driver_data,
   309			&mt8195_vdosys1_driver_data,
   310		},
   311	};
   312	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
