Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF950D6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiDYCkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiDYCkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:40:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D794B417;
        Sun, 24 Apr 2022 19:37:08 -0700 (PDT)
X-UUID: f4ba8226d13c448dbc6b2e2d86ee9c43-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b40454e7-8c83-49e6-8c7b-f0fe2e99d525,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:ce2af5ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: f4ba8226d13c448dbc6b2e2d86ee9c43-20220425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 201482578; Mon, 25 Apr 2022 10:37:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Apr 2022 10:37:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 10:37:03 +0800
Message-ID: <fdedea6f20738bfe2ede7e526aa653af1ac35768.camel@mediatek.com>
Subject: Re: [PATCH V3 11/17] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8192-sys-clock
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
Date:   Mon, 25 Apr 2022 10:37:02 +0800
In-Reply-To: <288f55f3-b3ed-32b8-9a44-652f3d53617d@linaro.org>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
         <20220422060152.13534-12-rex-bc.chen@mediatek.com>
         <288f55f3-b3ed-32b8-9a44-652f3d53617d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 18:27 +0800, Krzysztof Kozlowski wrote:
> On 22/04/2022 08:01, Rex-BC Chen wrote:
> > We will use the infra_ao reset which is defined in mt8192-sys-
> > clock.
> > The maximum value of reset-cells is 2. Therefore, we add this patch
> > to
> > define it.
> 
> Remove entire last sentence, does not make sense in the commit.
> 

Hello Krzysztof,

Thanks for your review.
I will drop "Therefore, we add this patch to define it." and add more
detailed messages in next version.

> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml       | 3
> > +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-
> > sys-clock.yaml
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-
> > sys-clock.yaml
> > index 5705bcf1fe47..28ebcecc8258 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-
> > sys-clock.yaml
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-
> > sys-clock.yaml
> > @@ -29,6 +29,9 @@ properties:
> >    '#clock-cells':
> >      const: 1
> >  
> > +  '#reset-cells':
> > +    maximum: 2
> 
> Why this is a maximum? Usually this is const, so how do you use it
> (with
> what values)?
> 
We need to let the driver compatible with previous setting in
drivers/clk/mediatek/reset.c

There are two use cases in our reset driver:
(Refer to [1])

1. #reset-cells = <1>
   When we input the argument, the older driver
use is to calculate  
   bank and bit by different method. From the implementation of
   reset_xlate(), we can see if the argument number is 1, it will
   return directly.

2. #reset-cells = <2>
   The input arguments is offset and bit. When we input two arguments,
   we can use reset_xlate() to calculate the corresponding id to assert
   and deassert.

[1]:
https://lore.kernel.org/all/20220422060152.13534-10-rex-bc.chen@mediatek.com/

If it's acceptable, I will add this in commit message.

BRs,
Rex
> > +
> >  required:
> >    - compatible
> >    - reg
> 
> 
> Best regards,
> Krzysztof

