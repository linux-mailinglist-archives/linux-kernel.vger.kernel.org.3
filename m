Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B588575DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiGOIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiGOIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:52:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A7E84EE3;
        Fri, 15 Jul 2022 01:51:35 -0700 (PDT)
X-UUID: d721200affec4765846b864848f39bc9-20220715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:34ea4b4a-b427-491f-97f1-0940e2b80b57,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.8,REQID:34ea4b4a-b427-491f-97f1-0940e2b80b57,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:0f94e32,CLOUDID:b1b695d7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:9a8e9ef91b98,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d721200affec4765846b864848f39bc9-20220715
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1312067785; Fri, 15 Jul 2022 16:51:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 15 Jul 2022 16:51:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Jul 2022 16:51:27 +0800
Message-ID: <05e7ace27af21d141c1ecd79fb45f6e5e9d32582.camel@mediatek.com>
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
Date:   Fri, 15 Jul 2022 16:51:27 +0800
In-Reply-To: <20220712111223.13080-6-rex-bc.chen@mediatek.com>
References: <20220712111223.13080-1-rex-bc.chen@mediatek.com>
         <20220712111223.13080-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

> +static void mtk_dp_hpd_sink_event(struct mtk_dp *mtk_dp)
> +{
> +	ssize_t ret;
> +	u8 sink_count;
> +	u8 link_status[DP_LINK_STATUS_SIZE] = {};
> +	u32 sink_count_reg = DP_SINK_COUNT_ESI;
> +	u32 link_status_reg = DP_LANE0_1_STATUS;
> +
> +	ret = drm_dp_dpcd_readb(&mtk_dp->aux, sink_count_reg,
> &sink_count);

According to your last reply, if drm_dp_dpcd_readb() fail, we could
skip below statement. So this just for error checking? If so, the next
drm_dp_dpcd_read() would also do the error checking, so the checking
here is redundant.

Regards,
CK

> +	if (ret < 1) {
> +		drm_err(mtk_dp->drm_dev, "Read sink count failed\n");
> +		return;
> +	}
> +
> +	drm_dbg(mtk_dp->drm_dev,
> +		"read sink count from dpcd: %d\n", sink_count);
> +
> +	ret = drm_dp_dpcd_read(&mtk_dp->aux, link_status_reg,
> link_status,
> +			       sizeof(link_status));
> +	if (!ret) {
> +		drm_err(mtk_dp->drm_dev, "Read link status failed\n");
> +		return;
> +	}
> +
> +	if (!drm_dp_channel_eq_ok(link_status, mtk_dp-
> >train_info.lane_count)) {
> +		drm_err(mtk_dp->drm_dev, "Channel EQ failed\n");
> +		return;
> +	}
> +
> +	if (link_status[1] & DP_REMOTE_CONTROL_COMMAND_PENDING)
> +		drm_dp_dpcd_writeb(&mtk_dp->aux,
> DP_DEVICE_SERVICE_IRQ_VECTOR,
> +				   DP_REMOTE_CONTROL_COMMAND_PENDING);
> +}
> +

