Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1277C573347
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiGMJqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiGMJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:46:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E5F90EC;
        Wed, 13 Jul 2022 02:45:48 -0700 (PDT)
X-UUID: fd6ec3c671494f468202f516ad68e594-20220713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:6c925a24-eda3-476d-80fe-f49c592c48eb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.8,REQID:6c925a24-eda3-476d-80fe-f49c592c48eb,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:0f94e32,CLOUDID:cf64dd32-b9e4-42b8-b28a-6364427c76bb,C
        OID:0974ccde4ec2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: fd6ec3c671494f468202f516ad68e594-20220713
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1170456231; Wed, 13 Jul 2022 17:45:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 13 Jul 2022 17:45:41 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 13 Jul 2022 17:45:41 +0800
Message-ID: <1dc880e7b5b6a28911a0c7acb29fa423ddb10da0.camel@mediatek.com>
Subject: Re: [PATCH v14 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
 driver
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <matthias.bgg@gmail.com>, <deller@gmx.de>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <liangxu.xu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 13 Jul 2022 17:45:41 +0800
In-Reply-To: <20220712111223.13080-6-rex-bc.chen@mediatek.com>
References: <20220712111223.13080-1-rex-bc.chen@mediatek.com>
         <20220712111223.13080-6-rex-bc.chen@mediatek.com>
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

On Tue, 2022-07-12 at 19:12 +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This patch adds a embedded displayport driver for the MediaTek mt8195
> SoC.
> 
> It supports the MT8195, the embedded DisplayPort units. It offers
> DisplayPort 1.4 with up to 4 lanes.
> 
> The driver creates a child device for the phy. The child device will
> never exist without the parent being active. As they are sharing a
> register range, the parent passes a regmap pointer to the child so
> that
> both can work with the same register range. The phy driver sets
> device
> data that is read by the parent to get the phy device that can be
> used
> to control the phy properties.
> 
> This driver is based on an initial version by
> Jitao shi <jitao.shi@mediatek.com>
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---

[snip]

> +
> +static void mtk_dp_set_msa(struct mtk_dp *mtk_dp)
> +{
> +	struct drm_display_mode mode;
> +	struct mtk_dp_timings *timings = &mtk_dp->info.timings;
> +
> +	drm_display_mode_from_videomode(&timings->vm, &mode);
> +
> +	/* horizontal */
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3010,
> +			   mode.htotal, HTOTAL_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3018,
> +			   timings->vm.hsync_len + timings-
> >vm.hback_porch,
> +			   HSTART_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3028,
> +			   timings->vm.hsync_len <<
> HSW_SW_DP_ENC0_P0_SHIFT,

Directly use a number for shift because we know it's a shift, so it's
not necessary to define a symbol for shift.

> +			   HSW_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3028,
> +			   0, HSP_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3020,
> +			   timings->vm.hactive,
> HWIDTH_SW_DP_ENC0_P0_MASK);
> +
> +	/* vertical */
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3014,
> +			   mode.vtotal, VTOTAL_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_301C,
> +			   timings->vm.vsync_len + timings-
> >vm.vback_porch,
> +			   VSTART_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_302C,
> +			   timings->vm.vsync_len <<
> VSW_SW_DP_ENC0_P0_SHIFT,

Ditto.

Regards,
CK

> +			   VSW_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_302C,
> +			   0, VSP_SW_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3024,
> +			   timings->vm.vactive,
> VHEIGHT_SW_DP_ENC0_P0_MASK);
> +
> +	/* horizontal */
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3064,
> +			   timings->vm.hactive,
> HDE_NUM_LAST_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3154,
> +			   mode.htotal, PGEN_HTOTAL_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3158,
> +			   timings->vm.hfront_porch,
> +			   PGEN_HSYNC_RISING_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_315C,
> +			   timings->vm.hsync_len,
> +			   PGEN_HSYNC_PULSE_WIDTH_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3160,
> +			   timings->vm.hback_porch + timings-
> >vm.hsync_len,
> +			   PGEN_HFDE_START_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3164,
> +			   timings->vm.hactive,
> +			   PGEN_HFDE_ACTIVE_WIDTH_DP_ENC0_P0_MASK);
> +
> +	/* vertical */
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3168,
> +			   mode.vtotal,
> +			   PGEN_VTOTAL_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_316C,
> +			   timings->vm.vfront_porch,
> +			   PGEN_VSYNC_RISING_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3170,
> +			   timings->vm.vsync_len,
> +			   PGEN_VSYNC_PULSE_WIDTH_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3174,
> +			   timings->vm.vback_porch + timings-
> >vm.vsync_len,
> +			   PGEN_VFDE_START_DP_ENC0_P0_MASK);
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3178,
> +			   timings->vm.vactive,
> +			   PGEN_VFDE_ACTIVE_WIDTH_DP_ENC0_P0_MASK);
> +}
> +

