Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C153258FA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiHKJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiHKJ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:56:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE1790C7C;
        Thu, 11 Aug 2022 02:56:41 -0700 (PDT)
X-UUID: dd9479c8580a4834ad6a1424f0a85f36-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=orX+YD+2Tvqn6+Tuj+MFgYJbcYh0B7itt3I1h7rJ9U0=;
        b=tgLDkNQ3oJ3KE5kW9slZrLhE+oid4ZB20ELKTn6hBianObZ0DrUSQnPOcXoG8HAj8UVVQ9e+GV7qq4gETjK7dpCOuhKtmf0Z0d1EmaJ2IYZ0W0lAHKIR9sYRCIP45MgyxvNbZAOWkRmucKR/tO6ckl85ilhjrRzwSF3ixYz+FTk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:55875548-051a-4c8e-be92-b7a98d45b22c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:7179619c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: dd9479c8580a4834ad6a1424f0a85f36-20220811
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1476812866; Thu, 11 Aug 2022 17:56:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 17:56:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Aug 2022 17:56:35 +0800
Message-ID: <14d0e1be2fbd7bbacb7553a2e2e5b9d941403c4f.camel@mediatek.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 11 Aug 2022 17:56:35 +0800
In-Reply-To: <815b03aa-ab39-ec8b-294b-68dff36e2d54@kernel.org>
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
         <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
         <CAGXv+5HXwVpaJPV-4Z6qw14xZzEkx_E7dVks6-GBa7bQyN8hCg@mail.gmail.com>
         <5dac39d1-3b42-40e9-5693-0c127e8c689a@gmail.com>
         <0fadcd9f50d49ecbb329e76a9ceb6ee689648955.camel@mediatek.com>
         <20220808170355.c2ih3xwqxlddsal7@notapiano>
         <6271732eb27824c5b841760243738ceb062f4c4a.camel@mediatek.com>
         <815b03aa-ab39-ec8b-294b-68dff36e2d54@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

he SoC-specific compatibles Hi Krzysztof,

On Wed, 2022-08-10 at 19:50 +0300, Krzysztof Kozlowski wrote:
> On 10/08/2022 15:58, Allen-KH Cheng wrote:
> > I agree the advantage of patch is aesthetic. Since I also want to
> > send
> > another "watchdog: Convert binding to YAML" PATCH, it's better let
> > all
> > wdt compatibles in the binding match the contents of mtk_wdt_dt_ids
> > in
> > drivers/watchdog/mtk_wdt.c
> > 
> > static const struct of_device_id mtk_wdt_dt_ids[] = {
> > 	{ .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
> > 	{ .compatible = "mediatek,mt6589-wdt" },
> > 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
> > 	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
> > 	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
> > 	{ .compatible = "mediatek,mt8192-wdt", .data = &mt8192_data },
> > 	{ .compatible = "mediatek,mt8195-wdt", .data = &mt8195_data },
> > 	{ /* sentinel */ }
> > };
> > 
> > We have "mediatek,mt8186-wdt" "mediatek,mt8195-wdt" and
> > "mediatek,mt7986-wdt" now and they have their DT data for the reset
> > control.
> > 
> > It's weird and unuseful to add "mediatek,mt6589-wdt" as fallback. 
> > 
> > 
> > Please kindly let me know if I missed anything
> 
> How the driver arranges it should not be a reason to use or not to
> use
> specific fallback. Although Rob acked it, but I still think you did
> not
> provide valid reason for the change.
> 
> Valid reason is usually the actual hardware (so they are actually not
> compatible with mt6589), not exactly how once someone did it in the
> driver.
> 
> Best regards,
> Krzysztof

Thank you for your detailed and clear explanation.

"mediatek,mt6589-wdt" provides the mtk watchdog support and the SoC-
specific compatibles is for reset controls to standard wdt.

"mediatek,mt6589-wdt" is compatible with mt8186, mt8195 and mt7986 and
just not support the reset controls. 

Based on the discussion of email thread, please drop my series.


Thanks to everyone for your comments.

Best regards,
Allen



