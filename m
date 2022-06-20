Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F579551085
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbiFTGlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiFTGlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:41:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9373DDF1F;
        Sun, 19 Jun 2022 23:40:51 -0700 (PDT)
X-UUID: c162e9edf4db4404856e4756a22d8076-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f6cdc3df-dea3-4d74-8c15-1165459c00cc,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:f6cdc3df-dea3-4d74-8c15-1165459c00cc,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:f20e832d-1756-4fa3-be7f-474a6e4be921,C
        OID:69f70ab7a418,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c162e9edf4db4404856e4756a22d8076-20220620
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1999594167; Mon, 20 Jun 2022 14:40:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 20 Jun 2022 14:40:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 20 Jun 2022 14:40:47 +0800
Message-ID: <08653b784294bb11182faf82c74757a14d780c4e.camel@mediatek.com>
Subject: Re: [PATCH v8 16/19] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8195
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
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
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
Date:   Mon, 20 Jun 2022 14:40:46 +0800
In-Reply-To: <20220523060056.24396-17-rex-bc.chen@mediatek.com>
References: <20220523060056.24396-1-rex-bc.chen@mediatek.com>
         <20220523060056.24396-17-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 14:00 +0800, Rex-BC Chen wrote:
> We will use mediatek clock reset as infracfg_ao reset instead of
> ti-syscon. To support this, remove property of ti reset and add
> property of #reset-cells for mediatek clock reset.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index b57e620c2c72..db16eba9d475 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,7 +10,6 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> -#include <dt-bindings/reset/ti-syscon.h>
>  
>  / {
>  	compatible = "mediatek,mt8195";
> @@ -292,20 +291,10 @@
>  		};
>  
>  		infracfg_ao: syscon@10001000 {
> -			compatible = "mediatek,mt8195-infracfg_ao",
> "syscon", "simple-mfd";
> +			compatible = "mediatek,mt8195-infracfg_ao",
> "syscon";
>  			reg = <0 0x10001000 0 0x1000>;
>  			#clock-cells = <1>;
> -
> -			infracfg_rst: reset-controller {
> -				compatible = "ti,syscon-reset";
> -				#reset-cells = <1>;
> -				ti,reset-bits = <
> -					0x140 18 0x144 18 0 0
> (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* pcie */
> -					0x120 0  0x124 0  0 0
> (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> -					0x730 10 0x734 10 0 0
> (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> -					0x150 5  0x154 5  0 0
> (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* svs gpu */
> -				>;
> -			};
> +			#reset-cells = <1>;
>  		};
>  
>  		pericfg: syscon@10003000 {
> -- 
> 2.18.0
> 

Hello Matthias,

driver part is accepted by Setphen[1].
dts part is also reviewed.
Is these dts parts ok for you? (including patch 15 and 16)
Or should I send another series for dts part?

Thanks!

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-next

BRs,
Bo-Chen

