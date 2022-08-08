Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36D858C244
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiHHEDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHHEDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:03:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F45F9A;
        Sun,  7 Aug 2022 21:03:31 -0700 (PDT)
X-UUID: 6cab6299791444e8972443bac60a73ef-20220808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=13dVi6zffDRyU08aWmQ+RkE23iuEih6mcqLZPlBATNQ=;
        b=W0Hxmb5Lipa+VZ0fXF3en8QZCxL+2eqLNNuNMto8QRl6TE/8U9RSuzYTmqc0b5fgjYAQqZcaZcwozFbGN0rTCoistx3mqi0T6r4a2VPGwvpdnpgH5b+YnYrdykcWKSnoaEEkabO91PNRucLQqBz32mId6eNT9T9a3HRA3wUya2Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:1448fca9-b1cb-490c-9fc2-6fc55749af56,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.9,REQID:1448fca9-b1cb-490c-9fc2-6fc55749af56,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:45
X-CID-META: VersionHash:3d8acc9,CLOUDID:df2d079c-da39-4e3b-a854-56c7d2111b46,C
        OID:f18e5827bede,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 6cab6299791444e8972443bac60a73ef-20220808
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1260182744; Mon, 08 Aug 2022 12:03:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 8 Aug 2022 12:03:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 8 Aug 2022 12:03:24 +0800
Message-ID: <f5165c4f6f4f72668035437ee27b476e588e60a3.camel@mediatek.com>
Subject: Re: [PATCH v16 3/8] drm/mediatek: Add MT8195 Embedded DisplayPort
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
Date:   Mon, 8 Aug 2022 12:03:24 +0800
In-Reply-To: <20220805101459.3386-4-rex-bc.chen@mediatek.com>
References: <20220805101459.3386-1-rex-bc.chen@mediatek.com>
         <20220805101459.3386-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Fri, 2022-08-05 at 18:14 +0800, Bo-Chen Chen wrote:
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
> Tested-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---

[snip]

> +
> +#define MTK_DP_ENC0_P0_30B8		(ENC0_OFFSET + 0xB8)

Useless, so remove it.

> +
> +#define MTK_DP_ENC0_P0_30BC		(ENC0_OFFSET + 0xBC)

Ditto.

> +#define ISRC_CONT_DP_ENC0_P0_MASK	BIT(0)
> +#define ISRC_CONT_DP_ENC0_P0_SHIFT	0
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MASK	GENMASK(10, 8)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT	BIT(3)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2 \
> +		(1 << AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4 \
> +		(2 << AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8 \
> +		(3 << AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2 \
> +		(5 << AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4 \
> +		(6 << AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT)
> +#define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8 \
> +		(7 << AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_SHIFT)
> +
> +#define MTK_DP_ENC0_P0_30D8		(ENC0_OFFSET + 0xD8)

Ditto.

> +#define MTK_DP_ENC0_P0_312C		(ENC0_OFFSET + 0x12C)

Ditto.

> +#define ASP_HB2_DP_ENC0_P0_MASK		GENMASK(7, 0)
> +#define ASP_HB3_DP_ENC0_P0_MASK		GENMASK(15, 8)
> +#define ASP_HB3_DP_ENC0_P0_SHIFT	BIT(3)
> +
> 

[snip]

> +
> +#define MTK_DP_ENC1_P0_3364				(ENC1_OFFSET +
> 0x164)
> +#define SDP_DOWN_CNT_INIT_IN_HBLANK_DP_ENC1_P0_MASK	GENMASK(11, 0)
> +#define SDP_DOWN_CNT_INIT_IN_HBLANK_DP_ENC1_P0_SHIFT	0
> +#define FIFO_READ_START_POINT_DP_ENC1_P0_MASK		GENMASK
> (15, 12)
> +#define FIFO_READ_START_POINT_DP_ENC1_P0_SHIFT		GENMASK
> (3, 2)

I would like bit-wise value has one more indent like [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/mediatek/mtk_disp_rdma.c?h=v5.19

Regards,
CK

> +
> +#define MTK_DP_ENC1_P0_3368				(ENC1_OFFSET +
> 0x168)
> +#define VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0_SHIFT	0
> +#define VIDEO_STABLE_CNT_THRD_DP_ENC1_P0_SHIFT		BIT(2)
> +#define SDP_DP13_EN_DP_ENC1_P0_SHIFT			BIT(3)
> +#define BS2BS_MODE_DP_ENC1_P0_MASK			GENMASK(13, 12)
> +#define BS2BS_MODE_DP_ENC1_P0_SHIFT			GENMASK(3, 2)
> +
> 

