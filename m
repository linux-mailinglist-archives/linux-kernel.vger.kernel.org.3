Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C957322B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiGMJMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiGMJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:12:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86CDA598;
        Wed, 13 Jul 2022 02:12:42 -0700 (PDT)
X-UUID: 26d315c2c3544c99a56db226c1688f00-20220713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:470977ff-af74-463d-a958-20fb93a9322b,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:51
X-CID-INFO: VERSION:1.1.8,REQID:470977ff-af74-463d-a958-20fb93a9322b,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-META: VersionHash:0f94e32,CLOUDID:6354dc32-b9e4-42b8-b28a-6364427c76bb,C
        OID:92ea3a584a4c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 26d315c2c3544c99a56db226c1688f00-20220713
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1206323069; Wed, 13 Jul 2022 17:12:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 13 Jul 2022 17:12:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jul 2022 17:12:35 +0800
Message-ID: <f22517dc676358e055eeb5192930b8a5f0d821a5.camel@mediatek.com>
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
Date:   Wed, 13 Jul 2022 17:12:35 +0800
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
> +static void mtk_dp_msa_bypass_enable(struct mtk_dp *mtk_dp, bool
> enable)
> +{
> +	u32 mask = BIT(HTOTAL_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(VTOTAL_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(HSTART_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(VSTART_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(HWIDTH_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(VHEIGHT_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(HSP_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(HSW_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(VSP_SEL_DP_ENC0_P0_SHIFT) |
> +		   BIT(VSW_SEL_DP_ENC0_P0_SHIFT);

I would like define a symbol like this

#define HTOTAL_SEL_DP_ENC0_P0 BIT(0)
#define VTOTAL_SEL_DP_ENC0_P0 BIT(1)
#define HSTART_SEL_DP_ENC0_P0 BIT(2)

Regards,
CK

> +	u32 val = enable ? 0 : mask;
> +
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3030, val, mask);
> +}
> +

