Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8951D5C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390973AbiEFK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390999AbiEFK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:29:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636DBB87D;
        Fri,  6 May 2022 03:25:26 -0700 (PDT)
X-UUID: a148a2a02f9c4c62a3e8622a000cbf10-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:ce892f98-26f0-42bb-8fd1-5a14f64b524d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:ce892f98-26f0-42bb-8fd1-5a14f64b524d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:0323d6b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: a148a2a02f9c4c62a3e8622a000cbf10-20220506
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1840432069; Fri, 06 May 2022 18:25:22 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 6 May 2022 18:25:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 May 2022 18:25:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 18:25:20 +0800
Message-ID: <21767265818ad000f3bfea576d26b919347126c2.camel@mediatek.com>
Subject: Re: [PATCH V5 00/16] Cleanup MediaTek clk reset drivers and support
 MT8192/MT8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 6 May 2022 18:25:20 +0800
In-Reply-To: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-28 at 19:56 +0800, Rex-BC Chen wrote:
> In this series, we cleanup MediaTek clock reset drivers in
> clk/mediatek
> folder. MediaTek clock reset driver is used to provide reset control
> of modules controlled in clk, like infra_ao.
> 
> Changes for V5:
> 1. Add all infra reset bits for MT8192 and MT8195.
> 2. Fix reviewers' comments.
> 
> Changes for V4:
> 1. Abandon the implementation of reset-cell = 2, and use reset index
> to
>    determine which reset bit is used.
> 2. Add documentation for enum/structure/function in reset.h.
> 3. Combine binding/drvier support patch for MT8192 and MT8195.
> 4. The MT8195 DTS is accepted by Matthias, and I add new DTS patch to
>    support infracfg_ao reset for MT8195. The DTS of MT8195 is still
>    not merged into mainline. Please refer to [1].
> 
> [1]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=for-next&id=37f2582883be7218dc69f9af135959a8e93de223
> 
> Changes for V3:
> 1. Modify drivers for reviewers' comments.
> 2. Add dt-binding patch for MT8192/MT8195 infra.
> 3. Add reset property of infra node for MT8192.
> 4. Use original function for simple operation.
> 
> Changes for V2:
> 1. Modify drivers for reviewers' comments.
> 2. Use simple reset to replace v1.
> 3. Recover v2 to set_clr.
> 4. Separate error handling to another patch.
> 5. Add support for input offset and bit from DT.
> 6. Add support for MT8192 and MT8195.
> 
> Rex-BC Chen (16):
>   clk: mediatek: reset: Add reset.h
>   clk: mediatek: reset: Fix written reset bit offset
>   clk: mediatek: reset: Refine and reorder functions in reset.c
>   clk: mediatek: reset: Extract common drivers to update function
>   clk: mediatek: reset: Merge and revise reset register function
>   clk: mediatek: reset: Revise structure to control reset register
>   clk: mediatek: reset: Support nonsequence base offsets of reset
> registers
>   clk: mediatek: reset: Change return type for clock reset register
> function
>   clk: mediatek: reset: Add new register reset function with device
>   clk: mediatek: reset: Add reset support for simple probe
>   dt-bindings: arm: mediatek: Add #reset-cells property for
> MT8192/MT8195
>   dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8195
>   dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8192
>   clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
>   arm64: dts: mediatek: Add infra #reset-cells property for MT8192
>   arm64: dts: mediatek: Add infra #reset-cells property for MT8195
> 
>  .../mediatek/mediatek,mt8192-sys-clock.yaml   |   3 +
>  .../mediatek/mediatek,mt8195-sys-clock.yaml   |   3 +
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   1 +
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  13 +-
>  drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
>  drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
>  drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
>  drivers/clk/mediatek/clk-mt2701.c             |  22 ++-
>  drivers/clk/mediatek/clk-mt2712.c             |  22 ++-
>  drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
>  drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
>  drivers/clk/mediatek/clk-mt7622.c             |  22 ++-
>  drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
>  drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
>  drivers/clk/mediatek/clk-mt8135.c             |  22 ++-
>  drivers/clk/mediatek/clk-mt8173.c             |  22 ++-
>  drivers/clk/mediatek/clk-mt8183.c             |  18 +-
>  drivers/clk/mediatek/clk-mt8192.c             |  18 ++
>  drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  15 ++
>  drivers/clk/mediatek/clk-mtk.c                |   7 +
>  drivers/clk/mediatek/clk-mtk.h                |   9 +-
>  drivers/clk/mediatek/reset.c                  | 172 ++++++++++++--
> ----
>  drivers/clk/mediatek/reset.h                  |  77 ++++++++
>  include/dt-bindings/reset/mt8192-resets.h     | 163
> +++++++++++++++++
>  include/dt-bindings/reset/mt8195-resets.h     | 170
> +++++++++++++++++
>  25 files changed, 759 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/clk/mediatek/reset.h
> 
> -- 
> 2.18.0
> 

Hello Stephen and Michael,

Could you spare some time to give us some suggestion?
Patches of this series are all reviewed.

Many thanks!

BRs,
Rex

