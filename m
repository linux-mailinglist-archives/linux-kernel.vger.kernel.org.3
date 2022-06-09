Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7410154453C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiFIIAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiFIIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:00:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF3B1080;
        Thu,  9 Jun 2022 01:00:26 -0700 (PDT)
X-UUID: 9a4171f0cecb4c8ea0ad39794640986a-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:5881918a-ced5-4720-ba34-449aba5cb31b,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:64c1c47e-c8dc-403a-96e8-6237210dceee,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 9a4171f0cecb4c8ea0ad39794640986a-20220609
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 384527576; Thu, 09 Jun 2022 16:00:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 9 Jun 2022 16:00:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 9 Jun 2022 16:00:22 +0800
Message-ID: <2a8e5db06f6f430835c4e197cfd97804d8bc3050.camel@mediatek.com>
Subject: Re: [PATCH v10 18/21] drm/mediatek: Add mt8195 Embedded DisplayPort
 driver
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun =?UTF-8?Q?=28=E4=BA=91=E6=98=A5=E5=B3=B0=29?= 
        <Chunfeng.Yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        Jitao Shi =?UTF-8?Q?=28=E7=9F=B3=E8=AE=B0=E6=B6=9B=29?= 
        <jitao.shi@mediatek.com>
CC:     Markus Schneider-Pargmann <msp@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Date:   Thu, 9 Jun 2022 16:00:21 +0800
In-Reply-To: <77cdd43716b49aaffd9e052f4fe2c88e198ea7ff.camel@mediatek.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-19-granquet@baylibre.com>
         <77cdd43716b49aaffd9e052f4fe2c88e198ea7ff.camel@mediatek.com>
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

On Tue, 2022-06-07 at 17:04 +0800, CK Hu wrote:
> Hi, Rex:
> 
> On Mon, 2022-05-23 at 12:47 +0200, Guillaume Ranquet wrote:
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > 
> > This patch adds a DisplayPort driver for the Mediatek mt8195 SoC.
> > 
> > It supports the mt8195, the embedded DisplayPort units. It offers
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
> > Jason-JH.Lin <jason-jh.lin@mediatek.com>.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > ---
> 
> [snip]
> 
> > +
> > +static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
> > +{
> > +	struct mtk_dp *mtk_dp = dev;
> > +	int event;
> > +	u8 buf[DP_RECEIVER_CAP_SIZE] = {};
> > +
> > +	event = mtk_dp_plug_state(mtk_dp) ? connector_status_connected
> > :
> > +						  connector_status_disc
> > onnected;
> > +
> > +	if (event < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	if (mtk_dp->drm_dev) {
> > +		dev_info(mtk_dp->dev, "drm_helper_hpd_irq_event\n");
> > +		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
> > +	}
> > +
> > +	if (mtk_dp->train_info.cable_state_change) {
> > +		mtk_dp->train_info.cable_state_change = false;
> > +
> > +		mtk_dp->train_state = MTK_DP_TRAIN_STATE_STARTUP;
> > +
> > +		if (!mtk_dp->train_info.cable_plugged_in ||
> > +		    !mtk_dp_plug_state(mtk_dp)) {
> > +			mtk_dp_video_mute(mtk_dp, true);
> 
> For eDP, when does 'unplug' happen? Explain this or move unplug
> processing to DP patch.
> 
> Regards,
> CK
> 

Hello CK,

ok, I move them to dp patch.

BRs,
Bo-Chen

> > +
> > +			mtk_dp_initialize_priv_data(mtk_dp);
> > +			mtk_dp_set_idle_pattern(mtk_dp, true);
> > +			if (mtk_dp->has_fec)
> > +				mtk_dp_fec_enable(mtk_dp, false);
> > +
> > +			mtk_dp_update_bits(mtk_dp,
> > MTK_DP_TOP_PWR_STATE,
> > +					   DP_PWR_STATE_BANDGAP_TPLL,
> > +					   DP_PWR_STATE_MASK);
> > +		} else {
> > +			mtk_dp_update_bits(mtk_dp,
> > MTK_DP_TOP_PWR_STATE,
> > +					   DP_PWR_STATE_BANDGAP_TPLL_LA
> > NE,
> > +					   DP_PWR_STATE_MASK);
> > +			drm_dp_read_dpcd_caps(&mtk_dp->aux, buf);
> > +			mtk_dp->train_info.link_rate =
> > +				min_t(int, mtk_dp->max_linkrate,
> > +				      buf[mtk_dp->max_linkrate]);
> > +			mtk_dp->train_info.lane_count =
> > +				min_t(int, mtk_dp->max_lanes,
> > +				      drm_dp_max_lane_count(buf));
> > +		}
> > +	}
> > +
> > +	if (mtk_dp->train_info.irq_status & MTK_DP_HPD_INTERRUPT) {
> > +		dev_dbg(mtk_dp->dev, "MTK_DP_HPD_INTERRUPT\n");
> > +		mtk_dp->train_info.irq_status &= ~MTK_DP_HPD_INTERRUPT;
> > +		mtk_dp_hpd_sink_event(mtk_dp);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> 

