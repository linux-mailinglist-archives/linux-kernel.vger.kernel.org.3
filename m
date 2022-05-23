Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD7530B75
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiEWI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiEWI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:57:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723B2126A;
        Mon, 23 May 2022 01:57:15 -0700 (PDT)
X-UUID: aa432fb806074429acbcf2fa9dfe86da-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f8b41018-8812-4d8f-bbfb-801da19abe5f,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:3f37467a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: aa432fb806074429acbcf2fa9dfe86da-20220523
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 791407665; Mon, 23 May 2022 16:57:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 16:57:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 23 May 2022 16:57:08 +0800
Message-ID: <f2dd851bdabe03c67da520ec1d2cdfdadc95e6f3.camel@mediatek.com>
Subject: Re: [PATCH v2 0/4] soc: mediatek: svs: add support for mt8186 and
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Mon, 23 May 2022 16:57:08 +0800
In-Reply-To: <20220523084034.26802-1-jia-wei.chang@mediatek.com>
References: <20220523084034.26802-1-jia-wei.chang@mediatek.com>
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

On Mon, 2022-05-23 at 16:40 +0800, Tim Chang wrote:

The Subject is for [Patch v3 0/4] rather than v2.
Sorry for my typo.

> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> This series supports MT8186 and MT8195 Smart Voltage Scaling (SVS)
> hardware which used as optimization of opp voltage table for
> corresponding dvfs drivers.
> 
> This series is based on Roger's series [1].
> [1]: Message ID: 20220516004311.18358-1-roger.lu@mediatek.com
> 
> Change since v2:
> - Reuse platform probe of MT8192 for MT8195.
> - Remove unnecessary svs bank parameters of MT8195.
> - Remove sw id check for MT8195 efuse parsing.
> 
> Change since v1:
> - Add myself as a co-maintainer of mtk-svs.yaml.
> - Fix MT8186 error handling in platform probe.
> - Add dt-bindings and support for MT8195 platform.
> 
> Jia-Wei Chang (4):
>   dt-bindings: soc: mediatek: add mt8186 svs dt-bindings
>   soc: mediatek: svs: add support for mt8186
>   dt-bindings: soc: mediatek: add mt8195 svs dt-bindings
>   soc: mediatek: svs: add support for mt8195
> 
>  .../bindings/soc/mediatek/mtk-svs.yaml        |   3 +
>  drivers/soc/mediatek/mtk-svs.c                | 502
> +++++++++++++++++-
>  2 files changed, 498 insertions(+), 7 deletions(-)
> 

