Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9C5229E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiEKCcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbiEKCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:32:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9510D61;
        Tue, 10 May 2022 19:32:03 -0700 (PDT)
X-UUID: 11e877910c1946a597159a7bcca16928-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:590066e2-11a0-4e58-852f-3e911ec78f9e,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:8d1d59b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 11e877910c1946a597159a7bcca16928-20220511
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1607058286; Wed, 11 May 2022 10:31:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 11 May 2022 10:31:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 11 May 2022 10:31:57 +0800
Message-ID: <3c2dd0f91c0ce007151093f1f3cb5bf8f49cd248.camel@mediatek.com>
Subject: Re: [PATCH next v3 2/2] arm64: dts: mediatek: mt8195: enable usb
 remote wakeup
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Bear Wang <bear.wang@mediatek.com>
Date:   Wed, 11 May 2022 10:31:57 +0800
In-Reply-To: <20220510121027.19041-2-chunfeng.yun@mediatek.com>
References: <20220510121027.19041-1-chunfeng.yun@mediatek.com>
         <20220510121027.19041-2-chunfeng.yun@mediatek.com>
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

On Tue, 2022-05-10 at 20:10 +0800, Chunfeng Yun wrote:
> Enable USB remote wakeup of all four xHCI controller
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: add reviewed-by AngeloGioacchino;
> 
> NOTE:
>   based on v5.18-next/dts64 of matthias.bgg's branch
> 
> v2: no changes, based on new version of mt8195.dtsi
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index d5bc4cf5f4ac..3ad14e0e0956 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -573,6 +573,8 @@
>  				 <&apmixedsys CLK_APMIXED_USB1PLL>,
>  				 <&infracfg_ao
> CLK_INFRA_AO_SSUSB_XHCI>;
>  			clock-names = "sys_ck", "ref_ck", "mcu_ck",
> "xhci_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
> +			wakeup-source;
>  			status = "disabled";
>  		};
>  
> @@ -636,6 +638,8 @@
>  				 <&apmixedsys CLK_APMIXED_USB1PLL>,
>  				 <&pericfg_ao
> CLK_PERI_AO_SSUSB_1P_XHCI>;
>  			clock-names = "sys_ck", "ref_ck",
> "mcu_ck","xhci_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
> +			wakeup-source;
>  			status = "disabled";
>  		};
>  
> @@ -655,6 +659,8 @@
>  				 <&topckgen CLK_TOP_SSUSB_P2_REF>,
>  				 <&pericfg_ao
> CLK_PERI_AO_SSUSB_2P_XHCI>;
>  			clock-names = "sys_ck", "ref_ck", "xhci_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
> +			wakeup-source;
>  			status = "disabled";
>  		};
>  
> @@ -674,6 +680,8 @@
>  				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
>  				 <&pericfg_ao
> CLK_PERI_AO_SSUSB_3P_XHCI>;
>  			clock-names = "sys_ck", "ref_ck", "xhci_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
> +			wakeup-source;
>  			status = "disabled";
>  		};
>  

Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>

Test method: test build pass and boot pass based on 'for-next' branch.

N
ote:
System suspend and resume of MT8195 has not been ready or enabled
on mainline. We cannot verify USB Host remote wake-up on mainline code,
but the settings and function works when applied to MediaTek's internal
working tree.

Regards,
Macpaul Lin


