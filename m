Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D95510B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiFTGt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiFTGt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:49:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966F6176;
        Sun, 19 Jun 2022 23:49:55 -0700 (PDT)
X-UUID: c299c47f328e4507b435047b71b4c7ce-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:a824e2f3-abc3-4a61-ba4f-f75105ac0024,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.6,REQID:a824e2f3-abc3-4a61-ba4f-f75105ac0024,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:b14ad71,CLOUDID:87d22a3d-9948-4b2a-a784-d8a6c1086106,C
        OID:cb306c6fdf1b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c299c47f328e4507b435047b71b4c7ce-20220620
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1770909525; Mon, 20 Jun 2022 14:49:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 20 Jun 2022 14:49:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 20 Jun 2022 14:49:46 +0800
Message-ID: <2cedb4cc1e1a69481d5997431ac2a4b368858afb.camel@mediatek.com>
Subject: Re: [PATCH v11 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
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
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 20 Jun 2022 14:49:46 +0800
In-Reply-To: <20220610105522.13449-6-rex-bc.chen@mediatek.com>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com>
         <20220610105522.13449-6-rex-bc.chen@mediatek.com>
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

Hi, Bo-Chen:

On Fri, 2022-06-10 at 18:55 +0800, Bo-Chen Chen wrote:
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
> [Bo-Chen: Cleanup the drivers and modify comments from reviewers]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---

[snip]

> +
> +static int mtk_dp_probe(struct platform_device *pdev)
> +{
> +	struct mtk_dp *mtk_dp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	int irq_num = 0;
> +
> +	mtk_dp = devm_kzalloc(dev, sizeof(*mtk_dp), GFP_KERNEL);
> +	if (!mtk_dp)
> +		return -ENOMEM;
> +
> +	mtk_dp->dev = dev;
> +
> +	irq_num = platform_get_irq(pdev, 0);
> +	if (irq_num < 0)
> +		return dev_err_probe(dev, irq_num,
> +				     "failed to request dp irq
> resource\n");
> +
> +	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 
> 1, 0);
> +	if (IS_ERR(mtk_dp->next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(mtk_dp->next_bridge),
> +				     "Failed to get bridge\n");
> +
> +	ret = mtk_dp_dt_parse(mtk_dp, pdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to parse dt\n");
> +
> +	drm_dp_aux_init(&mtk_dp->aux);
> +	mtk_dp->aux.name = "aux_mtk_dp";
> +	mtk_dp->aux.transfer = mtk_dp_aux_transfer;

In the comment of drm_dp_aux_init(), drm_dp_aux_init() is used before
drm_dp_aux_register(). So I think we still need to call
drm_dp_aux_register().

Regards,
CK

> +
> +	ret = devm_request_threaded_irq(dev, irq_num, mtk_dp_hpd_event,
> +					mtk_dp_hpd_event_thread,
> +					IRQ_TYPE_LEVEL_HIGH,
> dev_name(dev),
> +					mtk_dp);
> +	if (ret)
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				     "failed to request mediatek dptx
> irq\n");
> +
> +	mutex_init(&mtk_dp->dp_lock);
> +
> +	platform_set_drvdata(pdev, mtk_dp);
> +
> +	mtk_dp->phy_dev = platform_device_register_data(dev, "mediatek-
> dp-phy",
> +							PLATFORM_DEVID_
> AUTO,
> +							&mtk_dp->regs,
> +							sizeof(struct
> regmap *));
> +	if (IS_ERR(mtk_dp->phy_dev))
> +		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
> +				     "Failed to create device mediatek-
> dp-phy\n");
> +
> +	mtk_dp_get_calibration_data(mtk_dp);
> +
> +	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
> +
> +	if (IS_ERR(mtk_dp->phy)) {
> +		platform_device_unregister(mtk_dp->phy_dev);
> +		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy),
> +				     "Failed to get phy\n");
> +	}
> +
> +	mtk_dp->bridge.funcs = &mtk_dp_bridge_funcs;
> +	mtk_dp->bridge.of_node = dev->of_node;
> +
> +	mtk_dp->bridge.ops =
> +		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> DRM_BRIDGE_OP_HPD;
> +	mtk_dp->bridge.type = DRM_MODE_CONNECTOR_eDP;
> +
> +	drm_bridge_add(&mtk_dp->bridge);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	return 0;
> +}

