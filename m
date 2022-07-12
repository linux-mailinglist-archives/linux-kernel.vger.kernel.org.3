Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD4571409
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGLILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiGLIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:10:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A29E47C;
        Tue, 12 Jul 2022 01:10:14 -0700 (PDT)
X-UUID: cfffe12f99f9400e8664b26b50cd4cf4-20220712
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:bb70b979-a0bc-4ec1-8984-3e71cd97a885,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:0328be32-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: cfffe12f99f9400e8664b26b50cd4cf4-20220712
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 562334713; Tue, 12 Jul 2022 16:10:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 12 Jul 2022 16:10:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jul 2022 16:10:07 +0800
Message-ID: <aa0b332468145634d6a9ef538da5c3eb26033de3.camel@mediatek.com>
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
Date:   Tue, 12 Jul 2022 16:10:07 +0800
In-Reply-To: <fde545ed10e3baa1a375eead29dd2d12d95b7cb2.camel@mediatek.com>
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
         <20220701062808.18596-6-rex-bc.chen@mediatek.com>
         <fde545ed10e3baa1a375eead29dd2d12d95b7cb2.camel@mediatek.com>
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

On Thu, 2022-07-07 at 10:21 +0800, CK Hu wrote:
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
> > +
> > +static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
> > +{
> > +	mtk_dp_write(mtk_dp, MTK_DP_TOP_PWR_STATE, 0);
> > +
> > +	mtk_dp_write(mtk_dp, MTK_DP_0034,
> > +		     DA_CKM_CKTX0_EN_FORCE_EN |
> > +		     DA_CKM_BIAS_LPF_EN_FORCE_VAL |
> > +		     DA_CKM_BIAS_EN_FORCE_VAL |
> > +		     DA_XTP_GLB_LDO_EN_FORCE_VAL |
> > +		     DA_XTP_GLB_AVD10_ON_FORCE_VAL);
> 
> clk-mt8195-vdo0 driver [1] is part of mtk-mmsys driver [2] and it is
> still separated out to ccf driver. In addition, you does not manage
> the
> parent clock. If the parent clock is not enable, these leaf clock
> would
> not work.
> 
> [1] 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/mediatek/clk-mt8195-vdo0.c?h=v5.19-rc5#n138
> 
> [2] 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/mediatek/mtk-mmsys.c?h=v5.19-rc5#n140
> 
> Regards,
> CK
> 

Hello CK,

MTK_DP_0034 is just a enable control for dp hardware, so I think we
don't need to move it to ccf driver. it's not related to ccf.

After checking with Jitao, we only need to update
DA_CKM_CKTX0_EN_FORCE_E. I will set this bit as 1 in
mtk_dp_power_disable and 0 in mtk_dp_power_enable

BRs,
Bo-Chen

> > +
> > +	/* Disable RX */
> > +	mtk_dp_write(mtk_dp, MTK_DP_1040, 0);
> > +	mtk_dp_write(mtk_dp, MTK_DP_TOP_MEM_PD,
> > +		     0x550 | BIT(FUSE_SEL_SHIFT) |
> > BIT(MEM_ISO_EN_SHIFT));
> > +}
> > +
> 
> 

