Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7478756671F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiGEJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiGEJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:54:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3312096;
        Tue,  5 Jul 2022 02:52:02 -0700 (PDT)
X-UUID: 23dbcdd5835548e496fcf7fa4898f6ab-20220705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:89c0cbba-c655-4e43-9687-407f1f20471b,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:86d37463-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 23dbcdd5835548e496fcf7fa4898f6ab-20220705
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 344772149; Tue, 05 Jul 2022 17:51:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 5 Jul 2022 17:51:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 5 Jul 2022 17:51:55 +0800
Message-ID: <3cd66cc0adc84619150bc96416974bceb0b4e917.camel@mediatek.com>
Subject: Re: [PATCH v13 06/10] drm/mediatek: Add MT8195 External DisplayPort
 support
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
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
Date:   Tue, 5 Jul 2022 17:51:54 +0800
In-Reply-To: <5971f465-9514-d830-8467-e722475ecc7f@collabora.com>
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
         <20220701062808.18596-7-rex-bc.chen@mediatek.com>
         <5971f465-9514-d830-8467-e722475ecc7f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-01 at 16:14 +0800, AngeloGioacchino Del Regno wrote:
> Il 01/07/22 08:28, Bo-Chen Chen ha scritto:
> > From: Guillaume Ranquet <granquet@baylibre.com>
> > 
> > This patch adds External DisplayPort support to the mt8195 eDP
> > driver.
> > 
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_dp.c     | 197
> > +++++++++++++++++++++-----
> >   drivers/gpu/drm/mediatek/mtk_dp_reg.h |   1 +
> >   2 files changed, 161 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c
> > b/drivers/gpu/drm/mediatek/mtk_dp.c
> > index b672d5a6f5bd..c3be97dd055c 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> > @@ -105,6 +105,7 @@ struct mtk_dp {
> >   	struct regmap *regs;
> >   
> >   	bool enabled;
> > +	bool has_fec;
> 
> You're introducing this has_fec variable here....
> 
> >   
> >   	struct drm_connector *conn;
> >   };
> 
> 
> > @@ -1018,6 +1074,8 @@ static void
> > mtk_dp_initialize_priv_data(struct mtk_dp *mtk_dp)
> >   	mtk_dp->info.depth = DP_MSA_MISC_8_BPC;
> >   	memset(&mtk_dp->info.timings, 0, sizeof(struct
> > mtk_dp_timings));
> >   	mtk_dp->info.timings.frame_rate = 60;
> > +
> > +	mtk_dp->has_fec = false;
> 
> .... setting it as false here ....
> 
> >   }
> >   
> >   static void mtk_dp_setup_tu(struct mtk_dp *mtk_dp)
> > @@ -1498,15 +1562,38 @@ static int mtk_dp_init_port(struct mtk_dp
> > *mtk_dp)
> >   static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
> >   {
> >   	struct mtk_dp *mtk_dp = dev;
> > +	int event;
> >   	u8 buf[DP_RECEIVER_CAP_SIZE] = {};
> >   
> > +	event = mtk_dp_plug_state(mtk_dp) ?
> > +		connector_status_connected :
> > connector_status_disconnected;
> > +
> > +	if (event < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	dev_info(mtk_dp->dev, "drm_helper_hpd_irq_event\n");
> 
> P.S.: This should be a dev_dbg().
> 
> > +	drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
> > +
> >   	if (mtk_dp->train_info.cable_state_change) {
> >   		mtk_dp->train_info.cable_state_change = false;
> >   
> > -		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > -				   DP_PWR_STATE_BANDGAP_TPLL_LANE,
> > -				   DP_PWR_STATE_MASK);
> > -		drm_dp_read_dpcd_caps(&mtk_dp->aux, buf);
> > +		if (!mtk_dp->train_info.cable_plugged_in) {
> > +			mtk_dp_video_mute(mtk_dp, true);
> > +
> > +			mtk_dp_initialize_priv_data(mtk_dp);
> > +			mtk_dp_set_idle_pattern(mtk_dp, true);
> > +			if (mtk_dp->has_fec)
> 
> ...and you're checking it here, but there's nothing ever setting that
> as true!
> 
> Is there anything you forgot? :-)
> 
> Cheers,
> Angelo

Hello Angelo,

Thanks for your review.
We do not support fec currently, so I will drop them.

Thanks!

BRs,
Bo-Chen

