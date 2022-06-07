Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D453F7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiFGIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiFGIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:12:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B4C56;
        Tue,  7 Jun 2022 01:12:11 -0700 (PDT)
X-UUID: 8fb8eaf96f42466e8d9402f987ab23a8-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:8559b49c-3dcb-469a-9da5-0f36edc6332d,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:8559b49c-3dcb-469a-9da5-0f36edc6332d,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:efe1e9e4-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:632aa7625d2f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 8fb8eaf96f42466e8d9402f987ab23a8-20220607
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1791805342; Tue, 07 Jun 2022 16:12:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 7 Jun 2022 16:12:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 7 Jun 2022 16:12:04 +0800
Message-ID: <ff858934b622e6716dd48bf02d4d57f19358b805.camel@mediatek.com>
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
Date:   Tue, 7 Jun 2022 16:12:04 +0800
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
> +static int mtk_dp_train_start(struct mtk_dp *mtk_dp)
> +{
> +	int ret = 0;
> +	u8 lane_count;
> +	u8 link_rate;
> +	u8 train_limit;
> +	u8 max_link_rate;
> +	u8 plug_wait;
> +
> +	for (plug_wait = 7; !mtk_dp_plug_state(mtk_dp) && plug_wait >
> 0;
> +	     --plug_wait)
> +		/* Avoid short pulses on the HPD isr */
> +		usleep_range(1000, 5000);
> +	if (plug_wait == 0) {
> +		mtk_dp->train_state = MTK_DP_TRAIN_STATE_DPIDLE;

After return, mtk_dp->train_state would be set to
MTK_DP_TRAIN_STATE_DPIDLE, so drop this.

> +		return -ENODEV;
> +	}
> +
> +	link_rate = mtk_dp->rx_cap[1];
> +	lane_count = mtk_dp->rx_cap[2] & 0x1F;
> +
> +	mtk_dp->train_info.link_rate = min(mtk_dp->max_linkrate,
> link_rate);
> +	mtk_dp->train_info.lane_count = min(mtk_dp->max_lanes,
> lane_count);
> +	link_rate = mtk_dp->train_info.link_rate;
> +	lane_count = mtk_dp->train_info.lane_count;
> +
> +	switch (link_rate) {
> +	case MTK_DP_LINKRATE_RBR:
> +	case MTK_DP_LINKRATE_HBR:
> +	case MTK_DP_LINKRATE_HBR2:
> +	case MTK_DP_LINKRATE_HBR25:
> +	case MTK_DP_LINKRATE_HBR3:
> +		break;
> +	default:
> +		mtk_dp->train_info.link_rate = MTK_DP_LINKRATE_HBR3;
> +		break;
> +	};
> +
> +	max_link_rate = link_rate;
> +	for (train_limit = 6; train_limit > 0; train_limit--) {
> +		mtk_dp->train_info.cr_done = false;
> +		mtk_dp->train_info.eq_done = false;
> +
> +		mtk_dp_train_change_mode(mtk_dp);
> +		ret = mtk_dp_train_flow(mtk_dp, link_rate, lane_count);
> +		if (ret)
> +			return ret;
> +
> +		if (!mtk_dp->train_info.cr_done) {
> +			switch (link_rate) {
> +			case MTK_DP_LINKRATE_RBR:
> +				lane_count = lane_count / 2;
> +				link_rate = max_link_rate;
> +				if (lane_count == 0) {
> +					mtk_dp->train_state =
> +						MTK_DP_TRAIN_STATE_DPID
> LE;

After return, mtk_dp->train_state would be set to
MTK_DP_TRAIN_STATE_DPIDLE, so drop this.

Regards,
CK

> +					return -EIO;
> +				}
> +				break;
> +			case MTK_DP_LINKRATE_HBR:
> +				link_rate = MTK_DP_LINKRATE_RBR;
> +				break;
> +			case MTK_DP_LINKRATE_HBR2:
> +				link_rate = MTK_DP_LINKRATE_HBR;
> +				break;
> +			case MTK_DP_LINKRATE_HBR3:
> +				link_rate = MTK_DP_LINKRATE_HBR2;
> +				break;
> +			default:
> +				return -EINVAL;
> +			};
> +		} else if (!mtk_dp->train_info.eq_done) {
> +			if (lane_count == 0)
> +				return -EIO;
> +
> +			lane_count /= 2;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	if (train_limit == 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +

