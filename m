Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D25875B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiHBC4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHBC4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:56:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD81D0C0;
        Mon,  1 Aug 2022 19:56:41 -0700 (PDT)
X-UUID: 0f016471410a40bd970b5f5ee99a0f83-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:d2f20303-42dd-4a9c-bd21-a3eb2abb00cb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:d2f20303-42dd-4a9c-bd21-a3eb2abb00cb,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:0f96f5d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:423ab5852118,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0f016471410a40bd970b5f5ee99a0f83-20220802
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1129900911; Tue, 02 Aug 2022 10:56:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 10:56:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Aug 2022 10:56:31 +0800
Message-ID: <f38757a55a5a5f90099a2b166363b32da44ff3a7.camel@mediatek.com>
Subject: Re: [PATCH v15 05/11] drm/mediatek: Add MT8195 Embedded DisplayPort
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
Date:   Tue, 2 Aug 2022 10:56:30 +0800
In-Reply-To: <20220727045035.32225-6-rex-bc.chen@mediatek.com>
References: <20220727045035.32225-1-rex-bc.chen@mediatek.com>
         <20220727045035.32225-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Wed, 2022-07-27 at 12:50 +0800, Bo-Chen Chen wrote:
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
> +#define MTK_DP_ENC0_P0_31D0			(ENC0_OFFSET + 0x1D0)

MTK_DP_ENC0_P0_31D0 is uselese, so remove it.

> +#define VSC_EXT_CEA_HB0_DP_ENC0_P0_MASK		GENMASK(7, 0)
> +#define VSC_EXT_CEA_HB1_DP_ENC0_P0_MASK		GENMASK(15, 8)
> +#define VSC_EXT_CEA_HB1_DP_ENC0_P0_SHIFT	BIT(3)
> +
> +#define MTK_DP_ENC0_P0_31D4			(ENC0_OFFSET + 0x1D4)

Ditto.

> +#define VSC_EXT_CEA_HB2_DP_ENC0_P0_MASK		GENMASK(7, 0)
> +#define VSC_EXT_CEA_HB2_DP_ENC0_P0_SHIFT	0
> +#define VSC_EXT_CEA_HB3_DP_ENC0_P0_MASK		GENMASK(15, 8)
> +
> +#define MTK_DP_ENC0_P0_31D8			(ENC0_OFFSET + 0x1D8)

Ditto.

> +#define VSC_EXT_VESA_NUM_DP_ENC0_P0_MASK	GENMASK(5, 0)
> +#define VSC_EXT_VESA_NUM_DP_ENC0_P0_SHIFT	0
> +#define VSC_EXT_CEA_NUM_DP_ENC0_P0_MASK		GENMASK(13, 8)
> +#define VSC_EXT_CEA_NUM_DP_ENC0_P0_SHIFT	BIT(3)
> +
> +#define MTK_DP_ENC0_P0_31DC			(ENC0_OFFSET + 0x1DC)

Ditto.

Regards,
CK

> +#define HDR0_CFG_DP_ENC0_P0_MASK		GENMASK(7, 0)
> +#define HDR0_CFG_DP_ENC0_P0_SHIFT		0
> +#define MTK_DP_ENC0_P0_31E8			(ENC0_OFFSET + 0x1E8)
> +#define MTK_DP_ENC0_P0_31EC			(ENC0_OFFSET + 0x1EC)
> +#define AUDIO_CH_SRC_SEL_DP_ENC0_P0_MASK	BIT(4)
> +#define AUDIO_CH_SRC_SEL_DP_ENC0_P0_SHIFT	BIT(2)
> +#define ISRC1_HB3_DP_ENC0_P0_MASK		GENMASK(15, 8)
> +#define ISRC1_HB3_DP_ENC0_P0_SHIFT		BIT(3)
> +

