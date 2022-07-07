Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0145697B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiGGByH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiGGByF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:54:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE52E9FF;
        Wed,  6 Jul 2022 18:54:04 -0700 (PDT)
X-UUID: 86f8e103f55c4e24b408239f9b30eaaa-20220707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:87fa9421-dace-4402-9545-5a476338d534,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:91be9d63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 86f8e103f55c4e24b408239f9b30eaaa-20220707
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1376814873; Thu, 07 Jul 2022 09:54:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 7 Jul 2022 09:53:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 7 Jul 2022 09:53:58 +0800
Message-ID: <d802e3e442a516ba8c2f123a127e33c49f831744.camel@mediatek.com>
Subject: Re: [PATCH v16 0/5] drm/mediatek: Add MT8195 dp_intf driver
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <xinlei.lee@mediatek.com>, <liangxu.xu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 7 Jul 2022 09:53:58 +0800
In-Reply-To: <20220705102530.1344-1-rex-bc.chen@mediatek.com>
References: <20220705102530.1344-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Tue, 2022-07-05 at 18:25 +0800, Bo-Chen Chen wrote:
> The dpi/dpintf driver and the added helper functions are required for
> the DisplayPort driver to work.

For this series, applied to mediatek-drm-next [1], thanks.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/log/?h=mediatek-drm-next

Regards,
CK

> 
> This series is separated from [1] which is original from Guillaume.
> The display port driver is [2].
> 
> Changes for v16:
> 1. Separate input_2pixel and pixels_per_iter to other patches.
> 2. Remove function "mtk_dpi_matrix_sel" and color_fmt_trans_support
>    in patch "Add YUV422 output support".
> 3. Drop patches which are accepted.
> 
> Changes for v15:
> 1. Add a patch to remove support for output yuv422 for previous socs.
> 2. Only remain output format of reg888/yuv422 support for mt8195.
> 3. Adjust the order of patches.
> 
> Changes for v14:
> 1. Separate a new binding patch to modify mediatek string format.
> 2. Use GENMASK(4, 0) for INT_MATRIX_SEL_MASK in patch
>    "Add YUV422 output support"
> 3. Change kernel doc description of support_direct_pin.
> 4. Change to use pixels_per_iter to control quantity of transferred
>    pixels per iterration.
> 
> Changes for v13:
> 1. Change mediatek,mt8195-dp_intf to mediatek,mt8195-dp-intf.
> 2. Add kernel doc for mtk_dpi_conf.
> 3. Drop patch of tvd_pll enable.
> 4. Squash some color format transfer related patches.
> 5. Add new patch to support setting of direct connection to pins.
> 6. Change fix tag of "drm/mediatek: dpi: Only enable dpi after the
> bridge
>    is enabled".
> 
> Changes for v12:
> 1. Remove pll_gate.
> 2. Add more detailed commit message.
> 3. Separate tvd_clk patch and yuv422 output support from add dpintf
>    support patch
> 4. Remove limit patch and use common driver codes to determine this.
> 
> Changes for v11:
> 1. Rename ck_cg to pll_gate.
> 2. Add some commit message to clarify the modification reason.
> 3. Fix some driver order and modify for reviewers' comments.
> 
> [1]:
> https://lore.kernel.org/all/20220523104758.29531-1-granquet@baylibre.com/
> [2]:
> https://lore.kernel.org/all/20220610105522.13449-1-rex-bc.chen@mediatek.com/
> 
> Bo-Chen Chen (4):
>   drm/mediatek: dpi: Add YUV422 output support
>   drm/mediatek: dpi: add config to support direct connection to dpi
>     panels
>   drm/mediatek: dpi: Add input_2pixel config support
>   drm/mediatek: dpi: Add pixels_per_iter config support
> 
> Guillaume Ranquet (1):
>   drm/mediatek: dpi: Add dp_intf support
> 
>  drivers/gpu/drm/mediatek/mtk_dpi.c          | 115 +++++++++++++++++-
> --
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h     |  18 +++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   4 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   3 +
>  5 files changed, 126 insertions(+), 15 deletions(-)
> 

