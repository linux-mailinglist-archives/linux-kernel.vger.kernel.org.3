Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891EE54F2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381015AbiFQI2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiFQI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:28:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAA1689AA;
        Fri, 17 Jun 2022 01:28:49 -0700 (PDT)
X-UUID: 791e50f84bd446db9e483dfd68d4f070-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:9c5904cf-60ef-4f45-a2e4-d3bf6d6f4ced,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:16d79ff6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 791e50f84bd446db9e483dfd68d4f070-20220617
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 748113598; Fri, 17 Jun 2022 16:28:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 17 Jun 2022 16:28:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jun 2022 16:28:44 +0800
Message-ID: <4c801d6c6e9642d4f2d0b639cdd95718ea45df13.camel@mediatek.com>
Subject: Re: [PATCH v11 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
 driver
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "msp@baylibre.com" <msp@baylibre.com>,
        "granquet@baylibre.com" <granquet@baylibre.com>,
        Jitao Shi =?UTF-8?Q?=28=E7=9F=B3=E8=AE=B0=E6=B6=9B=29?= 
        <jitao.shi@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 17 Jun 2022 16:28:43 +0800
In-Reply-To: <1cf3e33dfc10e948094f11a7ce439ced1b43f4c9.camel@mediatek.com>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com>
         <20220610105522.13449-6-rex-bc.chen@mediatek.com>
         <1cf3e33dfc10e948094f11a7ce439ced1b43f4c9.camel@mediatek.com>
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

On Wed, 2022-06-15 at 13:50 +0800, CK Hu wrote:
> Hi, Bo-Chen:
> 
> On Fri, 2022-06-10 at 18:55 +0800, Bo-Chen Chen wrote:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > 
> > This patch adds a embedded displayport driver for the MediaTek
> > mt8195
> > SoC.
> > 
> > It supports the MT8195, the embedded DisplayPort units. It offers
> > DisplayPort 1.4 with up to 4 lanes.
> > 
> > The driver creates a child device for the phy. The child device
> > will
> > never exist without the parent being active. As they are sharing a
> > register range, the parent passes a regmap pointer to the child so
> > that
> > both can work with the same register range. The phy driver sets
> > device
> > data that is read by the parent to get the phy device that can be
> > used
> > to control the phy properties.
> > 
> > This driver is based on an initial version by
> > Jitao shi <jitao.shi@mediatek.com>
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > [Bo-Chen: Cleanup the drivers and modify comments from reviewers]
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> 
> [snip]
> 
> > +
> > +static int mtk_dp_train_flow(struct mtk_dp *mtk_dp, u8
> > target_link_rate,
> > +			     u8 target_lane_count)
> > +{
> > +	u8 lane_adjust[2] = {};
> > +	bool pass_tps1 = false;
> > +	bool pass_tps2_3 = false;
> > +	int train_retries;
> > +	int status_control;
> > +	int iteration_count;
> > +	int ret;
> > +	u8 prev_lane_adjust;
> > +
> > +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_LINK_BW_SET,
> > target_link_rate);
> > +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_LANE_COUNT_SET,
> > +			   target_lane_count |
> > DP_LANE_COUNT_ENHANCED_FRAME_EN);
> > +
> > +	if (mtk_dp->train_info.sink_ssc)
> > +		drm_dp_dpcd_writeb(&mtk_dp->aux, DP_DOWNSPREAD_CTRL,
> > +				   DP_SPREAD_AMP_0_5);
> > +
> > +	train_retries = 0;
> > +	status_control = 0;
> > +	iteration_count = 1;
> > +	prev_lane_adjust = 0xFF;
> > +
> > +	mtk_dp_set_lanes(mtk_dp, target_lane_count / 2);
> > +	ret = mtk_dp_phy_configure(mtk_dp, target_link_rate,
> > target_lane_count);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	dev_dbg(mtk_dp->dev,
> > +		"Link train target_link_rate = 0x%x, target_lane_count
> > = 0x%x\n",
> > +		target_link_rate, target_lane_count);
> > +
> > +	do {
> > +		train_retries++;
> > +		if (!mtk_dp->train_info.cable_plugged_in ||
> > +		    mtk_dp->train_info.irq_sta.hpd_disconnect) {
> > +			return -ENODEV;
> > +		}
> > +
> > +		if (mtk_dp->train_state < MTK_DP_TRAIN_STATE_TRAINING)
> 
> This checking would never be true, so remove it.
> 

Hello CK,

ok, I will do this.

> > +			return -EAGAIN;
> > +
> > +		if (!pass_tps1) {
> > +			ret = mtk_dp_train_tps_1(mtk_dp,
> > target_lane_count,
> > +						 &iteration_count,
> > lane_adjust,
> > +						 &status_control,
> > +						 &prev_lane_adjust);
> > +			if (!ret) {
> > +				pass_tps1 = true;
> > +				train_retries = 0;
> > +			} else if (ret == -EINVAL) {
> > +				break;
> > +			}
> > +		} else {
> > +			ret = mtk_dp_train_tps_2_3(mtk_dp,
> > target_link_rate,
> > +						   target_lane_count,
> > +						   &iteration_count,
> > +						   lane_adjust,
> > &status_control,
> > +						   &prev_lane_adjust);
> > +			if (!ret) {
> > +				pass_tps2_3 = true;
> > +				break;
> > +			} else if (ret == -EINVAL) {
> > +				break;
> > +			}
> > +		}
> > +
> > +		drm_dp_dpcd_read(&mtk_dp->aux,
> > DP_ADJUST_REQUEST_LANE0_1,
> > +				 lane_adjust, sizeof(lane_adjust));
> > +		mtk_dp_train_update_swing_pre(mtk_dp,
> > target_lane_count,
> > +					      lane_adjust);
> > +	} while (train_retries < MTK_DP_TRAIN_RETRY_LIMIT &&
> > +		 iteration_count < MTK_DP_TRAIN_MAX_ITERATIONS);
> 
> mtk_dp_train_tps_1() & mtk_dp_train_tps_2_3() would only be called
> once
> and never be called twice, so remove this loop.
> 
> Regards,
> CK
> 
> > +
> > +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_TRAINING_PATTERN_SET,
> > +			   DP_TRAINING_PATTERN_DISABLE);
> > +	ret = mtk_dp_train_set_pattern(mtk_dp, 0);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	if (!pass_tps2_3)
> > +		return -ETIMEDOUT;
> > +
> > +	mtk_dp->train_info.link_rate = target_link_rate;
> > +	mtk_dp->train_info.lane_count = target_lane_count;
> > +
> > +	mtk_dp_training_set_scramble(mtk_dp, true);
> > +
> > +	drm_dp_dpcd_writeb(&mtk_dp->aux, DP_LANE_COUNT_SET,
> > +			   target_lane_count |
> > +				   DP_LANE_COUNT_ENHANCED_FRAME_EN);
> > +	mtk_dp_set_enhanced_frame_mode(mtk_dp, true);
> > +
> > +	return ret;
> > +}
> 
> 

