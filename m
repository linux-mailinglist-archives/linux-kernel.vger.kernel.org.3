Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD4567C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiGFDdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGFDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:33:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4026BEA8;
        Tue,  5 Jul 2022 20:33:24 -0700 (PDT)
X-UUID: 589fe0f0c753419192ab061e9faacab5-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a6f913f4-edac-4b9a-a790-0a3976eb6da5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:d2b6b7d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 589fe0f0c753419192ab061e9faacab5-20220706
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1274548127; Wed, 06 Jul 2022 11:33:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 6 Jul 2022 11:33:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 11:33:18 +0800
Message-ID: <6ce60f09ccc60415bdee90ab2b336a3bbc61c102.camel@mediatek.com>
Subject: Re: [PATCH v4 0/4] soc: mediatek: svs: add support for mt8186 and
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
Date:   Wed, 6 Jul 2022 11:33:16 +0800
In-Reply-To: <20220620033156.21489-1-jia-wei.chang@mediatek.com>
References: <20220620033156.21489-1-jia-wei.chang@mediatek.com>
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

Hi Matthias,

Just a gentle ping for this series, is there anything I can do to get
this series merged?  Or can you help give an advice on it?

Thanks,
Jia-wei

On Mon, 2022-06-20 at 11:31 +0800, jia-wei.chang wrote:
> This series supports MT8186 and MT8195 Smart Voltage Scaling (SVS)
> hardware which used as optimization of opp voltage table for
> corresponding dvfs drivers.
> 
> This series is based on [1].
> [1]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=for-next
> 
> Change since v3:
> - Remove irqflags of MT8186 and MT8195.
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
>  drivers/soc/mediatek/mtk-svs.c                | 500
> +++++++++++++++++-
>  2 files changed, 496 insertions(+), 7 deletions(-)
> 

