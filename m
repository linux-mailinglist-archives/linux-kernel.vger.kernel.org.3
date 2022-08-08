Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3DA58C2BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiHHFQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHFQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:16:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13426345;
        Sun,  7 Aug 2022 22:16:33 -0700 (PDT)
X-UUID: c0be2cfb4a454ffba54c32e3cd77a658-20220808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AkMEMzZuPkD8LTOnQvmEPxNP+RnZp1tkZuAE46lGFXw=;
        b=A6xVHt/F/5rK7uz+kHdaph/EjiHsQR8V4vEsTYtDs8PcYZwUFQ9EiSC+0ZX6JUHTMu0miYwBFTYwkTiT/W3dLRv1dws67AJPIc5/slr20MkNcnPrVwHGsgWQwM7ElcOgXG+jEiy+2rKU94G4g8uDX5EqilelH3kuZkWUjPZ3evk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:42c3e49d-aa57-4453-a4cd-03f2ee5a90a8,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.9,REQID:42c3e49d-aa57-4453-a4cd-03f2ee5a90a8,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:45
X-CID-META: VersionHash:3d8acc9,CLOUDID:d3372fae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:314c0b5388c9,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: c0be2cfb4a454ffba54c32e3cd77a658-20220808
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 576822762; Mon, 08 Aug 2022 13:16:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 8 Aug 2022 13:16:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 8 Aug 2022 13:16:24 +0800
Message-ID: <926ea84a64429b1d6bc7f94d01d463c79167b87c.camel@mediatek.com>
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
Date:   Mon, 8 Aug 2022 13:16:24 +0800
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
> +static int mtk_dp_train_tps_1(struct mtk_dp *mtk_dp, u8
> target_lane_count,
> +			      u8 *lane_adjust, int *status_control,
> +			      u8 *prev_lane_adjust)
> +{
> +	u8 link_status[DP_LINK_STATUS_SIZE] = {};
> +
> +	mtk_dp_training_set_scramble(mtk_dp, false);

I think this statement could be moved to mtk_dp_train_flow() before the
training loop. After this moving, mtk_dp_train_tps_1() is almost the
same as mtk_dp_train_tps_2_3(), so try to merge these two function.

> +
> +	if (*status_control == 0) {
> +		mtk_dp_pattern(mtk_dp, true, target_lane_count,
> lane_adjust);
> +		*status_control = 1;

if calling mtk_dp_pattern() directly from mtk_dp_train_flow(), we could
drop status_control.

Regards,
CK

> +	}
> +
> +	drm_dp_link_train_clock_recovery_delay(&mtk_dp->aux, mtk_dp-
> >rx_cap);
> +	drm_dp_dpcd_read_link_status(&mtk_dp->aux, link_status);
> +
> +	if (drm_dp_clock_recovery_ok(link_status,
> +				     target_lane_count)) {
> +		mtk_dp->train_info.cr_done = true;
> +		dev_dbg(mtk_dp->dev, "Link train CR pass\n");
> +		return 0;
> +	} else if (*prev_lane_adjust == link_status[4]) {
> +		if (*prev_lane_adjust &
> DP_ADJUST_VOLTAGE_SWING_LANE0_MASK) {
> +			dev_dbg(mtk_dp->dev, "Link train CQ fail\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		*prev_lane_adjust = link_status[4];
> +	}
> +	return -EAGAIN;
> +}
> +
> +static int mtk_dp_train_tps_2_3(struct mtk_dp *mtk_dp, u8
> target_linkrate,
> +				u8 target_lane_count, u8 *lane_adjust,
> +				int *status_control, u8
> *prev_lane_adjust)
> +{
> +	u8 link_status[DP_LINK_STATUS_SIZE] = {};
> +
> +	if (*status_control == 1) {
> +		mtk_dp_pattern(mtk_dp, false, target_lane_count,
> lane_adjust);
> +		*status_control = 2;
> +	}
> +
> +	drm_dp_link_train_channel_eq_delay(&mtk_dp->aux, mtk_dp-
> >rx_cap);
> +
> +	drm_dp_dpcd_read_link_status(&mtk_dp->aux, link_status);
> +
> +	if (drm_dp_channel_eq_ok(link_status, target_lane_count)) {
> +		mtk_dp->train_info.eq_done = true;
> +		dev_dbg(mtk_dp->dev, "Link train EQ pass\n");
> +		return 0;
> +	}
> +
> +	dev_dbg(mtk_dp->dev, "Link train EQ fail\n");
> +
> +	if (*prev_lane_adjust != link_status[4])
> +		*prev_lane_adjust = link_status[4];
> +
> +	return -EAGAIN;
> +}
> +
> +static int mtk_dp_train_flow(struct mtk_dp *mtk_dp, u8
> target_link_rate,
> +			     u8 target_lane_count)
> +{
> +	u8 lane_adjust[2] = {};
> +	bool pass_tps1 = false;
> +	bool pass_tps2_3 = false;
> +	int train_retries;
> +	int status_control;
> +	int ret;
> +	u8 prev_lane_adjust;
> +
> +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_LINK_BW_SET,
> target_link_rate);
> +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_LANE_COUNT_SET,
> +			   target_lane_count |
> DP_LANE_COUNT_ENHANCED_FRAME_EN);
> +
> +	if (mtk_dp->train_info.sink_ssc)
> +		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_DOWNSPREAD_CTRL,
> +				   DP_SPREAD_AMP_0_5);
> +
> +	train_retries = 0;
> +	status_control = 0;
> +	prev_lane_adjust = 0xFF;
> +
> +	mtk_dp_set_lanes(mtk_dp, target_lane_count / 2);
> +	ret = mtk_dp_phy_configure(mtk_dp, target_link_rate,
> target_lane_count);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(mtk_dp->dev,
> +		"Link train target_link_rate = 0x%x, target_lane_count
> = 0x%x\n",
> +		target_link_rate, target_lane_count);
> +
> +	do {
> +		train_retries++;
> +		if (!mtk_dp->train_info.cable_plugged_in)
> +			return -ENODEV;
> +
> +		if (!pass_tps1) {
> +			ret = mtk_dp_train_tps_1(mtk_dp,
> target_lane_count,
> +						 lane_adjust,
> &status_control,
> +						 &prev_lane_adjust);
> +			if (!ret) {
> +				pass_tps1 = true;
> +				train_retries = 0;
> +			} else if (ret == -EINVAL) {
> +				break;
> +			}
> +		} else {
> +			ret = mtk_dp_train_tps_2_3(mtk_dp,
> target_link_rate,
> +						   target_lane_count,
> +						   lane_adjust,
> &status_control,
> +						   &prev_lane_adjust);
> +			if (!ret) {
> +				pass_tps2_3 = true;
> +				break;
> +			}
> +		}
> +
> +		drm_dp_dpcd_read(&mtk_dp->aux,
> DP_ADJUST_REQUEST_LANE0_1,
> +				 lane_adjust, sizeof(lane_adjust));
> +		mtk_dp_train_update_swing_pre(mtk_dp,
> target_lane_count,
> +					      lane_adjust);
> +	} while (train_retries < MTK_DP_TRAIN_DOWNSCALE_RETRY);
> +
> +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_TRAINING_PATTERN_SET,
> +			   DP_TRAINING_PATTERN_DISABLE);
> +	mtk_dp_train_set_pattern(mtk_dp, 0);
> +
> +	if (!pass_tps2_3)
> +		return -ETIMEDOUT;
> +
> +	mtk_dp->train_info.link_rate = target_link_rate;
> +	mtk_dp->train_info.lane_count = target_lane_count;
> +
> +	mtk_dp_training_set_scramble(mtk_dp, true);
> +
> +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_LANE_COUNT_SET,
> +			   target_lane_count |
> +				   DP_LANE_COUNT_ENHANCED_FRAME_EN);
> +	mtk_dp_set_enhanced_frame_mode(mtk_dp, true);
> +
> +	return ret;
> +}
> +

