Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952257129F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiGLG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:57:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CFC951CC;
        Mon, 11 Jul 2022 23:57:22 -0700 (PDT)
X-UUID: 098aa1e34f294927bc99f0d4833748ad-20220712
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:cfc356d1-53a1-4a27-8af5-3e9cd555aa1f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:7df7bb32-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 098aa1e34f294927bc99f0d4833748ad-20220712
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 558935923; Tue, 12 Jul 2022 14:57:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 12 Jul 2022 14:57:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jul 2022 14:57:15 +0800
Message-ID: <b30154d38b4c0216ddb6c587c1120846e2209335.camel@mediatek.com>
Subject: Re: [PATCH v13 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
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
        "Jitao Shi =?UTF-8?Q?=28=E7=9F=B3=E8=AE=B0=E6=B6=9B=29?=" 
        <jitao.shi@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "LiangXu Xu =?UTF-8?Q?=28=E5=BE=90=E4=BA=AE=29?=" 
        <LiangXu.Xu@mediatek.com>,
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
Date:   Tue, 12 Jul 2022 14:57:15 +0800
In-Reply-To: <6b4a4be9b5c93b1931cdbd5b009eac3bfa9badbe.camel@mediatek.com>
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
         <20220701062808.18596-6-rex-bc.chen@mediatek.com>
         <6b4a4be9b5c93b1931cdbd5b009eac3bfa9badbe.camel@mediatek.com>
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

On Thu, 2022-07-07 at 13:14 +0800, CK Hu wrote:
> Hi, Bo-Chen:
> 
> On Fri, 2022-07-01 at 14:28 +0800, Bo-Chen Chen wrote:
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
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> 
> [snip]
> 
> > +
> > +static ssize_t mtk_dp_hpd_sink_event(struct mtk_dp *mtk_dp)
> 
> The caller never use the return value, so let this function to void.
> 
> > +{
> > +	ssize_t ret;
> > +	u8 sink_count;
> > +	u8 link_status[DP_LINK_STATUS_SIZE] = {};
> > +	u32 sink_count_reg = DP_SINK_COUNT_ESI;
> > +	u32 link_status_reg = DP_LANE0_1_STATUS;
> > +
> > +	ret = drm_dp_dpcd_readb(&mtk_dp->aux, sink_count_reg,
> > &sink_count);
> 
> You read sink_count but never use it, so this read is redundant.
> Remove
> it.
> 

Hello CK,

this is a pre-request for the following codes, so I think we need to
keep this.

If we failed to read sink_count, we don't need to do the driver under
this.

> > +	if (ret < 1) {
> > +		drm_err(mtk_dp->drm_dev, "Read sink count failed\n");
> > +		return ret == 0 ? -EIO : ret;
> > +	}
> > +
> > +	ret = drm_dp_dpcd_read(&mtk_dp->aux, link_status_reg,
> > link_status,
> > +			       sizeof(link_status));
> > +	if (!ret) {
> > +		drm_err(mtk_dp->drm_dev, "Read link status failed\n");
> > +		return ret;
> > +	}
> > +
> > +	drm_dp_channel_eq_ok(link_status, mtk_dp-
> > > train_info.lane_count);
> 
> This function just return true or false, and you does not process the
> return value, so this is redundant. Remove it.
> 

I will handle this in next version.

BRs,
Bo-Chen

> Regard,
> CK
> 
> > +
> > +	if (link_status[1] & DP_REMOTE_CONTROL_COMMAND_PENDING)
> > +		drm_dp_dpcd_writeb(&mtk_dp->aux,
> > DP_DEVICE_SERVICE_IRQ_VECTOR,
> > +				   DP_REMOTE_CONTROL_COMMAND_PENDING);
> > +
> > +	return 0;
> > +}
> 
> 

