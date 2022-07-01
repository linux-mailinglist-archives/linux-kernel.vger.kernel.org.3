Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A24562ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiGAFST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiGAFSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:18:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E728B92;
        Thu, 30 Jun 2022 22:18:06 -0700 (PDT)
X-UUID: fd340e53259549fdbc695f57ccf4463e-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:b7540888-2f96-41a5-b4c2-1edb540b14ed,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:47
X-CID-INFO: VERSION:1.1.7,REQID:b7540888-2f96-41a5-b4c2-1edb540b14ed,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:47
X-CID-META: VersionHash:87442a2,CLOUDID:b62953d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:a84055e5f88c,Recheck:0,SF:28|17|19|48,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: fd340e53259549fdbc695f57ccf4463e-20220701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1009609211; Fri, 01 Jul 2022 13:18:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 1 Jul 2022 13:17:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 1 Jul 2022 13:17:58 +0800
Message-ID: <33f121fa1a97e9fa8fd3fc6e87f197b7965bd825.camel@mediatek.com>
Subject: Re: [PATCH v12 05/10] drm/mediatek: Add MT8195 Embedded DisplayPort
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
Date:   Fri, 1 Jul 2022 13:17:58 +0800
In-Reply-To: <78d71a052d214e0c11cab5c2f4dee39c4f67c0bc.camel@mediatek.com>
References: <20220627080341.5087-1-rex-bc.chen@mediatek.com>
         <20220627080341.5087-6-rex-bc.chen@mediatek.com>
         <78d71a052d214e0c11cab5c2f4dee39c4f67c0bc.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-29 at 13:34 +0800, CK Hu wrote:
> Hi, Bo-Chen:
> 
> On Mon, 2022-06-27 at 16:03 +0800, Bo-Chen Chen wrote:
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
> > +static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
> > +{
> > +	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
> > +			   0, SW_RST_B_PHYD);
> > +
> > +	/* Wait for power enable */
> > +	usleep_range(10, 200);
> > +
> > +	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
> > +			   SW_RST_B_PHYD, SW_RST_B_PHYD);
> > +	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > +			   DP_PWR_STATE_BANDGAP_TPLL,
> > DP_PWR_STATE_MASK);
> > +}
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
> > +
> > +	/* Disable RX */
> > +	mtk_dp_write(mtk_dp, MTK_DP_1040, 0);
> 
> MTK_DP_1040 is set to 0 in mtk_dp_power_disable(), but it is not set
> to
> other value in mtk_dp_power_enable(). Does any thing would be wrong
> when mtk_dp_power_disable() and mtk_dp_power_enable()?
> 
> Regards,
> CK
> 

Hello CK,

in mtk_dp_power_enable(),
after we reset the hw:
mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
		   SW_RST_B_PHYD, SW_RST_B_PHYD);
mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
		   DP_PWR_STATE_BANDGAP_TPLL,
		   DP_PWR_STATE_MASK);

the value will be set back to default value 0x7.
I will add "mtk_dp_write(mtk_dp, MTK_DP_1040, 7);" to prevent
misunderstanding.

BRs,
Bo-Chen

> > +	mtk_dp_write(mtk_dp, MTK_DP_TOP_MEM_PD,
> > +		     0x550 | BIT(FUSE_SEL_SHIFT) |
> > BIT(MEM_ISO_EN_SHIFT));
> > +}
> > +
> 
> 

