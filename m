Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09E5334E4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiEYBqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiEYBp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:45:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26F57121;
        Tue, 24 May 2022 18:45:55 -0700 (PDT)
X-UUID: 6e0202bcfdb0488caeadcff564587789-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a803b031-3b7c-4e37-974f-71e58a4947d6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:a803b031-3b7c-4e37-974f-71e58a4947d6,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:7f2e5747-4fb1-496b-8f1d-39e733fed1ea,C
        OID:22b6bf49322e,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:1,File:nil,QS:0,BEC:nil
X-UUID: 6e0202bcfdb0488caeadcff564587789-20220525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1558149621; Wed, 25 May 2022 09:45:49 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 25 May 2022 09:45:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 May 2022 09:45:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 25 May 2022 09:45:48 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <lkp@intel.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <kbuild-all@lists.01.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <llvm@lists.linux.dev>,
        <matthias.bgg@gmail.com>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <wenst@chromium.org>
Subject: Re: [PATCH v2 4/7] clk: mediatek: mt6779: use mtk_clk_simple_probe to simplify driver
Date:   Wed, 25 May 2022 09:45:48 +0800
Message-ID: <20220525014548.19749-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <202205242129.DezL7Tp0-lkp@intel.com>
References: <202205242129.DezL7Tp0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-imxrt1050.o
> ERROR: modpost: "vmf_insert_pfn" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-aud.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-aud.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-vdec.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-vdec.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-cam.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-cam.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_remove" [drivers/clk/mediatek/clk-mt6779-ipe.ko] undefined!
> >> ERROR: modpost: "mtk_clk_simple_probe" [drivers/clk/mediatek/clk-mt6779-ipe.ko] undefined!
> ERROR: modpost: "imx_clk_hw_pfd" [drivers/clk/imx/clk-imxrt1050.ko] undefined!
> WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many)

Thanks for the testing.
This patch depends on another patch [1], so I will just ignore this report.

thanks,
Miles

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
>    Depends on HAS_IOMEM && DRM && MMU
>    Selected by
>    - DRM_SSD130X && HAS_IOMEM && DRM
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

