Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D782542B75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiFHJYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiFHJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:24:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C51F7A58;
        Wed,  8 Jun 2022 01:45:20 -0700 (PDT)
X-UUID: d2f4794b2852431da6552fe1fce1a1d3-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9355ed3d-87b9-4cab-802a-191c99b7bdec,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:cbfc9f7e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: d2f4794b2852431da6552fe1fce1a1d3-20220608
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1124952300; Wed, 08 Jun 2022 16:45:15 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Jun 2022 16:45:14 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 8 Jun 2022 16:45:14 +0800
Message-ID: <8bd5136b1404e16ba5085c3151b31ec9a1715e54.camel@mediatek.com>
Subject: Re: [PATCH v10 18/21] drm/mediatek: Add mt8195 Embedded DisplayPort
 driver
From:   CK Hu <ck.hu@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, "Helge Deller" <deller@gmx.de>,
        Jitao shi <jitao.shi@mediatek.com>
CC:     Markus Schneider-Pargmann <msp@baylibre.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-fbdev@vger.kernel.org>
Date:   Wed, 8 Jun 2022 16:45:14 +0800
In-Reply-To: <20220523104758.29531-19-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-19-granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:

On Mon, 2022-05-23 at 12:47 +0200, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This patch adds a DisplayPort driver for the Mediatek mt8195 SoC.
> 
> It supports the mt8195, the embedded DisplayPort units. It offers
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
> Jason-JH.Lin <jason-jh.lin@mediatek.com>.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---

[snip]

> +
> +static bool mtk_dp_set_swing_pre_emphasis(struct mtk_dp *mtk_dp, int
> lane_num,
> +					  int swing_val, int
> preemphasis)

The return value is never processed, so let this function to be void.

Regards,
CK

> +{
> +	int ret;
> +
> +	u32 lane_shift = lane_num * DP_TX1_VOLT_SWING_SHIFT;
> +
> +	if (lane_num < 0 || lane_num > 3)

lane_num < 0 would not happen. lane_num > 3 only if device tree max
lane is wrong. So I would like to checkout max lane when parsing device
tree instead of checking here.

> +		return false;
> +
> +	dev_dbg(mtk_dp->dev,
> +		"link training swing_val= 0x%x, preemphasis = 0x%x\n",
> +		swing_val, preemphasis);
> +
> +	ret = mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_SWING_EMP,
> +				 swing_val << (DP_TX0_VOLT_SWING_SHIFT
> + lane_shift),
> +				 DP_TX0_VOLT_SWING_MASK << lane_shift);
> +	if (ret)
> +		return ret;
> +	ret = mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_SWING_EMP,
> +				 preemphasis << (DP_TX0_PRE_EMPH_SHIFT
> + lane_shift),
> +				 DP_TX0_PRE_EMPH_MASK << lane_shift);
> +
> +	return !ret;
> +}
> +

